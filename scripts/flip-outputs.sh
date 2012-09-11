#! /bin/bash

dev="$1"
when="$2"

FLAGS="-p -a 32 -d 32 -r 0"
EB_READ="eb-read"
EB_WRITE="eb-write"

utc=`echo "$when" | cut -d. -f1`
utchi=$(($utc/4294967296))
utclo=$(($utc%4294967296))
cycle=0

$EB_WRITE $FLAGS $dev 0x140010/4 $utchi
$EB_WRITE $FLAGS $dev 0x140014/4 $utclo
$EB_WRITE $FLAGS $dev 0x140018/4 $cycle
$EB_WRITE $FLAGS $dev 0x14001C/4 0xffffffff # toggle all outputs
$EB_WRITE $FLAGS $dev 0x140000/4 0 # enqueue the command

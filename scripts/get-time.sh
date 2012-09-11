#! /bin/bash

dev="$1"

FLAGS="-p -a 32 -d 32 -r 0"
EB_READ="eb-read"

while true; do
  UTClo=0x`$EB_READ $FLAGS $dev 0x20308/4`
  UTChi=0x`$EB_READ $FLAGS $dev 0x2030C/4`
  CNT=0x`$EB_READ $FLAGS $dev 0x20304/4`
  UTClon=0x`$EB_READ $FLAGS $dev 0x20308/4`
  
  if test $UTClo == $UTClon; then break; fi
done

NS=$((CNT*8))
UTC=$((UTChi*4294967296 + UTClo))
printf "%d.%09d = " $UTC $NS

echo -n `date +"%Y-%m-%d %H:%M:%S" -d @$UTC`
printf ".%09d\n" $NS

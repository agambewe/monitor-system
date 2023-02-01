#!/bin/bash
while true
do
clear

echo "MONITORING SYSTEM"
echo -n -e "    Hostname \t "
hostname
echo -n -e "    Ip Address \t "
hostname -I
echo

echo -n -e "    CPU \t "
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
echo -n -e "    Memory \t "
free | grep Mem | awk '{printf("%.2f%", $3/$2 * 100.0)}'
echo

#used
USED=`df -l | awk '/^\/dev\/mapper\/*/ { sum+=$3 } END { print sum }'`
#avail
AVAIL=`df -l | awk '/^\/dev\/mapper\/*/ { sum+=$2 } END { print sum }'`

TOTAL=`echo "$USED $AVAIL" | awk '{print ($1/$2*100)}'`

echo -n -e "    Storage \t "
printf "%0.2f%% \n" $TOTAL

sleep 3
done

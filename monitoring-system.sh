#!/bin/bash

DATE=$(date +'%H:%M %m-%d-%Y')
echo $DATE
echo "MONITORING SYSTEM"
echo -n -e "    Hostname \t "
hostname
echo -n -e "    Ip Address \t "
hostname -I
echo

echo -n -e "    CPU \t "
CPU=`top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'`
echo $CPU

echo -n -e "    Memory \t "
Memory=`free | grep Mem | awk '{printf("%.2f%", $3/$2 * 100.0)}'`
echo $Memory

#used
USED=`df -l | awk '/^\/dev\/mapper\/*/ { sum+=$3 } END { print sum }'`
#avail
AVAIL=`df -l | awk '/^\/dev\/mapper\/*/ { sum+=$2 } END { print sum }'`

TOTAL=`echo "$USED $AVAIL" | awk '{print ($1/$2*100)}'`

echo -n -e "    Storage \t "
printf "%0.2f%% \n" $TOTAL

echo "$HOSTNAME,$DATE,$CPU,$Memory,$TOTAL" >> monitoring.csv

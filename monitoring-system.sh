#!/bin/bash
while true
do
clear

echo "MONITORING SYSTEM"
echo -n -e "    Storage \t "
df -hl | awk '/^\/dev\/sd[abc]/ { sum+=$5 } END { print sum"%" }'
echo -n -e "    CPU \t "
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
echo -n -e "    Memory \t "
free | grep Mem | awk '{printf("%.2f%", $3/$2 * 100.0)}'
# echo -e "%"

sleep 3
done

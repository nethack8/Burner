#!/bin/bash
echo "Are you sure you want to overwrite "$1"?"
read -p "To confirm, enter confirm: " confirm
size=$( du -b $1 | egrep -o "[0-9]{1,40}" )
if [ $confirm == "confirm" ]; then
	echo "[i] Overwriting $1..."
	for i in {1..8}
	do
		dd if=/dev/urandom of=$1 bs=$size status=progress count=1 &> /dev/null
		echo "[i] $i/8 overwrites complete"
	done
	rm $1
	echo "[i] Overwrite complete"
else
	echo "exiting"
	sleep 3
	exit
fi

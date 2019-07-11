#!/bin/bash

help() {
	echo "usage: ./$0 <file>"
	exit 1
}

if [ $# != 1 ]; then
	help
fi

# Check if linux shred utility is installed
which shred &> /dev/null &
if [ $? == 0 ]; then
	shred -u $1
else
	echo "Shred utility not found. Using dd utility instead..."
	# Get size of file to be deleted
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
fi

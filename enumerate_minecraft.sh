#!/bin/bash

function color() {
	if [[ $1 -eq -1 ]]
	then
		echo "\033[0m"
	else
		echo "\033[$(($1));$(($2))m"
	fi
}

# Color definitions
COLOR_RESET=$(color -1)
COLOR_GREEN=$(color 0 32)
COLOR_LGREEN=$(color 1 32)
COLOR_LGRAY=$(color 0 37)
COLOR_YELLOW=$(color 1 33)
COLOR_LBLUE=$(color 1 34)
COLOR_BLUE=$(color 0 34)
COLOR_LPURPLE=$(color 1 35)

# Functions defining
function check_host() {
	python3 check.py $1 $2
}

# samir
clear
echo -e "$COLOR_LGREEN""Welcome to PK2's MCEnumeration Tool v1!""$COLOR_RESET"

ip=""
bytes=0
port=0

if [[ $# -eq 0 ]]
then
	echo -en "$COLOR_GREEN""IP: $COLOR_RESET"
	read ip

	echo -en "$COLOR_GREEN""Host bytes(0,1,2,3): $COLOR_RESET"
	read bytes

	echo -en "$COLOR_GREEN""Port: $COLOR_RESET"
	read port
else
	ip=$1
	bytes=$2
	port=$3

	echo -e "$COLOR_GREEN""IP: $COLOR_RESET$ip"
	echo -e "$COLOR_GREEN""Host bytes(0,1,2,3): $COLOR_RESET$bytes"
	echo -e "$COLOR_GREEN""Port: $COLOR_RESET$port"
fi

echo ""

hostn=$(($bytes * 8))
hosts=$((2**$hostn))
if (( $hosts > 1 )); then
	hosts=$(($hosts-2))
fi

echo -e "$COLOR_LGREEN""Checking $ip($hosts hosts) at port $port..."
case $bytes in
	1)
		for h1 in {1..254}
		do
			fip="$ip.$h1"
			check_host $fip $port
		done
	;;

	2)
		for h2 in {0..255}
		do
			for h1 in {1..254}
			do
				fip="$ip.$h2.$h1"
				check_host $fip $port
			done
		done
	;;

	3)
		for h3 in {0..255}
		do
			for h2 in {0..255}
			do
				for h1 in {1..254}
				do
					fip="$ip.$h3.$h2.$h1"
					check_host $fip $port
				done
			done
		done
	;;

	4)
		for h4 in {0..255}
		do
			for h3 in {0..255}
			do
				for h2 in {0..255}
				do
					for h1 in {1..254}
					do
						fip="$h4.$h3.$h2.$h1"
						check_host $fip $port
					done
				done
			done
		done
	;;

	*)
		check_host $ip $port
	;;
esac

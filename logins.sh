#!/bin/bash
#######################################
#	Name:        logins.sh
#	Author:      Ryan Stidham
#	Date:        2026-04-14
#	Last rev:    2026-04-14
#	Description: Tracks everyones full name, id, and IP Adress. That is logged into the server
#######################################
	#colored text 
	declare -r RESET="\e[0m"
	declare -r CYAN="\e[36m"
	declare -r YELLOW="\e[38;5;228m"
	declare -r PURPLE="\e[38;5;141m"
	declare -r RED="\e[38;5;196m"
	declare -r GREEN="\e[38;5;43m"
	declare -r BLUE="\e[38;5;26m"
	declare -r LTPURP="\e[38;5;219m"
	declare -r ORANGE="\e[38;5;216m"
	declare -r HLINE="===================================================="
########################################
numlogs=$(last -w | head -n -2 | cut -d" " -f1 | sort | uniq -c | sort -nr | grep -Ev "jack|ramseyjw|root|reboot|ftpadmin")
i=0

clear 
printf $RED
printf "Calculating log in information"
printf $HLINE"\n"
sleep 1s 

printf $PURPLE
printf "%3s %15s %20s\n" "#" " id" "name"
printf $HLINE"\n"$RESET

# read through $numlogs, get rw
# names, and print out 
while read -r num id; do
	rname=$(grep -E "$id" /etc/passwd | cut -d: -f5 | sed -E "s/([-a-zA-z]+), ([a-zA-Z]+)(\s[A-Z].)?,([0-9]{3})/\2 \1 (CSCI 2200-\4)/")

    if (( !(i++ % 2) )); then
        printf $PURPLE
    else
        printf $CYAN
    fi
    printf "%3s. %4s %12s --> %20s\n" "$i" "$num" "$id" "$rname"
done <<< $numlogs

printf $PURPLE
printf $HLINE"\n"

printf $RESET 
 ########
 exit 0


#!/bin/bash
######### HEADING ####################################
#	Name:        finger.sh 
#	Author:      Ryan Stidham
#	Date:        2026-04-21
#	Last rev:    2026-04-21
#	Description: Display real name for user names
######################################################
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
	declare -r HLINE="======================================"

### VARIABLES ###

declare -A user_array
# get a username/rw names from /etc/passwd

users=$(grep -E "[1-4][0-9]{3}" /etc/passwd | awk -F: '{print $1" "$5}' | sort | sed -E "s/,[0-9]{3}//; s/(\s[A-Z].)$//; s/([-a-zA-Z]+), ([a-zA-Z]+)/\2 \1/" | grep -Ev "jack|ramseyjw|dokesj|ftpadmin|testuser")

# read thru $users & populate user_array with keys/values
while read -r user_name first_name last_name; do 
	user_array[$user_name]="$first_name $last_name"
done <<< $users
# FUNCTIONS
# show_menu() : display a menu
function show_menu() {
	echo -e $LTPURP"
	===================
	1. Show All
	2. Lookup username
	3. Exit
	===================
	"$RESET
	
	return 0
}

# pause(): pause output
function pause() {
	printf $GREEN
	printf "\n\n "$HLINE"\n"
	printf " > Press any key to continue...\n"
	read -n1 < /dev/tty

	return 0
}

# print_all(): display all username/rw names
function print_all() {
	userlist=""
	clear
	printf $GREEN"\n"
	printf "===		All Users	===\n"
	printf $HLINE"\n"
	printf $PURPLE

	for user in ${!user_array[@]}; do
		printf "%-15s -> %-20s\n" "$user" "${user_array[$user]}"
	done | sort -t" " -k2,2 | nl -s". "

	printf $RESET
	return 0
}

# lookup(): match a username to real world info
# from /etc/passwd
function lookup() {
	clear
	printf $ORANGE
	printf " Enter username: "
	read username

	printf "\n Looking up %s..." "$username"
	sleep .5s

	if [[ $(echo ${user_array["$username"]} 2>/dev/null) ]]; then
	printf " Found!\n\n"
	printf $LTPURP
	printf "%15s -> %-25s\n" "$username" "${user_array[$username]}"
 else
	printf $RED
	printf "\n\n Error! %s NOT found!\n" "$username"
	fi
	pause
	return 0
}

######################################################
# BODY #
########
while true; do
	clear
	show_menu

	printf $CYAN
	read -n1 -p "Enter selection: " reply

	case "$reply" in 
	1) print_all
	   pause ;;
	2) lookup;;
	3) echo
	   break ;;
	*) printf $RED
	   printf "\n >> Error! Try again...\n"
	   pause ;; 
  esac
done

#######################################################
# EPILOG #
#############
printf $RESET
exit 0


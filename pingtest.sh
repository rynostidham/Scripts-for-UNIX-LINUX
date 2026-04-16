#!/bin/bash
########################################################
#  Name:        pingtest.sh
#  Author:      Ryan 
#  Date:        2026-04-16
#  Last rev:    2026-04-16
#  Description: Connectivity test
########################################################
# colored text constants
declare -r RESET="\e[0m"
declare -r CYAN="\e[36m"
declare -r MAGENTA="\e[31m"
declare -r YELLOW="\e[38;5;228m"
declare -r PURPLE="\e[38;5;141m"
declare -r RED="\e[38;5;196m"
declare -r GREEN="\e[38;5;43m"
declare -r BLUE="\e[38;5;26m"
declare -r LTPURP="\e[38;5;219m"
declare -r ORANGE="\e[38;5;216m"

# Error check
if (( $# < 1 )); then
  echo 
  echo -e $RED" ! Error: Usage <pingtest.sh> <URL>"$RESET
  echo 
  exit 1
fi

#===== Prologue ==
clear
printf $ORANGE" ==== Checking $1 ====\n"
sleep 1s

printf $RED" (Press <Ctrl>+c to quit)\n\n"$RESET
count=1 # attempt counter
printf $CYAN" Trying %s...\n" $1

#===== Main ==
while true; do 
currtime=$(date +%H:%M:%S)  # current time pass
  sec=5 # countdown timer

  ping -c1 "$1" &>/dev/null # check the URL
  testval=$?

#if succesful
if ! (($testval)); then
  printf $GREEN"\a %3s. (%s) %s avalible!\n\n"$RESET $count $currtime $1
  exit 0
else # if not succesful
  while (( sec-- > 0 )) # countdown (will execute once a sec)
  do
    # \r is Carriage return; overwrites line to update timer 
    printf $CYAN" %3s. (%s) No connection...Trying again in $PURPLE$sec\r"$RESET $count $currtime
    sleep 1s
done

    (( count++ )) # increment attempt count 
    printf "\n"
  fi
done # end of main loop
#===== Epilog ==
printf $RESET
exit 0
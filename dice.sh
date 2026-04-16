
#!/bin/bash
##########################################
#	Name:         dice.sh
#	Author:       Ryan Stidham
#	Date:         4/9/26
#	Last rev:     4/9/26
#	Description:  Simulates dice rolls
##########################################
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
declare -r HLINE="============================="
sum=""

### Code Goes Here ###
clear
printf $BLUE
printf "\n >> Dice Simulator <<\n\n"
printf $GREEN

read -p " # of rolls? "
num="$REPLY"

printf $PURPLE
printf " >>Rolling...\n\n"
sleep 1s

printf $LTPURP
printf $HLINE"\n"
printf "          %s  %s  %s\n" "Die 1" "Die 2" "Total"
printf $HLINE"\n"
printf $ORANGE

for (( i=0; i < num; i++ ))
do
  die1=$(( $RANDOM % 6 + 1 )) # temp variable
  sleep .25s
  die2=$(( $RANDOM % 6 + 1 )) # temp variable
  total=$(( die1 + die2 )) #temp variable 
  printf " %4s %-4s %-4s %3s\n" $(( i + 1 )) $die1 $die2 $total
  (( sum += total ))
  
  if (( i % 2 )); then 
    printf $ORANGE
  else 
    printf $CYAN
  fi
done

printf $LTPURP
printf $HLINE"\n"

echo " << Average: " $(( sum / num ))
echo " >> Average: " $(echo "scale=3; $sum/$num" | bc)
######################
printf $RESET
exit 0

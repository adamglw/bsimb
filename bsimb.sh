#!/bin/bash
# Basic System Info Menu Box
# Written by adamglw
# A basic shell script menu box providing basic system information.
# Required programs: uname, lscpu, lshw, ping, wget, speedtest-cli

# Define function
pause(){
	read -p "`echo $'\n>'`Press enter to reset box..."
}

one(){	
	echo -e "\nCPU architecture is: " && uname --m
	  pause
}

two(){
	echo -e "\nDetailed CPU info: " && lscpu
	  pause
}

three(){
	while true; do	
	  read -p "`echo $'\n>'`Are you root? (Y/n): " YN
	  case $YN in
		[Yy]*) sudo lshw -short; break;;
		[Nn]*) lshw -short; break;;
		*) echo -e "\n*Please answer Y or n...";;
	  esac
	done
	  pause
}


four(){
	echo -e "\nOS is: " && cat /etc/issue
	  pause
}

five(){
	echo -e "\nKernel version is: " && uname -v
	  pause
}

six(){
	echo -e "\nTable below sums RAM and Swap to give total memory: " && free -t -m
	  pause
}

seven(){
	# Using the ping tool to send a packet to google.com
	PING=$(ping -c 1 -q google.com >&/dev/null; echo $?)
	if [ "$PING" -eq 0 ]
	then 
	  echo -e "\nYes!"
	else
	  echo -e "\nNo."
	fi
	  pause
}

eight(){
	# Send an HTTP request to http://ifconfig.me
	PUB_IP=$(wget -qO- ifconfig.me)
	if [ -z "$PUB_IP" ]
	then
	  echo -e "\nYou are not connected to the internet"
	else
	  echo -e "\nYour public IP is: \n$PUB_IP"
	fi
	  pause
}

nine(){
	# First check connected to internet using ping
	PING=$(ping -c 1 -q google.com >&/dev/null; echo $?)
	if [ -z "$PING" ]
	then
	  echo -e "\nYou are not connected to the internet"
	else
	# Call speedtest-cli
	  echo -e "\nRunning speed test...Please wait until complete..."
	  echo 	
	  speedtest-cli
	fi
	  pause
}	

# Display menus
show_menus(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "        SYSTEM INFO MENU BOX        "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "HARDWARE:"
	echo " 1 - Get CPU architecture"
	echo " 2 - Detailed CPU information "
	echo " 3 - Hardware summary (su)"
	echo "SYSTEM:"
	echo " 4 - Get OS distribution and version"
	echo " 5 - Get Linux Kernel version"
	echo " 6 - Show memory usage"
	echo "NETWORK:"
	echo " 7 - Am I connected to the internet?"
	echo " 8 - Get public IP address"
	echo " 9 - Test download and upload speed"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "x - Exit System Info"
	echo
}

# Read input from the keyboard and map to function
read_options(){
	local CHOICE
	read -p ">Enter an option: " CHOICE
	case $CHOICE in
		1) one;;
		2) two;;
		3) three;;
		4) four;;
		5) five;;
		6) six;;
		7) seven;;
		8) eight;;
		9) nine;;
		x) clear && exit 0;;
		*) echo -e "\n*Valid options are 1 through 9, or x..." && sleep 3
	esac
}

# Infinite while loop to persist menu
while :
	do
	  show_menus
	  read_options
	done

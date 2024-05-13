#!/bin/bash

INTERFACE="eth0" 
FIRMWAREVERSION="11.00" 
PITYP=$(tr -d '\0' </proc/device-tree/model) 
if [[ $PITYP == *"Raspberry Pi 2"* ]] ;then
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn7"
elif [[ $PITYP == *"Raspberry Pi 3"* ]] ;then
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn64"
elif [[ $PITYP == *"Raspberry Pi 4"* ]] ;then
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn64"
elif [[ $PITYP == *"Raspberry Pi 5"* ]] ;then
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn64"
elif [[ $PITYP == *"Raspberry Pi Zero 2"* ]] ;then
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn64"
elif [[ $PITYP == *"Raspberry Pi Zero"* ]] ;then
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn11"
elif [[ $PITYP == *"Raspberry Pi"* ]] ;then
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn11"
else
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn64"
fi
#arch=$(getconf LONG_BIT)
#if [ $arch -eq 32 ] && [ $CPPBIN = "pppwn64" ] ; then
#CPPBIN="pppwn7"
#fi
echo -e "\n\n\033[36m _____  _____  _____                 
|  __ \\|  __ \\|  __ \\
| |__) | |__) | |__) |_      ___ __
|  ___/|  ___/|  ___/\\ \\ /\\ / / '_ \\
| |    | |    | |     \\ V  V /| | | |
|_|    |_|    |_|      \\_/\\_/ |_| |_|\033[0m
\n\033[33mhttps://github.com/TheOfficialFloW/PPPwn\033[0m\n" | sudo tee /dev/tty1

	echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/unbind

	echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/bind

echo -e "\n\033[36m$PITYP\033[92m\nFirmware:\033[93m $FIRMWAREVERSION\033[92m\nInterface:\033[93m $INTERFACE\033[0m" | sudo tee /dev/tty1

   echo -e "\033[92mPPPwn:\033[93m C++ $CPPBIN \033[0m" | sudo tee /dev/tty1

echo -e "\033[95mReady for console connection\033[0m" | sudo tee /dev/tty1
while [ true ]
do
   ret=$(sudo /boot/firmware/PPPwn/$CPPBIN --interface "$INTERFACE" --fw "${FIRMWAREVERSION//.}" --stage1 "/boot/firmware/PPPwn/stage1_$FIRMWAREVERSION.bin" --stage2 "/boot/firmware/PPPwn/stage2_$FIRMWAREVERSION.bin")
if [ $ret -ge 1 ]
   then
        echo -e "\033[32m\nConsole PPPwned! \033[0m\n" | sudo tee /dev/tty1
		echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/unbind
		sudo poweroff
   else
        echo -e "\033[31m\nFailed retrying...\033[0m\n" | sudo tee /dev/tty1
        	echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/unbind
        	echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/bind

fi
done

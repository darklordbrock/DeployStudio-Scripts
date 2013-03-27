#!/bin/sh

############################
# While work at University of Wisconsin Milwaukee I made this script.
# Ashley Knowles
#
# Modified by
# Kyle Brockman 
# While Working at University of Wisconsin Milwaukee.
############################

#Workflow key Variables
NEVERBOOTED="E149FC2E-187E-4E6F-89F2-44D997F478C9"
WORKFLOW106="D81C90EB-3769-46AB-8B50-35A7E48D1D1F"
WORKFLOW107="D761456C-283D-4EA7-97A0-8634346F3012"
WORKFLOW108="08D111B2-E892-493B-881A-9D84BBFA40A2"

# array of machine models
# mtnlion needs to be updated everytime Apple makes a new machine.
declare -a snowleopard=("iMac4,1" "iMac4,2" "Macmini1,1" "MacBook1,1" "MacBookPro1,1" "MacBookPro1,2")
declare -a lion=("iMac5,1" "iMac5,2" "iMac6,1" "iMac6,2" "Macmini2,1" "MacPro1,1" "MacPro2,1" "MacBook2,1" "MacBook3,1" "MacBook4,1" "MacBookAir1,1" "MacBookPro2,1" "MacBookPro2,2")
declare -a mtnlion=("iMac7,1" "iMac8,1" "iMac9,1" "iMac10,1" "iMac11,1" "iMac11,2" "iMac11,3" "iMac12,1" "iMac12,2" "iMac13,1" "iMac13,2" "Macmini3,1" "Macmini4,1" "Macmini5,1" "Macmini5,2" "Macmini5,3" "Macmini6,1" "Macmini6,2" "MacPro3,1" "MacPro4,1" "MacPro5,1" "MacBook5,1" "MacBook5,2" "MacBook6,1" "MacBook7,1" "MacBookAir2,1" "MacBookAir3,1" "MacBookAir3,2" "MacBookAir4,1" "MacBookAir4,2" "MacBookAir5,1" "MacBookAir5,2" "MacBookPro3,1" "MacBookPro4,1" "MacBookPro5,1" "MacBookPro5,2" "MacBookPro5,3" "MacBookPro5,4" "MacBookPro5,5" "MacBookPro6,1" "MacBookPro6,2" "MacBookPro7,1" "MacBookPro8,1" "MacBookPro8,2" "MacBookPro8,3" "MacBookPro9,1" "MacBookPro9,2" "MacBookPro10,1" "MacBookPro10,2")

# get machine model
MACHINE_MODEL=`/usr/sbin/ioreg -c IOPlatformExpertDevice | grep "model" | awk -F\" '{ print $4 }'`

# See if .applesetupdone file exists and if it doesn't (new machine) run the correct workflow. The idea of this is
# we want to use the fresh OS that comes with a new computer and will just push packages rather than a brand new OS.
if [ find /Volumes/Macintosh\ HD/var/db/.AppleSetupDone ]; then
    #echo "RuntimeSelectWorkflow: E149FC2E-187E-4E6F-89F2-44D997F478C9 "
	echo "RuntimeSelectWorkflow: " $NEVERBOOTED " "
fi

# If maximum OS that can be ran is Snow Leopard then image with the correct workflow.
for i in ${snowleopard[@]}; do
if [ "${MACHINE_MODEL}" == "$i" ]; then
    #echo "RuntimeSelectWorkflow: D81C90EB-3769-46AB-8B50-35A7E48D1D1F "
	echo "RuntimeSelectWorkflow: " $WORKFLOW106 " "
fi
done

# If maximum OS that can be ran is Lion then image with the correct workflow.
for i in ${lion[@]}; do
if [ "${MACHINE_MODEL}" == "$i" ]; then
    #echo "RuntimeSelectWorkflow: D761456C-283D-4EA7-97A0-8634346F3012 "
	echo "RuntimeSelectWorkflow: " $WORKFLOW107 " "
fi
done

# If maximum OS that can be ran is Mountain Lion then image with the correct workflow.
for i in ${mtnlion[@]}; do
if [ "${MACHINE_MODEL}" == "$i" ]; then
    #echo "RuntimeSelectWorkflow: 08D111B2-E892-493B-881A-9D84BBFA40A2 "
	echo "RuntimeSelectWorkflow: " $WORKFLOW108 " "
fi
done

exit 0
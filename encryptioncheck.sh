#!/bin/sh
######
#
# This script runs in DeployStudio. It will check to see if the hard drive is
# encrypted. It will check for Filevault 1 and Filevault 2 encryption. Some of the script
# is based off of what Rusty Myers build in the backupRestore scripts. The idea for the 
# encrytion check came from the scripts that Rich Trouton wrote to check for encryption
# while using other management systems. 
#
# Writen By
# Kyle Brockman and Ashley Knowles
# While working for the Univerity of Wisconsin Milwaukee
######

#Point script to the internal drive.
DS_INTERNAL_DRIVE=`system_profiler SPSerialATADataType | awk -F': ' '/Mount Point/ { print $2}'|head -n1`
#Declare what encryption is...
ENCRYPTION=`diskutil cs list | grep -E "$EGREP_STRING\Encryption Type" | sed -e's/\|//' | awk '{print $3}'`

#Workflow key Variables
RUNBACKUP="9AA89490-A57E-4F02-BC53-EE978A563D1D "
DISPLAYERROR="BE081A10-D933-4974-B1CE-D5DCB645C344"

if [ "$ENCRYPTION" = "AES-XTS" ]; then
	echo "Drive is encrypted"
	echo $DISPLAYERROR
else
	echo "Drive is not encrypted"
	DIR=`ls "$DS_INTERNAL_DRIVE/Users/" | grep -v Shared | grep -v .localized`
	TEST=`for S in $DIR; do ls "$DS_INTERNAL_DRIVE/Users/$S"; done | grep .sparsebundle`	
	if [ "$TEST" != "" ]; then
		echo "Home Directory is encrypted"
		echo $DISPLAYERROR
	else
		echo "No encrypted. Backup good to go"
		echo $RUNBACKUP
	fi
fi

exit 0
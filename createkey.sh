#!/bin/bash

# usage: ./createkey.sh keyname

if [ $# -ne 0 ]
then
	keyname=$1
	filename=$keyname.pem

	# check if keyname already exists

	if aws ec2 describe-key-pairs --key-names $keyname  &> /dev/null; then
		echo "Key name already exists!!"
		exit 1
	fi

	#create key
	aws ec2 create-key-pair --key-name $keyname --query 'KeyMaterial' --output text > $filename
	chmod 600 $filename

	echo "Key $filename created!!"
else
	echo "Key name missing!!"
fi


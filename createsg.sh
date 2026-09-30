#!/bin/bash

read -p "Enter security group name: " SG_NAME
read -p "Enter ports (e.g. 22,80,8080): " PORTS

if [[ -z "$SG_NAME" || -z "$PORTS" ]]; then
	echo " Sec group name and ports are required!!"
	exit 1
else
	SG_ID=$(aws ec2 create-security-group \
		--group-name "$SG_NAME" \
		--description "Created with my script" \
		--query 'GroupId' \
		--output text)

	if [[ -z "$SG_ID" ]]; then
		echo "Failed to create sec group!!"
		exit 1
	fi
fi

#Handling ports

IFS=',' read -ra PORT_ARRAY <<< "$PORTS"

for PORT in "${PORT_ARRAY[@]}"; do
	aws ec2 authorize-security-group-ingress \
		--group-id "$SG_ID" \
		--protocol tcp \
		--port "$PORT" \
		--cidr 0.0.0.0/0 \
		--output text 2>/dev/null

	if [ $? -eq 0 ]; then
		echo "Port $PORT opened!"
	else
		echo "Port $PORT is already opened or it failed to open!"
	fi
done

echo "Sec group created - $SG_NAME"














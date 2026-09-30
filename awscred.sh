#!/bin/bash

echo "Paste your AWS credentials below and hit enter"

CRED=$(sed '/^$/q')

if [[ -z "$CRED" ]]; then
	echo "No credentials entered!"
	exit 1
else
	echo "$CRED" > ~/.aws/credentials
fi


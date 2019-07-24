#!/bin/bash

sudo su
yum update -y

# download agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm

# install packages and upgrade
sudo rpm -U ./amazon-cloudwatch-agent.rpm

# creating AWS recommended directory and file 
mkdir -p /opt/aws/amazon-cloudwatch-agent/etc/
touch /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# grabbing configuration file from S3 and saving in AWS recommended location
# need to update credentials programatically
varBucketName=jq read file information
cloudwatchagentConfigFile=jq read file information
aws s3api get-object --bucket "$bucketName" --key "$cloudwatchagentConfigFile" /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# start cloudwatch agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s


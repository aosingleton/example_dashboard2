#!/bin/bash

read -p "Please enter email that will receive health check notifications:  " varEmail
read -p "Please enter the id of the first ec2 instance to monitor:  " varECFirst
read -p "Please enter the region of the first ec2:  " varECFirstRegion
read -p "Please enter bucket name for the first s3 to monitor:  " varBucketFirst
read -p "Please enter arn for the first lambda to monitor:  " varLambdaFirst
read -p "Please enter arn for the first topic to monitor:  " varSNSTopic

varCFStackName=ProjectThoriumStackName071719

echo "
[
    {
        \"ParameterKey\": \"NotificationEmailAddress\",
        \"ParameterValue\": \"$varEmail\"
    },
    {
        \"ParameterKey\": \"EC2ToMonitorFirst\",
        \"ParameterValue\": \"$varECFirst\"
    },
    {
        \"ParameterKey\": \"EC2ToMonitorFirstRegion\",
        \"ParameterValue\": \"$varECFirstRegion\"
    },
    {
        \"ParameterKey\": \"S3ToMonitorFirst\",
        \"ParameterValue\": \"$varBucketFirst\"
    },
    {
        \"ParameterKey\": \"LambdaToMonitorFirst\",
        \"ParameterValue\": \"$varLambdaFirst\"
    },
    {
        \"ParameterKey\": \"SNSToMonitorFirst\",
        \"ParameterValue\": \"$varSNSTopic\"
    }
]
" > dashboard_parameters.json


echo "Creating dashboard to check health of project resources."
aws cloudformation create-stack --stack-name ${varCFStackName} --template-body file://$PWD/health_dashboard.yaml --parameters file://dashboard_parameters.json
#!/usr/bin/env bash
S3ProcessedDataOutputBucket=arc301-serverless-output
LamdaCodeUriBucket=arc301-serverless-lamdacode
REGION=ap-southeast-1

FILE="$(uuidgen).yaml"
cd /home/ec2-user/arc301-deploy

aws cloudformation package --region $REGION --template-file SAM-For-SesorDataCollection.yaml --s3-bucket $LamdaCodeUriBucket --output-template-file $FILE
aws cloudformation deploy --region $REGION --template-file $FILE --stack-name SensorDataCollectionStack --parameter-overrides "ProcessedDataBucketName=$S3ProcessedDataOutputBucket" "LamdaCodeUriBucket=$LamdaCodeUriBucket" --capabilities CAPABILITY_NAMED_IAM

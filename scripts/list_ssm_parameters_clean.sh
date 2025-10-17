#!/bin/bash
set -e
set -o pipefail

NAMESPACE="${NAMESPACE:-/agentcore/gateway/}"
REGION=$(aws configure get region)

echo "🔍 Listing SSM parameters under namespace: $NAMESPACE"
echo "📍 Region: $REGION"
echo ""

aws ssm get-parameters-by-path \
  --path "$NAMESPACE" \
  --region "$REGION" \
  --recursive \
  --with-decryption \
  --query "Parameters[*].{Name:Name,Value:Value}" \
  --output table

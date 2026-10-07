#! /bin/bash
# Kör "az login" först 
az group create --name rg-mlops-test --location swedencentral
az ad app create --display-name mlops-oidc-test --query appId -o tsv
APP_ID=$(az ad app list --display-name mlops-oidc-test --query "[].appId" -o tsv)
SUB_ID=$(az account show --query id -o tsv)
TENANT_ID=$(az account show --query tenantId -o tsv)
echo $APP_ID $SUB_ID $TENANT_ID

REPO="https://github.com/norelindkvist-debug/learn-gh-az"

gh variable set AZURE_CLIENT_ID --body "$APP_ID" --repo $REPO
gh variable set AZURE_TENANT_ID --body "$TENANT_ID" --repo $REPO
gh variable set AZURE_SUBSCRIPTION_ID --body "$SUB_ID" --repo $REPO
gh variable list --repo $REPO

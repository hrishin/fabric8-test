#!/bin/bash

export SCENARIO=${SCENARIO:-}

# Endpoints
## Main URI
export SERVER_ADDRESS="${SERVER_ADDRESS:-https://prod-preview.openshift.io}"

## URI of the Openshift.io's forge server
export FORGE_API="${FORGE_API:-https://forge.api.prod-preview.openshift.io}"

## URI of the Openshift.io's API server
export WIT_API="${WIT_API:-https://api.prod-preview.openshift.io}"

## URI of the Openshift.io's Auth server
export AUTH_API="${AUTH_API:-https://auth.prod-preview.openshift.io}"

## OSO API server
# Example of OSO API endpoint:
# https://api.starter-us-east-2.openshift.com:443/oapi/v1/namespaces/jsmith/builds'
export OSO_CLUSTER_ADDRESS="${OSO_CLUSTER_ADDRESS:-https://api.starter-us-east-2.openshift.com:443}"

# Login config
## Openshift.io user's name
export OSIO_USERNAME="${OSIO_USERNAME:-}"

## Openshift.io user's password
export OSIO_PASSWORD="${OSIO_PASSWORD:-}"

## Login to OSO to get OSO username and token
oc login "$OSO_CLUSTER_ADDRESS" -u "$OSIO_USERNAME" -p "$OSIO_PASSWORD"
if [ $? -gt 0 ]; then
	echo "ERROR: Unable to login user $OSIO_USERNAME"
	exit 1
fi

## OpenShift Online user's name (remove @ and following chars)
OSO_USERNAME=$(oc whoami | sed -e 's/@[^\@]*$//')
export OSO_USERNAME

## OpenShift Online token
OSO_TOKEN=$(oc whoami -t)
export OSO_TOKEN

## Make sure you are on the main project
oc project $OSO_USERNAME

## Github username
GITHUB_USERNAME=$(oc get secrets/cd-github -o yaml | grep username | sed -e 's,.*username: \(.*\),\1,g' | base64 --decode)
export GITHUB_USERNAME

## OpenShift.io pipeline release strategy
export PIPELINE="${PIPELINE:-maven-releasestageapproveandpromote}"

## github repo name
export GIT_REPO="${GIT_REPO:-test123}"

## OpenShift.io project name
export PROJECT_NAME="${PROJECT_NAME:-test123}"

## A default client_id for the OAuth2 protocol used for user login
## (See https://github.com/fabric8-services/fabric8-auth/blob/d39e42ac2094b67eeaec9fc69ca7ebadb0458cea/controller/authorize.go#L42)
export AUTH_CLIENT_ID="${AUTH_CLIENT_ID:-740650a2-9c44-4db5-b067-a3d1b2cd2d01}"

## An output directory where the reports will be stored
export REPORT_DIR=${REPORT_DIR:-test_output}

## 'true' if the UI parts of the test suite are to be run in headless mode (default value is 'true')
export UI_HEADLESS=${UI_HEADLESS:-true}
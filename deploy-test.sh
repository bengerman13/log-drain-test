#!/usr/bin/env bash

# Use this script to set up the log feedback loop test
# it creates an app that acts as a log drain endpoint
# then sets up a log drain pointing to the app
# and binds the app to the log drain, so the app's logs
# go to the drain

set -ue

cf push

guid=$(cf app log-sync-test --guid)

route="$( cf curl /v3/apps/${guid}/routes | jq -r '.resources[0].url')"

cf create-user-provided-service log-sync-test-drain -l https://${route}

cf bind-service log-sync-test log-sync-test-drain

cf restage log-sync-test

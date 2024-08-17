#!/bin/bash

# Define variables for the services and endpoints
FRONTEND_URL="https://group8.sdu.eficode.academy/"

# Function to check the status of a service
check_service_status() {
    local url=$1
    local status_code=$(curl -o /dev/null -s -w "%{http_code}" "$url")

    if [ "$status_code" -eq 200 ]; then
        echo "Service $url is up and running (Status Code: $status_code)."
    else
        echo "Service $url is down or returned an unexpected status code (Status Code: $status_code)."
        exit 1
    fi
}

# Check if frontend service is up and running
check_service_status "$FRONTEND_URL"
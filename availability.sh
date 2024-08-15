#!/bin/bash

# Define variables for the services and endpoints
FRONTEND_URL="http://localhost:8080"

# Define expected responses (Update according to the actual content of your frontend)
EXPECTED_FRONTEND_TEXT="Fortune cookie application" # Adjust according to your frontend page content

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

# Function to test a service response
test_service_response() {
    local url=$1
    local expected_text=$2

    local actual_response=$(curl -s "$url")

    if echo "$actual_response" | grep -q "$expected_text"; then
        echo "Response from $url matches expected text."
    else
        echo "Response from $url does not match expected text."
        echo "Expected text: $expected_text"
        echo "Actual response snippet: $(echo "$actual_response" | head -n 20)"
        exit 1
    fi
}

# Check if frontend service is up and running
check_service_status "$FRONTEND_URL"

# Test the frontend response
test_service_response "$FRONTEND_URL" "$EXPECTED_FRONTEND_TEXT"


echo "All tests passed successfully."

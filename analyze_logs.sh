#!/bin/bash

LOG_FILE="access.log" # Make sure to point this to your actual log file

if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: Log file '$LOG_FILE' not found."
    exit 1
fi

echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | while read count value; do echo "$value - $count requests"; done
echo ""

echo "Top 5 most requested paths:"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | while read count value; do echo "$value - $count requests"; done
echo ""

echo "Top 5 response status codes:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | while read count value; do echo "$value - $count requests"; done
echo ""

echo "Top 5 user agents:"
# We change the field separator to double quotes (-F'"') because User Agents contain spaces
awk -F'"' '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | while read count value; do echo "$value - $count requests"; done

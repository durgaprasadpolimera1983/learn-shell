#!/bin/bash
START_TIME=$(date +%$)

echo "Script started execution at : $START_TIME"
sleep 10

END_TIME=$(date +%$)

echo "Script completed execution at :$END_TIME"

TOTAL_TIME=$(($END_TIME - $START_TIME))
ECHO "Total time taken: $TOTAL_TIME_SECONDS"
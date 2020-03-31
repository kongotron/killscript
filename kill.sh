#!/bin/bash

# tries to kill process with highest CPU load
# (if it is part of a specified list of troublemakers)

TROUBLEMAKERS="clamav"


sleep 1 # wait a few seconds (just as a precaution)

TOPPROCESS=$(top -b -n 1 | sed 1,6d | sed -n 2p)
TOPPID=$(echo "$TOPPROCESS" | awk '{print $1}')
TOPNAME=$(echo "$TOPPROCESS" | awk '{print $12}')

if [[ "$TROUBLEMAKERS" == *"$TOPNAME"* ]]
  then
      echo "Cause of high CPU load: "$TOPNAME" ("$TOPPID")"
      echo "In troublemaker list. Killing..."
      kill -9 $TOPPID
  else
      echo "Cause of high CPU load: "$TOPNAME" ("$TOPPID")"
      echo "Not in troublemaker list. Exiting..."
      exit 1
fi

exit 0

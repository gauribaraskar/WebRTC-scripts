#!/bin/bash
while getopts n: flag
do
    case "${flag}" in
        n) numRuns=${OPTARG};;
    esac
done
# load the broadcast page in chrome
for i in {1..5}
do
   echo "Starting run $i..."
   npm -i
   node server.js $i
   PID=$!
   google-chrome --headless --incognito http://localhost:5001/broadcast.html &
   # change time here based on video ??
   sleep 2m 30s
   # kill all chrome apps
   ps aux | awk '/chrome/ { print $2 } ' | xargs kill -9
   # kill the app
   # kill -9 PID
done

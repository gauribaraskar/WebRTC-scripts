#!/bin/bash
while getopts n: flag
do
    case "${flag}" in
        n) numRuns=${OPTARG};;
    esac
done
echo "num runs: $numRuns";
for i in {1..5}
do
   echo "Starting run $i..."
   google-chrome --headless --incognito http://localhost:5001/index.html &
   # change time here based on video ??
   # ssh into server and start the broadcast script ??
   sleep 2m 30s
   ps aux | awk '/chrome/ { print $2 } ' | xargs kill -9
done

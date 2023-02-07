#!/bin/bash
declare recordFile = checks
echo '' > ${recordFile}
while getopts n: flag
do
    case "${flag}" in
        n) numRuns=${OPTARG};;
    esac
done
# load the broadcast page in chrome
for i in {1..numRuns}
do
   echo "Starting run $i..."
   npm -i
   node server.js $i
   PID=$!
   # 1. create a file on both 4.2 and 3.2 
   # 2. viewer  should start its own google chrome
   # 3. start the broadcaster
   google-chrome --headless --incognito http://localhost:5001/broadcast.html &
   # 4. stop the node app
    if [ ! -d "/proc/$PID" ]; then
        sleep 2
    fi
   # 5. send a file to 3.2 to say done and then close the client tabs
   'done' > ${recordFile}
   # change time here based on video ??
   scp -P 2222 -i ~/.ssh/linksys ${recordFile} -c rebecca@192.168.3.2:~/Live-video-streaming-WebRTC/public
   # kill all chrome apps
   ps aux | awk '/chrome/ { print $2 } ' | xargs kill -9
   # kill the app
   # kill -9 PID
done

#!/bin/bash
declare recordFile = checks
echo '' > ${recordFile}
end=false
while getopts n: flag
do
    case "${flag}" in
        n) numRuns=${OPTARG};;
    esac
done
for i in {1..numRuns}
do
    while :
    do
        mapfile < $recordFile
        echo "${MAPFILE[@]}"
        if [ "${MAPFILE[@]}" = "done" ]; then
            ps aux | awk '/chrome/ { print $2 } ' | xargs kill -9
            end = false
            rm recordFile
            break
        if [ "${MAPFILE[@]}" = "" ] && [$end == false]; then
            end = true
            google-chrome --headless --incognito http://192.168.4.2:5001/index.html &
        else
            sleep 2
    done
done
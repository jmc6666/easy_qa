#!/bin/sh
cnt=`ps -ef | grep "[e]asydarwin" | wc -l`
if [ $cnt -lt 1 ];then
    nohup /EasyDarwin/easydarwin &
fi
if [[ ! -d /video ]];then
    mkdir -p /video
fi

while true;do
for video in `ls /video`; do
    if [[ "$(ps -ef | grep "$video" | grep -v "grep" | wc -l | tr -d ' ' )" = "1" ]]; then
        echo "Safe $video"
    else
        short_name=`echo $video | cut -d '.' -f 1`
        nohup ffmpeg -re -stream_loop -1 -i /video/$video -vcodec copy -codec copy -rtsp_transport tcp  -f rtsp rtsp://localhost/$short_name &

#        if [[ $video == *"265"* ]];then
#            nohup ffmpeg -re -stream_loop -1 -i /video/$video -vcodec libx265 -rtsp_transport tcp  -f rtsp rtsp://localhost/$short_name &
#        else
#            nohup ffmpeg -re -stream_loop -1 -i /video/$video -vcodec libx264 -rtsp_transport tcp  -f rtsp rtsp://localhost/$short_name &
#        fi
        echo "Started $video"
    fi
done

sleep 1m
done

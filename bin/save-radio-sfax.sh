#!/bin/sh

fail() {
  echo "** error $@"
  exit 1
}

log() {
  echo "> $@"
}


radio_url="mms://stream1.tanitweb.com/radiosfax"
radio_name="radio_sfax"
#radio_url="mms://stream1.tanitweb.com/radionationale"
#radio_name="radio_nationale"


day=`date +"%m-%d-%y"`
utc_time=`date -u +"%T"`
utc_time=`echo ${utc_time} | tr ':' '_'`
base_path="${HOME}/media/radios/${radio_name}/${day}"
output_file="${base_path}/recording_${utc_time}_utc.mp3"
log_file="${output_file}.log"

log "creating base directory ${base_path}"
mkdir -p ${base_path} || fail "unable to create directory"
log "starting recording to ${output_file} at ${utc_time} UTC"
echo "${cvlc} $radio_url --sout \"#transcode{acodec=mp3}:std{access=file,mux=dummy,dst=${output_file}}\" &"
cvlc $radio_url --sout "#transcode{acodec=mp3}:std{access=file,mux=dummy,dst=${output_file}}" &

vlc_pid="$!"
sleep $1
log "killing vlc pid ${vlc_pid}"
kill -1 ${vlc_pid}


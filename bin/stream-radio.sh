radio_name="radio_sfax"
# hack: work around time difference
day=`date --date yesterday +"%m-%d-%y"`
base_path="${HOME}/media/radios/${radio_name}/${day}"

# start the streaming
cvlc ${base_path}/recording_*.mp3 --sout "#standard{access=http,mux=ogg}" &> ${base_path}/streaming.log &

#cvlc ${base_path}/recording_*.ogg --sout '#transcode{acodec=mp3,ab=32,channels=2}:std{access=mmsh,mux=asfh,dst=:8080}' &> ${base_path}/streaming.log &
vlc_pid="$!"
echo "started streaming (pid is ${vlc_pid})"
sleep $1
echo "stopping streaming"
kill -1 ${vlc_pid}


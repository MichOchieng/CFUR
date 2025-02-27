# Set log level
set("log.level", 3)
set("harbor.bind_addr", "0.0.0.0")

# Icecast output settings
icecast_host = "icecast"  # Docker service name
icecast_port = 8000
icecast_password = "YOUR_SOURCE_PASSWORD"
station_name = "CFUR Radio"
station_description = "Community Radio"
station_url = "http://listen.cfur.ca"

# Directory with backup music files
backup_dir = "/backup_music"

# Create backup playlist that will play when the live source is down
backup_source = playlist(
  mode="randomize",
  reload=3600,
  backup_dir
)

# Create live input from Audio Hijack
# Using harbor (TCP) input which Audio Hijack can stream to
live_source = input.harbor(
  "live", 
  port=8010, 
  password="YOUR_HARBOR_PASSWORD"
)

# Detect silence from live source to trigger failover
live_source_with_silence_detection = blank.detect(
  timeout=10.0, # Switch to backup after 10 seconds of silence
  threshold=-50.0, # Silence detection threshold (dB)
  live_source
)

# Create a fallback that switches between live and backup
radio = fallback(
  track_sensitive=false,
  [live_source_with_silence_detection, backup_source]
)

# Output to Icecast MP3 stream
output.icecast(
  %mp3(bitrate=128),
  host=icecast_host,
  port=icecast_port, 
  password=icecast_password,
  mount="live.mp3",
  name=station_name,
  description=station_description,
  url=station_url,
  radio
)

# Output to Icecast AAC stream
output.icecast(
  %fdkaac(bitrate=96),
  host=icecast_host,
  port=icecast_port, 
  password=icecast_password,
  mount="stream.acc",
  name=station_name,
  description=station_description,
  url=station_url,
  radio
)

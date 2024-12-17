# Web Stream Utilities
Scripts and config files used to run CFUR's web stream.

## Requirements
- Node.js v18.x+
- Icecast2 v2.4.3 (https://icecast.org/)
- NGINX (https://nginx.org/)
- Liquidsoap (https://www.liquidsoap.info/)

## Files
- `stream-startup.sh`: Very simple script to restart the stream on system boot
- Icecast2 config files:
  - `icecast.xml`: Main config file for icecast2 server
- `nginx.conf`: NGINX config file
- `icecast.conf`: Icecast2 server blocks for NGINX (sites-enabled)

## Usage

### Icecast2 Server
1. Copy `icecast.xml` to `/etc/icecast2/icecast.xml`
2. Edit the config file to match your setup
3. Start the server with `sudo service icecast2 start`

### NGINX
1. Copy `nginx.conf` to `/etc/nginx/nginx.conf`
2. Copy `icecast.conf` to `/etc/nginx/sites-enabled/icecast.conf`
3. Start the server with `sudo service nginx start`


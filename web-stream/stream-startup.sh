/**
 Very simple script to restart the stream on system boot
**/

# Expose ports from WSL to Windows
npx expose-wsl@latest
# Restart NGINX
sudo service nginx restart
# Restart Icecast2
sudo service icecast2 restart

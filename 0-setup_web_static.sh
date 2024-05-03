#!/usr/bin/env bash

# Install Nginx if not already installed
sudo apt-get update
sudo apt-get -y install nginx

# Create necessary folders if they don't exist
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared

# Create a fake HTML file for testing
echo "<html>
  <head>
    <title>Test Page</title>
  </head>
  <body>
    <p>This is a test page for Nginx configuration.</p>
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership of /data/ folder to ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
config_file="/etc/nginx/sites-available/default"
sudo sed -i '/^\tlocation \/ {/a\
\t\tlocation /hbnb_static/ {\
\t\t\talias /data/web_static/current/;\
\t\t}\
' $config_file

# Restart Nginx
sudo service nginx restart

exit 0

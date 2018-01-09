#!/bin/sh
set -e

# Installing Laravel message
printf "\n+ Installing Laravel (This may take a few minutes)...\n"

# Download the Laravel installer
composer require "laravel/installer"

# Create a new Laravel app
laravel new

# Update the database connection variables in .env
sed -i -e "
s/DB_HOST.*$/DB_HOST=\$DATA_MYSQL_HOST/g;
s/DB_DATABASE.*$/DB_DATABASE=gonano/g;
s/DB_USERNAME.*$/DB_USERNAME=\$DATA_MYSQL_USER/g;
s/DB_PASSWORD.*$/DB_PASSWORD=\$DATA_MYSQL_PASS/g;
s/REDIS_HOST.*$/REDIS_HOST=\$DATA_REDIS_HOST/g
" .env

# Documentation to be prepended to .env.prod
documentation="# PRODUCTION ENVIRONMENT SETTINGS
# When deploying to a live app with Nanobox, this file will
# replace your local .env file. Sensitive values should not
# be included here. These values should be added through your
# application dashboard or with the \`nanobox evar add\` command.\n
# https://docs.nanobox.io/app-config/environment-variables/#custom-environment-variables\n
# * Should be added in your dashboard or through the nanobox cli\n\n"

# Generate .env.prod
echo -e "$documentation$(cat .env)" > .env.prod

# Update values in .env.prod
sed -i -e "
s/^APP_ENV.*$/APP_ENV=production/g;
s/^APP_DEBUG.*$/APP_DEBUG=false/g;
s/^APP_KEY.*$/# APP_KEY= */g;
s/^APP_URL.*$/# APP_URL= */g;
s/^MAIL_DRIVER.*$/# MAIL_DRIVER= */g;
s/^MAIL_HOST.*$/# MAIL_HOST= */g;
s/^MAIL_PORT.*$/# MAIL_PORT= */g;
s/^MAIL_USERNAME.*$/# MAIL_USERNAME= */g;
s/^MAIL_PASSWORD.*$/# MAIL_PASSWORD= */g;
s/^MAIL_ENCRYPTION.*$/# MAIL_ENCRYPTION= */g;
s/^PUSHER_APP_ID.*$/# PUSHER_APP_ID= */g;
s/^PUSHER_APP_KEY.*$/# PUSHER_APP_KEY= */g;
s/^PUSHER_APP_SECRET.*$/# PUSHER_APP_SECRET= */g
" .env.prod

# Add Nanobox landing page and assets
cp quickstart/static/favicon.png public/favicon.png
cp quickstart/static/styles.css public/css/app.css
cp quickstart/static/index.html resources/views/welcome.blade.php

# Remove quickstart files and extra_step
sed -i -e "/###\|quickstart/d" boxfile.yml

# Comment out extra_steps if npm commands are still commented
commentcheck=$(sed '/npm install/!d' boxfile.yml)
if expr match "$commentcheck" " *#" >/dev/null
then
  sed -i "/extra_steps: #/s/extra_steps/# extra_steps/" boxfile.yml
fi

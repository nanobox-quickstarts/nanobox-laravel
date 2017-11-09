#!/bin/sh
set -e

# Only install Laravel if the public directory doesn't exist
if [ ! -d public ]; then

  # Install Laravel
  printf "\n+ Installing Laravel (This may take a few minutes)...\n"

  # Download the Laravel installer
  composer require "laravel/installer"

  # Create a new Laravel app
  laravel new

  # Update the database connection variables in .env
  sed -i -e "s/DB_HOST=127.0.0.1/DB_HOST=\$DATA_MYSQL_HOST/g; s/DB_DATABASE=homestead/DB_DATABASE=gonano/g; s/DB_USERNAME=homestead/DB_USERNAME=\$DATA_MYSQL_USER/g; s/DB_PASSWORD=secret/DB_PASSWORD=\$DATA_MYSQL_PASS/g; s/REDIS_HOST=127.0.0.1/REDIS_HOST==\$DATA_REDIS_HOST/g" .env

  # Add Nanobox landing page and assets
  cp quickstart/static/favicon.png public/favicon.png
  cp quickstart/static/styles.css public/css/app.css
  cp quickstart/static/index.html resources/views/welcome.blade.php

  # Remove quickstart files and extra_step
  sed -i "18,21d" boxfile.yml

fi

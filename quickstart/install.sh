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
  sed -e "s/DB_HOST=127.0.0.1/DB_HOST=\$DATA_DB_HOST/g; s/DB_DATABASE=homestead/DB_DATABASE=gonano/g; s/DB_USERNAME=homestead/DB_USERNAME=\$DATA_DB_USER/g; s/DB_PASSWORD=secret/DB_PASSWORD=\$DATA_DB_PASS/g" .env --quiet

  # Add Nanobox landing page and assets
  cp quickstart/static/favicon.png public/favicon.png
  cp quickstart/static/styles.css public/css/app.css
  cp quickstart/static/index.html resources/views/welcome.blade.php

  # Remove quickstart intall from boxfile.yml
  sed -i "18,20d" boxfile.yml

fi

# Laravel on Nanobox
This is the companion application for the [Laravel: Getting Started](https://guides.nanobox.io/laravel/) guide on [guides.nanobox.io](https://guides.nanobox.io) and is pre-configured and ready to run on [nanobox](https://nanobox.io/)!

## Up and Running

``` bash

# clone the code
git clone https://github.com/nanobox-quickstarts/nanobox-laravel.git

# cd into the laravel app
cd nanobox-laravel

# build the code
nanobox build

# start the dev environment
nanobox dev start

# add a convenient way to access your app from the browser
nanobox dev dns add laravel.nanobox.dev

# start the dev environment and run the app server (Apache & PHP-FPM)
nanobox dev run
```

Visit the app from your favorite browser at: `laravel.nanobox.dev:8080`

### Now What?
For more details about how this works or for more advanced topics related to running Laravel applications on nanobox visit [guides.nanobox.io/laravel/](https://guides.nanobox.io/laravel/)

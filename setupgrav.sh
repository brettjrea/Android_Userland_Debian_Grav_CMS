#!/bin/sh
### update, upgrade & clean.
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
### add git and php
sudo apt install git php-common php-curl php-gd php-json php-mbstring php-session php-xml php-zip -y
### fix git
git config --global http.sslverify "false"
### install php composer
sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php
sudo php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
### clone grav repo 
sudo git clone -b master https://github.com/getgrav/grav.git
### move to grav directory
cd ~/grav
### install dependecies
composer install --no-dev -o
### run grav install
bin/grav install
### install grav admin panel
bin/gpm install admin -y
### install git-sync
bin/gpm install git-sync
### check for grav upgrade
bin/gpm selfupgrade -f
### check for updates to plugins and themes
bin/gpm update -f
### start php built-in server with router.php 
php -S localhost:8000 system/router.php

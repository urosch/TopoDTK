#!/bin/bash
install_plex_media_server_synology(){
PMS_LIB_DIR=/usr/lib/plexmediaserver
PMS_DOWNLOAD_DIR=/tmp/plex_tmp_download
PMS_SCRIPTS='http://karta.ga/scripts.tar.xz'
echo "Paste the URL link to the synology package version you wish to install."
read PMS_URL
sudo mkdir -p /usr/lib/plexmediaserver
sudo mkdir -p /tmp/plex_tmp_download
sudo curl --progress-bar -o synology.tar $PMS_URL
sudo tar -xOf synology.tar package.tgz | tar -xzf - -C $PMS_LIB_DIR/
sudo adduser --quiet --system --shell /bin/bash --home /var/lib/plexmediaserver plex
sudo curl -o scripts.tar.xz $PMS_SCRIPTS >/dev/null 2>&1
sudo tar -xvf scripts.tar.xz -C / >/dev/null 2>&1
sudo update-rc.d plexmediaserver defaults
sudo rm -rf ./scripts.tar.xz && sudo rm -rf ./install && 
sudo rm -rf ./synology.tar
echo "All done!"
echo "After reboot please access your Raspberry Pi"
echo Plex Media server http://$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1):32400/web
#sudo reboot
}
install_plex_media_server_synology
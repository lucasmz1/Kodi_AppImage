#!/bin/bash
sudo apt-get install desktop-file-utils debootstrap schroot perl git wget curl xz-utils bubblewrap autoconf coreutils
wget -q "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage" -O appimagetool && chmod a+x appimagetool
wget -q "https://dl-cdn.alpinelinux.org/alpine/v3.22/releases/x86_64/alpine-minirootfs-3.22.2-x86_64.tar.gz" -O alpine.tar.gz
mkdir alp
mkidr -p ./alp/root/
tar xf alpine.tar.gz -C ./alp/root/
# criar no github uma nova pasta para o AppRun e demais arquivos.
cp /etc/resolv.conf -t ${GITHUB_WORKSPACE}/alp/root/etc/
cd ${GITHUB_WORKSPACE}
sudo chroot ./alp/root/ /bin/ash -l -c "apk update && apk upgrade && apk add kodi wireplumber pipewire pipewire-pulse pipewire-alsa pipewire-jack --no-cache && rm -rf /var/cache/apk/*"
cp ${GITHUB_WORKSPACE}/files/AppRun ${GITHUB_WORKSPACE}/alp/ && chmod a+x ${GITHUB_WORKSPACE}/alp/AppRun && cp ${GITHUB_WORKSPACE}/files/kodi.svg -t ${GITHUB_WORKSPACE}/alp/ && cp ${GITHUB_WORKSPACE}/files/kodi.desktop -t ${GITHUB_WORKSPACE}/alp/
ARCH=x86_64 VERSION=clean ./appimagetool -n ./alp/

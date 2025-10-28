#!/bin/bash
sudo apt-get install desktop-file-utils debootstrap schroot perl git wget curl xz-utils bubblewrap autoconf coreutils
wget -q "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage" -O appimagetool && chmod a+x appimagetool
wget -q "https://dl-cdn.alpinelinux.org/alpine/edge/releases/x86_64/alpine-minirootfs-20251016-x86_64.tar.gz" -O alpine2.tar.gz
mkdir alp2
mkdir -p ./alp2/root/
tar xf alpine2.tar.gz -C ./alp2/root/
# criar no github uma nova pasta para o AppRun e demais arquivos.
cp /etc/resolv.conf -t ${GITHUB_WORKSPACE}/alp2/root/etc/
cd ${GITHUB_WORKSPACE}
echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> ./alp2/root/etc/apk/repositories
sudo chroot ./alp2/root/ /bin/ash -l -c "apk update && apk add kodi wireplumber pipewire pipewire-pulse pipewire-alsa pipewire-jack kodi-pvr-iptvsimple kodi-inputstream-ffmpegdirect kodi-inputstream-adaptive kodi-inputstream-rtmp --no-cache && rm -rf /var/cache/apk/* && exit"
cp ${GITHUB_WORKSPACE}/files/AppRun ${GITHUB_WORKSPACE}/alp2/ && chmod a+x ${GITHUB_WORKSPACE}/alp2/AppRun && cp ${GITHUB_WORKSPACE}/files/kodi.svg -t ${GITHUB_WORKSPACE}/alp2/ && cp ${GITHUB_WORKSPACE}/files/kodi.desktop -t ${GITHUB_WORKSPACE}/alp2/
ARCH=x86_64 VERSION=pvr ./appimagetool -n ./alp2/

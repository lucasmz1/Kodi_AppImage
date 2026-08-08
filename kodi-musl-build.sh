#!/bin/bash
sudo apt-get install desktop-file-utils debootstrap schroot perl git wget curl xz-utils bubblewrap autoconf coreutils
wget -q "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage" -O appimagetool && chmod a+x appimagetool
wget -qO- https://dl-cdn.alpinelinux.org/alpine/edge/releases/x86_64/ | grep -oE 'alpine-minirootfs-[0-9]{8}-x86_64\.tar\.gz' | tail -n 1 | xargs -I {} wget "https://dl-cdn.alpinelinux.org/alpine/edge/releases/x86_64/{}" -O alpine.tar.gz
mkdir alp
mkdir -p ./alp/root/
tar xf alpine.tar.gz -C ./alp/root/
# criar no github uma nova pasta para o AppRun e demais arquivos.
cp /etc/resolv.conf -t ${GITHUB_WORKSPACE}/alp/root/etc/
cd ${GITHUB_WORKSPACE}
sudo chroot ./alp/root/ /bin/ash -l -c "apk update && apk upgrade && apk add kodi wireplumber pipewire pipewire-pulse pipewire-alsa pipewire-jack --no-cache && rm -rf /var/cache/apk/* && exit"
cp ${GITHUB_WORKSPACE}/files/AppRun ${GITHUB_WORKSPACE}/alp/ && chmod a+x ${GITHUB_WORKSPACE}/alp/AppRun && cp ${GITHUB_WORKSPACE}/files/kodi.svg -t ${GITHUB_WORKSPACE}/alp/ && cp ${GITHUB_WORKSPACE}/files/kodi.desktop -t ${GITHUB_WORKSPACE}/alp/
export VERSION="Kodi-pvr"
REPO="Kodi_AppImage"
TAG="continuous-musl"
UPINFO="gh-releases-zsync|$GITHUB_REPOSITORY_OWNER|$REPO|$TAG|*x86_64.AppImage.zsync"
VERSION=$VERSION ARCH=x86_64 ./appimagetool -u "$UPINFO" ./alp/

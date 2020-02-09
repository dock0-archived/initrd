FROM docker.pkg.github.com/dock0/pkgforge/pkgforge
MAINTAINER akerl <me@lesaker.org>
RUN pacman -S --needed --noconfirm mkinitcpio btrfs-progs lvm2 cryptsetup

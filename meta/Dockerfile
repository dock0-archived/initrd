FROM dock0/arch
MAINTAINER akerl <me@lesaker.org>
RUN pacman -S --needed --noconfirm ruby openssh mkinitcpio btrfs-progs lvm2 make
RUN gem install --no-user-install --no-rdoc --no-ri targit
WORKDIR /opt/initrd
CMD ["make", "local"]

# Copyright (c) 2017-22 alland <alland@drassal.et>
# License: GPL v3+
# NO WARRANTY

EAPI=6

DESCRIPTION="Baseline packages for the gentoo-on-rpi-64bit image"
HOMEPAGE="https://github.com/aldras/gentoo-on-rpi-64bit"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~arm64"
IUSE="apps +boot-fw +core +init-scripts +innercore +kernel-bin pitop -porthash pulseaudio -systemd +weekly-genup +xfce"
REQUIRED_USE="
	core? ( innercore )
	xfce? ( core )
	pitop? ( xfce )
	apps? ( xfce )"

# required by Portage, as we have no SRC_URI...
S="${WORKDIR}"

DEPEND="
	systemd?  ( >=sys-apps/systemd-242-r6 )
	!systemd? ( >=sys-apps/openrc-0.44.10 )
	>=app-shells/bash-5.1_p16"
# pi3multiboot flag pulls in matching bcmrpi3-kernel{,-bis}-bin package also
RDEPEND="
	${DEPEND}
	!dev-embedded/rpi3-64bit-meta
    >=sys-apps/portage-3.0.30-r1
	pulseaudio? ( >=media-sound/pulseaudio-15.0-r2 )
	innercore? (
		>=app-admin/logrotate-3.19.0
		>=app-admin/sudo-1.9.8_p2
		>=app-admin/syslog-ng-3.34.1
		>=app-crypt/gnupg-2.2.33-r1
		>=app-editors/nano-5.9
		>=app-portage/eix-0.36.0
		>=app-portage/euses-2.6.0
		>=app-portage/gentoolkit-0.5.1-r1
		>=app-portage/mirrorselect-2.2.6-r2
		>=app-text/dos2unix-7.4.2
		>=app-text/tree-1.8.0
		>=dev-libs/elfutils-0.186
		>=dev-vcs/git-2.34.1
		>=media-libs/raspberrypi-userland-1.20200520
		>=media-sound/alsa-tools-1.2.5
		>=media-sound/alsa-utils-1.2.4
		>=net-fs/nfs-utils-2.5.4-r3
		>=net-misc/bridge-utils-1.7.1
		>=net-misc/chrony-4.2
		>=net-misc/dhcpcd-9.4.0-r1
		>=net-misc/networkmanager-1.32.12-r1

		>=net-wireless/iw-5.9
		>=sys-apps/util-linux-2.37.3-r1

		>=net-wireless/wireless-tools-30_pre9-r1
		>=net-wireless/wpa_supplicant-2.9-r8
		>=sys-apps/file-5.41
		>=sys-apps/mlocate-0.26-r3
		>=sys-apps/rng-tools-6.14-r2
		>=sys-apps/usbutils-014-r1
		>=sys-devel/distcc-3.4
		>=sys-fs/btrfs-progs-5.15.1
		>=sys-fs/dosfstools-4.2
		!systemd? ( >=sys-fs/udev-249.6-r2 )
		>=sys-fs/f2fs-tools-1.14.0
		>=sys-fs/fuse-3.10.5
		>=sys-fs/multipath-tools-0.8.7
		>=sys-process/cronie-1.5.7
        =dev-lang/python-3.9.9-r1[pgo(-)]
	)
	core? (
		>=app-arch/lzop-1.04
		>=app-crypt/libu2f-host-1.1.10
		>=app-editors/vim-8.2.3741
		>=app-editors/vim-core-8.2.3741
		>=app-misc/screen-4.8.0-r3
		>=app-text/psutils-1.17-r3
		>=dev-lang/go-1.17.7
		>=dev-libs/pigpio-79
		>=dev-python/pip-21.3.1-r1
		>=dev-tcltk/expect-5.45.4
		>=dev-util/strace-5.15
		>=mail-client/mailx-8.1.2.20180807
		>=mail-client/mailx-support-20060102-r2
		>=net-analyzer/iptraf-ng-1.2.1
		>=net-analyzer/nmap-7.92
		>=net-analyzer/tcpdump-4.99.1
		>=net-dialup/lrzsz-0.12.20-r4
		>=net-fs/samba-4.15.4-r1
		>=net-irc/irssi-1.2.3
		>=net-misc/iperf-3.10.1
		>=net-misc/keychain-2.8.5
		>=net-misc/youtube-dl-2021.12.17-r1
		>=net-vpn/networkmanager-openvpn-1.8.16
		>=net-vpn/openvpn-2.5.2-r2
		>=sys-apps/ack-3.5.0
		>=sys-apps/ethtool-5.15
		>=sys-apps/flashrom-1.2-r3
		>=sys-apps/hdparm-9.63
		>=sys-apps/i2c-tools-4.2
		>=sys-apps/smartmontools-7.2-r2
		>=sys-devel/clang-13.0.0
		>=sys-fs/ncdu-1.15.1-r1
		>=sys-fs/zerofree-1.1.1-r1
		>=sys-power/powertop-2.14
		>=sys-process/htop-3.1.2-r1
		>=sys-process/iotop-0.6
	)
	xfce? (
		>=app-arch/xarchiver-0.5.4.17
		>=app-emulation/qemu-6.2.0
		>=app-misc/mc-4.8.27
		>=gnome-extra/nm-applet-1.22.0-r1
		>=media-fonts/cantarell-0.301
		>=media-fonts/croscorefonts-1.31.0
		>=media-fonts/fontawesome-5.15.3
		>=media-fonts/libertine-5.3.0.20120702-r3
		>=media-fonts/ttf-bitstream-vera-1.10-r3
		>=media-libs/gst-plugins-bad-1.18.4-r2
		|| (
			<media-libs/mesa-20.2.0_rc1[rpi-v3d(-)]
			>=media-libs/mesa-21.3.5[video_cards_v3d(-),video_cards_vc4(-)]
		)
		>=media-sound/pavucontrol-5.0-r1
		>=media-tv/v4l-utils-1.20.0
		>=media-video/ffmpeg-4.4.1-r2
		>=net-misc/tigervnc-1.9.0-r2
		>=net-wireless/blueman-2.2.2
		>=sci-calculators/qalculate-gtk-3.22.0
		>=sci-calculators/speedcrunch-0.12.0-r1
		>=sys-apps/firejail-0.9.68-r1
		>=sys-block/gparted-1.3.1
		>=x11-apps/mesa-progs-8.4.0-r1
		>=x11-apps/xclock-1.0.9
		>=gui-libs/display-manager-init-1.0-r3
		>=x11-apps/xev-1.2.4
		>=x11-apps/xmodmap-1.0.10
		>=x11-apps/xsetroot-1.1.2-r1
		>=x11-base/xorg-server-21.1.3
		>=x11-misc/lightdm-1.30.0-r2
		>=x11-misc/lightdm-gtk-greeter-2.0.8
		>=x11-misc/xdiskusage-1.52
		>=x11-terms/xfce4-terminal-0.8.10
		>=x11-terms/xterm-367
		>=x11-themes/gnome-themes-standard-3.28
		>=xfce-base/xfce4-meta-4.16-r2
		>=xfce-extra/thunar-archive-plugin-0.4.0
		>=xfce-extra/thunar-volman-4.16.0
		>=xfce-extra/tumbler-4.16.0
		>=xfce-extra/xfce4-alsa-plugin-0.3.0
		>=xfce-extra/xfce4-cpufreq-plugin-1.2.7
		>=xfce-extra/xfce4-cpugraph-plugin-1.2.6
		>=xfce-extra/xfce4-indicator-plugin-2.4.1
		>=xfce-extra/xfce4-power-manager-4.16.0
		>=xfce-extra/xfce4-screenshooter-1.9.9
		>=xfce-extra/xfce4-systemload-plugin-1.3.1
		>=xfce-extra/xfce4-taskmanager-1.5.2
		>=xfce-extra/xfce4-xkb-plugin-0.8.2
	)
	pitop? (
		>=dev-embedded/pitop-speaker-1.1.0.1-r2
		>=sys-apps/pitop-poweroff-1.0.2-r6
		>=xfce-extra/xfce4-battery-plugin-1.1.0-r3[pitop]
		>=xfce-extra/xfce4-keycuts-pitop-1.0.2-r1
	)
	apps? (
		>=app-arch/p7zip-16.02-r8
		>=app-editors/mousepad-0.5.8
		>=app-office/libreoffice-7.2.5.2-r1
		>=app-office/libreoffice-l10n-7.2.5.2
		>=mail-client/claws-mail-3.18.0-r1
		>=mail-client/thunderbird-91.6.1
		>=media-gfx/fotoxx-19.13
		>=media-gfx/gimp-2.10.30
		>=media-video/mplayer-1.4-r1
		>=media-video/mpv-0.34.0
		>=media-video/smplayer-22.2.0
		>=media-video/vlc-3.0.16-r7
		>=net-analyzer/etherape-0.9.20
		>=net-analyzer/wireshark-3.6.2
		>=net-irc/hexchat-2.16.1
		>=net-p2p/transmission-3.00-r1
		>=sys-apps/gnome-disk-utility-40.2
		>=www-client/firefox-91.6.0
		>=www-client/links-2.25-r3
	)
"

src_install() {
	# basic framework file to enable / disable USE flags for this package
	insinto "/etc/portage/package.use/"
	newins "${FILESDIR}/package.use_${PN}-2" "${PN}"
}

pkg_postinst() {
	# ensure we have at least a system JVM set (if javac installed)
	if [ -e /usr/bin/javac ] && ! /usr/bin/javac -version &>/dev/null; then
		if eselect java-vm set system 1 &>/dev/null; then
			ewarn "Your JVM setup is now as follows:"
			ewarn "$(eselect java-vm show)"
			ewarn "Please modify (using eselect java-vm set ...) if incorrect"
		fi
	fi
	# migrate to appropriate sync-uri automatically, and force a sync
	# next time if we do, by deleting /usr/portage/metadata/timestamp.chk
	# (this is to ensure repo.hash{,.asc} gets added or removed, as
	# required)
#	local RCONPATH="${ROOT%/}/etc/portage/repos.conf/gentoo.conf"
#	if [ -e "${RCONPATH}" ]; then
#		if use porthash && grep -q 'rsync://isshoni.org/gentoo-portage-pi64-gem$' "${RCONPATH}"; then
#			sed -i 's#rsync://isshoni.org/gentoo-portage-pi64-gem$#rsync://isshoni.org/gentoo-portage-pi64#' "${RCONPATH}"
#			rm -fv "${ROOT%/}/usr/portage/metadata/timestamp.chk"
#			ewarn "This install has substituted:"
#			ewarn " rsync://isshoni.org/gentoo-portage-pi64"
#			ewarn "in place of:"
#			ewarn " rsync://isshoni.org/gentoo-portage-pi64-gem"
#			ewarn "as your gentoo repo's sync-uri"
#			ewarn "in ${RCONPATH}."
#			ewarn "The timestamp.chk file has also been deleted, to force"
#			ewarn "this repo to sync next time you run genup."
#		elif grep -q 'rsync://isshoni.org/gentoo-portage-pi64$' "${RCONPATH}"; then
#			sed -i 's#rsync://isshoni.org/gentoo-portage-pi64$#rsync://isshoni.org/gentoo-portage-pi64-gem#' "${RCONPATH}"
#			rm -fv "${ROOT%/}/usr/portage/metadata/timestamp.chk"
#			ewarn "This install has substituted:"
#			ewarn " rsync://isshoni.org/gentoo-portage-pi64-gem"
#			ewarn "in place of:"
#			ewarn " rsync://isshoni.org/gentoo-portage-pi64"
#			ewarn "as your gentoo repo's sync-uri"
#			ewarn "in ${RCONPATH}"
#			ewarn "The timestamp.chk file has also been deleted, to force"
#			ewarn "this repo to sync next time you run genup."
#			rm -fv "${ROOT%/}/usr/portage"{,/local}"/repo.hash"{,.asc}
#			ewarn "Any repo.hash{,.asc} files have also been deleted."
#		fi
#	else
#		if use porthash; then
#			ewarn "Please ensure you are using the following gentoo sync-uri:"
#			ewarn "rsync://isshoni.org/gentoo-portage-pi64"
#		fi
#		# otherwise assume user knows what they are doing and is using the
#		# main gentoo repo or similar
#	fi
	if use systemd; then
		ewarn "You are running with the systemd USE flag set!"
		ewarn "However, this package does not yet formally support systemd, so"
		ewarn "you are on your own to get things working ><"
	fi
}

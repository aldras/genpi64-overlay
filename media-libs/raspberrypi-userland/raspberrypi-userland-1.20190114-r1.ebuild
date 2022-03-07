# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit cmake-utils flag-o-matic git-r3

DESCRIPTION="Raspberry Pi userspace tools and libraries"
HOMEPAGE="https://github.com/raspberrypi/userland"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm ~arm64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	!media-libs/raspberrypi-userland-bin"

EGIT_REPO_URI="https://github.com/raspberrypi/userland"
# latest commit, as of of ebuild's version (datestamp)
EGIT_COMMIT="e5803f2c986cbf8c919c60278b3231dcdf4271a6"

#PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

pkg_setup() {
	append-ldflags $(no-as-needed)
}

src_configure() {
	local mycmakeargs=(
		-DVMCS_INSTALL_PREFIX="/usr"
	)
	if use arm64; then
		mycmakeargs+=(-DARM64=ON)
	fi

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/92-local-vchiq-permissions.rules

	dodir /usr/share/doc/${PF}
	mv "${D}"/usr/src/hello_pi "${D}"/usr/share/doc/${PF}/
	rmdir "${D}"/usr/src

	# remove potential collisions
	rm -rf "${D}/usr/include/GLES"
	rm -rf "${D}/usr/include/GLES2"
	rm -rf "${D}/usr/include/EGL"
	rm -rf "${D}/usr/include/KHR"

	# causes problems with fkms etc., so remove
	rm -fv "${D}/usr/lib/libbcm_host.so"

	# hacky fix for multilib issue
	mkdir -pv "${D}/usr/lib64"
	mv "${D}/usr/lib/"*.so "${D}/usr/lib64/"

	# hacky fix for /usr/etc path
	mv "${D}/usr/etc" "${D}/"
}


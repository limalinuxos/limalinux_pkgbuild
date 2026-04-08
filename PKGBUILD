pkgname=calamares
_pkgname=calamares
pkgver=3.4.2.r0.g841b478 
pkgrel=9
pkgdesc='Distribution-independent installer framework - Lima Linux (Auto-Swap + Dracut)'
arch=('x86_64')
url="https://codeberg.org/limalinuxos/calamares"
license=('LGPL')
conflicts=('calamares-next' 'calamares-git')
provides=('calamares')

depends=(
    'boost-libs'
    'ckbcomp'
    'cryptsetup'
    'doxygen'
    'dracut'
    'efibootmgr'
    'gptfdisk'
    'gtk-update-icon-cache'
    'icu'
    'kconfig'
    'kcoreaddons'
    'kcrash'
    'ki18n'
    'kparts'
    'kpmcore'
    'kservice'
    'kwidgetsaddons'
    'libpwquality'
    'polkit-qt6'
    'rsync'
    'qt6-declarative'
    'qt6-svg'
    'qt6-webengine' 
    'solid'
    'squashfs-tools'
    'yaml-cpp'
)

makedepends=(
    'boost'
    'cmake'
    'extra-cmake-modules'
    'git'
    'fakeroot'
    'ninja'
    'python-jsonschema'
    'python-pyaml'
    'python-unidecode'
    'qt6-tools'
)

backup=(
    'etc/calamares/modules/bootloader.conf'
    'etc/calamares/modules/displaymanager.conf'
    'etc/calamares/modules/dracutlukscfg.conf'
    'etc/calamares/modules/unpackfs.conf'
    'etc/calamares/settings.conf'
    'etc/calamares/branding/limalinux/branding.desc'
)

source=(
    "calamares::git+https://codeberg.org/limalinuxos/calamares"
    "cal_limalinux.desktop"
    "calamares_polkit"
    "calamares_wrapper"
    "suppress-qtinfo.patch"
)

sha256sums=(
    'SKIP'
    '31a07d76d5c8ffee0e88bf41119c875fafb2e0bcefdae945e748e3f9e6803d6d'
    '966c5f0834039dc6a7529e75f70417ba2510b1e643ffb49fd25855ce9dc244b4'
    'e4c9b9601020f2362311b9776de1aa363f6ee5d1d78a4b171ba2630644819f5b'
    'SKIP'
)

pkgver() {
    cd "$srcdir/$_pkgname"
    git describe --long --tags --abbrev=7 | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g'
}

prepare() {
    cd "$srcdir/$_pkgname"

   
    if [ -d "$srcdir/../modules" ]; then
        cp -rv "$srcdir/../modules/"* "src/modules/"
    fi

    
    sed -i 's/"Install configuration files" OFF/"Install configuration files" ON/' CMakeLists.txt
    
  
    sed -i "/import os/a import psutil" src/modules/fstab/main.py || true
    sed -i "s/desired_size = 512 \* 1024 \* 1024  # 512MiB/desired_size = psutil.virtual_memory().total/" src/modules/fstab/main.py

 
    patch -p1 -i "$srcdir/suppress-qtinfo.patch"
}

build() {
    cd "$srcdir/$_pkgname"

    cmake -S . -B build \
        -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_INSTALL_LIBDIR=lib \
        -DCMAKE_INSTALL_SYSCONFDIR=/etc \
        -DWITH_APPSTREAM=OFF \
        -DWITH_PYBIND11=OFF \
        -DWITH_QT6=ON \
        -DSKIP_MODULES="initramfs; \
            initramfscfg; \
            dummycpp; \
            dummyprocess; \
            dummypython; \
            dummypythonqt; \
            interactiveterminal; \
            keyboardq; \
            license; \
            localeq; \
            oemid; \
            packagechooserq; \
            partitionq; \
            services-openrc; \
            summaryq; \
            tracking; \
            usersq; \
            welcomeq"

    cmake --build build
}

package() {
    cd "$srcdir/$_pkgname/build"
    DESTDIR="$pkgdir" cmake --install .

    
    install -Dm644 "$srcdir/cal_limalinux.desktop" "$pkgdir/usr/share/applications/cal_limalinux.desktop"
    install -d "$pkgdir/etc/skel/Desktop"
    install -m755 "$srcdir/cal_limalinux.desktop" "$pkgdir/etc/skel/Desktop/cal_limalinux.desktop"


    install -Dm755 "$srcdir/calamares_wrapper" "$pkgdir/usr/bin/calamares_wrapper"
    install -Dm755 "$srcdir/calamares_polkit" "$pkgdir/usr/bin/calamares_polkit"

    
    rm -f "$pkgdir/usr/share/applications/calamares.desktop"
    rm -f "$pkgdir/etc/calamares/modules/initcpio.conf"
}

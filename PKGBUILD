# Maintainer: CraftingDragon007 <craftingdragon007@outlook.com>
pkgname=spiggen
pkgver=0.0.0alpha0
pkgrel=1
pkgdesc="Kekhafter Spigot Plugin Template Generator"
arch=("x86_64")
url="https://github.com/EarthPlay/SpigGen"
license=('MIT')
makedepends=('git')
source=("git+https://github.com/EarthPlay/SpigGen.git")
sha512sums=('SKIP')

package() {
mkdir -p "${pkgdir}/etc/"
mkdir -p "${pkgdir}/usr/bin/"
rm -rf "${srcdir}/SpigGen/.git"
rm -rf "${srcdir}/SpigGen/.vscode"
mv "${srcdir}/SpigGen" "${srcdir}/spiggen"
cp -r --verbose "${srcdir}/spiggen/" "${pkgdir}/etc/"
ln -s "${pkgdir}/etc/spiggen/spiggen.sh" "${pkgdir}/usr/bin/spiggen"
chmod +x "${pkgdir}/etc/spiggen/spiggen.sh"
}

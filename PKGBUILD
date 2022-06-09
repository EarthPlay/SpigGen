# Maintainer: CraftingDragon007 <craftingdragon007@outlook.com>
pkgname=spiggen
pkgver=0.0.0alpha0
pkgrel=1
pkgdesc="Kekhafter Spigot Plugin Template Generator"
arch=("x86_64")
url="https://github.com/EarthPlay/SpigGen"
license=('MIT')
makedepends=('dotnet-sdk' 'git')
source=("git+https://github.com/EarthPlay/SpigGen.git")
sha512sums=('SKIP')

package() {
mkdir -p "${pkgdir}/usr/bin/"
cp "${srcdir}/SpigGen/spiggen.sh" "${pkgdir}/usr/bin/spiggen"
chmod +x "${pkgdir}/usr/bin/spiggen"
}

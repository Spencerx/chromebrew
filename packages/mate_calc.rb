require 'package'

class Mate_calc < Package
  description 'Calculator for MATE.'
  homepage 'https://mate-desktop.org'
  version '1.21'
  license 'CC-BY-SA-3.0 and GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://pub.mate-desktop.org/releases/1.21/mate-calc-1.21.0.tar.xz'
  source_sha256 'c6b2c4d832f67d5f3d1293cb143e428365077e3cdfe4fc4bb80b3fce5362b51e'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '311ade356f6259ca68ebf2318b7dfec9053e51899c3bb033b91e091479d587f6',
     armv7l: '311ade356f6259ca68ebf2318b7dfec9053e51899c3bb033b91e091479d587f6',
     x86_64: 'c5848a45335a4bcbb9e4066c3e90875a82b3ebc1486fe1279ded5babbddd3148'
  })

  depends_on 'gtk3'
  depends_on 'mate_common'
  depends_on 'yelp_tools'

  def self.build
    system 'sh autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install' # the steps required to install the package
  end
end

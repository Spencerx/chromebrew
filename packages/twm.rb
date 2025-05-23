require 'package'

class Twm < Package
  description 'The twm package contains a very minimal window manager.'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.0.11'
  license 'MIT-with-advertising, MIT and ISC'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://www.x.org/pub/individual/app/twm-1.0.11.tar.xz'
  source_sha256 'f4e8a842dec410e79741f25ed4dfac09df080835d0bba2e3983b5914569b68c7'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '84bc4882736d4ed174741a07c60404d47cdbad726ac7e9b7ace07012ded84d58',
     armv7l: '84bc4882736d4ed174741a07c60404d47cdbad726ac7e9b7ace07012ded84d58',
     x86_64: '9108a3204e5b9eb37689aa8e97af6168cf3f4864c29d8d8e4e58ca6355de74a2'
  })

  depends_on 'xorg_server'

  def self.build
    system "./configure  #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

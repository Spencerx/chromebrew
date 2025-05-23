# Currently broken with gcc 14.
# See https://gitlab.gnome.org/GNOME/gdl/-/issues/9
require 'buildsystems/autotools'

class Gnome_docking_library < Autotools
  description 'GUsb is a GObject wrapper for libusb1'
  homepage 'https://www.gnome.org/'
  version "3.40.0-#{CREW_ICU_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gdl.git'
  git_hashtag "GDL_#{version.split('-').first.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7db8bf37bb50aad29887aa5193c57877cc891fc9ae97db16c58413b95831379a',
     armv7l: '7db8bf37bb50aad29887aa5193c57877cc891fc9ae97db16c58413b95831379a',
     x86_64: 'ed0585ee570743d2a03f347cd164dca608cf52b257d4c13c5d68512b5b6dc2b6'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnome_common' => :build
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'zlib' # R

  gnome

  def self.patch
    # Fix libxml compat.
    downloader 'https://gitlab.gnome.org/GNOME/gdl/-/merge_requests/4.patch', '3bbd9118ea685bd3b161afdb6653825bf96a844551dadaa024c1fa0e57617f57'
    system 'patch -Np1 -i 4.patch'
  end

  autotools_configure_options '--disable-gtk-doc'
end

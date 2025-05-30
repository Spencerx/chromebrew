require 'buildsystems/meson'

class Gtk3 < Meson
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://docs.gtk.org/gtk3/'
  version '3.24.49'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gtk.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '454e676c39fba0aac7c02e11a38f5dea95fd35992c1415d6e560a2625c8ef870',
     armv7l: '454e676c39fba0aac7c02e11a38f5dea95fd35992c1415d6e560a2625c8ef870',
     x86_64: 'f36ca615dd896a952ba2c71866a2d0ffece9a33e911e894e8d84ae4fbb2cf93c'
  })

  # L = Logical Dependency, R = Runtime Dependency
  depends_on 'adwaita_fonts' # L
  depends_on 'adwaita_icon_theme' # L
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'cups' # R
  depends_on 'docbook' => :build
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'ghostscript' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  # depends_on 'gnome_icon_theme' # L
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' => :build # Do we need this?
  depends_on 'graphite' => :build # Do we need this?
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme' # L
  depends_on 'iso_codes' => :build
  depends_on 'json_glib' => :build
  depends_on 'libdeflate' => :build # Do we need this?
  depends_on 'libepoxy' # R
  depends_on 'libjpeg_turbo' => :build # Do we need this?
  depends_on 'librsvg' # L
  depends_on 'libsass' => :build
  depends_on 'libspectre' => :build
  depends_on 'libx11' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxcursor' # R
  depends_on 'libxdamage' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxinerama' # R
  depends_on 'libxi' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxrandr' # R
  depends_on 'libxrender' # R
  depends_on 'mesa' => :build
  depends_on 'pango' # R
  depends_on 'rest' => :build
  depends_on 'shaderc' => :build
  depends_on 'shared_mime_info' # L
  depends_on 'sommelier' # L
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'wayland' # R
  depends_on 'xdg_base' # L

  gnome
  no_fhs
  no_upstream_update

  def self.patch
    # Use locally build subprojects
    @deps = %w[cairo librsvg]
    @deps.each do |dep|
      FileUtils.rm_rf ["subprojects/#{dep}", "subprojects/#{dep}.wrap"]
    end
  end

  meson_options '-Dbroadway_backend=true \
      -Ddemos=false \
      -Dexamples=false \
      -Dgtk_doc=false'

  meson_build_extras do
    File.write 'gtk3settings', <<~GTK3_CONFIG_HEREDOC
      [Settings]
      gtk-icon-theme-name = Adwaita
      gtk-fallback-icon-theme = gnome
      gtk-theme-name = Adwaita
      gtk-font-name = Adwaita Sans 11
      gtk-application-prefer-dark-theme = false
      monospace-font-name = Adwaita Mono 11
    GTK3_CONFIG_HEREDOC
  end

  meson_install_extras do
    system "sed -i 's,null,,g'  #{CREW_DEST_LIB_PREFIX}/pkgconfig/gtk*.pc"
    xdg_config_dest_home = File.join(CREW_DEST_PREFIX, '.config')
    FileUtils.install 'gtk3settings', "#{xdg_config_dest_home}/gtk-3.0/settings.ini", mode: 0o644
  end
end

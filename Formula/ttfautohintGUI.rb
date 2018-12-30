class Ttfautohintgui < Formula
  desc "Auto-hinter for TrueType fonts (GUI version)"
  homepage "https://www.freetype.org/ttfautohint/"
  url "https://downloads.sourceforge.net/project/freetype/ttfautohint/1.8.2/ttfautohint-1.8.2.tar.gz"
  sha256 "386741701596a8b2d5fb744901922ed2bd740490f7e6c81e5d7e83ac677889a7"

  head do
    url "https://repo.or.cz/ttfautohint.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "bison" => :build
    depends_on "libtool" => :build
    depends_on "pkg-config" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "freetype"
  depends_on "harfbuzz"
  depends_on "libpng"
  depends_on "qt"

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --without-doc
    ]

    ENV["QMAKESPEC"] = "macx-clang"
    system "./bootstrap" if build.head?
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/ttfautohint", "-V"
    system "#{bin}/ttfautohintGUI", "-V"
  end
end
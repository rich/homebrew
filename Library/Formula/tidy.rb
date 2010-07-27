require 'formula'

class Tidy < Formula
  version '1.2.2'
  url 'http://tidy.cvs.sourceforge.net/viewvc/tidy/tidy/?view=tar'
  homepage 'http://tidy.sf.net/'
  md5 '41693fef44ba3f8c3db1f14ac3fd6178'

  def install
    args = ["--prefix=#{prefix}"]

    system "/bin/sh build/gnuauto/setup.sh"
    system "./configure", *args
    system "make"
    system "make install"
  end
end


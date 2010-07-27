require 'formula'

class Tidy < Formula
  version '1.2.2'
  url 'http://tidy.cvs.sourceforge.net/viewvc/tidy/tidy/?view=tar'
  homepage 'http://tidy.sf.net/'
  md5 '2bebdcf35fab64ac60224dece946f5aa'

  def install
    syst
    args = ["--prefix=#{prefix}", "--enable-cli", "--enable-cgi", "--enable-shared", "--disable-debug", "--disable-dependency-tracking", "--with-config-file-path=#{etc}"]

    args += %w|--with-mysql --with-mysqli --with-pdo-mysql| if ARGV.include? "--mysql"
    args += %w|--with-pgsql --with-pdo-pgsql| if ARGV.include? "--postgresql"
    args << "--with-pear" if ARGV.include? "--pear"

    if ARGV.include? "--fpm"
      system "svn co http://svn.php.net/repository/php/php-src/branches/PHP_5_3/sapi/fpm sapi/fpm"
      system "./buildconf --force"
      args << "--enable-fpm"
    end

    system "/bin/sh build/gnuauto/setup.sh"
    system "./configure", *args
    system "make"
    system "make install"
  end
end

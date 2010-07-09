require 'formula'

class Php < Formula
  version '5.3.2'
  url 'http://us.php.net/get/php-5.3.2.tar.bz2/from/this/mirror'
  homepage 'http://www.php.net/'
  md5 '46f500816125202c48a458d0133254a4'

  def patches
    DATA
  end

  def options
    [
      ["--mysql", "Enable MySQL."],
      ["--postgresql", "Enable PostgreSQL."],
      ["--pear", "Enable PEAR."],
      ["--fpm", "Enable PHP-FPM"]
    ]
  end

  def deps
    dependencies = super
    dependencies << 'mysql' if ARGV.include? '--mysql'
    dependencies << 'postgresql' if ARGV.include? '--postgresql'
    dependencies
  end

  def install
    args = ["--prefix=#{prefix}", "--enable-cli", "--enable-cgi", "--enable-shared", "--disable-debug", "--disable-dependency-tracking", "--with-config-file-path=#{etc}"]

    args += %w|--with-mysql --with-mysqli --with-pdo-mysql| if ARGV.include? "--mysql"
    args += %w|--with-pgsql --with-pdo-pgsql| if ARGV.include? "--postgresql"
    args << "--with-pear" if ARGV.include? "--pear"

    if ARGV.include? "--fpm"
      system "svn co http://svn.php.net/repository/php/php-src/branches/PHP_5_3/sapi/fpm sapi/fpm"
      system "./buildconf --force"
      args << "--enable-fpm"
    end

    system "./configure", *args
    system "make"
    system "make install"
  end
end

__END__
diff -Naur php-5.3.0/ext/iconv/iconv.c php/ext/iconv/iconv.c
--- php-5.3.0/ext/iconv/iconv.c	2009-03-16 22:31:04.000000000 -0700
+++ php/ext/iconv/iconv.c	2009-07-15 14:40:09.000000000 -0700
@@ -51,9 +51,6 @@
 #include <gnu/libc-version.h>
 #endif
 
-#ifdef HAVE_LIBICONV
-#undef iconv
-#endif
 
 #include "ext/standard/php_smart_str.h"
 #include "ext/standard/base64.h"
@@ -182,9 +179,6 @@
 }
 /* }}} */
 
-#ifdef HAVE_LIBICONV
-#define iconv libiconv
-#endif
 
 /* {{{ typedef enum php_iconv_enc_scheme_t */
 typedef enum _php_iconv_enc_scheme_t {


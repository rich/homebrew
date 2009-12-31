require 'formula'

class Php < Formula
  version '5.3.1'
  url 'http://us.php.net/get/php-5.3.1.tar.bz2/from/this/mirror'
  homepage 'http://www.php.net/'
  md5 '63e97ad450f0f7259e785100b634c797'

  depends_on 'mysql' => :recommended
  depends_on 'postgresql' => :recommended

  def patches
    DATA
  end

  def options
    [
      ["--mysql", "Enable MySQL."],
      ["--postgresql", "Enable PostgreSQL."],
      ["--pear", "Enable PEAR."]
    ]
  end

  def install
    args = ["--prefix=#{prefix}", "--enable-cli", "--enable-cgi", "--enable-shared", "--disable-debug", "--disable-dependency-tracking", "--with-config-file-path=#{etc}"]

    args += %w|--with-mysql --with-mysqli --with-pdo-mysql| if ARGV.include? "--mysql"
    args += %w|--with-pgsql --with-pdo-pgsql| if ARGV.include? "--postgresql"
    args << "--with-pear" if ARGV.include? "--pear"

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC4736F4E1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 06:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhD3EXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 00:23:08 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:22233 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhD3EXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 00:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=12631; q=dns/txt;
  s=iport; t=1619756539; x=1620966139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S2XyC9Vs/8UkSD4/6EjEFcdfd/1g+e3eE3pXSDnb2u0=;
  b=ilCjEcMUeGSfACuF66uC0t9envpPR21i8a59cq4RgECsjvb3wTnPdHwS
   VQyYB9LGt/Y0dhsmGYQ/7WJbLrj3ilkFM8G+ETJlBv2qnmbf0HWv6FcXu
   PigWG1zvLu/xI4lsE6ShfJGyiGy9ezxOpx0wVaqVWLT5/ZOEAAfbmvCuH
   Y=;
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A1pCTC6zW9851hc0wCERnKrPwkL1zdoIgy1?=
 =?us-ascii?q?knxilNYDZeG/b1q+mFmvMH2RjozAsLUHY7ltyafIWGS3XQ9Zl6iLNhX4uKcQ?=
 =?us-ascii?q?H6tAKTQr1KwpDlx1TbcRHW0s54+eNef7NlCNv2ZGIK7vrSxAWjCd4vzJ2m/c?=
 =?us-ascii?q?mT5Nv29HtmQQF0Z6wI1W4QYTqzKFF8RwVNGPMCe6a028wvnVedUEVSRtinAD?=
 =?us-ascii?q?0/U/LbodrQmNbdfQceHBI88mC1/FaVwY+/NxCZ2xsEOgku/Z4StU7Yjgf++q?=
 =?us-ascii?q?Kv99a8xxO07R61071m3P3819BEGMuAzvIwFwypoAOpaIN9Mofy2AwInA=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0B9AAAYhYtg/4cNJK1aHQEBAQEJARI?=
 =?us-ascii?q?BBQUBggMIAQsBAYIpgU0BOTGMaIlTgQ+ZbxSBaAsBAQEPNAQBAYRQgX0CJTQ?=
 =?us-ascii?q?JDgIEAQEMAQEFAQEBAgEGBHEThV1DFgGGIwFGgT4BEoJxgwioVYIsgQGIMoF?=
 =?us-ascii?q?EFIEmAYhsdIQdHIFJQoEVgmx0hAUUg26CMwSCRzEpGhoBejZ3ASmRNI1pmym?=
 =?us-ascii?q?BFIMagSebcxAmpR0tlH2fGTuEMDWBHzqBWTMaCBsVgyRQGQ6OKAMWjkshAy8?=
 =?us-ascii?q?4AgYKAQEDCYlOe4JGAQE?=
X-IronPort-AV: E=Sophos;i="5.82,260,1613433600"; 
   d="scan'208";a="620387833"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 30 Apr 2021 04:22:18 +0000
Received: from zorba.cisco.com ([10.24.18.92])
        by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTP id 13U4MHxu023118;
        Fri, 30 Apr 2021 04:22:18 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        xe-linux-external@cisco.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] lib: early_string: allow early usage of some string functions
Date:   Thu, 29 Apr 2021 21:22:14 -0700
Message-Id: <20210430042217.1198052-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.18.92, [10.24.18.92]
X-Outbound-Node: alln-core-2.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This systems allows some string functions to be moved into
lib/early_string.c and they will be prepended with "early_" and compiled
without debugging like KASAN.

This is already done on x86 for,
"AMD Secure Memory Encryption (SME) support"

and on powerpc prom_init.c , and EFI's libstub.

The AMD memory feature disabled KASAN for all string functions, and
prom_init.c and efi libstub implement their own versions of the
functions.

This implementation allows sharing of the string functions without
removing the debugging features for the whole system.

Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 include/linux/string.h |   6 ++
 lib/Makefile           |  23 +++++-
 lib/early_string.c     | 172 +++++++++++++++++++++++++++++++++++++++++
 lib/string.c           | 154 ------------------------------------
 4 files changed, 200 insertions(+), 155 deletions(-)
 create mode 100644 lib/early_string.c

diff --git a/include/linux/string.h b/include/linux/string.h
index 9521d8cab18e..c0d45b92ba9e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -20,6 +20,7 @@ extern void *memdup_user_nul(const void __user *, size_t);
  */
 #include <asm/string.h>
 
+extern char * early_strcpy(char *,const char *);
 #ifndef __HAVE_ARCH_STRCPY
 extern char * strcpy(char *,const char *);
 #endif
@@ -42,12 +43,15 @@ extern char * strcat(char *, const char *);
 #ifndef __HAVE_ARCH_STRNCAT
 extern char * strncat(char *, const char *, __kernel_size_t);
 #endif
+extern size_t early_strlcat(char *, const char *, __kernel_size_t);
 #ifndef __HAVE_ARCH_STRLCAT
 extern size_t strlcat(char *, const char *, __kernel_size_t);
 #endif
+extern int early_strcmp(const char *,const char *);
 #ifndef __HAVE_ARCH_STRCMP
 extern int strcmp(const char *,const char *);
 #endif
+extern int early_strncmp(const char *,const char *,__kernel_size_t);
 #ifndef __HAVE_ARCH_STRNCMP
 extern int strncmp(const char *,const char *,__kernel_size_t);
 #endif
@@ -79,12 +83,14 @@ static inline __must_check char *strstrip(char *str)
 	return strim(str);
 }
 
+extern char * early_strstr(const char *, const char *);
 #ifndef __HAVE_ARCH_STRSTR
 extern char * strstr(const char *, const char *);
 #endif
 #ifndef __HAVE_ARCH_STRNSTR
 extern char * strnstr(const char *, const char *, size_t);
 #endif
+extern __kernel_size_t early_strlen(const char *);
 #ifndef __HAVE_ARCH_STRLEN
 extern __kernel_size_t strlen(const char *);
 #endif
diff --git a/lib/Makefile b/lib/Makefile
index b5307d3eec1a..25cc664f027e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -9,6 +9,8 @@ ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
 # flaky coverage that is not a function of syscall inputs. For example,
 # rbtree can be global and individual rotations don't correlate with inputs.
 KCOV_INSTRUMENT_string.o := n
+KCOV_INSTRUMENT_early_string.o := n
+KCOV_INSTRUMENT_early_string.nosan.o := n
 KCOV_INSTRUMENT_rbtree.o := n
 KCOV_INSTRUMENT_list_debug.o := n
 KCOV_INSTRUMENT_debugobjects.o := n
@@ -19,6 +21,12 @@ KCOV_INSTRUMENT_fault-inject.o := n
 # Use -ffreestanding to ensure that the compiler does not try to "optimize"
 # them into calls to themselves.
 CFLAGS_string.o := -ffreestanding
+CFLAGS_early_string.o := -ffreestanding
+CFLAGS_early_string.nosan.o := -ffreestanding -D__EARLY_STRING_ENABLED
+
+KASAN_SANITIZE_early_string.nosan.o := n
+
+CFLAGS_early_string.nosan.o += -fno-stack-protector
 
 # Early boot use of cmdline, don't instrument it
 ifdef CONFIG_AMD_MEM_ENCRYPT
@@ -27,7 +35,20 @@ KASAN_SANITIZE_string.o := n
 CFLAGS_string.o += -fno-stack-protector
 endif
 
-lib-y := ctype.o string.o vsprintf.o cmdline.o \
+$(obj)/early_string.nosan.o: $(src)/early_string.c $(recordmcount_source) $(objtool_dep) FORCE
+	$(call if_changed_rule,cc_o_c)
+	$(call cmd,force_checksrc)
+	$(Q)$(OBJCOPY) \
+		--rename-section .text=.init.text \
+		--redefine-sym strcmp=early_strcmp \
+		--redefine-sym strncmp=early_strncmp \
+		--redefine-sym strcpy=early_strcpy \
+		--redefine-sym strlcat=early_strlcat \
+		--redefine-sym strlen=early_strlen \
+		--redefine-sym strstr=early_strstr \
+		--redefine-sym memcmp=early_memcmp $@
+
+lib-y := ctype.o string.o early_string.o early_string.nosan.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o extable.o sha1.o irq_regs.o argv_split.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
diff --git a/lib/early_string.c b/lib/early_string.c
new file mode 100644
index 000000000000..21004e82159c
--- /dev/null
+++ b/lib/early_string.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/lib/string.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ */
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/bug.h>
+
+#ifdef __EARLY_STRING_ENABLED
+#undef EXPORT_SYMBOL
+#define EXPORT_SYMBOL(x)
+#endif
+
+#include <linux/string.h>
+
+#if !defined(__HAVE_ARCH_MEMCMP) || defined(__EARLY_STRING_ENABLED)
+/**
+ * memcmp - Compare two areas of memory
+ * @cs: One area of memory
+ * @ct: Another area of memory
+ * @count: The size of the area.
+ */
+#undef memcmp
+__visible int memcmp(const void *cs, const void *ct, size_t count)
+{
+	const unsigned char *su1, *su2;
+	int res = 0;
+
+	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
+		if ((res = *su1 - *su2) != 0)
+			break;
+	return res;
+}
+EXPORT_SYMBOL(memcmp);
+#endif
+
+#if !defined(HAVE_ARCH_STRCMP) || defined(__EARLY_STRING_ENABLED)
+/**
+ * strcmp - Compare two strings
+ * @cs: One string
+ * @ct: Another string
+ */
+int strcmp(const char *cs, const char *ct)
+{
+	unsigned char c1, c2;
+
+	while (1) {
+		c1 = *cs++;
+		c2 = *ct++;
+		if (c1 != c2)
+			return c1 < c2 ? -1 : 1;
+		if (!c1)
+			break;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(strcmp);
+#endif
+
+#if !defined(__HAVE_ARCH_STRCPY) || defined(__EARLY_STRING_ENABLED)
+/**
+ * strcpy - Copy a %NUL terminated string
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ */
+char *strcpy(char *dest, const char *src)
+{
+	char *tmp = dest;
+
+	while ((*dest++ = *src++) != '\0')
+		/* nothing */;
+	return tmp;
+}
+EXPORT_SYMBOL(strcpy);
+#endif
+
+#if !defined(__HAVE_ARCH_STRLCAT) || defined(__EARLY_STRING_ENABLED)
+/**
+ * strlcat - Append a length-limited, C-string to another
+ * @dest: The string to be appended to
+ * @src: The string to append to it
+ * @count: The size of the destination buffer.
+ */
+size_t strlcat(char *dest, const char *src, size_t count)
+{
+	size_t dsize = strlen(dest);
+	size_t len = strlen(src);
+	size_t res = dsize + len;
+
+	/* This would be a bug */
+	BUG_ON(dsize >= count);
+
+	dest += dsize;
+	count -= dsize;
+	if (len >= count)
+		len = count-1;
+	memcpy(dest, src, len);
+	dest[len] = 0;
+	return res;
+}
+EXPORT_SYMBOL(strlcat);
+#endif
+
+#if !defined(__HAVE_ARCH_STRLEN) || defined(__EARLY_STRING_ENABLED)
+/**
+ * strlen - Find the length of a string
+ * @s: The string to be sized
+ */
+size_t strlen(const char *s)
+{
+	const char *sc;
+
+	for (sc = s; *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
+EXPORT_SYMBOL(strlen);
+#endif
+
+#if !defined(__HAVE_ARCH_STRNCMP) || defined(__EARLY_STRING_ENABLED)
+/**
+ * strncmp - Compare two length-limited strings
+ * @cs: One string
+ * @ct: Another string
+ * @count: The maximum number of bytes to compare
+ */
+int strncmp(const char *cs, const char *ct, size_t count)
+{
+	unsigned char c1, c2;
+
+	while (count) {
+		c1 = *cs++;
+		c2 = *ct++;
+		if (c1 != c2)
+			return c1 < c2 ? -1 : 1;
+		if (!c1)
+			break;
+		count--;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(strncmp);
+#endif
+
+#if !defined(__HAVE_ARCH_STRSTR) || defined(__EARLY_STRING_ENABLED)
+/**
+ * strstr - Find the first substring in a %NUL terminated string
+ * @s1: The string to be searched
+ * @s2: The string to search for
+ */
+char *strstr(const char *s1, const char *s2)
+{
+	size_t l1, l2;
+
+	l2 = strlen(s2);
+	if (!l2)
+		return (char *)s1;
+	l1 = strlen(s1);
+	while (l1 >= l2) {
+		l1--;
+		if (!memcmp(s1, s2, l2))
+			return (char *)s1;
+		s1++;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(strstr);
+#endif
+
diff --git a/lib/string.c b/lib/string.c
index 7548eb715ddb..328649ccb34d 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -79,23 +79,6 @@ int strcasecmp(const char *s1, const char *s2)
 EXPORT_SYMBOL(strcasecmp);
 #endif
 
-#ifndef __HAVE_ARCH_STRCPY
-/**
- * strcpy - Copy a %NUL terminated string
- * @dest: Where to copy the string to
- * @src: Where to copy the string from
- */
-char *strcpy(char *dest, const char *src)
-{
-	char *tmp = dest;
-
-	while ((*dest++ = *src++) != '\0')
-		/* nothing */;
-	return tmp;
-}
-EXPORT_SYMBOL(strcpy);
-#endif
-
 #ifndef __HAVE_ARCH_STRNCPY
 /**
  * strncpy - Copy a length-limited, C-string
@@ -343,81 +326,6 @@ char *strncat(char *dest, const char *src, size_t count)
 EXPORT_SYMBOL(strncat);
 #endif
 
-#ifndef __HAVE_ARCH_STRLCAT
-/**
- * strlcat - Append a length-limited, C-string to another
- * @dest: The string to be appended to
- * @src: The string to append to it
- * @count: The size of the destination buffer.
- */
-size_t strlcat(char *dest, const char *src, size_t count)
-{
-	size_t dsize = strlen(dest);
-	size_t len = strlen(src);
-	size_t res = dsize + len;
-
-	/* This would be a bug */
-	BUG_ON(dsize >= count);
-
-	dest += dsize;
-	count -= dsize;
-	if (len >= count)
-		len = count-1;
-	memcpy(dest, src, len);
-	dest[len] = 0;
-	return res;
-}
-EXPORT_SYMBOL(strlcat);
-#endif
-
-#ifndef __HAVE_ARCH_STRCMP
-/**
- * strcmp - Compare two strings
- * @cs: One string
- * @ct: Another string
- */
-int strcmp(const char *cs, const char *ct)
-{
-	unsigned char c1, c2;
-
-	while (1) {
-		c1 = *cs++;
-		c2 = *ct++;
-		if (c1 != c2)
-			return c1 < c2 ? -1 : 1;
-		if (!c1)
-			break;
-	}
-	return 0;
-}
-EXPORT_SYMBOL(strcmp);
-#endif
-
-#ifndef __HAVE_ARCH_STRNCMP
-/**
- * strncmp - Compare two length-limited strings
- * @cs: One string
- * @ct: Another string
- * @count: The maximum number of bytes to compare
- */
-int strncmp(const char *cs, const char *ct, size_t count)
-{
-	unsigned char c1, c2;
-
-	while (count) {
-		c1 = *cs++;
-		c2 = *ct++;
-		if (c1 != c2)
-			return c1 < c2 ? -1 : 1;
-		if (!c1)
-			break;
-		count--;
-	}
-	return 0;
-}
-EXPORT_SYMBOL(strncmp);
-#endif
-
 #ifndef __HAVE_ARCH_STRCHR
 /**
  * strchr - Find the first occurrence of a character in a string
@@ -553,22 +461,6 @@ char *strim(char *s)
 }
 EXPORT_SYMBOL(strim);
 
-#ifndef __HAVE_ARCH_STRLEN
-/**
- * strlen - Find the length of a string
- * @s: The string to be sized
- */
-size_t strlen(const char *s)
-{
-	const char *sc;
-
-	for (sc = s; *sc != '\0'; ++sc)
-		/* nothing */;
-	return sc - s;
-}
-EXPORT_SYMBOL(strlen);
-#endif
-
 #ifndef __HAVE_ARCH_STRNLEN
 /**
  * strnlen - Find the length of a length-limited string
@@ -922,27 +814,6 @@ void *memmove(void *dest, const void *src, size_t count)
 EXPORT_SYMBOL(memmove);
 #endif
 
-#ifndef __HAVE_ARCH_MEMCMP
-/**
- * memcmp - Compare two areas of memory
- * @cs: One area of memory
- * @ct: Another area of memory
- * @count: The size of the area.
- */
-#undef memcmp
-__visible int memcmp(const void *cs, const void *ct, size_t count)
-{
-	const unsigned char *su1, *su2;
-	int res = 0;
-
-	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
-		if ((res = *su1 - *su2) != 0)
-			break;
-	return res;
-}
-EXPORT_SYMBOL(memcmp);
-#endif
-
 #ifndef __HAVE_ARCH_BCMP
 /**
  * bcmp - returns 0 if and only if the buffers have identical contents.
@@ -987,31 +858,6 @@ void *memscan(void *addr, int c, size_t size)
 EXPORT_SYMBOL(memscan);
 #endif
 
-#ifndef __HAVE_ARCH_STRSTR
-/**
- * strstr - Find the first substring in a %NUL terminated string
- * @s1: The string to be searched
- * @s2: The string to search for
- */
-char *strstr(const char *s1, const char *s2)
-{
-	size_t l1, l2;
-
-	l2 = strlen(s2);
-	if (!l2)
-		return (char *)s1;
-	l1 = strlen(s1);
-	while (l1 >= l2) {
-		l1--;
-		if (!memcmp(s1, s2, l2))
-			return (char *)s1;
-		s1++;
-	}
-	return NULL;
-}
-EXPORT_SYMBOL(strstr);
-#endif
-
 #ifndef __HAVE_ARCH_STRNSTR
 /**
  * strnstr - Find the first substring in a length-limited string
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F94E339E08
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 13:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhCMMY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 07:24:59 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:21028 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhCMMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 07:24:58 -0500
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 12DCNhQv030190;
        Sat, 13 Mar 2021 21:23:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 12DCNhQv030190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615638224;
        bh=YQNABWr0erz25nT0kbiVZpsc7Nb4rJN3cUE+AnMZjy4=;
        h=From:To:Cc:Subject:Date:From;
        b=CZGl5cldEUcbzsbLII3RXAiomKw7XGz2DqgY04/kSsUsUJLoDYBz9fnyT6Y48yti/
         jccFYXTsCSvUSbz3T4sksL6evS/tF4z7hNvFFKbQQadmmw1Pa743Va0YKMxe36r6Jc
         PMDF3JMy3bsJFyVoLmCWHQtBa0ikFID77M918ovDL4J2EHttPaub0cuGLg9pBRBls7
         t+rGVzBdNxhtRP4S6iQN4PbMhzgU5A/hd26MidoatvoTxIiqKcJUFg/yIsxZpgQCOg
         /7Sc8gCP8LShQnAGDJftsKtLcBMKtF8ixOGRbQ34ofh1YmR+e9aTQJBNKg2cnnUBQr
         72M+3mlNQeEIw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] xtensa: move CONFIG_CPU_*_ENDIAN defines to Kconfig
Date:   Sat, 13 Mar 2021 21:23:41 +0900
Message-Id: <20210313122342.69995-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the definition of CONFIG_CPU_*_ENDIAN to Kconfig, the best place
for CONFIG options.

I slightly simplified the test code. You can use the -P option to suppress
linemarker generation. The grep command is unneeded.

  $ echo __XTENSA_EB__ | xtensa-linux-gcc -E -
  # 1 "<stdin>"
  # 1 "<built-in>"
  # 1 "<command-line>"
  # 1 "<stdin>"
  1

  $ echo __XTENSA_EB__ | xtensa-linux-gcc -E -P -
  1

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
 - more cleanups

 arch/xtensa/Kconfig                    | 6 ++++++
 arch/xtensa/Makefile                   | 9 +--------
 arch/xtensa/boot/Makefile              | 4 ----
 arch/xtensa/boot/boot-elf/Makefile     | 6 +-----
 arch/xtensa/boot/boot-redboot/Makefile | 6 +-----
 5 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 9ad6b7b82707..37b04ccc0a7f 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -84,6 +84,12 @@ config KASAN_SHADOW_OFFSET
 	hex
 	default 0x6e400000
 
+config CPU_BIG_ENDIAN
+	def_bool $(success,test "$(shell,echo __XTENSA_EB__ | $(CC) -E -P -)" = 1)
+
+config CPU_LITTLE_ENDIAN
+	def_bool !CPU_BIG_ENDIAN
+
 menu "Processor type and features"
 
 choice
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index cf0940708702..f43c731dec89 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -52,14 +52,7 @@ ifneq ($(CONFIG_LD_NO_RELAX),)
 KBUILD_LDFLAGS := --no-relax
 endif
 
-ifeq ($(shell echo __XTENSA_EB__ | $(CC) -E - | grep -v "\#"),1)
-CHECKFLAGS += -D__XTENSA_EB__
-KBUILD_CPPFLAGS += -DCONFIG_CPU_BIG_ENDIAN
-endif
-ifeq ($(shell echo __XTENSA_EL__ | $(CC) -E - | grep -v "\#"),1)
-CHECKFLAGS += -D__XTENSA_EL__
-KBUILD_CPPFLAGS += -DCONFIG_CPU_LITTLE_ENDIAN
-endif
+CHECKFLAGS += -D $(if $(CONFIG_CPU_BIG_ENDIAN),__XTENSA_EB__,__XTENSA_EL__)
 
 vardirs := $(patsubst %,arch/xtensa/variants/%/,$(variant-y))
 plfdirs := $(patsubst %,arch/xtensa/platforms/%/,$(platform-y))
diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index f6bb352f94b4..a65b7a9ebff2 100644
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -12,10 +12,6 @@
 KBUILD_CFLAGS	+= -fno-builtin -Iarch/$(ARCH)/boot/include
 HOSTFLAGS	+= -Iarch/$(ARCH)/boot/include
 
-BIG_ENDIAN	:= $(shell echo __XTENSA_EB__ | $(CC) -E - | grep -v "\#")
-
-export BIG_ENDIAN
-
 subdir-y	:= lib
 targets		+= vmlinux.bin vmlinux.bin.gz
 targets		+= uImage xipImage
diff --git a/arch/xtensa/boot/boot-elf/Makefile b/arch/xtensa/boot/boot-elf/Makefile
index f7c775d53012..47b9063f2c5d 100644
--- a/arch/xtensa/boot/boot-elf/Makefile
+++ b/arch/xtensa/boot/boot-elf/Makefile
@@ -4,11 +4,7 @@
 # for more details.
 #
 
-ifeq ($(BIG_ENDIAN),1)
-OBJCOPY_ARGS    := -O elf32-xtensa-be
-else
-OBJCOPY_ARGS    := -O elf32-xtensa-le
-endif
+OBJCOPY_ARGS := -O $(if $(CONFIG_CPU_BIG_ENDIAN),elf32-xtensa-be,elf32-xtensa-le)
 
 export OBJCOPY_ARGS
 export CPPFLAGS_boot.lds += -P -C
diff --git a/arch/xtensa/boot/boot-redboot/Makefile b/arch/xtensa/boot/boot-redboot/Makefile
index 07cb24afedc2..1d1d46215b1c 100644
--- a/arch/xtensa/boot/boot-redboot/Makefile
+++ b/arch/xtensa/boot/boot-redboot/Makefile
@@ -4,11 +4,7 @@
 # for more details.
 #
 
-ifeq ($(BIG_ENDIAN),1)
-OBJCOPY_ARGS 	:= -O elf32-xtensa-be
-else
-OBJCOPY_ARGS 	:= -O elf32-xtensa-le
-endif
+OBJCOPY_ARGS := -O $(if $(CONFIG_CPU_BIG_ENDIAN),elf32-xtensa-be,elf32-xtensa-le)
 
 LD_ARGS	= -T $(srctree)/$(obj)/boot.ld
 
-- 
2.27.0


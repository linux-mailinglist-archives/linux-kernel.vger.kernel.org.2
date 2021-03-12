Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8DF3390F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhCLPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:15:18 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:17932 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhCLPPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:15:14 -0500
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 12CFELVS017750;
        Sat, 13 Mar 2021 00:14:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 12CFELVS017750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615562062;
        bh=di2FogfNTrfuBKoiuiGg7kZDO4ZOULOPFSBFHn6SMqA=;
        h=From:To:Cc:Subject:Date:From;
        b=OfZsvyCMX3mKwO9jjBPsMoGQ8rbioccDYnagZzsxHgq+v2QYpOfwzz8qH1gdP3StH
         e0o+q7MsyP9yAfusxh26ZKagb6Immiun3HxpnFKHwPxU19I7/desbsDzgYnA31WKba
         hd/L9E/Ehi0k3EA3en8iEOxJ1cWvuqvO81+lYDhH2OPuY3RbHKJzWZdqZjFzQuCWBH
         MBeW3FDPUxx4xLVCsCkfk3HkwM/SYejnJPYaGPBOCKacP5eTVvHjCRZ1hPNtuJ102K
         TcNuFNIfbAU7dS56GfBst2SnMHl5RiH8/KkGYUURYhyRCHdSYx3KfA0i41GxF2xzSO
         IRndf+RgpZ4Tw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: move CONFIG_CPU_*_ENDIAN defines to Kconfig
Date:   Sat, 13 Mar 2021 00:14:11 +0900
Message-Id: <20210312151411.101942-1-masahiroy@kernel.org>
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

If I understood correctly, xtensa compilers can support either
big-endian or little-endian. We cannot change it via a command option.
Actually, it does not understand -mbig-endian or -mlittle-endian.
(Is this correct?)

  $ xtensa-linux-gcc   -mbig-endian  /dev/null  -c -o /dev/null
  xtensa-linux-gcc: error: unrecognized command-line option '-mbig-endian'

I see -mbig-endian / -mlittle-endian in old GCC manual.
  https://gcc.gnu.org/onlinedocs/gcc-3.3.5/gcc/Xtensa-Options.html
But, I cannot see them in recent gcc manuals.
So, I have no idea better than checking __XTENSA_EB__ or __XTENSA_EL__.
I just moved the logic to Kconfig from Makefile.


 arch/xtensa/Kconfig  | 6 ++++++
 arch/xtensa/Makefile | 9 +--------
 2 files changed, 7 insertions(+), 8 deletions(-)

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
-- 
2.27.0


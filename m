Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE17328089
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhCAOS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:18:56 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:58846 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhCAOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:18:42 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 121EGHmx011120;
        Mon, 1 Mar 2021 23:16:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 121EGHmx011120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614608178;
        bh=KATgPEhHGlkRLTbr+4kD2peprMRFiYaPEpV9KBt8u6w=;
        h=From:To:Cc:Subject:Date:From;
        b=JRfAeV0A/kLiYu4Ziurfud8kEl6ivDMvPj7k7fggITLOx4gvatVOWjNIkxGNtRa2R
         XMdMNbZDyRFsyWou/uQ0IJkxedHbDOpEySDvdYOze0Un+oG4y8ioGpo80NrOON6nT7
         FCbGs5D3xjFJRfIAiMWN2028Z6fYWWO84p7B5GpDO2099fAkTjdmmyFVysAtRbBMcK
         RwGiYxUYoeUTUSVhBDcLcy1L1b9NicrYK2jHzMYK6eHCr9Qde2S+wnAZl1DyUnd3Fg
         e3J56Nt/5wbe+ZiUZHl9ROH24J4qCnJzrr6Zk4jm6t6BByOVZj3DaHQJNZpqD3Tbgq
         /aBLzgcjkiDyw==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: syscalls: switch to generic syscalltbl.sh
Date:   Mon,  1 Mar 2021 23:16:06 +0900
Message-Id: <20210301141606.341743-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many architectures duplicate similar shell scripts.

This commit converts ARM to use scripts/syscalltbl.sh.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm/kernel/entry-common.S |  8 ++++----
 arch/arm/tools/Makefile        |  9 ++++-----
 arch/arm/tools/syscalltbl.sh   | 22 ----------------------
 3 files changed, 8 insertions(+), 31 deletions(-)
 delete mode 100644 arch/arm/tools/syscalltbl.sh

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index e0d7833a1827..7f0b7aba1498 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -344,20 +344,19 @@ ENTRY(\sym)
 	.size	\sym, . - \sym
 	.endm
 
-#define NATIVE(nr, func) syscall nr, func
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+#define __SYSCALL(nr, func) syscall nr, func
 
 /*
  * This is the syscall table declaration for native ABI syscalls.
  * With EABI a couple syscalls are obsolete and defined as sys_ni_syscall.
  */
 	syscall_table_start sys_call_table
-#define COMPAT(nr, native, compat) syscall nr, native
 #ifdef CONFIG_AEABI
 #include <calls-eabi.S>
 #else
 #include <calls-oabi.S>
 #endif
-#undef COMPAT
 	syscall_table_end sys_call_table
 
 /*============================================================================
@@ -455,7 +454,8 @@ ENDPROC(sys_oabi_readahead)
  * using the compatibility syscall entries.
  */
 	syscall_table_start sys_oabi_call_table
-#define COMPAT(nr, native, compat) syscall nr, compat
+#undef __SYSCALL_WITH_COMPAT
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
 #include <calls-oabi.S>
 	syscall_table_end sys_oabi_call_table
 
diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index 3654f979851b..d8be90f2bb41 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -10,7 +10,7 @@ kapi := $(gen)/asm
 uapi := $(gen)/uapi/asm
 syshdr := $(srctree)/$(src)/syscallhdr.sh
 sysnr := $(srctree)/$(src)/syscallnr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
 syscall := $(src)/syscall.tbl
 
 gen-y := $(gen)/calls-oabi.S
@@ -47,8 +47,7 @@ quiet_cmd_syshdr = SYSHDR  $@
 		   '__NR_SYSCALL_BASE'
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@' \
-		   '$(systbl_abi_$(basetarget))'
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
 
 quiet_cmd_sysnr  = SYSNR   $@
       cmd_sysnr  = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@' \
@@ -70,10 +69,10 @@ sysnr_abi_unistd-nr := common,oabi,eabi,compat
 $(kapi)/unistd-nr.h: $(syscall) $(sysnr) FORCE
 	$(call if_changed,sysnr)
 
-systbl_abi_calls-oabi := common,oabi
+$(gen)/calls-oabi.S: abis := common,oabi
 $(gen)/calls-oabi.S: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
-systbl_abi_calls-eabi := common,eabi
+$(gen)/calls-eabi.S: abis := common,eabi
 $(gen)/calls-eabi.S: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
diff --git a/arch/arm/tools/syscalltbl.sh b/arch/arm/tools/syscalltbl.sh
deleted file mode 100644
index ae7e93cfbfd3..000000000000
--- a/arch/arm/tools/syscalltbl.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-    while read nr abi name entry compat; do
-        if [ "$abi" = "eabi" -a -n "$compat" ]; then
-            echo "$in: error: a compat entry for an EABI syscall ($name) makes no sense" >&2
-            exit 1
-        fi
-
-	if [ -n "$entry" ]; then
-            if [ -z "$compat" ]; then
-                echo "NATIVE($nr, $entry)"
-            else
-                echo "COMPAT($nr, $entry, $compat)"
-            fi
-        fi
-    done
-) > "$out"
-- 
2.27.0


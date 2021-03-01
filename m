Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105893282AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbhCAPjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:39:03 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:28628 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbhCAPid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:38:33 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 121Fawh7014128;
        Tue, 2 Mar 2021 00:36:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 121Fawh7014128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614613019;
        bh=SKhtT5tleMKgz5hsBf5rQZ2qPWHT+ZIFFqz79YnrzGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SMXD22Hd/IY8Fa3E7KNc/017r6PV7WrrDqLC2WsHoBY+QIwZwuIERI8v9As0xBQE3
         1BYW7S3RYFb3V2Kk2/Xj013H1er3palf9SCGpfQ2bS/5wyXjzqiJdoJxlvQZmIR192
         nA/Xah6HXuGPh43Pb6nJ5Uw7n37E80R7yTrqse9JAkWqExJElRHj5Z0RMD+YOOAKWv
         6GLOMFbT7PTm74wpGYKn7Og+wMNT0e7FXpE/EW7NfP1HsrruAS5AO3eQ6kj1b17s4P
         Ns85ThW9LxncKwyAQBR7FgvX6txjCMaFwhl/ug5V2YM8VMM2iHq6L49TkRdG3Cl4e+
         2r/CnnIEJPITQ==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] xtensa: syscalls: switch to generic syscalltbl.sh
Date:   Tue,  2 Mar 2021 00:36:55 +0900
Message-Id: <20210301153656.363839-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301153656.363839-1-masahiroy@kernel.org>
References: <20210301153656.363839-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many architectures duplicate similar shell scripts.

This commit converts xtensa to use scripts/syscalltbl.sh.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/xtensa/kernel/syscall.c              |  3 +--
 arch/xtensa/kernel/syscalls/Makefile      |  7 ++---
 arch/xtensa/kernel/syscalls/syscalltbl.sh | 32 -----------------------
 3 files changed, 3 insertions(+), 39 deletions(-)
 delete mode 100644 arch/xtensa/kernel/syscalls/syscalltbl.sh

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 26fa09ce4d17..201356faa7e6 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -28,9 +28,8 @@
 #include <linux/shm.h>
 
 syscall_t sys_call_table[] /* FIXME __cacheline_aligned */= {
-#define __SYSCALL(nr, entry, nargs)	(syscall_t)entry,
+#define __SYSCALL(nr, entry)	(syscall_t)entry,
 #include <asm/syscall_table.h>
-#undef __SYSCALL
 };
 
 #define COLOUR_ALIGN(addr, pgoff) \
diff --git a/arch/xtensa/kernel/syscalls/Makefile b/arch/xtensa/kernel/syscalls/Makefile
index 285aaba832d9..ad2492cb5568 100644
--- a/arch/xtensa/kernel/syscalls/Makefile
+++ b/arch/xtensa/kernel/syscalls/Makefile
@@ -7,7 +7,7 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
 
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/$(src)/syscallhdr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
@@ -16,10 +16,7 @@ quiet_cmd_syshdr = SYSHDR  $@
 		   '$(syshdr_offset_$(basetarget))'
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
-		   '$(systbl_abis_$(basetarget))'		\
-		   '$(systbl_abi_$(basetarget))'		\
-		   '$(systbl_offset_$(basetarget))'
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) $< $@
 
 $(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
diff --git a/arch/xtensa/kernel/syscalls/syscalltbl.sh b/arch/xtensa/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index 85d78d9309ad..000000000000
--- a/arch/xtensa/kernel/syscalls/syscalltbl.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-my_abi="$4"
-offset="$5"
-
-emit() {
-	t_nxt="$1"
-	t_nr="$2"
-	t_entry="$3"
-
-	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
-		t_nxt=$((t_nxt+1))
-	done
-	printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
-}
-
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	nxt=0
-	if [ -z "$offset" ]; then
-		offset=0
-	fi
-
-	while read nr abi name entry ; do
-		emit $((nxt+offset)) $((nr+offset)) $entry
-		nxt=$((nr+1))
-	done
-) > "$out"
-- 
2.27.0


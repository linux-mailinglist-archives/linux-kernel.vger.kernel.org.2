Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242493281A6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbhCAPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:00:52 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:19367 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbhCAPAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:00:44 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 121EwQpK003819;
        Mon, 1 Mar 2021 23:58:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 121EwQpK003819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614610708;
        bh=Vm0Cz4nIZxyggyLHUxO2PuNEI2EbflOodh40KfTUes4=;
        h=From:To:Cc:Subject:Date:From;
        b=ZHhJEO+MntJD9J6FNWDgYGYlR0E0MbP2mNDHOyYDKLSzdA/qL+dUEVleWyq6CGgrt
         X20X3LuySpjeEdLoxtECiFZpiF4He60ZlMmsTOaTvRlYUeiIuZJKvNRx6/zuUuejGi
         hxRQR43I9vy8AHv5xtrUBAdrsgZNx6RqcIy0beoiSHIhQI8TzQudXYWabAEcziJD1B
         9eZ3kAYJa+togKgRPNgZtCYFQgf8tVqO2NBFny7BnvY+3b6Tqx7j3y7J01UmAOZzn+
         t+EEmipsRH2QdpcCRv2om+XyTDnzPNwQU2DaM1MvM08UylUDiRzhNkEzncUMAmc+rH
         cxgKVsYRuJ7+Q==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John David Anglin <dave.anglin@bell.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        YiFei Zhu <yifeifz2@illinois.edu>
Subject: [PATCH 1/2] parisc: syscalls: switch to generic syscalltbl.sh
Date:   Mon,  1 Mar 2021 23:58:22 +0900
Message-Id: <20210301145823.359770-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many architectures duplicate similar shell scripts.

This commit converts parisc to use scripts/syscalltbl.sh. This also
unifies syscall_table_64.h and syscall_table_c32.h.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/include/asm/Kbuild            |  1 -
 arch/parisc/kernel/syscall.S              | 16 +++++-----
 arch/parisc/kernel/syscalls/Makefile      | 19 ++++--------
 arch/parisc/kernel/syscalls/syscalltbl.sh | 36 -----------------------
 4 files changed, 12 insertions(+), 60 deletions(-)
 delete mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh

diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 4406475a2304..e6e7f74c8ac9 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
-generated-y += syscall_table_c32.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += user.h
diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
index 322503780db6..3f24a0af1e04 100644
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -919,24 +919,24 @@ ENTRY(lws_table)
 END(lws_table)
 	/* End of lws table */
 
+#ifdef CONFIG_64BIT
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
+#else
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+#endif
 #define __SYSCALL(nr, entry)	ASM_ULONG_INSN entry
 	.align 8
 ENTRY(sys_call_table)
 	.export sys_call_table,data
-#ifdef CONFIG_64BIT
-#include <asm/syscall_table_c32.h>   /* Compat syscalls */
-#else
-#include <asm/syscall_table_32.h>    /* 32-bit native syscalls */
-#endif
+#include <asm/syscall_table_32.h>    /* 32-bit syscalls */
 END(sys_call_table)
 
 #ifdef CONFIG_64BIT
 	.align 8
 ENTRY(sys_call_table64)
-#include <asm/syscall_table_64.h>    /* 64-bit native syscalls */
+#include <asm/syscall_table_64.h>    /* 64-bit syscalls */
 END(sys_call_table64)
 #endif
-#undef __SYSCALL
 
 	/*
 		All light-weight-syscall atomic operations 
@@ -961,5 +961,3 @@ END(lws_lock_start)
 	.previous
 
 .end
-
-
diff --git a/arch/parisc/kernel/syscalls/Makefile b/arch/parisc/kernel/syscalls/Makefile
index 283f64407b07..11424f1c8d9e 100644
--- a/arch/parisc/kernel/syscalls/Makefile
+++ b/arch/parisc/kernel/syscalls/Makefile
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
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
 
 syshdr_abis_unistd_32 := common,32
 $(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
@@ -29,23 +26,17 @@ syshdr_abis_unistd_64 := common,64
 $(uapi)/unistd_64.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-systbl_abis_syscall_table_32 := common,32
+$(kapi)/syscall_table_32.h: abis := common,32
 $(kapi)/syscall_table_32.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
-systbl_abis_syscall_table_64 := common,64
+$(kapi)/syscall_table_64.h: abis := common,64
 $(kapi)/syscall_table_64.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
-systbl_abis_syscall_table_c32 := common,32
-systbl_abi_syscall_table_c32 := c32
-$(kapi)/syscall_table_c32.h: $(syscall) $(systbl) FORCE
-	$(call if_changed,systbl)
-
 uapisyshdr-y		+= unistd_32.h unistd_64.h
 kapisyshdr-y		+= syscall_table_32.h		\
-			   syscall_table_64.h		\
-			   syscall_table_c32.h
+			   syscall_table_64.h
 
 uapisyshdr-y	:= $(addprefix $(uapi)/, $(uapisyshdr-y))
 kapisyshdr-y	:= $(addprefix $(kapi)/, $(kapisyshdr-y))
diff --git a/arch/parisc/kernel/syscalls/syscalltbl.sh b/arch/parisc/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index f7393a7b18aa..000000000000
--- a/arch/parisc/kernel/syscalls/syscalltbl.sh
+++ /dev/null
@@ -1,36 +0,0 @@
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
-		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
-		t_nxt=$((t_nxt+1))
-	done
-	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
-}
-
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	nxt=0
-	if [ -z "$offset" ]; then
-		offset=0
-	fi
-
-	while read nr abi name entry compat ; do
-		if [ "$my_abi" = "c32" ] && [ ! -z "$compat" ]; then
-			emit $((nxt+offset)) $((nr+offset)) $compat
-		else
-			emit $((nxt+offset)) $((nr+offset)) $entry
-		fi
-		nxt=$((nr+1))
-	done
-) > "$out"
-- 
2.27.0


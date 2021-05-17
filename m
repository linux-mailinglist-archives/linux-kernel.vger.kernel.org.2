Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3ABF38257A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhEQHl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:41:26 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:34116 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhEQHlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:41:25 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 14H7cLoK027919;
        Mon, 17 May 2021 16:38:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 14H7cLoK027919
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621237103;
        bh=nQwjmmHWNqZNKCxsyVlSYNQY6IWZCSqmYQVRvxe0gNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYn672Wep5jQul1Ijeeba/P686Cy0fDHR1VJQzgMz0eLGo2L9qGCJ9r0GsrSFoRNR
         YdGmbbGhgLODq239T3EpPonNb9NHrhqOs4nXWstUYFlfDSkQEY3m8eIrhwPMdNXduQ
         xpiINoj5iF182T4t6fvgiOhoOqZfAiX5Uj4YvEoYMQjKvLELMCywGoftg6XuuTt9EF
         eBD0okwA6zib4WMz95cZ4Ydw1prPSs8e4454rwvX15txovvMeDLLxYwmzVGFsFXyXY
         97hEkD71DQD96EqZRATCHLY5tQrylrcyaPSSdgR7XG7o6hvKR4fH2WN0iFz6BPsSas
         +nACmx9PF4fwQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: [RESEND PATCH 2/6] x86/syscalls: switch to generic syscalltbl.sh
Date:   Mon, 17 May 2021 16:38:10 +0900
Message-Id: <20210517073815.97426-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210517073815.97426-1-masahiroy@kernel.org>
References: <20210517073815.97426-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many architectures duplicate similar shell scripts.

This commit converts x86 and UML to use scripts/syscalltbl.sh.

Currently, syscall_64.h mixes up x86_64 and x32 syscalls. This commit
splits it into syscall_64.h and syscall_x32.h.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/entry/syscall_32.c           | 12 +++++--
 arch/x86/entry/syscall_64.c           |  9 ++----
 arch/x86/entry/syscall_x32.c          | 15 +++------
 arch/x86/entry/syscalls/Makefile      | 10 ++++--
 arch/x86/entry/syscalls/syscalltbl.sh | 46 ---------------------------
 arch/x86/include/asm/Kbuild           |  1 +
 arch/x86/um/sys_call_table_32.c       |  8 +++--
 arch/x86/um/sys_call_table_64.c       |  9 ++----
 8 files changed, 34 insertions(+), 76 deletions(-)
 delete mode 100644 arch/x86/entry/syscalls/syscalltbl.sh

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 86eb0d89d46f..70bf46e73b1c 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -8,12 +8,18 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_I386(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
+#ifdef CONFIG_IA32_EMULATION
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
+#else
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+#endif
+
+#define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
 
 #include <asm/syscalls_32.h>
-#undef __SYSCALL_I386
+#undef __SYSCALL
 
-#define __SYSCALL_I386(nr, sym) [nr] = __ia32_##sym,
+#define __SYSCALL(nr, sym) [nr] = __ia32_##sym,
 
 __visible const sys_call_ptr_t ia32_sys_call_table[__NR_ia32_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 1594ec72bcbb..82670bb10931 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,14 +8,11 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_X32(nr, sym)
-#define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
-
-#define __SYSCALL_64(nr, sym) extern long __x64_##sym(const struct pt_regs *);
+#define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
-#undef __SYSCALL_64
+#undef __SYSCALL
 
-#define __SYSCALL_64(nr, sym) [nr] = __x64_##sym,
+#define __SYSCALL(nr, sym) [nr] = __x64_##sym,
 
 asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 3fea8fb9cd6a..6d2ef887d7b6 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -8,16 +8,11 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_64(nr, sym)
+#define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
+#include <asm/syscalls_x32.h>
+#undef __SYSCALL
 
-#define __SYSCALL_X32(nr, sym) extern long __x64_##sym(const struct pt_regs *);
-#define __SYSCALL_COMMON(nr, sym) extern long __x64_##sym(const struct pt_regs *);
-#include <asm/syscalls_64.h>
-#undef __SYSCALL_X32
-#undef __SYSCALL_COMMON
-
-#define __SYSCALL_X32(nr, sym) [nr] = __x64_##sym,
-#define __SYSCALL_COMMON(nr, sym) [nr] = __x64_##sym,
+#define __SYSCALL(nr, sym) [nr] = __x64_##sym,
 
 asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
 	/*
@@ -25,5 +20,5 @@ asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
 	 * when the & below is removed.
 	 */
 	[0 ... __NR_x32_syscall_max] = &__x64_sys_ni_syscall,
-#include <asm/syscalls_64.h>
+#include <asm/syscalls_x32.h>
 };
diff --git a/arch/x86/entry/syscalls/Makefile b/arch/x86/entry/syscalls/Makefile
index d8c4f6c9eadc..c4bd8dd82bb1 100644
--- a/arch/x86/entry/syscalls/Makefile
+++ b/arch/x86/entry/syscalls/Makefile
@@ -10,7 +10,7 @@ syscall32 := $(src)/syscall_32.tbl
 syscall64 := $(src)/syscall_64.tbl
 
 syshdr := $(srctree)/$(src)/syscallhdr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@' \
@@ -18,7 +18,7 @@ quiet_cmd_syshdr = SYSHDR  $@
 		   '$(syshdr_pfx_$(basetarget))' \
 		   '$(syshdr_offset_$(basetarget))'
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' $< $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
 
 quiet_cmd_hypercalls = HYPERCALLS $@
       cmd_hypercalls = $(CONFIG_SHELL) '$<' $@ $(filter-out $<, $(real-prereqs))
@@ -46,10 +46,15 @@ syshdr_pfx_unistd_64_x32 := x32_
 $(out)/unistd_64_x32.h: $(syscall64) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
+$(out)/syscalls_32.h: abis := i386
 $(out)/syscalls_32.h: $(syscall32) $(systbl) FORCE
 	$(call if_changed,systbl)
+$(out)/syscalls_64.h: abis := common,64
 $(out)/syscalls_64.h: $(syscall64) $(systbl) FORCE
 	$(call if_changed,systbl)
+$(out)/syscalls_x32.h: abis := common,x32
+$(out)/syscalls_x32.h: $(syscall64) $(systbl) FORCE
+	$(call if_changed,systbl)
 
 $(out)/xen-hypercalls.h: $(srctree)/scripts/xen-hypercalls.sh FORCE
 	$(call if_changed,hypercalls)
@@ -60,6 +65,7 @@ uapisyshdr-y			+= unistd_32.h unistd_64.h unistd_x32.h
 syshdr-y			+= syscalls_32.h
 syshdr-$(CONFIG_X86_64)		+= unistd_32_ia32.h unistd_64_x32.h
 syshdr-$(CONFIG_X86_64)		+= syscalls_64.h
+syshdr-$(CONFIG_X86_X32)	+= syscalls_x32.h
 syshdr-$(CONFIG_XEN)		+= xen-hypercalls.h
 
 uapisyshdr-y	:= $(addprefix $(uapi)/, $(uapisyshdr-y))
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
deleted file mode 100644
index 929bde120d6b..000000000000
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ /dev/null
@@ -1,46 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-
-syscall_macro() {
-    local abi="$1"
-    local nr="$2"
-    local entry="$3"
-
-    echo "__SYSCALL_${abi}($nr, $entry)"
-}
-
-emit() {
-    local abi="$1"
-    local nr="$2"
-    local entry="$3"
-    local compat="$4"
-
-    if [ "$abi" != "I386" -a -n "$compat" ]; then
-	echo "a compat entry ($abi: $compat) for a 64-bit syscall makes no sense" >&2
-	exit 1
-    fi
-
-    if [ -z "$compat" ]; then
-	if [ -n "$entry" ]; then
-	    syscall_macro "$abi" "$nr" "$entry"
-	fi
-    else
-	echo "#ifdef CONFIG_X86_32"
-	if [ -n "$entry" ]; then
-	    syscall_macro "$abi" "$nr" "$entry"
-	fi
-	echo "#else"
-	syscall_macro "$abi" "$nr" "$compat"
-	echo "#endif"
-    fi
-}
-
-grep '^[0-9]' "$in" | sort -n | (
-    while read nr abi name entry compat; do
-	abi=`echo "$abi" | tr '[a-z]' '[A-Z]'`
-	emit "$abi" "$nr" "$entry" "$compat"
-    done
-) > "$out"
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index b19ec8282d50..1e51650b79d7 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -3,6 +3,7 @@
 
 generated-y += syscalls_32.h
 generated-y += syscalls_64.h
+generated-y += syscalls_x32.h
 generated-y += unistd_32_ia32.h
 generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index 2ed81e581755..e83619c365dc 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -26,11 +26,13 @@
 
 #define old_mmap sys_old_mmap
 
-#define __SYSCALL_I386(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+
+#define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_32.h>
 
-#undef __SYSCALL_I386
-#define __SYSCALL_I386(nr, sym) [ nr ] = sym,
+#undef __SYSCALL
+#define __SYSCALL(nr, sym) [ nr ] = sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 2e8544dafbb0..6fb75af7cf54 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -36,14 +36,11 @@
 #define stub_execveat sys_execveat
 #define stub_rt_sigreturn sys_rt_sigreturn
 
-#define __SYSCALL_X32(nr, sym)
-#define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
-
-#define __SYSCALL_64(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_64.h>
 
-#undef __SYSCALL_64
-#define __SYSCALL_64(nr, sym) [ nr ] = sym,
+#undef __SYSCALL
+#define __SYSCALL(nr, sym) [ nr ] = sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
-- 
2.27.0


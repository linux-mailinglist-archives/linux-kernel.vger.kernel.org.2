Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED779327F4A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhCANTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:19:08 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:37523 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbhCANSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:18:39 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 121DFe7V026106;
        Mon, 1 Mar 2021 22:15:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 121DFe7V026106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614604546;
        bh=p+dw7L+w9yWi+tay3Ajra2nFDqOUrBXuy6WX1bBuhnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TX/6fjru/azTE2RPT2TNOh+kDnmh9iHwOLbu06K7Tx4XYD56ERmnzi5QQ5MWIJN+p
         /5mzjcirDbKbwuSF7TUu/EHqypiPw1cDOWvRVbzpWGjpIfjsNPcG2V3RnrM3G3s+/d
         t7BtJahHRX4SEEvmUhmqdfQtlacAA6CydBLpxlsL76ZxdGaMqseIogKL47XncaEd0f
         JA//RW04tFW5NqNdBGfH1qY2V1o2ZiTBgAD9FXwubKh8x7w7H2/qqw9T1ovZDzH5Kq
         cUmz4HkmACYFhUXq6lJ5orX/Orf7bDmcnc2l0nwbv3x6NZOvOieKq5kStd39rxAK2n
         iWXcQZQdgw9xQ==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
Subject: [PATCH 4/7] x86/syscalls: stop filling syscall arrays with *_sys_ni_syscall
Date:   Mon,  1 Mar 2021 22:15:29 +0900
Message-Id: <20210301131533.64671-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301131533.64671-1-masahiroy@kernel.org>
References: <20210301131533.64671-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up cleanup after switching to the generic
syscalltbl.sh.

The old arch/x86/entry/syscalls/syscalltbl.sh skipped non-existing
syscalls. So, the generated syscalls_64.h, for example, had a big
hole in the syscall numbers 335-423 range. That is why there exists
[0 ... __NR_*_syscall_max] = &__*_sys_ni_cyscall.

The new script, scripts/syscalltbl.sh automatically fills holes
with __SYSCALL(<nr>, sys_ni_syscall), hence such ugly code can
go away. The designated initializers, '[nr] =' are also unneeded.

Also, there is no need to give __NR_*_syscall_max+1 because the array
size is implied by the number of syscalls in the generated headers.
Hence, there is no need to include <asm/unistd.h>, either.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/entry/syscall_32.c     | 10 ++--------
 arch/x86/entry/syscall_64.c     | 10 ++--------
 arch/x86/entry/syscall_x32.c    | 10 ++--------
 arch/x86/um/sys_call_table_32.c |  6 ------
 arch/x86/um/sys_call_table_64.c |  6 ------
 5 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 70bf46e73b1c..8cfc9bc73e7f 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -5,7 +5,6 @@
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #ifdef CONFIG_IA32_EMULATION
@@ -19,13 +18,8 @@
 #include <asm/syscalls_32.h>
 #undef __SYSCALL
 
-#define __SYSCALL(nr, sym) [nr] = __ia32_##sym,
+#define __SYSCALL(nr, sym) __ia32_##sym,
 
-__visible const sys_call_ptr_t ia32_sys_call_table[__NR_ia32_syscall_max+1] = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_ia32_syscall_max] = &__ia32_sys_ni_syscall,
+__visible const sys_call_ptr_t ia32_sys_call_table[] = {
 #include <asm/syscalls_32.h>
 };
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 82670bb10931..be120eec1fc9 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -5,20 +5,14 @@
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL
 
-#define __SYSCALL(nr, sym) [nr] = __x64_##sym,
+#define __SYSCALL(nr, sym) __x64_##sym,
 
-asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_syscall_max] = &__x64_sys_ni_syscall,
+asmlinkage const sys_call_ptr_t sys_call_table[] = {
 #include <asm/syscalls_64.h>
 };
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 6d2ef887d7b6..bdd0e03a1265 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -5,20 +5,14 @@
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_x32.h>
 #undef __SYSCALL
 
-#define __SYSCALL(nr, sym) [nr] = __x64_##sym,
+#define __SYSCALL(nr, sym) __x64_##sym,
 
-asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_x32_syscall_max] = &__x64_sys_ni_syscall,
+asmlinkage const sys_call_ptr_t x32_sys_call_table[] = {
 #include <asm/syscalls_x32.h>
 };
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index e83619c365dc..f8323104e353 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -7,7 +7,6 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __NO_STUBS
@@ -37,11 +36,6 @@
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
 const sys_call_ptr_t sys_call_table[] ____cacheline_aligned = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_syscall_max] = &sys_ni_syscall,
 #include <asm/syscalls_32.h>
 };
 
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 6fb75af7cf54..5ed665dc785f 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -7,7 +7,6 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
-#include <asm/unistd.h>
 #include <asm/syscall.h>
 
 #define __NO_STUBS
@@ -45,11 +44,6 @@
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
 const sys_call_ptr_t sys_call_table[] ____cacheline_aligned = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_syscall_max] = &sys_ni_syscall,
 #include <asm/syscalls_64.h>
 };
 
-- 
2.27.0


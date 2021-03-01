Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BE8327F48
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhCANSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:18:38 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:36918 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbhCANSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:18:08 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 121DFe7T026106;
        Mon, 1 Mar 2021 22:15:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 121DFe7T026106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614604543;
        bh=kyBWoCO3BdtK9tSka2BMqht+lQedJUij9rXRPwBXhrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XycltIlbyj5AkkMrTH4rDZj+s3Lh4u1veaI5JD0eatHOv+EL2HmsepJusa3TN51Ul
         uWjkLApthLppXN/Fty5qUFGGe66M0mfvQ7NYPj+2sMkpQqNHA9Q77OaSZULqSETAE1
         gDmPUHEf2KHSuR0IulZirCJWRamE5X0T+runDsHjQxwr8R7wZUmixMfBjrNjCy5Y0s
         JS98UYF/LgfIASMC7pvfkFFflzyxrvmtDqzBnBFQco3roLfIN3vvc8PgfzE/5GD1uL
         lv+cVh2FiqP/sxux41TVQR7rSxTmhQNVB7qZ4CUG/qBmff6uFtsWdoM62wRp8mehFc
         YW+qzmtdP5lng==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 2/7] x86/entry/x32: rename __x32_compat_sys_* to __x64_compat_sys_*
Date:   Mon,  1 Mar 2021 22:15:27 +0900
Message-Id: <20210301131533.64671-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301131533.64671-1-masahiroy@kernel.org>
References: <20210301131533.64671-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/x86/entry/syscall_x32.c, the macros are mapped to symbols
as follows:

  __SYSCALL_COMMON(nr, sym)  -->  __x64_<sym>
  __SYSCALL_X32(nr, sym)     -->  __x32_<sym>

Originally, the syscalls in the x32 special range (512-547) were all
compat.

This assumption is now broken after the following commits:

  55db9c0e8534 ("net: remove compat_sys_{get,set}sockopt")
  5f764d624a89 ("fs: remove the compat readv/writev syscalls")
  598b3cec831f ("fs: remove compat_sys_vmsplice")
  c3973b401ef2 ("mm: remove compat_process_vm_{readv,writev}")

Those commits redefined __x32_sys_* to __x64_sys_* because there is
no stub like __x32_sys_*.

I think defining as follows is more sensible and cleaner.

  __SYSCALL_COMMON(nr, sym)  -->  __x64_<sym>
  __SYSCALL_X32(nr, sym)     -->  __x64_<sym>

This works because both x86_64 and x32 use the same ABI
(RDI, RSI, RDX, R10, R8, R9)

The ugly #define __x32_sys_* will go away.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/entry/syscall_x32.c           | 16 ++--------------
 arch/x86/include/asm/syscall_wrapper.h | 10 +++++-----
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index f2fe0a33bcfd..3fea8fb9cd6a 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -8,27 +8,15 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-/*
- * Reuse the 64-bit entry points for the x32 versions that occupy different
- * slots in the syscall table.
- */
-#define __x32_sys_readv		__x64_sys_readv
-#define __x32_sys_writev	__x64_sys_writev
-#define __x32_sys_getsockopt	__x64_sys_getsockopt
-#define __x32_sys_setsockopt	__x64_sys_setsockopt
-#define __x32_sys_vmsplice	__x64_sys_vmsplice
-#define __x32_sys_process_vm_readv	__x64_sys_process_vm_readv
-#define __x32_sys_process_vm_writev	__x64_sys_process_vm_writev
-
 #define __SYSCALL_64(nr, sym)
 
-#define __SYSCALL_X32(nr, sym) extern long __x32_##sym(const struct pt_regs *);
+#define __SYSCALL_X32(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #define __SYSCALL_COMMON(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_X32
 #undef __SYSCALL_COMMON
 
-#define __SYSCALL_X32(nr, sym) [nr] = __x32_##sym,
+#define __SYSCALL_X32(nr, sym) [nr] = __x64_##sym,
 #define __SYSCALL_COMMON(nr, sym) [nr] = __x64_##sym,
 
 asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 80c08c7d5e72..6a2827d0681f 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -17,7 +17,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * __x64_sys_*()         - 64-bit native syscall
  * __ia32_sys_*()        - 32-bit native syscall or common compat syscall
  * __ia32_compat_sys_*() - 32-bit compat syscall
- * __x32_compat_sys_*()  - 64-bit X32 compat syscall
+ * __x64_compat_sys_*()  - 64-bit X32 compat syscall
  *
  * The registers are decoded according to the ABI:
  * 64-bit: RDI, RSI, RDX, R10, R8, R9
@@ -166,17 +166,17 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * with x86_64 obviously do not need such care.
  */
 #define __X32_COMPAT_SYS_STUB0(name)					\
-	__SYS_STUB0(x32, compat_sys_##name)
+	__SYS_STUB0(x64, compat_sys_##name)
 
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
-	__SYS_STUBx(x32, compat_sys##name,				\
+	__SYS_STUBx(x64, compat_sys##name,				\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
 #define __X32_COMPAT_COND_SYSCALL(name)					\
-	__COND_SYSCALL(x32, compat_sys_##name)
+	__COND_SYSCALL(x64, compat_sys_##name)
 
 #define __X32_COMPAT_SYS_NI(name)					\
-	__SYS_NI(x32, compat_sys_##name)
+	__SYS_NI(x64, compat_sys_##name)
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
-- 
2.27.0


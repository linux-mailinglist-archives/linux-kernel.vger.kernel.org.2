Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F06379650
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhEJRqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:46:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55863 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232605AbhEJRqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:46:44 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14AHjGkF2449170
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 10:45:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14AHjGkF2449170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620668729;
        bh=7klTzXoyWK7ks0IjJ5/FTRGMRBklJ1eNEUW1iRRjNrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ES/TcXRsFrf3L4FDvf6a+L0MwbKsGNvcWR84nUkgNQUg+GZeaIpHaBTYB5g+tVAOx
         vIIJYsbFoyymXmob/rLCBJWqf1X0NIGgqopKUurOQdGsEUkKJ29M0BxtKgJFn3ZUhi
         LvKkYXj9oq1Zg0KNc5iTl9G+EqxQ6M+rVfhQ5FkbGwHVn30YbIbpQJYZbFag/r5jIx
         PS1UxeTG+An9VZxJZoS+mbpZSeqLVJRMGPFe6m5HNRaUSOx/1XcesqWKwVOM20cpH+
         9Ff/64oheKt5hxleE8NDOwtvXEAm6HKtK+HbsKFsCO+aeOU/6enngUftyPEVuyt8rj
         Y7QC41ieELVrA==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 5/6] x86/entry: use int for syscall number; handle all invalid syscall nrs
Date:   Mon, 10 May 2021 10:45:08 -0700
Message-Id: <20210510174509.3039991-6-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510174509.3039991-1-hpa@zytor.com>
References: <20210510174509.3039991-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Redefine the system call number consistently to be "int". A negative
number is a non-system call (which can be poked in by ptrace/seccomp
to indicate that no further processing should be done and that the
return value should be the current value in regs->ax, default to
-ENOSYS; a positive value which does not correspond to a system call
unconditionally returns -ENOSYS just like system calls that correspond
to holes in the system call table.

Note that this is already what syscall_get_nr() returns, so that is
what all the architecture-independent code already expects.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/entry/common.c        | 71 +++++++++++++++++++++++-----------
 arch/x86/entry/entry_64.S      |  2 +-
 arch/x86/include/asm/syscall.h |  2 +-
 3 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 00da0f5420de..6a31354d56d2 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -36,61 +36,86 @@
 #include <asm/irq_stack.h>
 
 #ifdef CONFIG_X86_64
-__visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned long nr)
+
+static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
+{
+	unsigned long unr = nr;
+
+	if (likely(unr < NR_syscalls)) {
+		unr = array_index_nospec(unr, NR_syscalls);
+		regs->ax = sys_call_table[unr](regs);
+		return true;
+	}
+	return false;
+}
+
+static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
+{
+	unsigned long xnr = nr;
+
+	xnr -= __X32_SYSCALL_BIT;
+
+	if (IS_ENABLED(CONFIG_X86_X32_ABI) &&
+	    likely(xnr < X32_NR_syscalls)) {
+		xnr = array_index_nospec(xnr, X32_NR_syscalls);
+		regs->ax = x32_sys_call_table[xnr](regs);
+		return true;
+	}
+	return false;
+}
+
+__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
 {
 	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
 
 	instrumentation_begin();
-	if (likely(nr < NR_syscalls)) {
-		nr = array_index_nospec(nr, NR_syscalls);
-		regs->ax = sys_call_table[nr](regs);
-#ifdef CONFIG_X86_X32_ABI
-	} else if (likely((nr & __X32_SYSCALL_BIT) &&
-			  (nr & ~__X32_SYSCALL_BIT) < X32_NR_syscalls)) {
-		nr = array_index_nospec(nr & ~__X32_SYSCALL_BIT,
-					X32_NR_syscalls);
-		regs->ax = x32_sys_call_table[nr](regs);
-#endif
+
+	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr)) {
+		/* Invalid system call, but still a system call? */
+		if (nr >= 0)
+			regs->ax = __x64_sys_ni_syscall(regs);
 	}
+
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 }
 #endif
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
-static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
+static __always_inline int syscall_32_enter(struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_IA32_EMULATION))
 		current_thread_info()->status |= TS_COMPAT;
 
-	return (unsigned int)regs->orig_ax;
+	return (int)regs->orig_ax;
 }
 
 /*
  * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
  */
-static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
-						  unsigned int nr)
+static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
 {
-	if (likely(nr < IA32_NR_syscalls)) {
+	if (likely((unsigned int)nr < IA32_NR_syscalls)) {
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call_table[nr](regs);
+	} else if (nr >= 0) {
+		regs->ax = __ia32_sys_ni_syscall(regs);
 	}
 }
 
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
-	unsigned int nr = syscall_32_enter(regs);
+	int nr = syscall_32_enter(regs);
 
 	add_random_kstack_offset();
 	/*
-	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
-	 * orig_ax, the unsigned int return value truncates it.  This may
+	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
+	 * orig_ax, the int return value truncates it.  This may
 	 * or may not be necessary, but it matches the old asm behavior.
 	 */
-	nr = (unsigned int)syscall_enter_from_user_mode(regs, nr);
+	nr = (int)syscall_enter_from_user_mode(regs, nr);
 	instrumentation_begin();
 
 	do_syscall_32_irqs_on(regs, nr);
@@ -101,7 +126,7 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 
 static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 {
-	unsigned int nr = syscall_32_enter(regs);
+	int nr = syscall_32_enter(regs);
 	int res;
 
 	add_random_kstack_offset();
@@ -136,8 +161,8 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 		return false;
 	}
 
-	/* The case truncates any ptrace induced syscall nr > 2^32 -1 */
-	nr = (unsigned int)syscall_enter_from_user_mode_work(regs, nr);
+	/* The case truncates any ptrace induced syscall nr > 2^31 -1 */
+	nr = (int)syscall_enter_from_user_mode_work(regs, nr);
 
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs, nr);
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1d9db15fdc69..85f04ea0e368 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -108,7 +108,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 
 	/* IRQs are off. */
 	movq	%rsp, %rdi
-	movq	%rax, %rsi
+	movslq	%eax, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
 	/*
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index f6593cafdbd9..f7e2d82d24fb 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -159,7 +159,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 		? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
 }
 
-void do_syscall_64(struct pt_regs *regs, unsigned long nr);
+void do_syscall_64(struct pt_regs *regs, int nr);
 void do_int80_syscall_32(struct pt_regs *regs);
 long do_fast_syscall_32(struct pt_regs *regs);
 
-- 
2.31.1


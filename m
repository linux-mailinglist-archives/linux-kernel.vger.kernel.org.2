Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0C938806B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351793AbhERTVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:21:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60847 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351776AbhERTVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:21:24 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14IJDDRs4008171
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 18 May 2021 12:19:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14IJDDRs4008171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621365599;
        bh=aZN0ATCPGdNxz3c4p7s/Y7tkLQGd59xFZeraRg2D2s0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYVfh7L+aeXdkpqI+xuEmIua4i7UBWQ9cQBSXR+4L1Y8GO2mDzzwufnbZ0b32XMlE
         hUQP6gFF3WSiXG34Sny3cUBoQn58dyNFITCNICAnnQb8xiI6AzZ/96adHRUYomo0Og
         2z57zJhdET0/ABm5bDUA/cfUSrPTu6NIlMgqegmS2QS6KuOqlj0dTVWg2nwgfwv2t7
         /gAUvqwg2SuFFON2mF7i2dEj5GFllBiBpCiTsSsGgbZCryFzk7cpoYWnUd7wnEUQvQ
         g2z55UvS+Qw/9wcsGtSa4M8UphBFcOPbwpb1i0vPRL8MIKgz0cmZI6kpcHOCrfu/WA
         bMNuPaqm+zuNQ==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/6] x86/syscall: use int everywhere for system call numbers
Date:   Tue, 18 May 2021 12:13:03 -0700
Message-Id: <20210518191303.4135296-7-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518191303.4135296-1-hpa@zytor.com>
References: <20210518191303.4135296-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

System call numbers are defined as int, so use int everywhere for
system call numbers. This patch is strictly a cleanup; it should not
change anything user visible; all ABI changes have been done in the
preceeding patches.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/entry/common.c        | 93 ++++++++++++++++++++++++----------
 arch/x86/include/asm/syscall.h |  2 +-
 2 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index f51bc17262db..714804f0970c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -36,49 +36,87 @@
 #include <asm/irq_stack.h>
 
 #ifdef CONFIG_X86_64
-__visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned long nr)
+
+static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
+{
+	/*
+	 * Convert negative numbers to very high and thus out of range
+	 * numbers for comparisons. Use unsigned long to slightly
+	 * improve the array_index_nospec() generated code.
+	 */
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
+	/*
+	 * Adjust the starting offset of the table, and convert numbers
+	 * < __X32_SYSCALL_BIT to very high and thus out of range
+	 * numbers for comparisons. Use unsigned long to slightly
+	 * improve the array_index_nospec() generated code.
+	 */
+	unsigned long xnr = nr - __X32_SYSCALL_BIT;
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
-	} else if (unlikely((int)nr != -1)) {
+
+	if (!do_syscall_x64(regs, nr) &&
+	    !do_syscall_x32(regs, nr) &&
+	    unlikely(nr != -1)) {
+		/* Invalid system call, but still a system call? */
 		regs->ax = __x64_sys_ni_syscall(regs);
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
-		nr = array_index_nospec(nr, IA32_NR_syscalls);
-		regs->ax = ia32_sys_call_table[nr](regs);
-	} else if (unlikely((int)nr != -1)) {
+	/*
+	 * Convert negative numbers to very high and thus out of range
+	 * numbers for comparisons. Use unsigned long to slightly
+	 * improve the array_index_nospec() generated code.
+	 */
+	unsigned long unr = nr;
+
+	if (likely(unr < IA32_NR_syscalls)) {
+		unr = array_index_nospec(unr, IA32_NR_syscalls);
+		regs->ax = ia32_sys_call_table[unr](regs);
+	} else if (unlikely(nr != -1)) {
 		regs->ax = __ia32_sys_ni_syscall(regs);
 	}
 }
@@ -86,15 +124,15 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
-	unsigned int nr = syscall_32_enter(regs);
+	int nr = syscall_32_enter(regs);
 
 	add_random_kstack_offset();
 	/*
-	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
-	 * orig_ax, the unsigned int return value truncates it.  This may
-	 * or may not be necessary, but it matches the old asm behavior.
+	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
+	 * orig_ax, the int return value truncates it. This matches
+	 * the semantics of syscall_get_nr().
 	 */
-	nr = (unsigned int)syscall_enter_from_user_mode(regs, nr);
+	nr = syscall_enter_from_user_mode(regs, nr);
 	instrumentation_begin();
 
 	do_syscall_32_irqs_on(regs, nr);
@@ -105,7 +143,7 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 
 static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 {
-	unsigned int nr = syscall_32_enter(regs);
+	int nr = syscall_32_enter(regs);
 	int res;
 
 	add_random_kstack_offset();
@@ -140,8 +178,7 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 		return false;
 	}
 
-	/* The case truncates any ptrace induced syscall nr > 2^32 -1 */
-	nr = (unsigned int)syscall_enter_from_user_mode_work(regs, nr);
+	nr = syscall_enter_from_user_mode_work(regs, nr);
 
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs, nr);
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CF3315D78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbhBJCl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:41:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234854AbhBJCgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:36:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26DFC64E76;
        Wed, 10 Feb 2021 02:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924436;
        bh=/Pf7vFrDw0g0wUIGzXuLweRtgvKYoTB8gKEuEiREsy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qoYs7Q6HAnNokDn4kghQkKXXXVBpdafqsb31nJmUSDxtRudLEDv2nR7+1qrbdTxE8
         aGakZlN9OXIULjUiQj5trAZ1rTfp9fPAm06Agdq+XSxu9xrilfo8vFu6mdkz3ToEQd
         yI6zfPHNa+v6g1Zhpaf9CcmI/xjl0Ggv4kz792wvnNzYRuRPtQ50iAkvlTwX/1yrvW
         jAu/njyj/jpGHuj4GjafyjercZj1RrnDgr8qEFHqseeH1ZWVefHY4x23jaWAiic/Ne
         GuIunBgLUi5uWWSOcxkarDppN1Qo0tPoCQAV2fXU3yeCHefqlhG6p2Gd/Xy0BARap4
         CQdN1MqdY4pgw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 09/14] x86/fault: Split the OOPS code out from no_context()
Date:   Tue,  9 Feb 2021 18:33:41 -0800
Message-Id: <450f8d8eabafb83a5df349108c8e5ea83a2f939d.1612924255.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612924255.git.luto@kernel.org>
References: <cover.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all callers of no_context() want to run exception fixups.
Separate the OOPS code out from the fixup code in no_context().

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 116 +++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 54 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 3fe2f4800b69..8b8bd0a4f4b2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -654,53 +654,20 @@ static void set_signal_archinfo(unsigned long address,
 }
 
 static noinline void
-no_context(struct pt_regs *regs, unsigned long error_code,
-	   unsigned long address, int signal, int si_code)
+page_fault_oops(struct pt_regs *regs, unsigned long error_code,
+		unsigned long address)
 {
-	struct task_struct *tsk = current;
 	unsigned long flags;
 	int sig;
 
 	if (user_mode(regs)) {
 		/*
-		 * This is an implicit supervisor-mode access from user
-		 * mode.  Bypass all the kernel-mode recovery code and just
-		 * OOPS.
+		 * Implicit kernel access from user mode?  Skip the stack
+		 * overflow and EFI special cases.
 		 */
 		goto oops;
 	}
 
-	/* Are we prepared to handle this kernel fault? */
-	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
-		/*
-		 * Any interrupt that takes a fault gets the fixup. This makes
-		 * the below recursive fault logic only apply to a faults from
-		 * task context.
-		 */
-		if (in_interrupt())
-			return;
-
-		/*
-		 * Per the above we're !in_interrupt(), aka. task context.
-		 *
-		 * In this case we need to make sure we're not recursively
-		 * faulting through the emulate_vsyscall() logic.
-		 */
-		if (current->thread.sig_on_uaccess_err && signal) {
-			sanitize_error_code(address, &error_code);
-
-			set_signal_archinfo(address, error_code);
-
-			/* XXX: hwpoison faults will set the wrong code. */
-			force_sig_fault(signal, si_code, (void __user *)address);
-		}
-
-		/*
-		 * Barring that, we can do the fixup and be happy.
-		 */
-		return;
-	}
-
 #ifdef CONFIG_VMAP_STACK
 	/*
 	 * Stack overflow?  During boot, we can fault near the initial
@@ -708,8 +675,8 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	 * that we're in vmalloc space to avoid this.
 	 */
 	if (is_vmalloc_addr((void *)address) &&
-	    (((unsigned long)tsk->stack - 1 - address < PAGE_SIZE) ||
-	     address - ((unsigned long)tsk->stack + THREAD_SIZE) < PAGE_SIZE)) {
+	    (((unsigned long)current->stack - 1 - address < PAGE_SIZE) ||
+	     address - ((unsigned long)current->stack + THREAD_SIZE) < PAGE_SIZE)) {
 		unsigned long stack = __this_cpu_ist_top_va(DF) - sizeof(void *);
 		/*
 		 * We're likely to be running with very little stack space
@@ -732,20 +699,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	}
 #endif
 
-	/*
-	 * 32-bit:
-	 *
-	 *   Valid to do another page fault here, because if this fault
-	 *   had been triggered by is_prefetch fixup_exception would have
-	 *   handled it.
-	 *
-	 * 64-bit:
-	 *
-	 *   Hall of shame of CPU/BIOS bugs.
-	 */
-	if (is_prefetch(regs, error_code, address))
-		return;
-
 	/*
 	 * Buggy firmware could access regions which might page fault, try to
 	 * recover from such faults.
@@ -762,7 +715,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 
 	show_fault_oops(regs, error_code, address);
 
-	if (task_stack_end_corrupted(tsk))
+	if (task_stack_end_corrupted(current))
 		printk(KERN_EMERG "Thread overran stack, or stack corrupted\n");
 
 	sig = SIGKILL;
@@ -775,6 +728,61 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	oops_end(flags, regs, sig);
 }
 
+static noinline void
+no_context(struct pt_regs *regs, unsigned long error_code,
+	   unsigned long address, int signal, int si_code)
+{
+	if (user_mode(regs)) {
+		/*
+		 * This is an implicit supervisor-mode access from user
+		 * mode.  Bypass all the kernel-mode recovery code and just
+		 * OOPS.
+		 */
+		goto oops;
+	}
+
+	/* Are we prepared to handle this kernel fault? */
+	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
+		/*
+		 * Any interrupt that takes a fault gets the fixup. This makes
+		 * the below recursive fault logic only apply to a faults from
+		 * task context.
+		 */
+		if (in_interrupt())
+			return;
+
+		/*
+		 * Per the above we're !in_interrupt(), aka. task context.
+		 *
+		 * In this case we need to make sure we're not recursively
+		 * faulting through the emulate_vsyscall() logic.
+		 */
+		if (current->thread.sig_on_uaccess_err && signal) {
+			sanitize_error_code(address, &error_code);
+
+			set_signal_archinfo(address, error_code);
+
+			/* XXX: hwpoison faults will set the wrong code. */
+			force_sig_fault(signal, si_code, (void __user *)address);
+		}
+
+		/*
+		 * Barring that, we can do the fixup and be happy.
+		 */
+		return;
+	}
+
+	/*
+	 * AMD erratum #91 manifests as a spurious page fault on a PREFETCH
+	 * instruction.
+	 */
+	if (is_prefetch(regs, error_code, address))
+		return;
+
+oops:
+	page_fault_oops(regs, error_code, address);
+}
+
 /*
  * Print out info about fatal segfaults, if the show_unhandled_signals
  * sysctl is set:
-- 
2.29.2


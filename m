Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC0309E72
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhAaUAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:00:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231652AbhAaTyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:54:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C06464E45;
        Sun, 31 Jan 2021 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612113892;
        bh=HepQvI0wvXt/1k1onm6Zz8Ow8kY0AcY6XDUlPSCCaVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kthmt4qbvtS/tpzTn/Of6D4YG6PbKRwP6avoNIfh2vdMX6J5l4MUKSXPNDJNbLbXY
         eIWKHSMragBzpIB+VRSRkioCbz6qTNGpH0cUF1edYgecTvIFbItd5ZdRT44gxpQS3H
         YhkP3t0WHbAelkzx3RFSf+w8Oa2TIU4B47fTcmBjl3zoazQ6Y86EduZtIKVlSLWK/5
         v1xIhAleOUQ6BfpAS/ARRUJIA6uY+DE/NWUr9PFQuoJFNXx9va9nQ+Yej9R3ErtoVP
         UEM05Mul0/4KtfUGr3FBVVG4lF9X2+PpiftvfCdzsllQUm0jOBPPre1UG4kFAU9j9+
         r72YqlkuhsZlQ==
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
Subject: [PATCH 07/11] x86/fault: Split the OOPS code out from no_context()
Date:   Sun, 31 Jan 2021 09:24:38 -0800
Message-Id: <c5f715daf95fc7e94e279f0486908b53e1cdba3c.1612113550.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612113550.git.luto@kernel.org>
References: <cover.1612113550.git.luto@kernel.org>
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
index 1939e546beae..6f43d080e1e8 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -618,53 +618,20 @@ static void set_signal_archinfo(unsigned long address,
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
@@ -672,8 +639,8 @@ no_context(struct pt_regs *regs, unsigned long error_code,
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
@@ -696,20 +663,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
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
@@ -726,7 +679,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 
 	show_fault_oops(regs, error_code, address);
 
-	if (task_stack_end_corrupted(tsk))
+	if (task_stack_end_corrupted(current))
 		printk(KERN_EMERG "Thread overran stack, or stack corrupted\n");
 
 	sig = SIGKILL;
@@ -739,6 +692,61 @@ no_context(struct pt_regs *regs, unsigned long error_code,
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


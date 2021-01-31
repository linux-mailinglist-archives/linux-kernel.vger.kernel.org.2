Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAEF309F70
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 00:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhAaXWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 18:22:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhAaXWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 18:22:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0546B64E2F;
        Sun, 31 Jan 2021 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612113889;
        bh=RSaw1Pdee0Nwnj+x/26+WekJffZOFEp1pVxYigZYU3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TqxTVNvXanFOJJ43RPFcbA4cyjzkYKRFbij3hsSgdZcUcUU+YlR2/LhULFg1PE/QG
         aH5L8z5hhABSjKH8mqyE/M9ddcRDOE8PDdgPQJMp55mzofkG1z43C8B1Vefd4hHpLD
         abMhQFG0KzNM03ek/wSEs2qVSGhyggWOYqw2gmLlk6OfMKDaBVbMyaTnvwiZN41/CH
         gWDfpB82mpx2ONUtr19JgExFA1wAgb0BarhN8oiKiwkMaKoGdTaxic0HsMmis6W0k/
         yRgvyRkMH0x+dgFcb7WQm2Y3BangwSlH74Zji1OoNt/pdw1/ttKdHtgNia8OPIP54n
         6nr7Nf4p+AxGw==
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
Subject: [PATCH 02/11] x86/fault: Fold mm_fault_error() into do_user_addr_fault()
Date:   Sun, 31 Jan 2021 09:24:33 -0800
Message-Id: <c5adc9322511167403edd334ca760466535f582d.1612113550.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612113550.git.luto@kernel.org>
References: <cover.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm_fault_error() is logically just the end of do_user_addr_fault().
Combine the functions.  This makes the code easier to read.

Most of the churn here is from renaming hw_error_code to error_code in
do_user_addr_fault().

This makes no difference at all to the generated code (objdump -dr) as
compared to changing noinline to __always_inline in the definition of
mm_fault_error().

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 97 +++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 52 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 50dfdc71761e..aff35c9ba018 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -944,40 +944,6 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 }
 
-static noinline void
-mm_fault_error(struct pt_regs *regs, unsigned long error_code,
-	       unsigned long address, vm_fault_t fault)
-{
-	if (fatal_signal_pending(current) && !(error_code & X86_PF_USER)) {
-		no_context(regs, error_code, address, 0, 0);
-		return;
-	}
-
-	if (fault & VM_FAULT_OOM) {
-		/* Kernel mode? Handle exceptions or die: */
-		if (!(error_code & X86_PF_USER)) {
-			no_context(regs, error_code, address,
-				   SIGSEGV, SEGV_MAPERR);
-			return;
-		}
-
-		/*
-		 * We ran out of memory, call the OOM killer, and return the
-		 * userspace (which will retry the fault, or kill us if we got
-		 * oom-killed):
-		 */
-		pagefault_out_of_memory();
-	} else {
-		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
-			     VM_FAULT_HWPOISON_LARGE))
-			do_sigbus(regs, error_code, address, fault);
-		else if (fault & VM_FAULT_SIGSEGV)
-			bad_area_nosemaphore(regs, error_code, address);
-		else
-			BUG();
-	}
-}
-
 static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
 {
 	if ((error_code & X86_PF_WRITE) && !pte_write(*pte))
@@ -1215,7 +1181,7 @@ NOKPROBE_SYMBOL(do_kern_addr_fault);
 /* Handle faults in the user portion of the address space */
 static inline
 void do_user_addr_fault(struct pt_regs *regs,
-			unsigned long hw_error_code,
+			unsigned long error_code,
 			unsigned long address)
 {
 	struct vm_area_struct *vma;
@@ -1235,8 +1201,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * Reserved bits are never expected to be set on
 	 * entries in the user portion of the page tables.
 	 */
-	if (unlikely(hw_error_code & X86_PF_RSVD))
-		pgtable_bad(regs, hw_error_code, address);
+	if (unlikely(error_code & X86_PF_RSVD))
+		pgtable_bad(regs, error_code, address);
 
 	/*
 	 * If SMAP is on, check for invalid kernel (supervisor) access to user
@@ -1246,10 +1212,10 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * enforcement appears to be consistent with the USER bit.
 	 */
 	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
-		     !(hw_error_code & X86_PF_USER) &&
+		     !(error_code & X86_PF_USER) &&
 		     !(regs->flags & X86_EFLAGS_AC)))
 	{
-		bad_area_nosemaphore(regs, hw_error_code, address);
+		bad_area_nosemaphore(regs, error_code, address);
 		return;
 	}
 
@@ -1258,7 +1224,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * in a region with pagefaults disabled then we must not take the fault
 	 */
 	if (unlikely(faulthandler_disabled() || !mm)) {
-		bad_area_nosemaphore(regs, hw_error_code, address);
+		bad_area_nosemaphore(regs, error_code, address);
 		return;
 	}
 
@@ -1279,9 +1245,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-	if (hw_error_code & X86_PF_WRITE)
+	if (error_code & X86_PF_WRITE)
 		flags |= FAULT_FLAG_WRITE;
-	if (hw_error_code & X86_PF_INSTR)
+	if (error_code & X86_PF_INSTR)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
 #ifdef CONFIG_X86_64
@@ -1297,7 +1263,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * to consider the PF_PK bit.
 	 */
 	if (is_vsyscall_vaddr(address)) {
-		if (emulate_vsyscall(hw_error_code, regs, address))
+		if (emulate_vsyscall(error_code, regs, address))
 			return;
 	}
 #endif
@@ -1320,7 +1286,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 			 * Fault from code in kernel from
 			 * which we do not expect faults.
 			 */
-			bad_area_nosemaphore(regs, hw_error_code, address);
+			bad_area_nosemaphore(regs, error_code, address);
 			return;
 		}
 retry:
@@ -1336,17 +1302,17 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	vma = find_vma(mm, address);
 	if (unlikely(!vma)) {
-		bad_area(regs, hw_error_code, address);
+		bad_area(regs, error_code, address);
 		return;
 	}
 	if (likely(vma->vm_start <= address))
 		goto good_area;
 	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		bad_area(regs, hw_error_code, address);
+		bad_area(regs, error_code, address);
 		return;
 	}
 	if (unlikely(expand_stack(vma, address))) {
-		bad_area(regs, hw_error_code, address);
+		bad_area(regs, error_code, address);
 		return;
 	}
 
@@ -1355,8 +1321,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * we can handle it..
 	 */
 good_area:
-	if (unlikely(access_error(hw_error_code, vma))) {
-		bad_area_access_error(regs, hw_error_code, address, vma);
+	if (unlikely(access_error(error_code, vma))) {
+		bad_area_access_error(regs, error_code, address, vma);
 		return;
 	}
 
@@ -1378,7 +1344,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
-			no_context(regs, hw_error_code, address, SIGBUS,
+			no_context(regs, error_code, address, SIGBUS,
 				   BUS_ADRERR);
 		return;
 	}
@@ -1395,10 +1361,37 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	mmap_read_unlock(mm);
-	if (unlikely(fault & VM_FAULT_ERROR)) {
-		mm_fault_error(regs, hw_error_code, address, fault);
+	if (likely(!(fault & VM_FAULT_ERROR)))
+		return;
+
+	if (fatal_signal_pending(current) && !(error_code & X86_PF_USER)) {
+		no_context(regs, error_code, address, 0, 0);
 		return;
 	}
+
+	if (fault & VM_FAULT_OOM) {
+		/* Kernel mode? Handle exceptions or die: */
+		if (!(error_code & X86_PF_USER)) {
+			no_context(regs, error_code, address,
+				   SIGSEGV, SEGV_MAPERR);
+			return;
+		}
+
+		/*
+		 * We ran out of memory, call the OOM killer, and return the
+		 * userspace (which will retry the fault, or kill us if we got
+		 * oom-killed):
+		 */
+		pagefault_out_of_memory();
+	} else {
+		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
+			     VM_FAULT_HWPOISON_LARGE))
+			do_sigbus(regs, error_code, address, fault);
+		else if (fault & VM_FAULT_SIGSEGV)
+			bad_area_nosemaphore(regs, error_code, address);
+		else
+			BUG();
+	}
 }
 NOKPROBE_SYMBOL(do_user_addr_fault);
 
-- 
2.29.2


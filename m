Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF65F315D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhBJChx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:37:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235222AbhBJCed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:34:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C74E564E4B;
        Wed, 10 Feb 2021 02:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924430;
        bh=UBckSXAn7+TzIJAdzzJwBWSbnS3mlnXWKrI75P5t2Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVjwL94Y+plaimvdesfGBd1AGZlw+O7k9CV9RwNxcHdWP/fvIScNqFwYYBAihOMuI
         9NzJ7aUulRoCW7jer1LJmcyP5N7UYI3mG0jmVLR+wjGRagM1L1KB9bVwtYVyfAi1nC
         AcEvUDXSBVtJwmjCPrt0a0iTxv6NHSp6s9KaV16LrwUfC+GuxrJPrYZsnOSHzta6ld
         MgqBnWryZNaSuJXJN7a8Pm5MsINZNO7TSTcZnAVUC8NlkIrLcr0rHLjqOuCA9RXmx/
         45VE4i4kL4bKI21Qe718wi9IY3OimA/bxi4bYR5wNNbSg283ixXP5T7Et6u+f6Fa54
         6MraZfQjPiiWw==
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
Subject: [PATCH v2 03/14] x86/fault: Fold mm_fault_error() into do_user_addr_fault()
Date:   Tue,  9 Feb 2021 18:33:35 -0800
Message-Id: <dedc4d9c9b047e51ce38b991bd23971a28af4e7b.1612924255.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612924255.git.luto@kernel.org>
References: <cover.1612924255.git.luto@kernel.org>
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
index 818902b08c52..91cf7a672c04 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -981,40 +981,6 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
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
@@ -1252,7 +1218,7 @@ NOKPROBE_SYMBOL(do_kern_addr_fault);
 /* Handle faults in the user portion of the address space */
 static inline
 void do_user_addr_fault(struct pt_regs *regs,
-			unsigned long hw_error_code,
+			unsigned long error_code,
 			unsigned long address)
 {
 	struct vm_area_struct *vma;
@@ -1272,8 +1238,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * Reserved bits are never expected to be set on
 	 * entries in the user portion of the page tables.
 	 */
-	if (unlikely(hw_error_code & X86_PF_RSVD))
-		pgtable_bad(regs, hw_error_code, address);
+	if (unlikely(error_code & X86_PF_RSVD))
+		pgtable_bad(regs, error_code, address);
 
 	/*
 	 * If SMAP is on, check for invalid kernel (supervisor) access to user
@@ -1283,10 +1249,10 @@ void do_user_addr_fault(struct pt_regs *regs,
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
 
@@ -1295,7 +1261,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * in a region with pagefaults disabled then we must not take the fault
 	 */
 	if (unlikely(faulthandler_disabled() || !mm)) {
-		bad_area_nosemaphore(regs, hw_error_code, address);
+		bad_area_nosemaphore(regs, error_code, address);
 		return;
 	}
 
@@ -1316,9 +1282,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-	if (hw_error_code & X86_PF_WRITE)
+	if (error_code & X86_PF_WRITE)
 		flags |= FAULT_FLAG_WRITE;
-	if (hw_error_code & X86_PF_INSTR)
+	if (error_code & X86_PF_INSTR)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
 #ifdef CONFIG_X86_64
@@ -1334,7 +1300,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * to consider the PF_PK bit.
 	 */
 	if (is_vsyscall_vaddr(address)) {
-		if (emulate_vsyscall(hw_error_code, regs, address))
+		if (emulate_vsyscall(error_code, regs, address))
 			return;
 	}
 #endif
@@ -1357,7 +1323,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 			 * Fault from code in kernel from
 			 * which we do not expect faults.
 			 */
-			bad_area_nosemaphore(regs, hw_error_code, address);
+			bad_area_nosemaphore(regs, error_code, address);
 			return;
 		}
 retry:
@@ -1373,17 +1339,17 @@ void do_user_addr_fault(struct pt_regs *regs,
 
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
 
@@ -1392,8 +1358,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * we can handle it..
 	 */
 good_area:
-	if (unlikely(access_error(hw_error_code, vma))) {
-		bad_area_access_error(regs, hw_error_code, address, vma);
+	if (unlikely(access_error(error_code, vma))) {
+		bad_area_access_error(regs, error_code, address, vma);
 		return;
 	}
 
@@ -1415,7 +1381,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
-			no_context(regs, hw_error_code, address, SIGBUS,
+			no_context(regs, error_code, address, SIGBUS,
 				   BUS_ADRERR);
 		return;
 	}
@@ -1432,11 +1398,38 @@ void do_user_addr_fault(struct pt_regs *regs,
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
+
 	check_v8086_mode(regs, address, tsk);
 }
 NOKPROBE_SYMBOL(do_user_addr_fault);
-- 
2.29.2


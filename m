Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627F242D111
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhJNDie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhJNDi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:38:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3231C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so3782292pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3dIJYpLgUscbVOuuN31HzOtkwTNeYXv+/7s43RJxbb4=;
        b=MEHIXCltdBN/sqAnNWxmIURxKo4D784+6PAqfVD9mOdPz/RtLaV81l2qUrPgxTXqdp
         eoID89Sotx3RkZkjHre7hl/hQn72pvPQkEwMFwuY080h8WOy/a3oufF1v6r8LeYGqq68
         m9pqfqVDIp+kDTbNy1B0uEQABIrYgx0Ih0VD1wDpu7QG0W1rfbiUPaeTC4IoHB1CXTPh
         TrvDU7UZ8sTgCg79ztZIpYcHEgocJUNTVmNJLJEmTNw43h8n2ut+3SCxcKOaJ9XEcHY+
         uotWljNxFGMmgEs9IqwGJvgTr6H/m1ix3KddPuexA8fDxJkA/GJfT+VAiQT6xeKm2IdV
         8ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dIJYpLgUscbVOuuN31HzOtkwTNeYXv+/7s43RJxbb4=;
        b=PP3bqY3vgocyT3LVS8o1TNo3KmSBKXo9ytkSWTVtnX+4Q9sHHJf224MxFRFMW9KBLG
         khtaJComqLJHNb8ugsKHCOY9FMCheyZIXUwZkRAa91C4KCbRJhnOV6H6VfWKFG+VZPro
         D2+6nCCI6jIKdMEpKc6qEGU5za8/G3E6NuUS1fZQ3EhVoJvzk31FVSjE1cTZohle9n+c
         rCbNQm4lmbusjdgWqrL3GNU+5rzyKl+JdibRTwkY3CKNlbaNLlklIgGII2o3m66x4vcL
         JW1qtmVfLDtm2zT6827iykSPfh/Q3hpRFqvbs1AWFIw6aqaGzQVT4NnzF6oYCtW8pgxi
         CzeA==
X-Gm-Message-State: AOAM530RO70MBYQ8Z5SKelJiPFnBweeyfyFvYOJiZMkAdR/7R9ZkRlcg
        NzGBEFw5g7VYGKBt6MX0v2Ig7yY32nU=
X-Google-Smtp-Source: ABdhPJw0A93bey+MjXNL0qdRCeAueR9YU4yF55l44dRWggaEvLxyNbRUK+7oRiUWBGCNzO9nug+Gfg==
X-Received: by 2002:a17:90b:1b0b:: with SMTP id nu11mr3565668pjb.210.1634182583150;
        Wed, 13 Oct 2021 20:36:23 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id p2sm867269pgd.84.2021.10.13.20.36.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:36:22 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH V3 24/49] x86/entry: Implement the whole error_entry() as C code
Date:   Thu, 14 Oct 2021 11:33:47 +0800
Message-Id: <20211014033414.16321-19-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

All the needed facilities are set in entry64.c, the whole error_entry()
can be implemented in C in entry64.c.  The C version generally has better
readability and easier to be updated/improved.

No function change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c     | 63 +++++++++++++++++++++++++++
 arch/x86/entry/entry_64.S    | 82 +-----------------------------------
 arch/x86/include/asm/traps.h |  1 +
 3 files changed, 65 insertions(+), 81 deletions(-)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 173cf621317c..c8ede8b088a6 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -77,3 +77,66 @@ static __always_inline void kernel_entry_swapgs_and_fence(void)
 	native_swapgs();
 	fence_swapgs_kernel_entry();
 }
+
+/*
+ * Put pt_regs onto the task stack and switch GS and CR3 if needed.
+ * The actual stack switch is done in entry_64.S.
+ *
+ * Becareful, it might be in the user CR3 and user GS base at the start
+ * of the function.
+ */
+asmlinkage __visible __entry_text
+struct pt_regs *error_entry(struct pt_regs *eregs)
+{
+	unsigned long iret_ip = (unsigned long)native_irq_return_iret;
+
+	if (user_mode(eregs)) {
+		/*
+		 * We entered from user mode.
+		 * Switch to kernel gsbase and CR3.
+		 */
+		user_entry_swapgs_and_fence();
+		switch_to_kernel_cr3();
+
+		/* Put pt_regs onto the task stack. */
+		return sync_regs(eregs);
+	}
+
+	/*
+	 * There are two places in the kernel that can potentially fault with
+	 * usergs. Handle them here.  B stepping K8s sometimes report a
+	 * truncated RIP for IRET exceptions returning to compat mode. Check
+	 * for these here too.
+	 */
+	if ((eregs->ip == iret_ip) || (eregs->ip == (unsigned int)iret_ip)) {
+		eregs->ip = iret_ip; /* Fix truncated RIP */
+
+		/*
+		 * We came from an IRET to user mode, so we have user
+		 * gsbase and CR3.  Switch to kernel gsbase and CR3:
+		 */
+		user_entry_swapgs_and_fence();
+		switch_to_kernel_cr3();
+
+		/*
+		 * Pretend that the exception came from user mode: set up
+		 * pt_regs as if we faulted immediately after IRET and put
+		 * pt_regs onto the real task stack.
+		 */
+		return sync_regs(fixup_bad_iret(eregs));
+	}
+
+	/*
+	 * Hack: asm_load_gs_index_gs_change can fail with user gsbase.
+	 * If this happens, fix up gsbase and proceed.  We'll fix up the
+	 * exception and land in asm_load_gs_index_gs_change's error
+	 * handler with kernel gsbase.
+	 */
+	if (eregs->ip == (unsigned long)asm_load_gs_index_gs_change)
+		kernel_entry_swapgs_and_fence();
+	else
+		fence_swapgs_kernel_entry();
+
+	/* Enter from kernel, don't move pt_regs */
+	return eregs;
+}
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b97ce4204f6d..23de2a789e3d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -334,7 +334,7 @@ SYM_CODE_END(ret_from_fork)
 	 * XENPV uses its own pvops for iret and load_gs_index().  And it
 	 * doesn't need to switch CR3.  So it can skip invoking error_entry().
 	 */
-	ALTERNATIVE "call error_entry; movq %rax, %rsp", \
+	ALTERNATIVE "movq %rsp, %rdi; call error_entry; movq %rax, %rsp", \
 		"", X86_FEATURE_XENPV
 
 	ENCODE_FRAME_POINTER
@@ -984,86 +984,6 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	jmp		restore_regs_and_return_to_kernel
 SYM_CODE_END(paranoid_exit)
 
-/*
- * Save all registers in pt_regs, and switch GS if needed.
- */
-SYM_CODE_START_LOCAL(error_entry)
-	UNWIND_HINT_FUNC
-	testb	$3, CS+8(%rsp)
-	jz	.Lerror_kernelspace
-
-	/*
-	 * We entered from user mode or we're pretending to have entered
-	 * from user mode due to an IRET fault.
-	 */
-	swapgs
-	FENCE_SWAPGS_USER_ENTRY
-	/* We have user CR3.  Change to kernel CR3. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
-
-	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
-.Lerror_entry_from_usermode_after_swapgs:
-	/* Put us onto the real thread stack. */
-	call	sync_regs
-	ret
-
-	/*
-	 * There are two places in the kernel that can potentially fault with
-	 * usergs. Handle them here.  B stepping K8s sometimes report a
-	 * truncated RIP for IRET exceptions returning to compat mode. Check
-	 * for these here too.
-	 */
-.Lerror_kernelspace:
-	leaq	native_irq_return_iret(%rip), %rcx
-	cmpq	%rcx, RIP+8(%rsp)
-	je	.Lerror_bad_iret
-	movl	%ecx, %eax			/* zero extend */
-	cmpq	%rax, RIP+8(%rsp)
-	je	.Lbstep_iret
-	cmpq	$asm_load_gs_index_gs_change, RIP+8(%rsp)
-	jne	.Lerror_entry_done_lfence
-
-	/*
-	 * hack: .Lgs_change can fail with user gsbase.  If this happens, fix up
-	 * gsbase and proceed.  We'll fix up the exception and land in
-	 * .Lgs_change's error handler with kernel gsbase.
-	 */
-	swapgs
-
-	/*
-	 * The above code has no serializing instruction.  So do an lfence
-	 * to prevent GS speculation, regardless of whether it is kernel
-	 * gsbase or user gsbase.
-	 */
-.Lerror_entry_done_lfence:
-	FENCE_SWAPGS_KERNEL_ENTRY
-	leaq	8(%rsp), %rax			/* return pt_regs pointer */
-	ret
-
-.Lbstep_iret:
-	/* Fix truncated RIP */
-	movq	%rcx, RIP+8(%rsp)
-	/* fall through */
-
-.Lerror_bad_iret:
-	/*
-	 * We came from an IRET to user mode, so we have user
-	 * gsbase and CR3.  Switch to kernel gsbase and CR3:
-	 */
-	swapgs
-	FENCE_SWAPGS_USER_ENTRY
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
-
-	/*
-	 * Pretend that the exception came from user mode: set up pt_regs
-	 * as if we faulted immediately after IRET.
-	 */
-	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
-	call	fixup_bad_iret
-	mov	%rax, %rdi
-	jmp	.Lerror_entry_from_usermode_after_swapgs
-SYM_CODE_END(error_entry)
-
 SYM_CODE_START_LOCAL(error_return)
 	UNWIND_HINT_REGS
 	DEBUG_ENTRY_ASSERT_IRQS_OFF
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 1cdd7e8bcba7..686461ac9803 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -14,6 +14,7 @@
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
 struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs);
+asmlinkage __visible notrace struct pt_regs *error_entry(struct pt_regs *eregs);
 void __init trap_init(void);
 asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
 #endif
-- 
2.19.1.6.gb485710b


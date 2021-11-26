Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6500D45EB6C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376826AbhKZK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhKZK0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:26:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D9DC0613F4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:23 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so9576536pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skz2ky+4WsJNxm6BH7gg8OJQZ9eNxqkUNVw7fsuurVM=;
        b=qtyDZNdLnHQRVi64TsgXpujJ4/ppsnV7w2QEBVwdr7FLCWybH0/HopQ35KrKmVKI9D
         H7KxPXB3LCxcT2KSQdx8kA60OhrYFPV7NroTiZ3fVVycuDSUmdBEjdJa85VRZdgH47hr
         Q8Ku4pPDT5+MW5+hhsb+JteIE14GvVWma0YmFtFTo1mUA+AQ59mV2DLVMNT8ZsuscZ6L
         Q35L0bBRISQJHYfdUBY+bBtnnEeD1i63+KRFLvn6REWdNF/oefT4mjUSTn6ew14BhHLV
         CcagNtFMfmtmdDlKMChOuIWbM5b/x+hJ2kwcy5x4otFnPE+jjyKQg03J5wl0iaMcS8h/
         Qz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skz2ky+4WsJNxm6BH7gg8OJQZ9eNxqkUNVw7fsuurVM=;
        b=TTHzY/BfB4Fy8tRE/nDA1zkq1Ux6tfFJ1IJuTqM4TvvwBHOSal7EF/yB5oavRj4E8m
         nALBNtfh+DnTPgxpHOwepkYUH5knqhRITrcuujGN1Lxuv2n01MThsc8XNtgKQv7OKanJ
         peC3+7fQapHNwPV3o0JsZiOPfDehHHoNSoTfIsPrpGlQrlcDFNK3I+PtJ2tTYBSnTqNT
         zzxFFZiXNjupjlvswqcdgc/y2HA1BNlteuaojQ+k0b/tyhBhj1gpUNUPYfEpATmY7o08
         dDQTDs//LGdOSbrB81uXFi4p1za5iDOl/Y2KoEhH/qnWFBUgo3XihLE9OnHXyBjrEXtd
         NnYA==
X-Gm-Message-State: AOAM531/aPQ7v8KrjnsobcVsYFfykDXkKOGYG9PTrmbWvMBYu+HcyhFV
        71xceOT352nnOkixMApzE8sH7RRUQiM=
X-Google-Smtp-Source: ABdhPJz7cfJGoAP4MtDv9HDnrM62uLiw1ez+AqxJvySrmHThRKvViJvUy+km2GKhpeusTfH/1/zWKA==
X-Received: by 2002:a17:90b:1b03:: with SMTP id nu3mr14524784pjb.47.1637921662301;
        Fri, 26 Nov 2021 02:14:22 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id pc1sm11677415pjb.5.2021.11.26.02.14.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:14:21 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH V6 23/49] x86/entry: Implement the whole error_entry() as C code
Date:   Fri, 26 Nov 2021 18:11:43 +0800
Message-Id: <20211126101209.8613-24-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/entry64.c     | 68 ++++++++++++++++++++++++++++++
 arch/x86/entry/entry_64.S    | 82 +-----------------------------------
 arch/x86/include/asm/traps.h |  1 +
 3 files changed, 70 insertions(+), 81 deletions(-)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 3db503ea0703..0dc63ae8153a 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -68,3 +68,71 @@ static __always_inline void user_entry_swapgs_and_fence(void)
 	native_swapgs();
 	fence_swapgs_user_entry();
 }
+
+/*
+ * Put pt_regs onto the task stack and switch GS and CR3 if needed.
+ * The actual stack switch is done in entry_64.S.
+ *
+ * Be careful, it might be in the user CR3 and user GS base at the start
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
+		native_swapgs();
+
+	/*
+	 * The above code has no serializing instruction.  So do an lfence
+	 * to prevent GS speculation, regardless of whether it is kernel
+	 * gsbase or user gsbase.
+	 */
+	fence_swapgs_kernel_entry();
+
+	/* Enter from kernel, don't move pt_regs */
+	return eregs;
+}
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4d88cd0c46c6..16b2215bdb23 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -333,7 +333,7 @@ SYM_CODE_END(ret_from_fork)
 	 * XENPV uses its own pvops for iret and load_gs_index().  And it
 	 * doesn't need to switch CR3.  So it can skip invoking error_entry().
 	 */
-	ALTERNATIVE "call error_entry; movq %rax, %rsp", \
+	ALTERNATIVE "movq %rsp, %rdi; call error_entry; movq %rax, %rsp", \
 		"", X86_FEATURE_XENPV
 
 	ENCODE_FRAME_POINTER
@@ -982,86 +982,6 @@ SYM_CODE_START_LOCAL(paranoid_exit)
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


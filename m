Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DEB43B43B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbhJZOfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbhJZOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:35:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C063C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:32:59 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 75so14338102pga.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+kKa3emf5DnvAgRp3p/IYmQCfDVw7HP1ShiM4i/fHQ=;
        b=IWSfQAw4H1RgCDGNNyi1lAaW0zcZNu3tIUaKSTtMg6dHphDk1BUhCHBOXB4LQVteA4
         wEETWGkxvZtla+9KplyCTFJdc8sxBtsNmPOzal8lFBZN2ykR4z6JqRlvPs3lQEijRb+v
         IH0qsUbMjTtMDRjfDXrrO+gJFAUvHb/7bWxG4Ph5d31cI6d8DNxz++SoZOIXW3UIcoK/
         mBkOYDCYHzyOINd/+d8oTl9xFqAXwWsEQJOu8zDYTlShEStl48Z4KA8sq/rLOEZE8hpM
         rZ8om/N7opjr2d//rbLMO5bZjlNdRAKQGbs8tmDLVE/pR15B74srOofhOI/XvR7Amq//
         6OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+kKa3emf5DnvAgRp3p/IYmQCfDVw7HP1ShiM4i/fHQ=;
        b=r4S/gfHXYLZAggDVKgP0r6h/K7Q8nrzd0MUV23RyCox81YlEV9jyPPPIWicb60bv1J
         btK0yKPpGSxkJaiV7twmVPuCN8ScjZ1pY7wIP+U5ZYGhddblZtwuBBojiSOVl7UojhzU
         ZZwVjmSAJcYcCGu0SS9HzZxfogzF5gz9RvmQGLiX+pTPFwQ3CKlDn71qdsW7L2urQGee
         IhglW3sPbuhN7igBKk+/KwFxl6WSskSb2EGfPS8kvEjKuJSUAme4btTiywn1XJs+ohHn
         xo69GCxllFSWDc5e7G87Z9nr0D+2O3jrrOkqxvq7FshBgFsgCXhzuD4U00OFZNARLjv+
         GI5w==
X-Gm-Message-State: AOAM533O3BjYAl3CDrUWKc609TZowoBsK4cB9SSJb/3veyq/cwHo2e1I
        9LJ+ACdhDL6L9H1XVptCpyM6AjumgMY=
X-Google-Smtp-Source: ABdhPJyTmFB47saqkcphlcKY208twoVpeBTssgqoTTf726P99t/+5RRiGs85kQVQVrQaTVg846ZLYg==
X-Received: by 2002:a05:6a00:114c:b0:47b:b98b:2210 with SMTP id b12-20020a056a00114c00b0047bb98b2210mr26470459pfm.75.1635258778793;
        Tue, 26 Oct 2021 07:32:58 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id d10sm2194010pgi.40.2021.10.26.07.32.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:32:58 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH V4 24/50] x86/entry: Implement the whole error_entry() as C code
Date:   Tue, 26 Oct 2021 22:32:33 +0800
Message-Id: <20211026143301.18895-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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
index 173cf621317c..a8e59ae41794 100644
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


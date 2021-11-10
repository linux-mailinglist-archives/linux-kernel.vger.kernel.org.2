Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C4D44C086
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhKJMC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhKJMCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:02:47 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18837C0613F5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:00 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id b4so2042991pgh.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWpGCPlZ01egFomhS7f9UJOH1z4zA1TYrEEUBosZaY0=;
        b=TBUDDeu1ymu+0UPd28pzMf5iKv0Ijz4TUcrxUJafaBVe3VOtx4SwMSiAJC/U74PE1m
         DDWx6LNOCMHcs5hs09Vu4xpbuGR8leHmR2/S/dU1Y+tVUeBhhgk1Jr6mrQ7by/7Lkvuk
         2Ox4+eXD+pRFc4GCU4ejlF0g7W5MXvE2lAUsN3ax890997pwy6UnzQ7XGgjKjaTr94ru
         7KN+//8VGqn7vtPLg31FgtuxLWmi+SpqrlFSDlRkqw8BKhtFCtC22bYb69VqMAu/Gac4
         yAjp8uOpEhCq3CmNQj3OS7AMIJUC1xsWmCFAlJnAYOcHoYH1Rlkl2ozVtXeRbL7ZaJ0a
         w3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWpGCPlZ01egFomhS7f9UJOH1z4zA1TYrEEUBosZaY0=;
        b=l32/h5HDA1g22Li479g2JzFFigRM+XqjM5wDHZoBW1unICJfkW/SC8oOcxUhZXtQ3v
         jCVXA/H0tlvcm7jxLttVMERzvy2d2TihcSzfhm6pSgh1g+PqAOLhpaKUKSe4j9bfUcGs
         j3YT3d6XSBQYpouLZZb+PFrAP/apm0d37maqIN7rjvV+SXVBP6ZvMS2iREDg60hrobv0
         Wm7geIxH9FN+6C+6AK66JNl18He/NHvsiRUAQZIl0wHuCHxoUhh2uDCV6yedijRwWyEu
         IkWBpkqu50jbp3V2w5dQg9s0L/C2JplHyROWKw83dquy+X+YYocmEVyJY/TC32hKZAEw
         91tg==
X-Gm-Message-State: AOAM5321g+jIihI6/Yw82d8NEY7u14Z9OgesLuQnIaYxt0QxiIDbAHWh
        0KkyUGNyDOvaTWrgIA4gCbpOxvBxWWc=
X-Google-Smtp-Source: ABdhPJwcU09gCPHYEzYUV1jUv7I+oGyJO1P3yH/Rz9R3AcD++KFVsHOd2+fuOZU9vOUL8ii7ir9Tdg==
X-Received: by 2002:a65:5688:: with SMTP id v8mr11430285pgs.304.1636545599273;
        Wed, 10 Nov 2021 03:59:59 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id f11sm17760137pga.11.2021.11.10.03.59.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:59:58 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH V5 24/50] x86/entry: Implement the whole error_entry() as C code
Date:   Wed, 10 Nov 2021 19:57:10 +0800
Message-Id: <20211110115736.3776-25-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index ebc7419a0367..dac327c56204 100644
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
@@ -985,86 +985,6 @@ SYM_CODE_START_LOCAL(paranoid_exit)
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


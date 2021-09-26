Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F9D4189C2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhIZPMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhIZPMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:12:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D21C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w11so9949314plz.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m51n+JE32X8AmGvsKtqDE3JWPCU8e4/30P20NgZZoMI=;
        b=JFQ3jfqdq+eqA1ihgMRRfdLt6aZO26PcrJpE+fYoB6IX+zG6o1C8+/X9ei/r5KGz6D
         V0waTzmlbPVbhLIt3uAIBeW5MZISaYRH6AvOm/SMVd42+cMyBZ58q5oNoC/HPRyyjlRR
         Zwp9sNayavHxSHwnBfzRhtdA8pdzKNS7aMzpsfUzqZ52Gsu0vEURFQxtrq6sUQWKsvCk
         eFcPaHniVpOTSuE1VDfTHl0qjf/5QX79vp5zcWZNzM/r92cXynCRAxQrheBH/LYqNYzv
         dIeZzh2od90SqBea53e5znQDp9co8u0eOqKOcueJehO2r7Zg6Qwlw0KuhMv4CUEj+2K2
         Y1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m51n+JE32X8AmGvsKtqDE3JWPCU8e4/30P20NgZZoMI=;
        b=njESAxSHhvUVBNYkIi/BUOzKzirK2NNZWNbqrbIfY2fu2GTEAcnTI+4XNBpLaY6Xqp
         Pl5K8ZPVXtLYvOlX0r7p7wUsrHGE5grTYq23GbAz6eEXf9zp1fqyVqir+o3+ao1T62ve
         rUAMerFBcovCFCkO27PCbOxgSoUgQjKkW8wwzvmhOgDz2qOww8JdlHJKWe2w2fZx0yHA
         Uy0hmU41iP8cW/sZQRzbEAF1spWXMc2xVed4QiOUYNafmltnCrHwBrNAUKVM6+5vTRKH
         YGlkPDiztqUf1rY/OT54vJlppfWlsi8rYtDrAwGNQYChHu27CdKVc1Pf6i8swNFZ2Trl
         O1nA==
X-Gm-Message-State: AOAM531LSC2PALXF5VlTcxBk244DCHDeummayRYuegR5PaeGXPefQrRQ
        8Z4Ux5CBTf0MBf6zpIXSh27dmb1PHZ6DsA==
X-Google-Smtp-Source: ABdhPJzZ6YltCO4oVoR5oIyRq2ST4T5KTADFGSRA+pktMmtIHjyqO6pBBb9PWSmLIzVUcy1PmlQfgg==
X-Received: by 2002:a17:902:6e0f:b0:13c:9d43:7d7a with SMTP id u15-20020a1709026e0f00b0013c9d437d7amr18268521plk.62.1632669027898;
        Sun, 26 Sep 2021 08:10:27 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id w7sm773313pfj.189.2021.09.26.08.10.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:10:27 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Youquan Song <youquan.song@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH V2 16/41] x86/entry: Implement the whole error_entry() as C code
Date:   Sun, 26 Sep 2021 23:08:13 +0800
Message-Id: <20210926150838.197719-17-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

All the needed facilities are set in entry64.c, the whole error_entry()
can be implemented in C in entry64.c.  The C version generally has better
readability and easier to be updated/improved.

No function change intended. Only a check for X86_FEATURE_XENPV is added
because the new error_entry() does not use the pv SWAPGS, rather it uses
native_swapgs().  And for XENPV, error_entry() has nothing to do, so it
can return directly.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c     | 76 ++++++++++++++++++++++++++++++++++
 arch/x86/entry/entry_64.S    | 80 +-----------------------------------
 arch/x86/include/asm/traps.h |  1 +
 3 files changed, 78 insertions(+), 79 deletions(-)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index dafae60d31f9..5f2be4c3f333 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -56,3 +56,78 @@ static __always_inline void kernel_entry_fence_no_swapgs(void)
 {
 	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_KERNEL);
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
+	asm volatile ("cld");
+
+	/*
+	 * When XENPV, it is already in the task stack, and it can't fault
+	 * from native_irq_return_iret and asm_load_gs_index_gs_change()
+	 * since XENPV uses its own pvops for iret and load_gs_index, and
+	 * also it doesn't use PTI.  So it can directly return and
+	 * native_swapgs() can be used in the following code.
+	 */
+	if (static_cpu_has(X86_FEATURE_XENPV))
+		return eregs;
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
+		user_entry_swapgs_and_fence();
+	else
+		kernel_entry_fence_no_swapgs();
+
+	/* Enter from kernel, don't move pt_regs */
+	return eregs;
+}
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 757e7155670e..169ee14cc2d6 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -325,6 +325,7 @@ SYM_CODE_END(ret_from_fork)
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
+	movq	%rsp, %rdi
 	call	error_entry
 	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
 	ENCODE_FRAME_POINTER
@@ -964,85 +965,6 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	jmp		restore_regs_and_return_to_kernel
 SYM_CODE_END(paranoid_exit)
 
-/*
- * Save all registers in pt_regs, and switch GS if needed.
- */
-SYM_CODE_START_LOCAL(error_entry)
-	UNWIND_HINT_FUNC
-	cld
-	testb	$3, CS+8(%rsp)
-	jz	.Lerror_kernelspace
-
-	/*
-	 * We entered from user mode or we're pretending to have entered
-	 * from user mode due to an IRET fault.
-	 */
-	SWAPGS
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
-.Lerror_entry_done_lfence:
-	FENCE_SWAPGS_KERNEL_ENTRY
-.Lerror_entry_done:
-	leaq	8(%rsp), %rax			/* return pt_regs pointer */
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
-	SWAPGS
-	FENCE_SWAPGS_USER_ENTRY
-	jmp .Lerror_entry_done
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
-	SWAPGS
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


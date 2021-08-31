Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72A3FCC97
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbhHaRwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbhHaRwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:52:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69BEC061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q21so11114780plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zO24lvmubAmQxxAiplYA7Xg8Aixu0f/Y2EDPOoZ/Cvk=;
        b=cqzd2VOsD7OwMg+JmpQ6ccJyCpFqZ2EtWbgJL4GI4XudfNeWkkwi0Qr+heNZ+3HAgV
         2bTz9AxYjGKfR+jVHyE1p1FZfditTg2IXByapgIITqDnnpcF9EoTLjWLp3mav9IJ8D9Z
         UKoW/y+LvrzUPX1YY0vjaiBrxeI8xVaJjZAngw/vUizxBW+q3edCHfhiTAUTOdI5NKbt
         +1e8OAVRqzp6I0uj1szXiQMkqUpFnFmnImeJ95ZNVBzvLJMqFLmy0U0q5DNjzpG+Chhy
         meHB1bUB/rE8Pa+89lkIgObXJuOyt1XfJEA+jUZoPae3f45YWjGLECYWqFQlUqT258XO
         VRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zO24lvmubAmQxxAiplYA7Xg8Aixu0f/Y2EDPOoZ/Cvk=;
        b=lIABSNYXqpmoEAlhs95GGHPQGQ+m1MdTTywvtdPiGWdIC33A8aVNAS4eYnOhZx2Jk8
         V1bUd0ia0guuAVPFxmTXgvzke8FqaYlOTaXJ1OfwTUOZ/l8qQEGSfx2pI468QTV4rXhk
         l5QGnOoyHkcGYZoHntu/j4RFT606/qyLCzGYGIniion7yq7KgyYIAL2yOzrFckc+G4ut
         4HRwaxdCETJbvF/6TyT3RcN/9gAnH0PutnDX3jhzxsBPvtlwvSnbZFaCKp2De5A/Kv9+
         9JradonZQv/1UE6Pn0pCuysiTSDBQmqKOF2EQYWjZ8Yb+TWRTsw5WBPVk5HZ0ag02OXN
         OGIQ==
X-Gm-Message-State: AOAM532/557Z/eg7LgPG6toXK5JJ6bN0+c667DTunJjtQLbgtxLNIIFO
        DumqpOruHSTPbJM/h9QP0/QkIxfD8T8=
X-Google-Smtp-Source: ABdhPJxmwuXo7KwYV3Zi4ODRbbzHDsSEC1gLbaFGR86ztmxaA/XJMll1vdgr0tgqhNhYHq9D+FwAjA==
X-Received: by 2002:a17:902:e550:b0:137:734f:1d84 with SMTP id n16-20020a170902e55000b00137734f1d84mr5743721plf.27.1630432298178;
        Tue, 31 Aug 2021 10:51:38 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id u7sm3413838pju.13.2021.08.31.10.51.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:51:37 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 11/24] x86/entry: Replace the most of asm code of error_entry to C code
Date:   Wed,  1 Sep 2021 01:50:12 +0800
Message-Id: <20210831175025.27570-12-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

All the needed facilities are set in traps.c, the major body of
error_entry() can be implemented in C in traps.c.  The C version
generally has better readibility and easier to be updated/improved.

No function change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S    | 71 +--------------------------------
 arch/x86/entry/traps.c       | 76 ++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/traps.h |  1 +
 3 files changed, 78 insertions(+), 70 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 42d2918f5646..bc9e2f5ad370 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -972,83 +972,14 @@ SYM_CODE_START_LOCAL(error_entry)
 	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
-	testb	$3, CS+8(%rsp)
-	jz	.Lerror_kernelspace
 
-	/*
-	 * We entered from user mode or we're pretending to have entered
-	 * from user mode due to an IRET fault.
-	 */
-	SWAPGS
-	FENCE_SWAPGS_USER_ENTRY
-	/* We have user CR3.  Change to kernel CR3. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
-
-.Lerror_entry_from_usermode_after_swapgs:
-	/* Put us onto the real thread stack. */
 	popq	%r12				/* save return addr in %12 */
 	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
-	call	sync_regs
+	call	do_error_entry
 	movq	%rax, %rsp			/* switch stack */
 	ENCODE_FRAME_POINTER
 	pushq	%r12
 	ret
-
-.Lerror_entry_done_lfence:
-	FENCE_SWAPGS_KERNEL_ENTRY
-.Lerror_entry_done:
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
-	popq	%r12				/* save return addr in %12 */
-	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
-	call	fixup_bad_iret
-	mov	%rax, %rsp
-	ENCODE_FRAME_POINTER
-	pushq	%r12
-	jmp	.Lerror_entry_from_usermode_after_swapgs
 SYM_CODE_END(error_entry)
 
 SYM_CODE_START_LOCAL(error_return)
diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index c718663e57ef..b8fdf6a9682f 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -804,6 +804,82 @@ static __always_inline void fence_swapgs_kernel_entry(void)
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
+struct pt_regs *do_error_entry(struct pt_regs *eregs)
+{
+	unsigned long iret_ip = (unsigned long)native_irq_return_iret;
+
+	/*
+	 * When XENPV, it is already in the task stack, and it can't fault
+	 * from native_irq_return_iret and asm_load_gs_index_gs_change()
+	 * since XENPV uses its own pvops for iret and load_gs_index.
+	 * So it can directly return.
+	 */
+	if (static_cpu_has(X86_FEATURE_XENPV))
+		return eregs;
+
+	if (user_mode(eregs)) {
+		/*
+		 * We entered from user mode.
+		 * Switch to kernel gsbase and CR3.
+		 */
+		native_swapgs();
+		fence_swapgs_user_entry();
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
+		native_swapgs();
+		fence_swapgs_user_entry();
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
+	if (eregs->ip == (unsigned long)asm_load_gs_index_gs_change) {
+		native_swapgs();
+		fence_swapgs_user_entry();
+	} else {
+		fence_swapgs_kernel_entry();
+	}
+
+	/* Enter from kernel, don't move pt_regs */
+	return eregs;
+}
 #endif
 
 static bool is_sysenter_singlestep(struct pt_regs *regs)
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index e9e3801391d5..7b51a8081ae4 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -14,6 +14,7 @@
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
 struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs);
+asmlinkage __visible notrace struct pt_regs *do_error_entry(struct pt_regs *eregs);
 void __init trap_init(void);
 asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
 #endif
-- 
2.19.1.6.gb485710b


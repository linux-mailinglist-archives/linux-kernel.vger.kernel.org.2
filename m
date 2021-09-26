Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771234189E5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhIZPPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbhIZPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:14:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64528C06177A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:13:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v19so10560471pjh.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJi1JQbaK9SO3nicMv24xZhpKb6ZtwPZpPX202BdRjg=;
        b=MFthCKmfoA7I1Kx0O9kIgdw8fyPCpwQodmcZ/P6Rbo8G54QKUWJpZ7EPqiyKIVkoEA
         OSeQH8+y3as58XQTSnOfQvroLc4K9ymyi3fTgoO1t7qKsb2yBrq+Ng67tJwXjOG2ungK
         Q+49m7wTYD5lGEnPQCjWhP1b0f5vgQvj4fAe0Ck6G9ZpKV45f/7qPp+04DB6t6HtQ5Sv
         /hobZKeOyNytpWD1PrBg2p3dZVZLouH01NwCuoPeCEST365YfRwTIymxXal+cpM1ow0n
         KWgBUjN8Gg74jG9DuAMWpqE6maEzYFbhAZ8ZIGH9bP5DIIbuk5f7iqEuVvSE83Q42Nsq
         pPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJi1JQbaK9SO3nicMv24xZhpKb6ZtwPZpPX202BdRjg=;
        b=qIbLoMyOH9dmJMKd4CsUQEN4lE35xuyowr5Ye44WkIW//AIQ2JhxMWlGFjNDNd3WMU
         k+Yi3HERt2XWyJd/0jicXr5l8obwmPwcfHN9IdJ9iyAJr471ol6zuhLoFd5B88FE4BzY
         6oys9ZkudUCBhIY507G7WgwMZXHpSc2+0RSdyjTc4mh6VEeDFFC5w3H7ZdLE3XA3Guvh
         UwWqoNeZ6NlGR3HGfJg1XyM+GFhKak1VGQiLSnZZ0uyvoLv+SY2zoKZI/q4XB9u9Wkru
         QjkFmGrscCV9Tbr2eKC7771riVKfahR6kE5L0cXdhqNaP5OARgiwz35TML6h3dhodA0q
         ZOTg==
X-Gm-Message-State: AOAM531MO5mVUjtpw5vmE63Te4PdwctRUhE0VNay6pZdtssGPBGGmCRP
        dJgiCcrBTLNLmeBB3z76S/8ctEVF0X/AfA==
X-Google-Smtp-Source: ABdhPJyL/EQhQwvjguttGbxArK5XOFG6XCbw0/AmACuqzfJOdZZZrG06HQw45936eYCPCLwNQKNV/g==
X-Received: by 2002:a17:90a:7602:: with SMTP id s2mr7161393pjk.197.1632669200619;
        Sun, 26 Sep 2021 08:13:20 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id a26sm15992796pgm.87.2021.09.26.08.13.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:13:20 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 41/41] x86/syscall/64: Move the checking for sysret to C code
Date:   Sun, 26 Sep 2021 23:08:38 +0800
Message-Id: <20210926150838.197719-42-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Like do_fast_syscall_32() which checks whether it can return to userspace
via fast instructions before the function returns, do_syscall_64()
also checks whether it can use sysret to return to userspace before
do_syscall_64() returns via C code.  And a bunch of ASM code can be
removed.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/calling.h       | 10 +----
 arch/x86/entry/common.c        | 73 ++++++++++++++++++++++++++++++-
 arch/x86/entry/entry_64.S      | 78 ++--------------------------------
 arch/x86/include/asm/syscall.h |  2 +-
 4 files changed, 78 insertions(+), 85 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 6f9de1c6da73..05da3ef48ee4 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -109,27 +109,19 @@ For 32-bit we have the following conventions - kernel is built with
 	CLEAR_REGS
 .endm
 
-.macro POP_REGS pop_rdi=1 skip_r11rcx=0
+.macro POP_REGS pop_rdi=1
 	popq %r15
 	popq %r14
 	popq %r13
 	popq %r12
 	popq %rbp
 	popq %rbx
-	.if \skip_r11rcx
-	popq %rsi
-	.else
 	popq %r11
-	.endif
 	popq %r10
 	popq %r9
 	popq %r8
 	popq %rax
-	.if \skip_r11rcx
-	popq %rsi
-	.else
 	popq %rcx
-	.endif
 	popq %rdx
 	popq %rsi
 	.if \pop_rdi
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b33..718045b7a53c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -70,7 +70,77 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
 	return false;
 }
 
-__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
+/*
+ * Change top bits to match the most significant bit (47th or 56th bit
+ * depending on paging mode) in the address to get canonical address.
+ *
+ * If width of "canonical tail" ever becomes variable, this will need
+ * to be updated to remain correct on both old and new CPUs.
+ */
+static __always_inline u64 canonical_address(u64 vaddr)
+{
+	if (IS_ENABLED(CONFIG_X86_5LEVEL) && static_cpu_has(X86_FEATURE_LA57))
+		return ((s64)vaddr << (64 - 57)) >> (64 - 57);
+	else
+		return ((s64)vaddr << (64 - 48)) >> (64 - 48);
+}
+
+/*
+ * Check if it can use SYSRET.
+ *
+ * Try to use SYSRET instead of IRET if we're returning to
+ * a completely clean 64-bit userspace context.
+ *
+ * Returns 0 to return using IRET or 1 to return using SYSRET.
+ */
+static __always_inline int can_sysret(struct pt_regs *regs)
+{
+	/* In the Xen PV case we must use iret anyway. */
+	if (static_cpu_has(X86_FEATURE_XENPV))
+		return 0;
+
+	/* SYSRET requires RCX == RIP && R11 == RFLAGS */
+	if (regs->ip != regs->cx || regs->flags != regs->r11)
+		return 0;
+
+	/* CS and SS must match SYSRET */
+	if (regs->cs != __USER_CS || regs->ss != __USER_DS)
+		return 0;
+
+	/*
+	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
+	 * in kernel space.  This essentially lets the user take over
+	 * the kernel, since userspace controls RSP.
+	 */
+	if (regs->cx != canonical_address(regs->cx))
+		return 0;
+
+	/*
+	 * SYSCALL clears RF when it saves RFLAGS in R11 and SYSRET cannot
+	 * restore RF properly. If the slowpath sets it for whatever reason, we
+	 * need to restore it correctly.
+	 *
+	 * SYSRET can restore TF, but unlike IRET, restoring TF results in a
+	 * trap from userspace immediately after SYSRET.  This would cause an
+	 * infinite loop whenever #DB happens with register state that satisfies
+	 * the opportunistic SYSRET conditions.  For example, single-stepping
+	 * this user code:
+	 *
+	 *           movq	$stuck_here, %rcx
+	 *           pushfq
+	 *           popq %r11
+	 *   stuck_here:
+	 *
+	 * would never get past 'stuck_here'.
+	 */
+	if (regs->r11 & (X86_EFLAGS_RF | X86_EFLAGS_TF))
+		return 0;
+
+	return 1;
+}
+
+/* Returns 0 to return using IRET or 1 to return using SYSRET. */
+__visible noinstr int do_syscall_64(struct pt_regs *regs, int nr)
 {
 	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
@@ -84,6 +154,7 @@ __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
 
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
+	return can_sysret(regs);
 }
 #endif
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 260be3c9da7d..777fbf7c3939 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -112,85 +112,15 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	movslq	%eax, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
-	/*
-	 * Try to use SYSRET instead of IRET if we're returning to
-	 * a completely clean 64-bit userspace context.  If we're not,
-	 * go to the slow exit path.
-	 * In the Xen PV case we must use iret anyway.
-	 */
-
-	ALTERNATIVE "", "jmp	swapgs_restore_regs_and_return_to_usermode", \
-		X86_FEATURE_XENPV
-
-	movq	RCX(%rsp), %rcx
-	movq	RIP(%rsp), %r11
-
-	cmpq	%rcx, %r11	/* SYSRET requires RCX == RIP */
-	jne	swapgs_restore_regs_and_return_to_usermode
+	testl	%eax, %eax
+	jz swapgs_restore_regs_and_return_to_usermode
 
 	/*
-	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
-	 * in kernel space.  This essentially lets the user take over
-	 * the kernel, since userspace controls RSP.
-	 *
-	 * If width of "canonical tail" ever becomes variable, this will need
-	 * to be updated to remain correct on both old and new CPUs.
-	 *
-	 * Change top bits to match most significant bit (47th or 56th bit
-	 * depending on paging mode) in the address.
-	 */
-#ifdef CONFIG_X86_5LEVEL
-	ALTERNATIVE "shl $(64 - 48), %rcx; sar $(64 - 48), %rcx", \
-		"shl $(64 - 57), %rcx; sar $(64 - 57), %rcx", X86_FEATURE_LA57
-#else
-	shl	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
-	sar	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
-#endif
-
-	/* If this changed %rcx, it was not canonical */
-	cmpq	%rcx, %r11
-	jne	swapgs_restore_regs_and_return_to_usermode
-
-	cmpq	$__USER_CS, CS(%rsp)		/* CS must match SYSRET */
-	jne	swapgs_restore_regs_and_return_to_usermode
-
-	movq	R11(%rsp), %r11
-	cmpq	%r11, EFLAGS(%rsp)		/* R11 == RFLAGS */
-	jne	swapgs_restore_regs_and_return_to_usermode
-
-	/*
-	 * SYSCALL clears RF when it saves RFLAGS in R11 and SYSRET cannot
-	 * restore RF properly. If the slowpath sets it for whatever reason, we
-	 * need to restore it correctly.
-	 *
-	 * SYSRET can restore TF, but unlike IRET, restoring TF results in a
-	 * trap from userspace immediately after SYSRET.  This would cause an
-	 * infinite loop whenever #DB happens with register state that satisfies
-	 * the opportunistic SYSRET conditions.  For example, single-stepping
-	 * this user code:
-	 *
-	 *           movq	$stuck_here, %rcx
-	 *           pushfq
-	 *           popq %r11
-	 *   stuck_here:
-	 *
-	 * would never get past 'stuck_here'.
-	 */
-	testq	$(X86_EFLAGS_RF|X86_EFLAGS_TF), %r11
-	jnz	swapgs_restore_regs_and_return_to_usermode
-
-	/* nothing to check for RSP */
-
-	cmpq	$__USER_DS, SS(%rsp)		/* SS must match SYSRET */
-	jne	swapgs_restore_regs_and_return_to_usermode
-
-	/*
-	 * We win! This label is here just for ease of understanding
+	 * This label is here just for ease of understanding
 	 * perf profiles. Nothing jumps here.
 	 */
 syscall_return_via_sysret:
-	/* rcx and r11 are already restored (see code above) */
-	POP_REGS pop_rdi=0 skip_r11rcx=1
+	POP_REGS pop_rdi=0
 
 	/*
 	 * Now all regs are restored except RSP and RDI.
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index f7e2d82d24fb..477adea7bac0 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -159,7 +159,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 		? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
 }
 
-void do_syscall_64(struct pt_regs *regs, int nr);
+int do_syscall_64(struct pt_regs *regs, int nr);
 void do_int80_syscall_32(struct pt_regs *regs);
 long do_fast_syscall_32(struct pt_regs *regs);
 
-- 
2.19.1.6.gb485710b


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC2A3FCC9F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbhHaRxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbhHaRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:53:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8398C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fz10so101160pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nx8SGw3Bxz59kcEk9XONofm77DPwctaE1atb14dECHI=;
        b=W+o5jiMivwg+U5Bsw8L4Qy1x5Xk6rVxWxGirH4J6acXFB5rtMivyeQz+ze83UuswnW
         ck8b7WoKbbsajtQyfNviJCwJyu9sGLbYlKH41J8L2xLhdQkwg7Gw/viQZaJyZNvdzwsR
         Ki5L0eJG8nXIQC2L9tqqKNOfg6nhxRw6DElK77iruvIGkBq+y6EJTmSrrMofSUU3L8zJ
         elrnV4QnCMFFLFfjzcvYT8alNHKWFH0izGQG/TYn2Qvl83MydwGIJePw5hkMGdc4wdKn
         ASIpYQqa9HfZ391FzeLmUki0tznZfcHQa6u3uFY7Qu7LSx97ukqnQGGbuOY/2qS0rDBj
         8doQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nx8SGw3Bxz59kcEk9XONofm77DPwctaE1atb14dECHI=;
        b=oOpdqIx75dHGV1JhySq4KbB5oJgf09PYnLkLuu9rp6TXvHH/U93fVfLHGmgIEAT9i3
         e/yyDGib97OG6cH9aChFpJKE4yhaFrPEyNuiODoa3oa0TEN6JlJ8yQ2DxhdZ7CbS1r19
         HxGWvAYnhounxgTlzTMLBP6cT/ulI34rfDOuMXR4LVSmuxQm+8qb0AD0aEcRGjpUbOt4
         I+eyCZMKyyL59vxxuzGzTEkLidg60iY0UROAn88yfnK8cFKOFqsuyd16svil0E6oIy8k
         JQLcyHCAOJwbZ+vDwnT9nHBitDkHH41warnrTnmnjwVaF1zv7Lw6wPPigEEz7V16l4TE
         8XyQ==
X-Gm-Message-State: AOAM5324IORkGiC2Wx3mFK+zuOtinGbxZXxdmS49JnXo6N1xdvxR8rgR
        749LYWuRtylHb39Vzyu0oQ1nOvgxnJc=
X-Google-Smtp-Source: ABdhPJyASylpbUxJOW37bQnlFSh1YGj188jt7Dmnb8nrHvCJYeajX+jIRk8e2ovU9DsxHAvS9Q9RDw==
X-Received: by 2002:a17:902:ba90:b0:135:6709:705 with SMTP id k16-20020a170902ba9000b0013567090705mr5647069pls.79.1630432337952;
        Tue, 31 Aug 2021 10:52:17 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id gg22sm3440339pjb.19.2021.08.31.10.52.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:52:17 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 17/24] x86/entry: Introduce struct ist_regs
Date:   Wed,  1 Sep 2021 01:50:18 +0800
Message-Id: <20210831175025.27570-18-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

struct ist_regs is the upmost stack frame for IST interrupt, it
consists of struct pt_regs and other fields which will be added in
later patch.

Make vc_switch_off_ist() take ist_regs as its argument and it will switch
the whole ist_regs if needed.

Make the frame before calling paranoid_entry() and paranoid_exit() be
struct ist_regs.

This patch is prepared for converting paranoid_entry() and paranoid_exit()
into C code which will need the additinal fields to store the results in
paranoid_entry() and to use them in paranoid_exit().

The C interrupt handlers don't use struct ist_regs due to they don't need
the additional fields in the struct ist_regs, and they still use pt_regs.

No functional change intended and IST_pt_reg is still 0.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S        | 37 ++++++++++++++++++--------------
 arch/x86/entry/traps.c           | 16 +++++++-------
 arch/x86/include/asm/traps.h     | 10 ++++++++-
 arch/x86/kernel/asm-offsets_64.c |  2 ++
 4 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e968074046c3..1ae10ca351f4 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -431,13 +431,14 @@ SYM_CODE_START(\asmsym)
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
 
-	UNWIND_HINT_REGS
+	UNWIND_HINT_REGS offset=IST_pt_regs
 
-	movq	%rsp, %rdi		/* pt_regs pointer */
+	leaq	IST_pt_regs(%rsp), %rdi	/* pt_regs pointer */
 
 	call	\cfunc
 
 	call	paranoid_exit
+	addq	$IST_pt_regs, %rsp	/* put %rsp back to pt_regs */
 	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack and use the noist entry point */
@@ -488,7 +489,7 @@ SYM_CODE_START(\asmsym)
 	 */
 	call	paranoid_entry
 
-	UNWIND_HINT_REGS
+	UNWIND_HINT_REGS offset=IST_pt_regs
 
 	/*
 	 * Switch off the IST stack to make it free for nested exceptions. The
@@ -496,17 +497,17 @@ SYM_CODE_START(\asmsym)
 	 * stack if it is safe to do so. If not it switches to the VC fall-back
 	 * stack.
 	 */
-	movq	%rsp, %rdi		/* pt_regs pointer */
+	movq	%rsp, %rdi		/* ist_regs pointer */
 	call	vc_switch_off_ist
 	movq	%rax, %rsp		/* Switch to new stack */
 
-	UNWIND_HINT_REGS
+	UNWIND_HINT_REGS offset=IST_pt_regs
 
-	/* Update pt_regs */
-	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
-	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
+	leaq	IST_pt_regs(%rsp), %rdi	/* pt_regs pointer */
 
-	movq	%rsp, %rdi		/* pt_regs pointer */
+	/* Update pt_regs */
+	movq	ORIG_RAX(%rdi), %rsi	/* get error code into 2nd argument*/
+	movq	$-1, ORIG_RAX(%rdi)	/* no syscall to restart */
 
 	call	kernel_\cfunc
 
@@ -516,6 +517,7 @@ SYM_CODE_START(\asmsym)
 	 * so it is definitely mapped even with PTI enabled.
 	 */
 	call	paranoid_exit
+	addq	$IST_pt_regs, %rsp	/* put %rsp back to pt_regs */
 	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack */
@@ -539,14 +541,15 @@ SYM_CODE_START(\asmsym)
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
-	UNWIND_HINT_REGS
+	UNWIND_HINT_REGS offset=IST_pt_regs
 
-	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
-	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
-	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
+	leaq	IST_pt_regs(%rsp), %rdi	/* pt_regs pointer into first argument */
+	movq	ORIG_RAX(%rdi), %rsi	/* get error code into 2nd argument*/
+	movq	$-1, ORIG_RAX(%rdi)	/* no syscall to restart */
 	call	\cfunc
 
 	call	paranoid_exit
+	addq	$IST_pt_regs, %rsp	/* put %rsp back to pt_regs */
 	jmp	restore_regs_and_return_to_kernel
 
 _ASM_NOKPROBE(\asmsym)
@@ -852,8 +855,9 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	PUSH_AND_CLEAR_REGS skip_rdi=1
 	movq	RDI(%rsp), %rsi	/* temporarily store the return address in %rsi */
 	movq	%rdi, RDI(%rsp) /* put %rdi onto pt_regs */
+	subq	$IST_pt_regs, %rsp /* reserve room for ist_regs */
 	pushq	%rsi		/* put the return address onto the stack */
-	ENCODE_FRAME_POINTER 8
+	ENCODE_FRAME_POINTER 8+IST_pt_regs
 
 	/*
 	 * Always stash CR3 in %r14.  This value will be restored,
@@ -1294,9 +1298,9 @@ end_repeat_nmi:
 	 * Use paranoid_entry to handle SWAPGS and CR3.
 	 */
 	call	paranoid_entry
-	UNWIND_HINT_REGS
+	UNWIND_HINT_REGS offset=IST_pt_regs
 
-	movq	%rsp, %rdi
+	leaq	IST_pt_regs(%rsp), %rdi		/* pt_regs pointer */
 	movq	$-1, %rsi
 	call	exc_nmi
 
@@ -1305,6 +1309,7 @@ end_repeat_nmi:
 	 * restore_regs_and_return_to_kernel as we must handle nested NMI.
 	 */
 	call	paranoid_exit
+	addq	$IST_pt_regs, %rsp		/* put %rsp back to pt_regs */
 
 	POP_REGS
 
diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index 40722a2f61ae..da55565d43ef 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -693,17 +693,17 @@ struct pt_regs *sync_regs(struct pt_regs *eregs)
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *regs)
+asmlinkage __visible noinstr struct ist_regs *vc_switch_off_ist(struct ist_regs *ist)
 {
 	unsigned long sp, *stack;
 	struct stack_info info;
-	struct pt_regs *regs_ret;
+	struct ist_regs *ist_ret;
 
 	/*
 	 * In the SYSCALL entry path the RSP value comes from user-space - don't
 	 * trust it and switch to the current kernel stack
 	 */
-	if (ip_within_syscall_gap(regs)) {
+	if (ip_within_syscall_gap(&ist->regs)) {
 		sp = this_cpu_read(cpu_current_top_of_stack);
 		goto sync;
 	}
@@ -713,7 +713,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 	 * happened from a safe stack. Not safe are the entry or unknown stacks,
 	 * use the fall-back stack instead in this case.
 	 */
-	sp    = regs->sp;
+	sp    = ist->regs.sp;
 	stack = (unsigned long *)sp;
 
 	if (!get_stack_info_noinstr(stack, current, &info) || info.type == STACK_TYPE_ENTRY ||
@@ -726,12 +726,12 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 	 * IST stack. The code below only copies pt_regs, the real switch happens
 	 * in assembly code.
 	 */
-	sp = ALIGN_DOWN(sp, 8) - sizeof(*regs_ret);
+	sp = ALIGN_DOWN(sp, 8) - sizeof(*ist_ret);
 
-	regs_ret = (struct pt_regs *)sp;
-	*regs_ret = *regs;
+	ist_ret = (struct ist_regs *)sp;
+	*ist_ret = *ist;
 
-	return regs_ret;
+	return ist_ret;
 }
 #endif
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 5c41a279c1e0..e24c63bbc30a 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -11,9 +11,17 @@
 #include <asm/trap_pf.h>
 
 #ifdef CONFIG_X86_64
+struct ist_regs {
+	/*
+	 * ist specific fields must be defined before pt_regs
+	 * and they are located below pt_regs on the stacks.
+	 */
+	struct pt_regs regs;
+};
+
 asmlinkage __visible notrace struct pt_regs *do_error_entry(struct pt_regs *eregs);
 void __init trap_init(void);
-asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
+asmlinkage __visible noinstr struct ist_regs *vc_switch_off_ist(struct ist_regs *ist);
 #endif
 
 #ifdef CONFIG_X86_F00F_BUG
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index b14533af7676..3cffadf64ac2 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -4,6 +4,7 @@
 #endif
 
 #include <asm/ia32.h>
+#include <asm/traps.h>
 
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_PARAVIRT_SPINLOCKS)
 #include <asm/kvm_para.h>
@@ -55,6 +56,7 @@ int main(void)
 #undef ENTRY
 
 	BLANK();
+	DEFINE(IST_pt_regs, offsetof(struct ist_regs, regs));
 
 #ifdef CONFIG_STACKPROTECTOR
 	DEFINE(stack_canary_offset, offsetof(struct fixed_percpu_data, stack_canary));
-- 
2.19.1.6.gb485710b


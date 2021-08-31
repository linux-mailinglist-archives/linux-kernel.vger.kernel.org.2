Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8193FCCA5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbhHaRxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbhHaRxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:53:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255D8C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e7so17544613pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A1W/lbk/P5E4KNiUo5KnoRZgcx0Zc7o60x5E/YMFVvA=;
        b=HWedbFBMjHXSH0jT0HSed4v3MkU0KvnOtDRQQtfxZZq/wIPiaGiMGK7qImrzJ2raon
         YkDkotOUmzDXOPF2a8qxLUkQ66E3fXepHMOdv2Pl6iBUWOF2mBw+LknrHv1fMcWmnpIx
         28h0S3NdmAAiD31WRWhSZ01x/L8DpUA8YU1YBh14a2SvAsH0LLiAMAUVDvFwjqE9evcv
         tCHLjaPcde/qyezMRJC5RVkJOEV0PWJ631eRiyH8An3wGqVw5STbTM3S5ryi+WDj5FWU
         EG0Zv9FCWujjYNmPsBIQ0UaCx7GjrMjnFclsUkX/N87HCfgqUqL15V9sW74EhWooYfZY
         gg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1W/lbk/P5E4KNiUo5KnoRZgcx0Zc7o60x5E/YMFVvA=;
        b=kPJfwBxmlTZ8jPw3mZRsQtRRkP/lYo79ScWnx3XYfM//VVY9UHHYdUhHTn2DYEd9fd
         wj673kYZQofMil/3vyH3LotwLz2AvlfQ9At7UctvHGO/FvG951fara9ud77DipTivkUz
         4/gPwyJSqhW52wbGUruTzayYpGpDgh0McelyP+JqcZzUbSdKz1/KDR2jTYbS8wRjVMdk
         SbBoQZZUowqZg7uqIYDrw3gRbJPoSGs0GuEx7kuHhV5ELFbuaAE7dBn4OYFCpVgGlEl+
         XdAklWH5dNN3I7Ak8QwgyQl0m6KiaZSt2nTjwxspeHQLV1l3gP+UTwsZwOLCXy8g2OQC
         ZqZg==
X-Gm-Message-State: AOAM532UeFAD+PIW+b+CYYUqIWeQNX6E9nwDt+ooOiW8Pbu9GeCsbnoZ
        UqRNBnSx3/pi+lB6hJQ2r29mUUf54Io=
X-Google-Smtp-Source: ABdhPJwT/obPQS1G888ke3tek1PIjXUM3FmXn65j6dVt3IEkhLQIkhnkFNC+hXnZ2yeWwdYogV+7tA==
X-Received: by 2002:aa7:80d1:0:b029:399:ce3a:d617 with SMTP id a17-20020aa780d10000b0290399ce3ad617mr29474529pfn.16.1630432368163;
        Tue, 31 Aug 2021 10:52:48 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id z8sm18302337pfa.113.2021.08.31.10.52.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:52:47 -0700 (PDT)
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
Subject: [PATCH 22/24] x86/entry: Implement and use do_paranoid_entry() and paranoid_exit()
Date:   Wed,  1 Sep 2021 01:50:23 +0800
Message-Id: <20210831175025.27570-23-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

All the facilities are set in traps.c, so we can implement the major body
of paranoid_entry() in C as do_paranoid_entry() and the whole
paranoid_exit() in C.

paranoid_entry() needs to save two values which are added into the
struct ist_regs.  And paranoid_exit() use them after the interrupt
is handled.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S    | 128 +++--------------------------------
 arch/x86/entry/traps.c       |  62 +++++++++++++++++
 arch/x86/include/asm/traps.h |  22 ++++++
 3 files changed, 92 insertions(+), 120 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1ae10ca351f4..8b2e19e6c9e1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -437,6 +437,7 @@ SYM_CODE_START(\asmsym)
 
 	call	\cfunc
 
+	movq	%rsp, %rdi		/* ist_regs pointer */
 	call	paranoid_exit
 	addq	$IST_pt_regs, %rsp	/* put %rsp back to pt_regs */
 	jmp	restore_regs_and_return_to_kernel
@@ -516,6 +517,7 @@ SYM_CODE_START(\asmsym)
 	 * identical to the stack in the IRET frame or the VC fall-back stack,
 	 * so it is definitely mapped even with PTI enabled.
 	 */
+	movq	%rsp, %rdi		/* ist_regs pointer */
 	call	paranoid_exit
 	addq	$IST_pt_regs, %rsp	/* put %rsp back to pt_regs */
 	jmp	restore_regs_and_return_to_kernel
@@ -548,6 +550,7 @@ SYM_CODE_START(\asmsym)
 	movq	$-1, ORIG_RAX(%rdi)	/* no syscall to restart */
 	call	\cfunc
 
+	movq	%rsp, %rdi		/* ist_regs pointer */
 	call	paranoid_exit
 	addq	$IST_pt_regs, %rsp	/* put %rsp back to pt_regs */
 	jmp	restore_regs_and_return_to_kernel
@@ -840,14 +843,8 @@ SYM_CODE_END(xen_failsafe_callback)
 #endif /* CONFIG_XEN_PV */
 
 /*
- * Save all registers in pt_regs. Return GSBASE related information
- * in EBX depending on the availability of the FSGSBASE instructions:
- *
- * FSGSBASE	R/EBX
- *     N        0 -> SWAPGS on exit
- *              1 -> no SWAPGS on exit
- *
- *     Y        GSBASE value at entry, must be restored in paranoid_exit
+ * Save all registers and addtional info in ist_regs.
+ * Switch CR3 and gsbase if needed.
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
@@ -856,124 +853,14 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	movq	RDI(%rsp), %rsi	/* temporarily store the return address in %rsi */
 	movq	%rdi, RDI(%rsp) /* put %rdi onto pt_regs */
 	subq	$IST_pt_regs, %rsp /* reserve room for ist_regs */
+	movq	%rsp, %rdi	/* ist_regs pointer */
 	pushq	%rsi		/* put the return address onto the stack */
 	ENCODE_FRAME_POINTER 8+IST_pt_regs
 
-	/*
-	 * Always stash CR3 in %r14.  This value will be restored,
-	 * verbatim, at exit.  Needed if paranoid_entry interrupted
-	 * another entry that already switched to the user CR3 value
-	 * but has not yet returned to userspace.
-	 *
-	 * This is also why CS (stashed in the "iret frame" by the
-	 * hardware at entry) can not be used: this may be a return
-	 * to kernel code, but with a user CR3 value.
-	 *
-	 * Switching CR3 does not depend on kernel GSBASE so it can
-	 * be done before switching to the kernel GSBASE. This is
-	 * required for FSGSBASE because the kernel GSBASE has to
-	 * be retrieved from a kernel internal table.
-	 */
-	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
-
-	/*
-	 * Handling GSBASE depends on the availability of FSGSBASE.
-	 *
-	 * Without FSGSBASE the kernel enforces that negative GSBASE
-	 * values indicate kernel GSBASE. With FSGSBASE no assumptions
-	 * can be made about the GSBASE value when entering from user
-	 * space.
-	 */
-	ALTERNATIVE "jmp .Lparanoid_entry_checkgs", "", X86_FEATURE_FSGSBASE
-
-	/*
-	 * Read the current GSBASE and store it in %rbx unconditionally,
-	 * retrieve and set the current CPUs kernel GSBASE. The stored value
-	 * has to be restored in paranoid_exit unconditionally.
-	 *
-	 * The unconditional write to GS base below ensures that no subsequent
-	 * loads based on a mispredicted GS base can happen, therefore no LFENCE
-	 * is needed here.
-	 */
-	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
-	ret
-
-.Lparanoid_entry_checkgs:
-	/* EBX = 1 -> kernel GSBASE active, no restore required */
-	movl	$1, %ebx
-	/*
-	 * The kernel-enforced convention is a negative GSBASE indicates
-	 * a kernel value. No SWAPGS needed on entry and exit.
-	 */
-	movl	$MSR_GS_BASE, %ecx
-	rdmsr
-	testl	%edx, %edx
-	jns	.Lparanoid_entry_swapgs
-	ret
-
-.Lparanoid_entry_swapgs:
-	swapgs
-
-	/*
-	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
-	 * unconditional CR3 write, even in the PTI case.  So do an lfence
-	 * to prevent GS speculation, regardless of whether PTI is enabled.
-	 */
-	FENCE_SWAPGS_KERNEL_ENTRY
-
-	/* EBX = 0 -> SWAPGS required on exit */
-	xorl	%ebx, %ebx
+	call	do_paranoid_entry
 	ret
 SYM_CODE_END(paranoid_entry)
 
-/*
- * "Paranoid" exit path from exception stack.  This is invoked
- * only on return from IST interrupts that came from kernel space.
- *
- * We may be returning to very strange contexts (e.g. very early
- * in syscall entry), so checking for preemption here would
- * be complicated.  Fortunately, there's no good reason to try
- * to handle preemption here.
- *
- * R/EBX contains the GSBASE related information depending on the
- * availability of the FSGSBASE instructions:
- *
- * FSGSBASE	R/EBX
- *     N        0 -> SWAPGS on exit
- *              1 -> no SWAPGS on exit
- *
- *     Y        User space GSBASE, must be restored unconditionally
- */
-SYM_CODE_START_LOCAL(paranoid_exit)
-	UNWIND_HINT_REGS offset=8
-	/*
-	 * The order of operations is important. RESTORE_CR3 requires
-	 * kernel GSBASE.
-	 *
-	 * NB to anyone to try to optimize this code: this code does
-	 * not execute at all for exceptions from user mode. Those
-	 * exceptions go through error_exit instead.
-	 */
-	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
-
-	/* Handle the three GSBASE cases */
-	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
-
-	/* With FSGSBASE enabled, unconditionally restore GSBASE */
-	wrgsbase	%rbx
-	ret
-
-.Lparanoid_exit_checkgs:
-	/* On non-FSGSBASE systems, conditionally do SWAPGS */
-	testl		%ebx, %ebx
-	jnz		.Lparanoid_exit_done
-
-	/* We are returning to a context with user GSBASE */
-	swapgs
-.Lparanoid_exit_done:
-	ret
-SYM_CODE_END(paranoid_exit)
-
 /*
  * Save all registers in pt_regs, and switch GS if needed.
  */
@@ -1308,6 +1195,7 @@ end_repeat_nmi:
 	 * Use paranoid_exit to handle SWAPGS and CR3, but no need to use
 	 * restore_regs_and_return_to_kernel as we must handle nested NMI.
 	 */
+	movq	%rsp, %rdi			/* ist_regs pointer */
 	call	paranoid_exit
 	addq	$IST_pt_regs, %rsp		/* put %rsp back to pt_regs */
 
diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index b5c92b4e0cb5..52511db6baa6 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -1029,6 +1029,68 @@ static __always_inline unsigned long ist_switch_to_kernel_gsbase(void)
 	/* SWAPGS required on exit */
 	return 0;
 }
+
+asmlinkage __visible __entry_text
+void do_paranoid_entry(struct ist_regs *ist)
+{
+	/*
+	 * Always stash CR3 in ist->cr3.  This value will be restored,
+	 * verbatim, at exit.  Needed if paranoid_entry interrupted
+	 * another entry that already switched to the user CR3 value
+	 * but has not yet returned to userspace.
+	 *
+	 * This is also why CS (stashed in the "iret frame" by the
+	 * hardware at entry) can not be used: this may be a return
+	 * to kernel code, but with a user CR3 value.
+	 *
+	 * Switching CR3 does not depend on kernel GSBASE so it can
+	 * be done before switching to the kernel GSBASE. This is
+	 * required for FSGSBASE because the kernel GSBASE has to
+	 * be retrieved from a kernel internal table.
+	 */
+	ist->cr3 = ist_switch_to_kernel_cr3();
+
+	/* Handle GSBASE, store the return value in ist_regs for exit. */
+	ist->gsbase = ist_switch_to_kernel_gsbase();
+}
+
+/*
+ * "Paranoid" exit path from exception stack.  This is invoked
+ * only on return from IST interrupts that came from kernel space.
+ *
+ * We may be returning to very strange contexts (e.g. very early
+ * in syscall entry), so checking for preemption here would
+ * be complicated.  Fortunately, there's no good reason to try
+ * to handle preemption here.
+ */
+asmlinkage __visible __entry_text
+void paranoid_exit(struct ist_regs *ist)
+{
+	/*
+	 * Restore cr3 at first, it can use kernel GSBASE.
+	 */
+	ist_restore_cr3(ist->cr3);
+
+	/*
+	 * Handle the three GSBASE cases.
+	 *
+	 * ist->gsbase contains the GSBASE related information depending
+	 * on the availability of the FSGSBASE instructions:
+	 *
+	 * FSGSBASE	ist->gsbase
+	 *     N        0 -> SWAPGS on exit
+	 *              1 -> no SWAPGS on exit
+	 *
+	 *     Y        User space GSBASE, must be restored unconditionally
+	 */
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		wrgsbase(ist->gsbase);
+		return;
+	}
+
+	if (!ist->gsbase)
+		native_swapgs();
+}
 #endif
 
 static bool is_sysenter_singlestep(struct pt_regs *regs)
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index e24c63bbc30a..0bc7117a01cd 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -12,6 +12,26 @@
 
 #ifdef CONFIG_X86_64
 struct ist_regs {
+	/*
+	 * Always stash CR3 in cr3.  This value will be restored,
+	 * verbatim, at exit.  Needed if paranoid_entry interrupted
+	 * another entry that already switched to the user CR3 value
+	 * but has not yet returned to userspace.
+	 */
+	unsigned long cr3;
+
+	/*
+	 * gsbase contains the GSBASE related information depending on the
+	 * availability of the FSGSBASE instructions:
+	 *
+	 * FSGSBASE	gsbase
+	 *     N        0 -> SWAPGS on exit
+	 *              1 -> no SWAPGS on exit
+	 *
+	 *     Y        User space GSBASE, must be restored unconditionally
+	 */
+	unsigned long gsbase;
+
 	/*
 	 * ist specific fields must be defined before pt_regs
 	 * and they are located below pt_regs on the stacks.
@@ -20,6 +40,8 @@ struct ist_regs {
 };
 
 asmlinkage __visible notrace struct pt_regs *do_error_entry(struct pt_regs *eregs);
+asmlinkage __visible notrace void do_paranoid_entry(struct ist_regs *ist);
+asmlinkage __visible notrace void paranoid_exit(struct ist_regs *ist);
 void __init trap_init(void);
 asmlinkage __visible noinstr struct ist_regs *vc_switch_off_ist(struct ist_regs *ist);
 #endif
-- 
2.19.1.6.gb485710b


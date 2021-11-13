Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1895E44F31B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 13:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhKMMoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 07:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhKMMoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 07:44:18 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825AAC061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 04:41:26 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bf8so23556275oib.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 04:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DT/aKtdsbsaPL0NshVNHNqnn3FWatfFa+7E4dkN1spE=;
        b=l3ARHKKsRwR1lhy8CAPcYyTqtXdFCqT+wqODGl29fM4BIpo+6omYAUHAkMtwkH4Uh1
         jYSAIXcfGX4u404fOr0UIixWEWeS7PTn/M6iRXoScofPz961qJjUyyxYLMngMegWDzbp
         mPDEk3Vl4WdPXAya8gM12wrMO3vqX/WU5IQbRKuT2p6yrIj51Sz35dUT8qYYKCigA7/Y
         XMx6OJmMnGkBZrSv/cNkTCOWBp9Ro/BAcAO9RfOlrmKzMxznVFsEx3W7x6Fx55ESX0X9
         5h3cgMpZhiYEpVT01Xw7TBC4HLXQtNbRnhxmfskJ8VyRiATN459sJCokl9NfOMcOFjan
         qgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DT/aKtdsbsaPL0NshVNHNqnn3FWatfFa+7E4dkN1spE=;
        b=QthFFquQHw4U5AgpARcuF802XlnlD13OSlu/RGiPDyFJzXLj9H4H0oTFae7MPMiJzz
         IIXpwpv2eqKpi4Y362dw1iuYbW3GT7miUsc2pc+vGiOr0A3/BgnB7ip6Dhh0WwxqQs79
         NWdz2yqxS1dqwxpbKreOiLePcSAA3OOcyMdkOrHycoS8dvF3QqEI+iTuIr8MgDfeo9zY
         oLry2mptjLisfkn5O79PZJaqrB4FpTk8aYHU8c7xljILvNEheS6HIZBv+HyFvIR9A5Rh
         Qs6SJ84VvTqJDqHUBFslY5DUv2AgBhMiIvVW8hi6GpWSvO1YXUOaTtytGX5/7k5P3wfY
         MT1g==
X-Gm-Message-State: AOAM532/2U/VSu1QS1LYId7WmqdEVd1rTx2ozpUd2nhZs1g/BIVFbbU7
        uM9h1CUMMcm6Jc4n3WlZfmHFNE/mdA==
X-Google-Smtp-Source: ABdhPJwHaou/RZ1lqbXzkBkwSgdk/wo92BM8X6skK0aObMc26sXXYbQjDtDJX/qW1/Xp5gN0hMDzcQ==
X-Received: by 2002:a05:6808:a08:: with SMTP id n8mr24497300oij.148.1636807285693;
        Sat, 13 Nov 2021 04:41:25 -0800 (PST)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id x8sm1796675otg.31.2021.11.13.04.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 04:41:25 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/3] x86-64: Use per-cpu stack canary if supported by compiler
Date:   Sat, 13 Nov 2021 07:40:33 -0500
Message-Id: <20211113124035.9180-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211113124035.9180-1-brgerst@gmail.com>
References: <20211113124035.9180-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the compiler supports it, use a standard per-cpu variable for the
stack protector instead of the old fixed location.  Keep the fixed
location code for compatibility with older compilers.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                      |  5 +++++
 arch/x86/Makefile                     | 21 ++++++++++++++-------
 arch/x86/entry/entry_64.S             |  6 +++++-
 arch/x86/include/asm/processor.h      | 14 +++++++++++---
 arch/x86/include/asm/stackprotector.h | 17 ++++++-----------
 arch/x86/kernel/asm-offsets_64.c      |  2 +-
 arch/x86/kernel/cpu/common.c          | 14 ++++++++------
 arch/x86/kernel/head_64.S             | 16 ++++++++++++----
 arch/x86/kernel/vmlinux.lds.S         |  4 ++--
 arch/x86/xen/xen-head.S               | 10 ++++------
 10 files changed, 68 insertions(+), 41 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b1d4b481fcdd..8268910e09cd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -397,6 +397,11 @@ config CC_HAS_SANE_STACKPROTECTOR
 	   the compiler produces broken code or if it does not let us control
 	   the segment on 32-bit kernels.
 
+config STACKPROTECTOR_FIXED
+	bool
+	depends on X86_64 && STACKPROTECTOR
+	default y if !$(cc-option,-mstack-protector-guard-reg=gs)
+
 menu "Processor type and features"
 
 config SMP
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index aab70413ae7a..94aee76a3457 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -79,13 +79,7 @@ ifeq ($(CONFIG_X86_32),y)
         # temporary until string.h is fixed
         KBUILD_CFLAGS += -ffreestanding
 
-	ifeq ($(CONFIG_STACKPROTECTOR),y)
-		ifeq ($(CONFIG_SMP),y)
-			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
-		else
-			KBUILD_CFLAGS += -mstack-protector-guard=global
-		endif
-	endif
+	percpu_seg := fs
 else
         BITS := 64
         UTS_MACHINE := x86_64
@@ -126,6 +120,19 @@ else
 
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel
+
+	percpu_seg := gs
+endif
+
+ifeq ($(CONFIG_STACKPROTECTOR),y)
+	ifneq ($(CONFIG_STACKPROTECTOR_FIXED),y)
+		ifeq ($(CONFIG_SMP),y)
+			KBUILD_CFLAGS += -mstack-protector-guard-reg=$(percpu_seg) \
+					 -mstack-protector-guard-symbol=__stack_chk_guard
+		else
+			KBUILD_CFLAGS += -mstack-protector-guard=global
+		endif
+	endif
 endif
 
 ifdef CONFIG_X86_X32
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e38a4cf795d9..2006fde249c2 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -217,6 +217,10 @@ syscall_return_via_sysret:
 	sysretq
 SYM_CODE_END(entry_SYSCALL_64)
 
+#ifdef CONFIG_STACKPROTECTOR_FIXED
+#define __stack_chk_guard fixed_percpu_data + stack_canary_offset
+#endif
+
 /*
  * %rdi: prev task
  * %rsi: next task
@@ -240,7 +244,7 @@ SYM_FUNC_START(__switch_to_asm)
 
 #ifdef CONFIG_STACKPROTECTOR
 	movq	TASK_stack_canary(%rsi), %rbx
-	movq	%rbx, PER_CPU_VAR(fixed_percpu_data) + stack_canary_offset
+	movq	%rbx, PER_CPU_VAR(__stack_chk_guard)
 #endif
 
 #ifdef CONFIG_RETPOLINE
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 191878a65c61..44376a15b9d2 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -427,6 +427,8 @@ struct irq_stack {
 DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
 
 #ifdef CONFIG_X86_64
+
+#ifdef CONFIG_STACKPROTECTOR_FIXED
 struct fixed_percpu_data {
 	/*
 	 * GCC hardcodes the stack canary as %gs:40.  Since the
@@ -442,10 +444,19 @@ struct fixed_percpu_data {
 
 DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
 DECLARE_INIT_PER_CPU(fixed_percpu_data);
+#endif /* STACKPROTECTOR_FIXED */
 
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
+#ifdef CONFIG_STACKPROTECTOR_FIXED
 	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
+#else
+#ifdef CONFIG_SMP
+	return per_cpu_offset(cpu);
+#else
+	return 0;
+#endif
+#endif
 }
 
 DECLARE_PER_CPU(void *, hardirq_stack_ptr);
@@ -455,9 +466,6 @@ extern asmlinkage void ignore_sysret(void);
 /* Save actual FS/GS selectors and bases to current->thread */
 void current_save_fsgs(void);
 #else	/* X86_64 */
-#ifdef CONFIG_STACKPROTECTOR
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
-#endif
 DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
 #endif	/* !X86_64 */
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 24a8d6c4fb18..1c7f0035c8fb 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -37,6 +37,12 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 
+#ifdef CONFIG_STACKPROTECTOR_FIXED
+#define __stack_chk_guard fixed_percpu_data.stack_canary
+#else
+DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+#endif
+
 /*
  * Initialize the stackprotector canary value.
  *
@@ -53,9 +59,6 @@ static __always_inline void boot_init_stack_canary(void)
 	u64 canary;
 	u64 tsc;
 
-#ifdef CONFIG_X86_64
-	BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) != 40);
-#endif
 	/*
 	 * We both use the random pool and the current TSC as a source
 	 * of randomness. The TSC only matters for very early init,
@@ -68,20 +71,12 @@ static __always_inline void boot_init_stack_canary(void)
 	canary &= CANARY_MASK;
 
 	current->stack_canary = canary;
-#ifdef CONFIG_X86_64
-	this_cpu_write(fixed_percpu_data.stack_canary, canary);
-#else
 	this_cpu_write(__stack_chk_guard, canary);
-#endif
 }
 
 static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
 {
-#ifdef CONFIG_X86_64
-	per_cpu(fixed_percpu_data.stack_canary, cpu) = idle->stack_canary;
-#else
 	per_cpu(__stack_chk_guard, cpu) = idle->stack_canary;
-#endif
 }
 
 #else	/* STACKPROTECTOR */
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index b14533af7676..e9f4870a5321 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -56,7 +56,7 @@ int main(void)
 
 	BLANK();
 
-#ifdef CONFIG_STACKPROTECTOR
+#ifdef CONFIG_STACKPROTECTOR_FIXED
 	DEFINE(stack_canary_offset, offsetof(struct fixed_percpu_data, stack_canary));
 	BLANK();
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0083464de5e3..f3dfb5b59530 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1767,10 +1767,6 @@ static __init int setup_clearcpuid(char *arg)
 __setup("clearcpuid=", setup_clearcpuid);
 
 #ifdef CONFIG_X86_64
-DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
-		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
-EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
-
 /*
  * The following percpu variables are hot.  Align current_task to
  * cacheline size such that they fall in the same cacheline.
@@ -1840,12 +1836,18 @@ DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) =
 	(unsigned long)&init_thread_union + THREAD_SIZE;
 EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
 
+#endif	/* CONFIG_X86_64 */
+
 #ifdef CONFIG_STACKPROTECTOR
+#ifdef CONFIG_STACKPROTECTOR_FIXED
+DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
+		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
+EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
+#else
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
-
-#endif	/* CONFIG_X86_64 */
+#endif
 
 /*
  * Clear all 6 debug registers:
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8b3ebd2bb85..6e396ffb1610 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -198,10 +198,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movl %eax,%fs
 	movl %eax,%gs
 
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data. If the
-	 * stack protector canary is enabled, it is located at %gs:40.
+	/*
+	 * Set up GS base.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
@@ -337,7 +335,17 @@ SYM_CODE_END(vc_boot_ghcb)
 	__REFDATA
 	.balign	8
 SYM_DATA(initial_code,	.quad x86_64_start_kernel)
+
+#ifdef CONFIG_STACKPROTECTOR_FIXED
 SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(fixed_percpu_data))
+#else
+#ifdef CONFIG_SMP
+SYM_DATA(initial_gs,	.quad __per_cpu_load)
+#else
+SYM_DATA(initial_gs,	.quad 0)
+#endif
+#endif
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3d6dc12d198f..c475d21d2126 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -481,10 +481,10 @@ SECTIONS
  */
 #define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
 INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(fixed_percpu_data);
 INIT_PER_CPU(irq_stack_backing_store);
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_STACKPROTECTOR_FIXED
+INIT_PER_CPU(fixed_percpu_data);
 . = ASSERT((fixed_percpu_data == 0),
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 9e27b86a0c31..54995efd74f7 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -54,16 +54,14 @@ SYM_CODE_START(startup_xen)
 	mov %_ASM_SI, xen_start_info
 	mov initial_stack(%rip), %rsp
 
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data.  If the
-	 * stack protector canary is enabled, it is located at %gs:40.
+	/*
+	 * Set up GS base.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movq	$INIT_PER_CPU_VAR(fixed_percpu_data),%rax
-	cdq
+	movl	initial_gs(%rip),%eax
+	movl	initial_gs+4(%rip),%edx
 	wrmsr
 
 	call xen_start_kernel
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A261030E300
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhBCTCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhBCTCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:02:32 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C806C061786
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 11:01:52 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id v19so359996pgj.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 11:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDxDAnnqnOo7ujPzNRqlXw7rq7vDB876Vjj3hoOFOtk=;
        b=b9Ws/fWLEZDqcYF3V57A3Budmb2gdeJqB+iOL2CQPU6lO44QO/O3DECjgW0JwE9stR
         QwBlV7brNTWK72cb/5ScL8uw8lUp2KLAUyWZn46F73cp32xtImfDJ/Sm90c3HUjq3ezf
         xiwyEtk0R+xtcguvmKsnSB/zlwExrWCaybrRBU1fOaBpMGGbtB4DpxouY4NjwBPkubX7
         j2CWSSM6zJof4Y1BpBY8wwy3lr/MHiQx4k38bJW+WP7XvofHcSW6gCmVCkuP5YN1ooFD
         lIUu/yAq9EHq+EHUVmLM+oNMnEjejeMBeO93SKHWXq+hZjARGgit8baJ7Bv1rXJdrI4T
         VtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDxDAnnqnOo7ujPzNRqlXw7rq7vDB876Vjj3hoOFOtk=;
        b=gEJqUdzse6oSWhxJAva5VBbf2T/ac1dzcuXoKRKvvkzLmmf7JenNyUeMdw1CKgO6a0
         lOyIut2jWTBBToDFXdqD46I2/ptkxRv4lu76tBZqYR0inD1QZvODF0sKO/FqjrXYRHTJ
         PCELiM13Y5yXGvdHPAur10ILgBYu69sCKpD01n+GT5N6nea/atHiwP2AOZ0Rugbpd5iM
         1bipYVar7hbo7Ff6/+u39Tbkq+BCFbc2S4LGIcPj3kK8FbWArvw+FidwvwnrFHHIaZSn
         HVwr8mxFqLCHL0pp4MtSDpj4WmA3w6ge+QsNEW5oaucUYUrm2AMFS0emH7UX0sqUaP0z
         0k3w==
X-Gm-Message-State: AOAM530JLYFNT9yPHV4GdYe6jWZ9E+/WazQ1C4Wm7uavCaTScrswjUPi
        ArH+AMQFtD7gNueRerNHyyw=
X-Google-Smtp-Source: ABdhPJxS5Nmn0WkYYsCHGooJus2gkhDPtezhmTvif9pU7zbvhQhflhmJ5iLeBi+BbUYczNxYgHcutg==
X-Received: by 2002:a62:2702:0:b029:1d1:b92a:ef2a with SMTP id n2-20020a6227020000b02901d1b92aef2amr3259813pfn.5.1612378911636;
        Wed, 03 Feb 2021 11:01:51 -0800 (PST)
Received: from localhost.localdomain (76-242-91-105.lightspeed.sntcca.sbcglobal.net. [76.242.91.105])
        by smtp.gmail.com with ESMTPSA id 129sm2907306pfw.86.2021.02.03.11.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 11:01:50 -0800 (PST)
From:   sonicadvance1@gmail.com
X-Google-Original-From: Sonicadvance1@gmail.com
Cc:     amanieu@gmail.com, Ryan Houdek <Sonicadvance1@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Martin <Dave.Martin@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kevin Hao <haokexin@gmail.com>,
        Jason Yan <yanaijie@huawei.com>,
        Peter Collingbourne <pcc@google.com>,
        Julien Grall <julien.grall@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Matteo Croce <mcroce@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] [RFC] arm64: Exposes support for 32-bit syscalls
Date:   Wed,  3 Feb 2021 11:01:21 -0800
Message-Id: <20210203190135.64839-1-Sonicadvance1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210202165437.334515-1-Sonicadvance1@gmail.com>
References: <20210202165437.334515-1-Sonicadvance1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Houdek <Sonicadvance1@gmail.com>

Sorry about the noise. I obviously don't work in this ecosystem.

The problem:
We need to support 32-bit processes running under a userspace
compatibility layer. The compatibility layer is a AArch64 process.
This means exposing the 32bit compatibility syscalls to userspace.

Why do we need compatibility layers?
There are ARMv8 CPUs that only support AArch64 but still need to run
AArch32 applications.
Cortex-A34/R82 and other cores are prime examples of this.
Additionally if a user is needing to run legacy 32-bit x86 software, it
needs the same compatibility layer.

Who does this matter to?
Any user that has a specific need to run legacy 32-bit software under a
compatibility layer.
Not all software is open source or easy to convert to 64bit, it's
something we need to live with.
Professional software and the gaming ecosystem is rife with this.

What applications have tried to work around this problem?
FEX emulator (1) - Userspace x86 to AArch64 compatibility layer
Tango binary translator (2) - AArch32 to AArch64 compatibility layer
QEmu (3) - Not really but they do some userspace ioctl emulation

What problems did they hit?
FEX and Tango hit problems with emulating memory related syscalls.
- Emulating 32-bit mmap, mremap, shmat in userspace changes behaviour
All three hit issues with ioctl emulation
- ioctls are free to do what they want including allocating memory and
returning opaque structures with pointers.

With this patch we will be exposing the compatibility syscall table
through the regular syscall svc API. There is prior art here where on
x86-64 they also expose the compatibility tables.
The justification for this is that we need to maintain support for 32bit
application compatibility going in to the foreseeable future.
Userspace does almost all of the heavy lifting here, especially when the
hardware no longer supports the 32bit use case.

A couple of caveats to this approach.
Userspace must know that this doesn't solve structure alignment problems
for the x86->AArch64 (1) case.
The API for this changes from syscall number in x8 to x7 to match
AArch32 syscall semantics
This is now exposing the compat syscalls to userspace, but for the sake
of userspace compatibility it is a necessary evil.

Why does the upstream kernel care?
I believe every user wants to have their software ecosystem continue
working if they are in a mixed AArch32/AArch64 world even when they are
running AArch64 only hardware. The kernel should facilitate a good user
experience.

External Resources
(1) https://github.com/FEX-Emu/FEX
(2) https://www.amanieusystems.com/
(3) https://www.qemu.org/

Further reading
- https://github.com/FEX-Emu/FEX/wiki/32Bit-x86-Woes
- Original patch: https://github.com/Amanieu/linux/commit/b4783002afb0

Changes in v2:
- Removed a tangential code path to make this more concise
  - Now doesn't cover Tango's full use case
  - This is purely for conciseness sake, easy enough to add back
- Cleaned up commit message
Signed-off-by: Ryan Houdek <Sonicadvance1@gmail.com>
---
 arch/arm64/Kconfig                   |   9 +
 arch/arm64/include/asm/compat.h      |  20 +++
 arch/arm64/include/asm/exception.h   |   2 +-
 arch/arm64/include/asm/mmu.h         |   7 +
 arch/arm64/include/asm/pgtable.h     |  10 ++
 arch/arm64/include/asm/processor.h   |   6 +-
 arch/arm64/include/asm/thread_info.h |   7 +
 arch/arm64/kernel/asm-offsets.c      |   3 +
 arch/arm64/kernel/entry-common.c     |   9 +-
 arch/arm64/kernel/fpsimd.c           |   2 +-
 arch/arm64/kernel/hw_breakpoint.c    |   2 +-
 arch/arm64/kernel/perf_regs.c        |   2 +-
 arch/arm64/kernel/process.c          |  13 +-
 arch/arm64/kernel/ptrace.c           |   6 +-
 arch/arm64/kernel/signal.c           |   2 +-
 arch/arm64/kernel/syscall.c          |  41 ++++-
 arch/arm64/mm/mmap.c                 | 249 +++++++++++++++++++++++++++
 17 files changed, 369 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..9832f05daaee 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1147,6 +1147,15 @@ config XEN
 	help
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM64.
 
+config ARM_COMPAT_DISPATCH
+	bool "32bit syscall dispatch table"
+	depends on COMPAT && ARM64
+	default y
+	help
+	  Kernel support for exposing the 32-bit syscall dispatch table to
+	  userspace.
+	  For dynamically translating 32-bit applications to a 64-bit process.
+
 config FORCE_MAX_ZONEORDER
 	int
 	default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 23a9fb73c04f..d00c6f427999 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -180,10 +180,30 @@ struct compat_shmid64_ds {
 
 static inline int is_compat_task(void)
 {
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	/* It is compatible if Tango, 32bit compat, or 32bit thread */
+	return current_thread_info()->compat_syscall_flags != 0 || test_thread_flag(TIF_32BIT);
+#else
 	return test_thread_flag(TIF_32BIT);
+#endif
 }
 
 static inline int is_compat_thread(struct thread_info *thread)
+{
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	/* It is compatible if Tango, 32bit compat, or 32bit thread */
+	return thread->compat_syscall_flags != 0 || test_ti_thread_flag(thread, TIF_32BIT);
+#else
+	return test_ti_thread_flag(thread, TIF_32BIT);
+#endif
+}
+
+static inline int is_aarch32_compat_task(void)
+{
+	return test_thread_flag(TIF_32BIT);
+}
+
+static inline int is_aarch32_compat_thread(struct thread_info *thread)
 {
 	return test_ti_thread_flag(thread, TIF_32BIT);
 }
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 99b9383cd036..f2c94b44b51c 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -45,7 +45,7 @@ void do_sysinstr(unsigned int esr, struct pt_regs *regs);
 void do_sp_pc_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
 void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr);
 void do_cp15instr(unsigned int esr, struct pt_regs *regs);
-void do_el0_svc(struct pt_regs *regs);
+void do_el0_svc(struct pt_regs *regs, unsigned int iss);
 void do_el0_svc_compat(struct pt_regs *regs);
 void do_ptrauth_fault(struct pt_regs *regs, unsigned int esr);
 #endif	/* __ASM_EXCEPTION_H */
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index b2e91c187e2a..0744db65c0a9 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -27,6 +27,9 @@ typedef struct {
 	refcount_t	pinned;
 	void		*vdso;
 	unsigned long	flags;
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	unsigned long	compat_mmap_base;
+#endif
 } mm_context_t;
 
 /*
@@ -79,6 +82,10 @@ extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
 extern bool kaslr_requires_kpti(void);
 
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+extern void process_init_compat_mmap(void);
+#endif
+
 #define INIT_MM_CONTEXT(name)	\
 	.pgd = init_pg_dir,
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4ff12a7adcfd..5e7662c2675c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -974,6 +974,16 @@ static inline bool arch_faults_on_old_pte(void)
 }
 #define arch_faults_on_old_pte arch_faults_on_old_pte
 
+/*
+ * We provide our own arch_get_unmapped_area to handle 32-bit mmap calls from
+ * tango.
+ */
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+#define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index fce8cbecd6bc..03c05cd19f87 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -175,7 +175,7 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 #define task_user_tls(t)						\
 ({									\
 	unsigned long *__tls;						\
-	if (is_compat_thread(task_thread_info(t)))			\
+	if (is_aarch32_compat_thread(task_thread_info(t)))			\
 		__tls = &(t)->thread.uw.tp2_value;			\
 	else								\
 		__tls = &(t)->thread.uw.tp_value;			\
@@ -256,8 +256,8 @@ extern struct task_struct *cpu_switch_to(struct task_struct *prev,
 #define task_pt_regs(p) \
 	((struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1)
 
-#define KSTK_EIP(tsk)	((unsigned long)task_pt_regs(tsk)->pc)
-#define KSTK_ESP(tsk)	user_stack_pointer(task_pt_regs(tsk))
+#define KSTK_EIP(tsk)  ((unsigned long)task_pt_regs(tsk)->pc)
+#define KSTK_ESP(tsk)  user_stack_pointer(task_pt_regs(tsk))
 
 /*
  * Prefetching support
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 1fbab854a51b..cb04c7c4df38 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -41,6 +41,9 @@ struct thread_info {
 #endif
 		} preempt;
 	};
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	int			compat_syscall_flags;	/* 32-bit compat syscall */
+#endif
 #ifdef CONFIG_SHADOW_CALL_STACK
 	void			*scs_base;
 	void			*scs_sp;
@@ -107,6 +110,10 @@ void arch_release_task_struct(struct task_struct *tsk);
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
 				 _TIF_SYSCALL_EMU)
 
+#define TIF_COMPAT_32BITSYSCALL 0 /* Trivial 32bit compatible syscall */
+
+#define _TIF_COMPAT_32BITSYSCALL (1 << TIF_COMPAT_32BITSYSCALL)
+
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
 	.scs_base	= init_shadow_call_stack,			\
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 7d32fc959b1a..742203cff128 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -34,6 +34,9 @@ int main(void)
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
   DEFINE(TSK_TI_TTBR0,		offsetof(struct task_struct, thread_info.ttbr0));
 #endif
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+  DEFINE(TI_COMPAT_SYSCALL,	offsetof(struct task_struct, thread_info.compat_syscall_flags));
+#endif
 #ifdef CONFIG_SHADOW_CALL_STACK
   DEFINE(TSK_TI_SCS_BASE,	offsetof(struct task_struct, thread_info.scs_base));
   DEFINE(TSK_TI_SCS_SP,		offsetof(struct task_struct, thread_info.scs_sp));
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 43d4c329775f..6d98a9c6fafd 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -228,12 +228,12 @@ static void notrace el0_dbg(struct pt_regs *regs, unsigned long esr)
 }
 NOKPROBE_SYMBOL(el0_dbg);
 
-static void notrace el0_svc(struct pt_regs *regs)
+static void notrace el0_svc(struct pt_regs *regs, unsigned int iss)
 {
 	if (system_uses_irq_prio_masking())
 		gic_write_pmr(GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET);
 
-	do_el0_svc(regs);
+	do_el0_svc(regs, iss);
 }
 NOKPROBE_SYMBOL(el0_svc);
 
@@ -251,7 +251,10 @@ asmlinkage void notrace el0_sync_handler(struct pt_regs *regs)
 
 	switch (ESR_ELx_EC(esr)) {
 	case ESR_ELx_EC_SVC64:
-		el0_svc(regs);
+		/* Redundant masking here to show we are getting ISS mask
+		 * Then we are pulling the imm16 out of it for SVC64
+		 */
+		el0_svc(regs, (esr & ESR_ELx_ISS_MASK) & 0xffff);
 		break;
 	case ESR_ELx_EC_DABT_LOW:
 		el0_da(regs, esr);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 062b21f30f94..a35ab449a466 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -937,7 +937,7 @@ void fpsimd_release_task(struct task_struct *dead_task)
 void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 {
 	/* Even if we chose not to use SVE, the hardware could still trap: */
-	if (unlikely(!system_supports_sve()) || WARN_ON(is_compat_task())) {
+	if (unlikely(!system_supports_sve()) || WARN_ON(is_aarch32_compat_task())) {
 		force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 		return;
 	}
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 712e97c03e54..37c9349c4999 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -168,7 +168,7 @@ static int is_compat_bp(struct perf_event *bp)
 	 * deprecated behaviour if we use unaligned watchpoints in
 	 * AArch64 state.
 	 */
-	return tsk && is_compat_thread(task_thread_info(tsk));
+	return tsk && is_aarch32_compat_thread(task_thread_info(tsk));
 }
 
 /**
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index f6f58e6265df..c4b061f0d182 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -66,7 +66,7 @@ int perf_reg_validate(u64 mask)
 
 u64 perf_reg_abi(struct task_struct *task)
 {
-	if (is_compat_thread(task_thread_info(task)))
+	if (is_aarch32_compat_thread(task_thread_info(task)))
 		return PERF_SAMPLE_REGS_ABI_32;
 	else
 		return PERF_SAMPLE_REGS_ABI_64;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index a47a40ec6ad9..9c0775babbd0 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -314,7 +314,7 @@ static void tls_thread_flush(void)
 {
 	write_sysreg(0, tpidr_el0);
 
-	if (is_compat_task()) {
+	if (is_aarch32_compat_task()) {
 		current->thread.uw.tp_value = 0;
 
 		/*
@@ -409,7 +409,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		*task_user_tls(p) = read_sysreg(tpidr_el0);
 
 		if (stack_start) {
-			if (is_compat_thread(task_thread_info(p)))
+			if (is_aarch32_compat_thread(task_thread_info(p)))
 				childregs->compat_sp = stack_start;
 			else
 				childregs->sp = stack_start;
@@ -453,7 +453,7 @@ static void tls_thread_switch(struct task_struct *next)
 {
 	tls_preserve_current_state();
 
-	if (is_compat_thread(task_thread_info(next)))
+	if (is_aarch32_compat_thread(task_thread_info(next)))
 		write_sysreg(next->thread.uw.tp_value, tpidrro_el0);
 	else if (!arm64_kernel_unmapped_at_el0())
 		write_sysreg(0, tpidrro_el0);
@@ -619,7 +619,12 @@ unsigned long arch_align_stack(unsigned long sp)
  */
 void arch_setup_new_exec(void)
 {
-	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	process_init_compat_mmap();
+	current_thread_info()->compat_syscall_flags = 0;
+#endif
+
+	current->mm->context.flags = is_aarch32_compat_task() ? MMCF_AARCH32 : 0;
 
 	ptrauth_thread_init_user(current);
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index f49b349e16a3..2e3c242941d1 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -175,7 +175,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 	const char *desc = "Hardware breakpoint trap (ptrace)";
 
 #ifdef CONFIG_COMPAT
-	if (is_compat_task()) {
+	if (is_aarch32_compat_task()) {
 		int si_errno = 0;
 		int i;
 
@@ -1725,7 +1725,7 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 	 */
 	if (is_compat_task())
 		return &user_aarch32_view;
-	else if (is_compat_thread(task_thread_info(task)))
+	else if (is_aarch32_compat_thread(task_thread_info(task)))
 		return &user_aarch32_ptrace_view;
 #endif
 	return &user_aarch64_view;
@@ -1906,7 +1906,7 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
 	/* https://lore.kernel.org/lkml/20191118131525.GA4180@willie-the-truck */
 	user_regs_reset_single_step(regs, task);
 
-	if (is_compat_thread(task_thread_info(task)))
+	if (is_aarch32_compat_thread(task_thread_info(task)))
 		return valid_compat_regs(regs);
 	else
 		return valid_native_regs(regs);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index a8184cad8890..e6462b32effa 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -813,7 +813,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	/*
 	 * Set up the stack frame
 	 */
-	if (is_compat_task()) {
+	if (is_aarch32_compat_task()) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
 			ret = compat_setup_rt_frame(usig, ksig, oldset, regs);
 		else
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index e4c0dadf0d92..6857dad5df8e 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -21,7 +21,7 @@ static long do_ni_syscall(struct pt_regs *regs, int scno)
 {
 #ifdef CONFIG_COMPAT
 	long ret;
-	if (is_compat_task()) {
+	if (is_aarch32_compat_task()) {
 		ret = compat_arm_syscall(regs, scno);
 		if (ret != -ENOSYS)
 			return ret;
@@ -167,6 +167,9 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		local_daif_mask();
 		flags = current_thread_info()->flags;
 		if (!has_syscall_work(flags) && !(flags & _TIF_SINGLESTEP)) {
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+			current_thread_info()->compat_syscall_flags = 0;
+#endif
 			/*
 			 * We're off to userspace, where interrupts are
 			 * always enabled after we restore the flags from
@@ -180,6 +183,9 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 
 trace_exit:
 	syscall_trace_exit(regs);
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	current_thread_info()->compat_syscall_flags = 0;
+#endif
 }
 
 static inline void sve_user_discard(void)
@@ -199,10 +205,39 @@ static inline void sve_user_discard(void)
 	sve_user_disable();
 }
 
-void do_el0_svc(struct pt_regs *regs)
+void do_el0_svc(struct pt_regs *regs, unsigned int iss)
 {
 	sve_user_discard();
-	el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
+	/* XXX: Which style is more ideal to take here? */
+#if 0
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	/* Hardcode syscall 0x8000'0000 to be a 32bit support syscall */
+	if (regs->regs[8] == 0x80000000) {
+		current_thread_info()->compat_syscall_flags = _TIF_COMPAT_32BITSYSCALL;
+		el0_svc_common(regs, regs->regs[7], __NR_compat_syscalls,
+			       compat_sys_call_table);
+
+	} else
+#endif
+		el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
+#else
+	switch (iss) {
+	/* SVC #1 is now a 32bit support syscall
+	 * Any other SVC ISS falls down the regular syscall code path
+	 */
+	case 1:
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+		current_thread_info()->compat_syscall_flags = _TIF_COMPAT_32BITSYSCALL;
+		el0_svc_common(regs, regs->regs[7], __NR_compat_syscalls,
+			       compat_sys_call_table);
+#else
+		return -ENOSYS;
+#endif
+		break;
+	default:
+		el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
+	}
+#endif
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 3028bacbc4e9..857aa03a3ac2 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -17,6 +17,8 @@
 #include <linux/io.h>
 #include <linux/personality.h>
 #include <linux/random.h>
+#include <linux/security.h>
+#include <linux/hugetlb.h>
 
 #include <asm/cputype.h>
 
@@ -68,3 +70,250 @@ int devmem_is_allowed(unsigned long pfn)
 }
 
 #endif
+
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+
+/* Definitions for compat syscall guest mmap area */
+#define COMPAT_MIN_GAP			(SZ_128M)
+#define COMPAT_STACK_TOP		0xffff0000
+#define COMPAT_MAX_GAP			(COMPAT_STACK_TOP/6*5)
+#define COMPAT_TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE_32 / 4)
+#define COMPAT_STACK_RND_MASK		(0x7ff >> (PAGE_SHIFT - 12))
+
+#ifndef arch_get_mmap_end
+#define arch_get_mmap_end(addr)	(TASK_SIZE)
+#endif
+
+#ifndef arch_get_mmap_base
+#define arch_get_mmap_base(addr, base) (base)
+#endif
+
+static int mmap_is_legacy(unsigned long rlim_stack)
+{
+	if (current->personality & ADDR_COMPAT_LAYOUT)
+		return 1;
+
+	if (rlim_stack == RLIM_INFINITY)
+		return 1;
+
+	return sysctl_legacy_va_layout;
+}
+
+static unsigned long compat_mmap_base(unsigned long rnd, unsigned long gap)
+{
+	unsigned long pad = stack_guard_gap;
+
+	/* Account for stack randomization if necessary */
+	if (current->flags & PF_RANDOMIZE)
+		pad += (COMPAT_STACK_RND_MASK << PAGE_SHIFT);
+
+	/* Values close to RLIM_INFINITY can overflow. */
+	if (gap + pad > gap)
+		gap += pad;
+
+	if (gap < COMPAT_MIN_GAP)
+		gap = COMPAT_MIN_GAP;
+	else if (gap > COMPAT_MAX_GAP)
+		gap = COMPAT_MAX_GAP;
+
+	return PAGE_ALIGN(COMPAT_STACK_TOP - gap - rnd);
+}
+
+void process_init_compat_mmap(void)
+{
+	unsigned long random_factor = 0UL;
+	unsigned long rlim_stack = rlimit(RLIMIT_STACK);
+
+	if (current->flags & PF_RANDOMIZE) {
+		random_factor = (get_random_long() &
+			((1UL << mmap_rnd_compat_bits) - 1)) << PAGE_SHIFT;
+	}
+
+	if (mmap_is_legacy(rlim_stack)) {
+		current->mm->context.compat_mmap_base =
+			COMPAT_TASK_UNMAPPED_BASE + random_factor;
+	} else {
+		current->mm->context.compat_mmap_base =
+			compat_mmap_base(random_factor, rlim_stack);
+	}
+}
+
+/* Get an address range which is currently unmapped.
+ * For shmat() with addr=0.
+ *
+ * Ugly calling convention alert:
+ * Return value with the low bits set means error value,
+ * ie
+ *	if (ret & ~PAGE_MASK)
+ *		error = ret;
+ *
+ * This function "knows" that -ENOMEM has the bits set.
+ */
+unsigned long
+arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
+	struct vm_unmapped_area_info info;
+	const unsigned long mmap_end = arch_get_mmap_end(addr);
+	bool bad_addr = false;
+
+	if (len > mmap_end - mmap_min_addr)
+		return -ENOMEM;
+
+	/*
+	 * Ensure that translated processes do not allocate the last
+	 * page of the 32-bit address space, or anything above it.
+	 */
+	if (is_compat_task())
+		bad_addr = addr + len > TASK_SIZE_32;
+
+	if (flags & MAP_FIXED)
+		return bad_addr ? -ENOMEM : addr;
+
+	if (addr && !bad_addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma_prev(mm, addr, &prev);
+		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
+		    (!vma || addr + len <= vm_start_gap(vma)) &&
+		    (!prev || addr >= vm_end_gap(prev)))
+			return addr;
+	}
+
+	info.flags = 0;
+	info.length = len;
+	if (is_compat_task()) {
+		info.low_limit = mm->context.compat_mmap_base;
+		info.high_limit = TASK_SIZE_32;
+	} else {
+		info.low_limit = mm->mmap_base;
+		info.high_limit = mmap_end;
+	}
+	info.align_mask = 0;
+	return vm_unmapped_area(&info);
+}
+
+/*
+ * This mmap-allocator allocates new areas top-down from below the
+ * stack's low limit (the base):
+ */
+unsigned long
+arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
+			  unsigned long len, unsigned long pgoff,
+			  unsigned long flags)
+{
+
+	struct vm_area_struct *vma, *prev;
+	struct mm_struct *mm = current->mm;
+	struct vm_unmapped_area_info info;
+	const unsigned long mmap_end = arch_get_mmap_end(addr);
+	bool bad_addr = false;
+
+	/* requested length too big for entire address space */
+	if (len > mmap_end - mmap_min_addr)
+		return -ENOMEM;
+
+	/*
+	 * Ensure that translated processes do not allocate the last
+	 * page of the 32-bit address space, or anything above it.
+	 */
+	if (is_compat_task())
+		bad_addr = addr + len > TASK_SIZE_32;
+
+	if (flags & MAP_FIXED)
+		return bad_addr ? -ENOMEM : addr;
+
+	/* requesting a specific address */
+	if (addr && !bad_addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma_prev(mm, addr, &prev);
+		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
+				(!vma || addr + len <= vm_start_gap(vma)) &&
+				(!prev || addr >= vm_end_gap(prev)))
+			return addr;
+	}
+
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	if (is_compat_task())
+		info.high_limit = mm->context.compat_mmap_base;
+	else
+		info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
+	info.align_mask = 0;
+	addr = vm_unmapped_area(&info);
+
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	if (offset_in_page(addr)) {
+		VM_BUG_ON(addr != -ENOMEM);
+		info.flags = 0;
+		if (is_compat_task()) {
+			info.low_limit = COMPAT_TASK_UNMAPPED_BASE;
+			info.high_limit = TASK_SIZE_32;
+		} else {
+			info.low_limit = TASK_UNMAPPED_BASE;
+			info.high_limit = mmap_end;
+		}
+		addr = vm_unmapped_area(&info);
+	}
+
+	return addr;
+}
+
+unsigned long
+hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct hstate *h = hstate_file(file);
+	struct vm_unmapped_area_info info;
+	bool bad_addr = false;
+
+	if (len & ~huge_page_mask(h))
+		return -EINVAL;
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	/*
+	 * Ensure that translated processes do not allocate the last
+	 * page of the 32-bit address space, or anything above it.
+	 */
+	if (is_compat_task())
+		bad_addr = addr + len > TASK_SIZE_32;
+
+	if (flags & MAP_FIXED) {
+		if (prepare_hugepage_range(file, addr, len))
+			return -EINVAL;
+		return bad_addr ? -ENOMEM : addr;
+	}
+
+	if (addr && !bad_addr) {
+		addr = ALIGN(addr, huge_page_size(h));
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vm_start_gap(vma)))
+			return addr;
+	}
+
+	info.flags = 0;
+	info.length = len;
+	if (is_compat_task()) {
+		info.low_limit = COMPAT_TASK_UNMAPPED_BASE;
+		info.high_limit = TASK_SIZE_32;
+	} else {
+		info.low_limit = TASK_UNMAPPED_BASE;
+		info.high_limit = TASK_SIZE;
+	}
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
+}
+
+#endif
-- 
2.27.0


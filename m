Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D53F32471F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 23:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhBXWsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 17:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbhBXWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 17:48:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB6BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:47:56 -0800 (PST)
Date:   Wed, 24 Feb 2021 22:47:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614206874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vwCZp2huJKVXoEvWygaW1wVNEVUOK9ZJGQFkg51h0WY=;
        b=O+wqA1pMClg0+7OK/ZJbVehDYKI6n5YgZnBbzQqtBpzBQtfjTJKGkBdStNXWxtIowXQdXS
        Tg0z99/UKwDxy8DCPapSGZxr1nDoOs7LBgo7zgDyIapc+UpgO7T19zMd9ysuXLmQfYxICw
        tCBZt70eNcW/ABuc1S+A9bFrKR+SiuATaaYtKtqWysAfZxCQCWFX6icAlgdaQ8y9rcTaes
        Pfp+9tLMfzgeXGlg4CxFqCqjWVTOcQEE4A9F12ihT1LQSrlcHCrK5v5UShZghTWKIpR4Fg
        p7qURtHeRBPVMc6fUpqI196xaKnTeUziUGZpo9/RHNywDFiV4/55z9cL6AS7yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614206874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vwCZp2huJKVXoEvWygaW1wVNEVUOK9ZJGQFkg51h0WY=;
        b=SVUPIeQhm0qVSq8SEuZ2mVk/gJ+kVQGP2IY3YauxQcixlXx/QXxH5S2kkgLXyiAnrKXqQm
        M7Pw+BzRR61YNbDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/entry for 5.12
Message-ID: <161420682325.18281.7125785645465599243.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2021-02-24

up to:  724c8a23d589: objtool: Fix stack-swizzle for FRAME_POINTER=y

Rework of the x86 irq stack handling:

  The irq stack switching was moved out of the ASM entry code in course of
  the entry code consolidation. It ended up being suboptimal in various
  ways.

  - Make the stack switching inline so the stackpointer manipulation is not
    longer at an easy to find place.

  - Get rid of the unnecessary indirect call.

  - Avoid the double stack switching in interrupt return and reuse the
    interrupt stack for softirq handling.

  - A objtool fix for CONFIG_FRAME_POINTER=y builds where it got confused
    about the stack pointer manipulation.

Thanks,

	tglx

------------------>
Peter Zijlstra (1):
      objtool: Fix stack-swizzle for FRAME_POINTER=y

Thomas Gleixner (15):
      x86/entry: Fix instrumentation annotation
      x86/irq: Sanitize irq stack tracking
      x86/irq/64: Adjust the per CPU irq stack pointer by 8
      x86/apic: Split out spurious handling code
      x86/irq: Provide macro for inlining irq stack switching
      x86/entry: Convert system vectors to irq stack macro
      x86/entry: Convert device interrupts to inline stack switching
      x86/entry: Use run_sysvec_on_irqstack_cond() for XEN upcall
      x86/softirq: Remove indirection in do_softirq_own_stack()
      x86: Select CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
      softirq: Move __ARCH_HAS_DO_SOFTIRQ to Kconfig
      softirq: Move do_softirq_own_stack() to generic asm header
      x86/softirq/64: Inline do_softirq_own_stack()
      um: Enforce the usage of asm-generic/softirq_stack.h

 arch/Kconfig                         |   6 +
 arch/parisc/Kconfig                  |   1 +
 arch/parisc/include/asm/hardirq.h    |   4 -
 arch/parisc/kernel/irq.c             |   1 +
 arch/powerpc/Kconfig                 |   1 +
 arch/powerpc/include/asm/irq.h       |   2 -
 arch/powerpc/kernel/irq.c            |   1 +
 arch/s390/Kconfig                    |   1 +
 arch/s390/include/asm/hardirq.h      |   1 -
 arch/s390/kernel/irq.c               |   1 +
 arch/sh/Kconfig                      |   1 +
 arch/sh/include/asm/irq.h            |   1 -
 arch/sh/kernel/irq.c                 |   1 +
 arch/sparc/Kconfig                   |   1 +
 arch/sparc/include/asm/irq_64.h      |   1 -
 arch/sparc/kernel/irq_64.c           |   1 +
 arch/um/include/asm/Kbuild           |   1 +
 arch/x86/Kconfig                     |   2 +
 arch/x86/entry/common.c              |  19 +--
 arch/x86/entry/entry_64.S            |  41 -----
 arch/x86/include/asm/idtentry.h      |  11 +-
 arch/x86/include/asm/irq.h           |   2 -
 arch/x86/include/asm/irq_stack.h     | 279 +++++++++++++++++++++++++----------
 arch/x86/include/asm/processor.h     |   9 +-
 arch/x86/include/asm/softirq_stack.h |  11 ++
 arch/x86/kernel/apic/apic.c          |  31 ++--
 arch/x86/kernel/cpu/common.c         |   4 +-
 arch/x86/kernel/dumpstack_64.c       |  22 ++-
 arch/x86/kernel/irq.c                |   2 +-
 arch/x86/kernel/irq_32.c             |   1 +
 arch/x86/kernel/irq_64.c             |  12 +-
 arch/x86/kernel/process_64.c         |   2 +-
 include/asm-generic/Kbuild           |   1 +
 include/asm-generic/softirq_stack.h  |  14 ++
 include/linux/interrupt.h            |   9 --
 kernel/softirq.c                     |   2 +
 tools/objtool/check.c                |  14 ++
 37 files changed, 318 insertions(+), 196 deletions(-)
 create mode 100644 arch/x86/include/asm/softirq_stack.h
 create mode 100644 include/asm-generic/softirq_stack.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 207261f4879d..2bb30673d8e6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -821,6 +821,12 @@ config HAVE_IRQ_EXIT_ON_IRQ_STACK
 	  This spares a stack switch and improves cache usage on softirq
 	  processing.
 
+config HAVE_SOFTIRQ_ON_OWN_STACK
+	bool
+	help
+	  Architecture provides a function to run __do_softirq() on a
+	  seperate stack.
+
 config PGTABLE_LEVELS
 	int
 	default 2
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index ecef9aff9d72..07fbe1a82f3e 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -63,6 +63,7 @@ config PARISC
 	select HAVE_FTRACE_MCOUNT_RECORD if HAVE_DYNAMIC_FTRACE
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
+	select HAVE_SOFTIRQ_ON_OWN_STACK if IRQSTACKS
 	select SET_FS
 
 	help
diff --git a/arch/parisc/include/asm/hardirq.h b/arch/parisc/include/asm/hardirq.h
index fad29aa6f45f..1e4fbd0fd944 100644
--- a/arch/parisc/include/asm/hardirq.h
+++ b/arch/parisc/include/asm/hardirq.h
@@ -12,10 +12,6 @@
 #include <linux/threads.h>
 #include <linux/irq.h>
 
-#ifdef CONFIG_IRQSTACKS
-#define __ARCH_HAS_DO_SOFTIRQ
-#endif
-
 typedef struct {
 	unsigned int __softirq_pending;
 	unsigned int kernel_stack_usage;
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 1dfb439b0692..0d46b19dc4d3 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <asm/io.h>
 
+#include <asm/softirq_stack.h>
 #include <asm/smp.h>
 #include <asm/ldcw.h>
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2ffb229d8d2d..386ae12d8523 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -235,6 +235,7 @@ config PPC
 	select MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 4f983ca4030a..f3f264e441a7 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -37,8 +37,6 @@ extern int distribute_irqs;
 
 struct pt_regs;
 
-#define __ARCH_HAS_DO_SOFTIRQ
-
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 /*
  * Per-cpu stacks for handling critical, debug and machine check
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 086b0a743329..d71fd10a1dd4 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -66,6 +66,7 @@
 #include <asm/livepatch.h>
 #include <asm/asm-prototypes.h>
 #include <asm/hw_irq.h>
+#include <asm/softirq_stack.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e8f7216f6c63..c1ff874e6c2e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -184,6 +184,7 @@ config S390
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index dfbc3c6c0674..58668ffb5488 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -18,7 +18,6 @@
 #define or_softirq_pending(x)  (S390_lowcore.softirq_pending |= (x))
 
 #define __ARCH_IRQ_STAT
-#define __ARCH_HAS_DO_SOFTIRQ
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
 
 static inline void ack_bad_irq(unsigned int irq)
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index c6d40bcf4a68..601c21791338 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -28,6 +28,7 @@
 #include <asm/irq.h>
 #include <asm/hw_irq.h>
 #include <asm/stacktrace.h>
+#include <asm/softirq_stack.h>
 #include "entry.h"
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct irq_stat, irq_stat);
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7ac847ca6356..e798e55915c2 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -54,6 +54,7 @@ config SUPERH
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_UID16
+	select HAVE_SOFTIRQ_ON_OWN_STACK if IRQSTACKS
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_FORCED_THREADING
diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
index 6d44c32ef047..839551ce398c 100644
--- a/arch/sh/include/asm/irq.h
+++ b/arch/sh/include/asm/irq.h
@@ -51,7 +51,6 @@ asmlinkage int do_IRQ(unsigned int irq, struct pt_regs *regs);
 #ifdef CONFIG_IRQSTACKS
 extern void irq_ctx_init(int cpu);
 extern void irq_ctx_exit(int cpu);
-# define __ARCH_HAS_DO_SOFTIRQ
 #else
 # define irq_ctx_init(cpu) do { } while (0)
 # define irq_ctx_exit(cpu) do { } while (0)
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index ab5f790b0cd2..ef0f0827cf57 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -20,6 +20,7 @@
 #include <linux/uaccess.h>
 #include <asm/thread_info.h>
 #include <cpu/mmu_context.h>
+#include <asm/softirq_stack.h>
 
 atomic_t irq_err_count;
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 5993eb544d35..164a5254c91c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -96,6 +96,7 @@ config SPARC64
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
 	select ARCH_HAS_GIGANTIC_PAGE
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index 4d748e93b974..154df2cf19f4 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -93,7 +93,6 @@ void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
 
 extern void *hardirq_stack[NR_CPUS];
 extern void *softirq_stack[NR_CPUS];
-#define __ARCH_HAS_DO_SOFTIRQ
 
 #define NO_IRQ		0xffffffff
 
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 3ec9f1402aad..c8848bb681a1 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -42,6 +42,7 @@
 #include <asm/head.h>
 #include <asm/hypervisor.h>
 #include <asm/cacheflush.h>
+#include <asm/softirq_stack.h>
 
 #include "entry.h"
 #include "cpumap.h"
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index a58811dc054c..d7492e5a1bbb 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -20,6 +20,7 @@ generic-y += param.h
 generic-y += pci.h
 generic-y += percpu.h
 generic-y += preempt.h
+generic-y += softirq_stack.h
 generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3b2102024906..cd4b9b1204a8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -191,6 +191,7 @@ config X86
 	select HAVE_HW_BREAKPOINT
 	select HAVE_IDE
 	select HAVE_IOREMAP_PROT
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
@@ -223,6 +224,7 @@ config X86
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_STATIC_CALL
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 0904f5676e4d..a2433ae8a65e 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -249,30 +249,23 @@ static __always_inline bool get_and_clear_inhcall(void) { return false; }
 static __always_inline void restore_inhcall(bool inhcall) { }
 #endif
 
-static void __xen_pv_evtchn_do_upcall(void)
+static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 {
-	irq_enter_rcu();
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
 	inc_irq_stat(irq_hv_callback_count);
 
 	xen_hvm_evtchn_do_upcall();
 
-	irq_exit_rcu();
+	set_irq_regs(old_regs);
 }
 
 __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs;
+	irqentry_state_t state = irqentry_enter(regs);
 	bool inhcall;
-	irqentry_state_t state;
 
-	state = irqentry_enter(regs);
-	old_regs = set_irq_regs(regs);
-
-	instrumentation_begin();
-	run_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
-	instrumentation_begin();
-
-	set_irq_regs(old_regs);
+	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ce0464d630a2..400908dff42e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -754,47 +754,6 @@ SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
 SYM_CODE_END(.Lbad_gs)
 	.previous
 
-/*
- * rdi: New stack pointer points to the top word of the stack
- * rsi: Function pointer
- * rdx: Function argument (can be NULL if none)
- */
-SYM_FUNC_START(asm_call_on_stack)
-SYM_INNER_LABEL(asm_call_sysvec_on_stack, SYM_L_GLOBAL)
-SYM_INNER_LABEL(asm_call_irq_on_stack, SYM_L_GLOBAL)
-	/*
-	 * Save the frame pointer unconditionally. This allows the ORC
-	 * unwinder to handle the stack switch.
-	 */
-	pushq		%rbp
-	mov		%rsp, %rbp
-
-	/*
-	 * The unwinder relies on the word at the top of the new stack
-	 * page linking back to the previous RSP.
-	 */
-	mov		%rsp, (%rdi)
-	mov		%rdi, %rsp
-	/* Move the argument to the right place */
-	mov		%rdx, %rdi
-
-1:
-	.pushsection .discard.instr_begin
-	.long 1b - .
-	.popsection
-
-	CALL_NOSPEC	rsi
-
-2:
-	.pushsection .discard.instr_end
-	.long 2b - .
-	.popsection
-
-	/* Restore the previous stack pointer from RBP. */
-	leaveq
-	ret
-SYM_FUNC_END(asm_call_on_stack)
-
 #ifdef CONFIG_XEN_PV
 /*
  * A note on the "critical region" in our callback handler.
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 41e2e2e1b439..5eb3bdf36a41 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -187,23 +187,22 @@ __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
  * has to be done in the function body if necessary.
  */
 #define DEFINE_IDTENTRY_IRQ(func)					\
-static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
+static void __##func(struct pt_regs *regs, u32 vector);			\
 									\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
+	u32 vector = (u32)(u8)error_code;				\
 									\
 	instrumentation_begin();					\
-	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
-	__##func (regs, (u8)error_code);				\
-	irq_exit_rcu();							\
+	run_irq_on_irqstack_cond(__##func, regs, vector);		\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
 }									\
 									\
-static __always_inline void __##func(struct pt_regs *regs, u8 vector)
+static noinline void __##func(struct pt_regs *regs, u32 vector)
 
 /**
  * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
@@ -237,10 +236,8 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
-	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_sysvec_on_irqstack_cond(__##func, regs);			\
-	irq_exit_rcu();							\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
 }									\
diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 76d389691b5b..768aa234cbb4 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -25,8 +25,6 @@ static inline int irq_canonicalize(int irq)
 
 extern int irq_init_percpu_irqstack(unsigned int cpu);
 
-#define __ARCH_HAS_DO_SOFTIRQ
-
 struct irq_desc;
 
 extern void fixup_irqs(void);
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 775816965c6a..9b2a0ff76c73 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -7,100 +7,217 @@
 #include <asm/processor.h>
 
 #ifdef CONFIG_X86_64
-static __always_inline bool irqstack_active(void)
-{
-	return __this_cpu_read(irq_count) != -1;
-}
-
-void asm_call_on_stack(void *sp, void (*func)(void), void *arg);
-void asm_call_sysvec_on_stack(void *sp, void (*func)(struct pt_regs *regs),
-			      struct pt_regs *regs);
-void asm_call_irq_on_stack(void *sp, void (*func)(struct irq_desc *desc),
-			   struct irq_desc *desc);
 
-static __always_inline void __run_on_irqstack(void (*func)(void))
-{
-	void *tos = __this_cpu_read(hardirq_stack_ptr);
-
-	__this_cpu_add(irq_count, 1);
-	asm_call_on_stack(tos - 8, func, NULL);
-	__this_cpu_sub(irq_count, 1);
+/*
+ * Macro to inline switching to an interrupt stack and invoking function
+ * calls from there. The following rules apply:
+ *
+ * - Ordering:
+ *
+ *   1. Write the stack pointer into the top most place of the irq
+ *	stack. This ensures that the various unwinders can link back to the
+ *	original stack.
+ *
+ *   2. Switch the stack pointer to the top of the irq stack.
+ *
+ *   3. Invoke whatever needs to be done (@asm_call argument)
+ *
+ *   4. Pop the original stack pointer from the top of the irq stack
+ *	which brings it back to the original stack where it left off.
+ *
+ * - Function invocation:
+ *
+ *   To allow flexible usage of the macro, the actual function code including
+ *   the store of the arguments in the call ABI registers is handed in via
+ *   the @asm_call argument.
+ *
+ * - Local variables:
+ *
+ *   @tos:
+ *	The @tos variable holds a pointer to the top of the irq stack and
+ *	_must_ be allocated in a non-callee saved register as this is a
+ *	restriction coming from objtool.
+ *
+ *	Note, that (tos) is both in input and output constraints to ensure
+ *	that the compiler does not assume that R11 is left untouched in
+ *	case this macro is used in some place where the per cpu interrupt
+ *	stack pointer is used again afterwards
+ *
+ * - Function arguments:
+ *	The function argument(s), if any, have to be defined in register
+ *	variables at the place where this is invoked. Storing the
+ *	argument(s) in the proper register(s) is part of the @asm_call
+ *
+ * - Constraints:
+ *
+ *   The constraints have to be done very carefully because the compiler
+ *   does not know about the assembly call.
+ *
+ *   output:
+ *     As documented already above the @tos variable is required to be in
+ *     the output constraints to make the compiler aware that R11 cannot be
+ *     reused after the asm() statement.
+ *
+ *     For builds with CONFIG_UNWIND_FRAME_POINTER ASM_CALL_CONSTRAINT is
+ *     required as well as this prevents certain creative GCC variants from
+ *     misplacing the ASM code.
+ *
+ *  input:
+ *    - func:
+ *	  Immediate, which tells the compiler that the function is referenced.
+ *
+ *    - tos:
+ *	  Register. The actual register is defined by the variable declaration.
+ *
+ *    - function arguments:
+ *	  The constraints are handed in via the 'argconstr' argument list. They
+ *	  describe the register arguments which are used in @asm_call.
+ *
+ *  clobbers:
+ *     Function calls can clobber anything except the callee-saved
+ *     registers. Tell the compiler.
+ */
+#define call_on_irqstack(func, asm_call, argconstr...)			\
+{									\
+	register void *tos asm("r11");					\
+									\
+	tos = ((void *)__this_cpu_read(hardirq_stack_ptr));		\
+									\
+	asm_inline volatile(						\
+	"movq	%%rsp, (%[tos])				\n"		\
+	"movq	%[tos], %%rsp				\n"		\
+									\
+	asm_call							\
+									\
+	"popq	%%rsp					\n"		\
+									\
+	: "+r" (tos), ASM_CALL_CONSTRAINT				\
+	: [__func] "i" (func), [tos] "r" (tos) argconstr		\
+	: "cc", "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10",	\
+	  "memory"							\
+	);								\
 }
 
-static __always_inline void
-__run_sysvec_on_irqstack(void (*func)(struct pt_regs *regs),
-			 struct pt_regs *regs)
-{
-	void *tos = __this_cpu_read(hardirq_stack_ptr);
-
-	__this_cpu_add(irq_count, 1);
-	asm_call_sysvec_on_stack(tos - 8, func, regs);
-	__this_cpu_sub(irq_count, 1);
+/* Macros to assert type correctness for run_*_on_irqstack macros */
+#define assert_function_type(func, proto)				\
+	static_assert(__builtin_types_compatible_p(typeof(&func), proto))
+
+#define assert_arg_type(arg, proto)					\
+	static_assert(__builtin_types_compatible_p(typeof(arg), proto))
+
+/*
+ * Macro to invoke system vector and device interrupt C handlers.
+ */
+#define call_on_irqstack_cond(func, regs, asm_call, constr, c_args...)	\
+{									\
+	/*								\
+	 * User mode entry and interrupt on the irq stack do not	\
+	 * switch stacks. If from user mode the task stack is empty.	\
+	 */								\
+	if (user_mode(regs) || __this_cpu_read(hardirq_stack_inuse)) {	\
+		irq_enter_rcu();					\
+		func(c_args);						\
+		irq_exit_rcu();						\
+	} else {							\
+		/*							\
+		 * Mark the irq stack inuse _before_ and unmark _after_	\
+		 * switching stacks. Interrupts are disabled in both	\
+		 * places. Invoke the stack switch macro with the call	\
+		 * sequence which matches the above direct invocation.	\
+		 */							\
+		__this_cpu_write(hardirq_stack_inuse, true);		\
+		call_on_irqstack(func, asm_call, constr);		\
+		__this_cpu_write(hardirq_stack_inuse, false);		\
+	}								\
 }
 
-static __always_inline void
-__run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
-		      struct irq_desc *desc)
-{
-	void *tos = __this_cpu_read(hardirq_stack_ptr);
-
-	__this_cpu_add(irq_count, 1);
-	asm_call_irq_on_stack(tos - 8, func, desc);
-	__this_cpu_sub(irq_count, 1);
+/*
+ * Function call sequence for __call_on_irqstack() for system vectors.
+ *
+ * Note that irq_enter_rcu() and irq_exit_rcu() do not use the input
+ * mechanism because these functions are global and cannot be optimized out
+ * when compiling a particular source file which uses one of these macros.
+ *
+ * The argument (regs) does not need to be pushed or stashed in a callee
+ * saved register to be safe vs. the irq_enter_rcu() call because the
+ * clobbers already prevent the compiler from storing it in a callee
+ * clobbered register. As the compiler has to preserve @regs for the final
+ * call to idtentry_exit() anyway, it's likely that it does not cause extra
+ * effort for this asm magic.
+ */
+#define ASM_CALL_SYSVEC							\
+	"call irq_enter_rcu				\n"		\
+	"movq	%[arg1], %%rdi				\n"		\
+	"call %P[__func]				\n"		\
+	"call irq_exit_rcu				\n"
+
+#define SYSVEC_CONSTRAINTS	, [arg1] "r" (regs)
+
+#define run_sysvec_on_irqstack_cond(func, regs)				\
+{									\
+	assert_function_type(func, void (*)(struct pt_regs *));		\
+	assert_arg_type(regs, struct pt_regs *);			\
+									\
+	call_on_irqstack_cond(func, regs, ASM_CALL_SYSVEC,		\
+			      SYSVEC_CONSTRAINTS, regs);		\
 }
 
-#else /* CONFIG_X86_64 */
-static inline bool irqstack_active(void) { return false; }
-static inline void __run_on_irqstack(void (*func)(void)) { }
-static inline void __run_sysvec_on_irqstack(void (*func)(struct pt_regs *regs),
-					    struct pt_regs *regs) { }
-static inline void __run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
-					 struct irq_desc *desc) { }
-#endif /* !CONFIG_X86_64 */
-
-static __always_inline bool irq_needs_irq_stack(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		return false;
-	if (!regs)
-		return !irqstack_active();
-	return !user_mode(regs) && !irqstack_active();
+/*
+ * As in ASM_CALL_SYSVEC above the clobbers force the compiler to store
+ * @regs and @vector in callee saved registers.
+ */
+#define ASM_CALL_IRQ							\
+	"call irq_enter_rcu				\n"		\
+	"movq	%[arg1], %%rdi				\n"		\
+	"movl	%[arg2], %%esi				\n"		\
+	"call %P[__func]				\n"		\
+	"call irq_exit_rcu				\n"
+
+#define IRQ_CONSTRAINTS	, [arg1] "r" (regs), [arg2] "r" (vector)
+
+#define run_irq_on_irqstack_cond(func, regs, vector)			\
+{									\
+	assert_function_type(func, void (*)(struct pt_regs *, u32));	\
+	assert_arg_type(regs, struct pt_regs *);			\
+	assert_arg_type(vector, u32);					\
+									\
+	call_on_irqstack_cond(func, regs, ASM_CALL_IRQ,			\
+			      IRQ_CONSTRAINTS, regs, vector);		\
 }
 
-
-static __always_inline void run_on_irqstack_cond(void (*func)(void),
-						 struct pt_regs *regs)
-{
-	lockdep_assert_irqs_disabled();
-
-	if (irq_needs_irq_stack(regs))
-		__run_on_irqstack(func);
-	else
-		func();
+#define ASM_CALL_SOFTIRQ						\
+	"call %P[__func]				\n"
+
+/*
+ * Macro to invoke __do_softirq on the irq stack. This is only called from
+ * task context when bottom halfs are about to be reenabled and soft
+ * interrupts are pending to be processed. The interrupt stack cannot be in
+ * use here.
+ */
+#define do_softirq_own_stack()						\
+{									\
+	__this_cpu_write(hardirq_stack_inuse, true);			\
+	call_on_irqstack(__do_softirq, ASM_CALL_SOFTIRQ);		\
+	__this_cpu_write(hardirq_stack_inuse, false);			\
 }
 
-static __always_inline void
-run_sysvec_on_irqstack_cond(void (*func)(struct pt_regs *regs),
-			    struct pt_regs *regs)
-{
-	lockdep_assert_irqs_disabled();
-
-	if (irq_needs_irq_stack(regs))
-		__run_sysvec_on_irqstack(func, regs);
-	else
-		func(regs);
+#else /* CONFIG_X86_64 */
+/* System vector handlers always run on the stack they interrupted. */
+#define run_sysvec_on_irqstack_cond(func, regs)				\
+{									\
+	irq_enter_rcu();						\
+	func(regs);							\
+	irq_exit_rcu();							\
 }
 
-static __always_inline void
-run_irq_on_irqstack_cond(void (*func)(struct irq_desc *desc), struct irq_desc *desc,
-			 struct pt_regs *regs)
-{
-	lockdep_assert_irqs_disabled();
-
-	if (irq_needs_irq_stack(regs))
-		__run_irq_on_irqstack(func, desc);
-	else
-		func(desc);
+/* Switches to the irq stack within func() */
+#define run_irq_on_irqstack_cond(func, regs, vector)			\
+{									\
+	irq_enter_rcu();						\
+	func(regs, vector);						\
+	irq_exit_rcu();							\
 }
 
+#endif /* !CONFIG_X86_64 */
+
 #endif
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c20a52b5534b..dc6d149bf851 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -426,8 +426,6 @@ struct irq_stack {
 	char		stack[IRQ_STACK_SIZE];
 } __aligned(IRQ_STACK_SIZE);
 
-DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
-
 #ifdef CONFIG_X86_32
 DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
 #else
@@ -454,7 +452,8 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
 }
 
-DECLARE_PER_CPU(unsigned int, irq_count);
+DECLARE_PER_CPU(void *, hardirq_stack_ptr);
+DECLARE_PER_CPU(bool, hardirq_stack_inuse);
 extern asmlinkage void ignore_sysret(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
@@ -473,9 +472,9 @@ struct stack_canary {
 };
 DECLARE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
 #endif
-/* Per CPU softirq stack pointer */
+DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
-#endif	/* X86_64 */
+#endif	/* !X86_64 */
 
 extern unsigned int fpu_kernel_xstate_size;
 extern unsigned int fpu_user_xstate_size;
diff --git a/arch/x86/include/asm/softirq_stack.h b/arch/x86/include/asm/softirq_stack.h
new file mode 100644
index 000000000000..889d53d6a0e1
--- /dev/null
+++ b/arch/x86/include/asm/softirq_stack.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SOFTIRQ_STACK_H
+#define _ASM_X86_SOFTIRQ_STACK_H
+
+#ifdef CONFIG_X86_64
+# include <asm/irq_stack.h>
+#else
+# include <asm-generic/softirq_stack.h>
+#endif
+
+#endif
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 819db00c9388..bda4f2a36868 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2138,18 +2138,11 @@ void __init register_lapic_address(unsigned long address)
  * Local APIC interrupts
  */
 
-/**
- * spurious_interrupt - Catch all for interrupts raised on unused vectors
- * @regs:	Pointer to pt_regs on stack
- * @vector:	The vector number
- *
- * This is invoked from ASM entry code to catch all interrupts which
- * trigger on an entry which is routed to the common_spurious idtentry
- * point.
- *
- * Also called from sysvec_spurious_apic_interrupt().
+/*
+ * Common handling code for spurious_interrupt and spurious_vector entry
+ * points below. No point in allowing the compiler to inline it twice.
  */
-DEFINE_IDTENTRY_IRQ(spurious_interrupt)
+static noinline void handle_spurious_interrupt(u8 vector)
 {
 	u32 v;
 
@@ -2184,9 +2177,23 @@ DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 	trace_spurious_apic_exit(vector);
 }
 
+/**
+ * spurious_interrupt - Catch all for interrupts raised on unused vectors
+ * @regs:	Pointer to pt_regs on stack
+ * @vector:	The vector number
+ *
+ * This is invoked from ASM entry code to catch all interrupts which
+ * trigger on an entry which is routed to the common_spurious idtentry
+ * point.
+ */
+DEFINE_IDTENTRY_IRQ(spurious_interrupt)
+{
+	handle_spurious_interrupt(vector);
+}
+
 DEFINE_IDTENTRY_SYSVEC(sysvec_spurious_apic_interrupt)
 {
-	__spurious_interrupt(regs, SPURIOUS_APIC_VECTOR);
+	handle_spurious_interrupt(SPURIOUS_APIC_VECTOR);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9215b91bc044..ab640abe26b6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1742,8 +1742,8 @@ DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned =
 	&init_task;
 EXPORT_PER_CPU_SYMBOL(current_task);
 
-DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
-DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
+DEFINE_PER_CPU(void *, hardirq_stack_ptr);
+DEFINE_PER_CPU(bool, hardirq_stack_inuse);
 
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 1dd851397bd9..5601b95944fa 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -128,12 +128,21 @@ static __always_inline bool in_exception_stack(unsigned long *stack, struct stac
 
 static __always_inline bool in_irq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *end   = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
-	unsigned long *begin = end - (IRQ_STACK_SIZE / sizeof(long));
+	unsigned long *end = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
+	unsigned long *begin;
 
 	/*
-	 * This is a software stack, so 'end' can be a valid stack pointer.
-	 * It just means the stack is empty.
+	 * @end points directly to the top most stack entry to avoid a -8
+	 * adjustment in the stack switch hotpath. Adjust it back before
+	 * calculating @begin.
+	 */
+	end++;
+	begin = end - (IRQ_STACK_SIZE / sizeof(long));
+
+	/*
+	 * Due to the switching logic RSP can never be == @end because the
+	 * final operation is 'popq %rsp' which means after that RSP points
+	 * to the original stack and not to @end.
 	 */
 	if (stack < begin || stack >= end)
 		return false;
@@ -143,8 +152,9 @@ static __always_inline bool in_irq_stack(unsigned long *stack, struct stack_info
 	info->end	= end;
 
 	/*
-	 * The next stack pointer is the first thing pushed by the entry code
-	 * after switching to the irq stack.
+	 * The next stack pointer is stored at the top of the irq stack
+	 * before switching to the irq stack. Actual stack entries are all
+	 * below that.
 	 */
 	info->next_sp = (unsigned long *)*(end - 1);
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index d4ad344e80bf..58aa712973ac 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -228,7 +228,7 @@ static __always_inline void handle_irq(struct irq_desc *desc,
 				       struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_X86_64))
-		run_irq_on_irqstack_cond(desc->handle_irq, desc, regs);
+		generic_handle_irq_desc(desc);
 	else
 		__handle_irq(desc, regs);
 }
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index 0b79efc87be5..044902d5a3c4 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -22,6 +22,7 @@
 
 #include <asm/apic.h>
 #include <asm/nospec-branch.h>
+#include <asm/softirq_stack.h>
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 440eed558558..1c0fb96b9e39 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -20,6 +20,7 @@
 #include <linux/sched/task_stack.h>
 
 #include <asm/cpu_entry_area.h>
+#include <asm/softirq_stack.h>
 #include <asm/irq_stack.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -48,7 +49,8 @@ static int map_irq_stack(unsigned int cpu)
 	if (!va)
 		return -ENOMEM;
 
-	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
+	/* Store actual TOS to avoid adjustment in the hotpath */
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #else
@@ -60,7 +62,8 @@ static int map_irq_stack(unsigned int cpu)
 {
 	void *va = per_cpu_ptr(&irq_stack_backing_store, cpu);
 
-	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
+	/* Store actual TOS to avoid adjustment in the hotpath */
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #endif
@@ -71,8 +74,3 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 		return 0;
 	return map_irq_stack(cpu);
 }
-
-void do_softirq_own_stack(void)
-{
-	run_on_irqstack_cond(__do_softirq, NULL);
-}
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ad582f9ac5a6..d08307df69ad 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -539,7 +539,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	int cpu = smp_processor_id();
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
-		     this_cpu_read(irq_count) != -1);
+		     this_cpu_read(hardirq_stack_inuse));
 
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
 		switch_fpu_prepare(prev_fpu, cpu);
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 7282c0f50c85..302506bbc2a4 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -50,6 +50,7 @@ mandatory-y += sections.h
 mandatory-y += serial.h
 mandatory-y += shmparam.h
 mandatory-y += simd.h
+mandatory-y += softirq_stack.h
 mandatory-y += switch_to.h
 mandatory-y += timex.h
 mandatory-y += tlbflush.h
diff --git a/include/asm-generic/softirq_stack.h b/include/asm-generic/softirq_stack.h
new file mode 100644
index 000000000000..eceeecf6a5bd
--- /dev/null
+++ b/include/asm-generic/softirq_stack.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __ASM_GENERIC_SOFTIRQ_STACK_H
+#define __ASM_GENERIC_SOFTIRQ_STACK_H
+
+#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
+void do_softirq_own_stack(void);
+#else
+static inline void do_softirq_own_stack(void)
+{
+	__do_softirq();
+}
+#endif
+
+#endif
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index bb8ff9083e7d..967e25767153 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -569,15 +569,6 @@ struct softirq_action
 asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
 
-#ifdef __ARCH_HAS_DO_SOFTIRQ
-void do_softirq_own_stack(void);
-#else
-static inline void do_softirq_own_stack(void)
-{
-	__do_softirq();
-}
-#endif
-
 extern void open_softirq(int nr, void (*action)(struct softirq_action *));
 extern void softirq_init(void);
 extern void __raise_softirq_irqoff(unsigned int nr);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9d71046ea247..9908ec4a9bfe 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -26,6 +26,8 @@
 #include <linux/tick.h>
 #include <linux/irq.h>
 
+#include <asm/softirq_stack.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 080a3d6cbd75..8beca861fd14 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2084,6 +2084,20 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				}
 			}
 
+			else if (op->dest.reg == CFI_SP &&
+				 cfi->vals[op->src.reg].base == CFI_SP_INDIRECT &&
+				 cfi->vals[op->src.reg].offset == cfa->offset) {
+
+				/*
+				 * The same stack swizzle case 2) as above. But
+				 * because we can't change cfa->base, case 3)
+				 * will become a regular POP. Pretend we're a
+				 * PUSH so things don't go unbalanced.
+				 */
+				cfi->stack_size += 8;
+			}
+
+
 			break;
 
 		case OP_SRC_ADD:


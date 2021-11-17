Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EABC45482C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbhKQOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:10:51 -0500
Received: from foss.arm.com ([217.140.110.172]:57144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233775AbhKQOKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:10:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 504DCED1;
        Wed, 17 Nov 2021 06:07:52 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B92173F70D;
        Wed, 17 Nov 2021 06:07:49 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aou@eecs.berkeley.edu, borntraeger@de.ibm.com, bp@alien8.de,
        broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, palmer@dabbelt.com, paul.walmsley@sifive.com,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCH 1/9] arch: Make ARCH_STACKWALK independent of STACKTRACE
Date:   Wed, 17 Nov 2021 14:07:29 +0000
Message-Id: <20211117140737.44420-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211117140737.44420-1-mark.rutland@arm.com>
References: <20211117140737.44420-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Make arch_stack_walk() available for ARCH_STACKWALK architectures
without it being entangled in STACKTRACE.

Link: https://lore.kernel.org/lkml/20211022152104.356586621@infradead.org/
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[Mark: rebase, drop unnecessary arm change]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/arm64/kernel/stacktrace.c |  4 ----
 arch/powerpc/kernel/Makefile   |  3 +--
 arch/riscv/kernel/stacktrace.c |  4 ----
 arch/s390/kernel/Makefile      |  3 +--
 arch/x86/kernel/Makefile       |  2 +-
 include/linux/stacktrace.h     | 35 ++++++++++++++++++-----------------
 6 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 94f83cd44e50..e6ba6b000564 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -221,8 +221,6 @@ void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
 	barrier();
 }
 
-#ifdef CONFIG_STACKTRACE
-
 noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 			      void *cookie, struct task_struct *task,
 			      struct pt_regs *regs)
@@ -241,5 +239,3 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 
 	walk_stackframe(task, &frame, consume_entry, cookie);
 }
-
-#endif
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 0e3640e14eb1..992cdd03c376 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -47,7 +47,7 @@ obj-y				:= cputable.o syscalls.o \
 				   udbg.o misc.o io.o misc_$(BITS).o \
 				   of_platform.o prom_parse.o firmware.o \
 				   hw_breakpoint_constraints.o interrupt.o \
-				   kdebugfs.o
+				   kdebugfs.o stacktrace.o
 obj-y				+= ptrace/
 obj-$(CONFIG_PPC64)		+= setup_64.o \
 				   paca.o nvram_64.o note.o
@@ -116,7 +116,6 @@ obj-$(CONFIG_OPTPROBES)		+= optprobes.o optprobes_head.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= kprobes-ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
-obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
 obj-$(CONFIG_ARCH_HAS_DMA_SET_MASK) += dma-mask.o
 
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 0fcdc0233fac..201ee206fb57 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -139,12 +139,8 @@ unsigned long __get_wchan(struct task_struct *task)
 	return pc;
 }
 
-#ifdef CONFIG_STACKTRACE
-
 noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 		     struct task_struct *task, struct pt_regs *regs)
 {
 	walk_stackframe(task, regs, consume_entry, cookie);
 }
-
-#endif /* CONFIG_STACKTRACE */
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 80f500ffb55c..be8007f367aa 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -40,7 +40,7 @@ obj-y	+= sysinfo.o lgr.o os_info.o machine_kexec.o
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
 obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
 obj-y	+= nospec-branch.o ipl_vmparm.o machine_kexec_reloc.o unwind_bc.o
-obj-y	+= smp.o text_amode31.o
+obj-y	+= smp.o text_amode31.o stacktrace.o
 
 extra-y				+= head64.o vmlinux.lds
 
@@ -55,7 +55,6 @@ compat-obj-$(CONFIG_AUDIT)	+= compat_audit.o
 obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o
 obj-$(CONFIG_COMPAT)		+= $(compat-obj-y)
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
-obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_KPROBES)		+= kprobes_insn_page.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 2ff3e600f426..6aef9ee28a39 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -84,7 +84,7 @@ obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
-obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
+obj-y				+= stacktrace.o
 obj-y				+= cpu/
 obj-y				+= acpi/
 obj-y				+= reboot.o
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index bef158815e83..97455880ac41 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -8,22 +8,6 @@
 struct task_struct;
 struct pt_regs;
 
-#ifdef CONFIG_STACKTRACE
-void stack_trace_print(const unsigned long *trace, unsigned int nr_entries,
-		       int spaces);
-int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
-			unsigned int nr_entries, int spaces);
-unsigned int stack_trace_save(unsigned long *store, unsigned int size,
-			      unsigned int skipnr);
-unsigned int stack_trace_save_tsk(struct task_struct *task,
-				  unsigned long *store, unsigned int size,
-				  unsigned int skipnr);
-unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
-				   unsigned int size, unsigned int skipnr);
-unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
-unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries);
-
-/* Internal interfaces. Do not use in generic code */
 #ifdef CONFIG_ARCH_STACKWALK
 
 /**
@@ -76,8 +60,25 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
 
 void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 			  const struct pt_regs *regs);
+#endif /* CONFIG_ARCH_STACKWALK */
 
-#else /* CONFIG_ARCH_STACKWALK */
+#ifdef CONFIG_STACKTRACE
+void stack_trace_print(const unsigned long *trace, unsigned int nr_entries,
+		       int spaces);
+int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
+			unsigned int nr_entries, int spaces);
+unsigned int stack_trace_save(unsigned long *store, unsigned int size,
+			      unsigned int skipnr);
+unsigned int stack_trace_save_tsk(struct task_struct *task,
+				  unsigned long *store, unsigned int size,
+				  unsigned int skipnr);
+unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
+				   unsigned int size, unsigned int skipnr);
+unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
+unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries);
+
+#ifndef CONFIG_ARCH_STACKWALK
+/* Internal interfaces. Do not use in generic code */
 struct stack_trace {
 	unsigned int nr_entries, max_entries;
 	unsigned long *entries;
-- 
2.11.0


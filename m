Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68247315CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhBJCL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbhBJA4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:56:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ECBC06178C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 16:53:41 -0800 (PST)
Message-Id: <20210210002513.181713427@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612918419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WKq3GCcYkMbymQHJPYIDVqNf1n+hrUsEGvAShKjJmQE=;
        b=0WQgQTOo+nkbMSdWh5br+KqPlLf1R8aq6yfIizK9/KdNn7ZMxVHjJPPMktI3ff73HuqliG
        +NbzC7NyUUja1fBqtCUNg4hzFWUqOMcVNQ77s9ACOKAIFa7lpJ0WSAJKNojOi7qLlNLieN
        wNzIbXeuTjEu0Zc1lcRaK3tjZucieJZ+gF+bdOsltn+CrxQJ2txNSOpT8+1bUjbsRHtGMI
        1xlpTSziUDBHSwZ0Yr9bqOmf4/1yEYlLPkhN91RTqv4TALQ6M4314e1xlc2kMZadFp9r/V
        owovAShrM+peDo/b8Mc0vZ5wuna139nhsrnL/ff+keYRrOizptkD33+NATtxgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612918419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WKq3GCcYkMbymQHJPYIDVqNf1n+hrUsEGvAShKjJmQE=;
        b=Yst+O9vmy2fZbJJ36FPzLCcUE3Qk0Vxs37Z1D3ZVEx0BqjEiRzZYleQHeG/NSeyZDclszu
        VB+EM4I+sZFNs5Cg==
Date:   Wed, 10 Feb 2021 00:40:52 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Lai Jiangshan <jiangshanlai+lkml@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch V2 11/13] softirq: Move __ARCH_HAS_DO_SOFTIRQ to Kconfig
References: <20210209234041.127454039@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for inlining do_softirq_own_stack() replace
__ARCH_HAS_DO_SOFTIRQ with a Kconfig switch and select it in the affected
architectures.

This allows in the next step to move the function prototype and the inline
stub into a seperate asm-generic header file which is required to avoid
include recursion.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Lai Jiangshan <jiangshanlai+lkml@gmail.com>
---
V2: New patch to get rid of the nested #ifdeffery - Lai
---
 arch/Kconfig                      |    6 ++++++
 arch/parisc/Kconfig               |    1 +
 arch/parisc/include/asm/hardirq.h |    4 ----
 arch/powerpc/Kconfig              |    1 +
 arch/powerpc/include/asm/irq.h    |    2 --
 arch/s390/Kconfig                 |    1 +
 arch/s390/include/asm/hardirq.h   |    1 -
 arch/sh/Kconfig                   |    1 +
 arch/sh/include/asm/irq.h         |    1 -
 arch/sparc/Kconfig                |    1 +
 arch/sparc/include/asm/irq_64.h   |    1 -
 arch/x86/Kconfig                  |    1 +
 arch/x86/include/asm/irq.h        |    2 --
 include/linux/interrupt.h         |    2 +-
 14 files changed, 13 insertions(+), 12 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -759,6 +759,12 @@ config HAVE_IRQ_EXIT_ON_IRQ_STACK
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
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -63,6 +63,7 @@ config PARISC
 	select HAVE_FTRACE_MCOUNT_RECORD if HAVE_DYNAMIC_FTRACE
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
+	select HAVE_SOFTIRQ_ON_OWN_STACK if IRQSTACKS
 	select SET_FS
 
 	help
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
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -237,6 +237,7 @@ config PPC
 	select MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_IRQ_TIME_ACCOUNTING
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -37,8 +37,6 @@ extern int distribute_irqs;
 
 struct pt_regs;
 
-#define __ARCH_HAS_DO_SOFTIRQ
-
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 /*
  * Per-cpu stacks for handling critical, debug and machine check
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -182,6 +182,7 @@ config S390
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -18,7 +18,6 @@
 #define or_softirq_pending(x)  (S390_lowcore.softirq_pending |= (x))
 
 #define __ARCH_IRQ_STAT
-#define __ARCH_HAS_DO_SOFTIRQ
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
 
 static inline void ack_bad_irq(unsigned int irq)
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -55,6 +55,7 @@ config SUPERH
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_UID16
+	select HAVE_SOFTIRQ_ON_OWN_STACK if IRQSTACKS
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_FORCED_THREADING
--- a/arch/sh/include/asm/irq.h
+++ b/arch/sh/include/asm/irq.h
@@ -51,7 +51,6 @@ asmlinkage int do_IRQ(unsigned int irq,
 #ifdef CONFIG_IRQSTACKS
 extern void irq_ctx_init(int cpu);
 extern void irq_ctx_exit(int cpu);
-# define __ARCH_HAS_DO_SOFTIRQ
 #else
 # define irq_ctx_init(cpu) do { } while (0)
 # define irq_ctx_exit(cpu) do { } while (0)
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -97,6 +97,7 @@ config SPARC64
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
 	select ARCH_HAS_GIGANTIC_PAGE
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -93,7 +93,6 @@ void arch_trigger_cpumask_backtrace(cons
 
 extern void *hardirq_stack[NR_CPUS];
 extern void *softirq_stack[NR_CPUS];
-#define __ARCH_HAS_DO_SOFTIRQ
 
 #define NO_IRQ		0xffffffff
 
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -221,6 +221,7 @@ config X86
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_STATIC_CALL
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -25,8 +25,6 @@ static inline int irq_canonicalize(int i
 
 extern int irq_init_percpu_irqstack(unsigned int cpu);
 
-#define __ARCH_HAS_DO_SOFTIRQ
-
 struct irq_desc;
 
 extern void fixup_irqs(void);
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -569,7 +569,7 @@ struct softirq_action
 asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
 
-#ifdef __ARCH_HAS_DO_SOFTIRQ
+#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void);
 #else
 static inline void do_softirq_own_stack(void)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654C443AF05
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhJZJ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:28:33 -0400
Received: from foss.arm.com ([217.140.110.172]:55638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234984AbhJZJ2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:28:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D4BD1FB;
        Tue, 26 Oct 2021 02:25:56 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 805273F70D;
        Tue, 26 Oct 2021 02:25:53 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, maz@kernel.org, nickhu@andestech.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vgupta@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org
Subject: [PATCH v2 12/17] irq: arm64: perform irqentry in entry code
Date:   Tue, 26 Oct 2021 10:24:59 +0100
Message-Id: <20211026092504.27071-13-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211026092504.27071-1-mark.rutland@arm.com>
References: <20211026092504.27071-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have arch/arm64
perform all the irqentry accounting in its entry code.

As arch/arm64 already performs portions of the irqentry logic in
enter_from_kernel_mode() and exit_to_kernel_mode(), including
rcu_irq_{enter,exit}(), the only additional calls that need to be made
are to irq_{enter,exit}_rcu(). Removing the calls to
rcu_irq_{enter,exit}() from handle_domain_irq() ensures that we inform
RCU once per IRQ entry and will correctly identify quiescent periods.

Since we should not call irq_{enter,exit}_rcu() when entering a
pseudo-NMI, el1_interrupt() is reworked to have separate __el1_irq() and
__el1_pnmi() paths for regular IRQ and psuedo-NMI entry, with
irq_{enter,exit}_irq() only called for the former.

In preparation for removing HANDLE_DOMAIN_IRQ, the irq regs are managed
in do_interrupt_handler() for both regular IRQ and pseudo-NMI. This is
currently redundant, but not harmful.

For clarity the preemption logic is moved into __el1_irq(). We should
never preempt within a pseudo-NMI, and arm64_enter_nmi() already
enforces this by incrementing the preempt_count, but it's clearer if we
never invoke the preemption logic when entering a pseudo-NMI.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Pingfan Liu <kernelfans@gmail.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig               |  1 -
 arch/arm64/kernel/entry-common.c | 52 ++++++++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 553239a5a5f7..5c7ae4c3954b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -134,7 +134,6 @@ config ARM64
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
 	select HANDLE_DOMAIN_IRQ
-	select HANDLE_DOMAIN_IRQ_IRQENTRY
 	select HARDIRQS_SW_RESEND
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 32f9796c4ffe..f7408edf8571 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -17,6 +17,7 @@
 #include <asm/daifflags.h>
 #include <asm/esr.h>
 #include <asm/exception.h>
+#include <asm/irq_regs.h>
 #include <asm/kprobes.h>
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -219,22 +220,6 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-static void noinstr enter_el1_irq_or_nmi(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
-		arm64_enter_nmi(regs);
-	else
-		enter_from_kernel_mode(regs);
-}
-
-static void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
-		arm64_exit_nmi(regs);
-	else
-		exit_to_kernel_mode(regs);
-}
-
 static void __sched arm64_preempt_schedule_irq(void)
 {
 	lockdep_assert_irqs_disabled();
@@ -263,10 +248,14 @@ static void __sched arm64_preempt_schedule_irq(void)
 static void do_interrupt_handler(struct pt_regs *regs,
 				 void (*handler)(struct pt_regs *))
 {
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
 	if (on_thread_stack())
 		call_on_irq_stack(regs, handler);
 	else
 		handler(regs);
+
+	set_irq_regs(old_regs);
 }
 
 extern void (*handle_arch_irq)(struct pt_regs *);
@@ -432,13 +421,22 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
 	}
 }
 
-static void noinstr el1_interrupt(struct pt_regs *regs,
-				  void (*handler)(struct pt_regs *))
+static __always_inline void __el1_pnmi(struct pt_regs *regs,
+				       void (*handler)(struct pt_regs *))
 {
-	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
+	arm64_enter_nmi(regs);
+	do_interrupt_handler(regs, handler);
+	arm64_exit_nmi(regs);
+}
+
+static __always_inline void __el1_irq(struct pt_regs *regs,
+				      void (*handler)(struct pt_regs *))
+{
+	enter_from_kernel_mode(regs);
 
-	enter_el1_irq_or_nmi(regs);
+	irq_enter_rcu();
 	do_interrupt_handler(regs, handler);
+	irq_exit_rcu();
 
 	/*
 	 * Note: thread_info::preempt_count includes both thread_info::count
@@ -449,7 +447,17 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
 	    READ_ONCE(current_thread_info()->preempt_count) == 0)
 		arm64_preempt_schedule_irq();
 
-	exit_el1_irq_or_nmi(regs);
+	exit_to_kernel_mode(regs);
+}
+static void noinstr el1_interrupt(struct pt_regs *regs,
+				  void (*handler)(struct pt_regs *))
+{
+	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
+
+	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
+		__el1_pnmi(regs, handler);
+	else
+		__el1_irq(regs, handler);
 }
 
 asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
@@ -667,7 +675,9 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
 	if (regs->pc & BIT(55))
 		arm64_apply_bp_hardening();
 
+	irq_enter_rcu();
 	do_interrupt_handler(regs, handler);
+	irq_exit_rcu();
 
 	exit_to_user_mode(regs);
 }
-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7FF43AFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbhJZKSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:18:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60698 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhJZKSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:25 -0400
Date:   Tue, 26 Oct 2021 10:16:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lGewyJdHfgIwB9Qygra0fVtrmjCeMHGmYBJ5ymtx37M=;
        b=txg4Dfv74g1nyzb9TcA51EQF75bsPX8nk/I7QGDvIESpZYptW5b3Dsw8CzXj1NnF6uz1m9
        oJzR/5hnrARxerpKFIs3sspRqgMls7alkityhUAzmQVguktEpJ0ztxNEPvHHxQGX2IGg/T
        OXAt5q9xeuR1htGshcr2DveAriFbeIDOTW8t3NuRX8BsiD1BI9RDQ95G59KRHABk7d/qTx
        cKJgXzzLT8C26jluP0FOkrbZf9L5orn766bQrgA7ZFyr1Dde78NpCVbITaneZbphQ5VIYT
        ABHEWHmqVKSiSBxg9C4mLF/iHoJqijMO/Rbh5cO4uu+xvKLV5RoIzGNuBENeUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lGewyJdHfgIwB9Qygra0fVtrmjCeMHGmYBJ5ymtx37M=;
        b=H63bVUJu5kvBtQxjQG6OwzhIBhurJ9YN/QkwwZDDCAslUjB4Wl4s+EoEs3+nyJ3NRkG7JA
        7DuJ8l5pdXbm57Bg==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: arm64: perform irqentry in entry code
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
MIME-Version: 1.0
Message-ID: <163524336046.626.6427481115469949613.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     26dc129342cfc1e09dcf8473331efcf419a471af
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/26dc129342cfc1e09dcf8473331efcf419a471af
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 19 Oct 2021 18:28:39 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Tue, 26 Oct 2021 10:12:53 +01:00

irq: arm64: perform irqentry in entry code

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
 arch/arm64/Kconfig               |  1 +-
 arch/arm64/kernel/entry-common.c | 52 ++++++++++++++++++-------------
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 553239a..5c7ae4c 100644
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
index 32f9796..f7408ed 100644
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

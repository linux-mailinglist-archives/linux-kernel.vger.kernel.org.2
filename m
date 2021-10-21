Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAAC4369FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhJUSFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:05:42 -0400
Received: from foss.arm.com ([217.140.110.172]:46086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232492AbhJUSFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:05:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18B6FED1;
        Thu, 21 Oct 2021 11:03:21 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A99B3F70D;
        Thu, 21 Oct 2021 11:03:18 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, maz@kernel.org, nickhu@andestech.com,
        palmer@dabbelt.com, paulmck@kernel.org, paul.walmsley@sifive.com,
        peterz@infradead.org, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        torvalds@linux-foundation.org, tsbogend@alpha.franken.de,
        vgupta@kernel.org, will@kernel.org
Subject: [PATCH 09/15] irq: arm: perform irqentry in entry code
Date:   Thu, 21 Oct 2021 19:02:30 +0100
Message-Id: <20211021180236.37428-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211021180236.37428-1-mark.rutland@arm.com>
References: <20211021180236.37428-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have arch/arm
perform all the irqentry accounting in its entry code.

For configurations with CONFIG_GENERIC_IRQ_MULTI_HANDLER, we can use
generic_handle_arch_irq(). Other than asm_do_IRQ(), all C calls to
handle_IRQ() are from irqchip handlers which will be called from
generic_handle_arch_irq(), so to avoid double accounting IRQ entry, the
entry logic is moved from handle_IRQ() into asm_do_IRQ().

For ARMv7M the entry assembly is tightly coupled with the NVIC irqchip, and
while the entry code should logically live under arch/arm/, moving the
entry logic there makes things more convoluted. So for now, place the
entry logic in the NVIC irqchip, but separated into a separate
function to make the split of responsibility clear.

For all other configurations without CONFIG_GENERIC_IRQ_MULTI_HANDLER,
IRQ entry is already handled in arch code, and requires no changes.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/Kconfig             |  1 -
 arch/arm/kernel/entry-armv.S |  5 +----
 arch/arm/kernel/irq.c        | 14 ++++++++------
 drivers/irqchip/irq-nvic.c   | 19 +++++++++++++++++--
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f18aff82c27b..fc196421b2ce 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -65,7 +65,6 @@ config ARM
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select HANDLE_DOMAIN_IRQ
-	select HANDLE_DOMAIN_IRQ_IRQENTRY
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 241b73d64df7..3d0b6169ab86 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -38,14 +38,11 @@
  */
 	.macro	irq_handler
 #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
-	ldr	r1, =handle_arch_irq
 	mov	r0, sp
-	badr	lr, 9997f
-	ldr	pc, [r1]
+	bl	generic_handle_arch_irq
 #else
 	arch_irq_handler_default
 #endif
-9997:
 	.endm
 
 	.macro	pabt_helper
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 20ab1e607522..b79975bd988c 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -63,11 +63,8 @@ int arch_show_interrupts(struct seq_file *p, int prec)
  */
 void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct irq_desc *desc;
 
-	irq_enter();
-
 	/*
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
@@ -81,9 +78,6 @@ void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 		handle_irq_desc(desc);
 	else
 		ack_bad_irq(irq);
-
-	irq_exit();
-	set_irq_regs(old_regs);
 }
 
 /*
@@ -92,7 +86,15 @@ void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 asmlinkage void __exception_irq_entry
 asm_do_IRQ(unsigned int irq, struct pt_regs *regs)
 {
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs = set_irq_regs(regs);
+
 	handle_IRQ(irq, regs);
+
+	set_irq_regs(old_regs);
+	irq_exit();
 }
 
 void __init init_IRQ(void)
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index b31c4cff4d3a..ce330880665e 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -37,12 +37,27 @@
 
 static struct irq_domain *nvic_irq_domain;
 
-asmlinkage void __exception_irq_entry
-nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
+static void __nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
 {
 	handle_domain_irq(nvic_irq_domain, hwirq, regs);
 }
 
+/*
+ * TODO: restructure the ARMv7M entry logic so that this entry logic can live
+ * in arch code.
+ */
+asmlinkage void __exception_irq_entry
+static void nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs = set_irq_regs(regs);
+	__nvic_handle_irq(hwirq, regs);
+	set_irq_regs(old_regs);
+	irq_exit();
+}
+
 static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
-- 
2.11.0


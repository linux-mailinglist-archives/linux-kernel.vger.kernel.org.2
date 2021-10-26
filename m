Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3139043AFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhJZKSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:18:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60724 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbhJZKS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:27 -0400
Date:   Tue, 26 Oct 2021 10:16:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6fOtUc7faQ8eF36XhIRs84mZdba823W1XL5c65416l4=;
        b=iQDXn8mO/or8Rauq1VxscXbqEklMTEnAQztAFnhoesnehS100/KKEzjiHfqHBp/xWmWGWj
        trNcdiIAoICQU+/+aP9Io0p3mdLFUxRZnknAB0wOhcDhfEt8EoBIo+XQZ8ZFNwG3R2PzoG
        orINIIJZJ0ieG/X1Ao6kyiDAb0dCQGx6uNDrTvCrM3qe2RAhFq6oBXJ9L3+be8Mri/GbWL
        UZDqqUeEViDpU0z775WQRtf8aMALhvvk3suuiK506qw8X7/UWiaNDCqECKUKT5ZjMViQ4e
        dTaeQ1w8V/Z/a5OkSyNWUgpde3VzHZsmrvfL7uejSp6DPO6D4ZCkeDlnbxfXrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6fOtUc7faQ8eF36XhIRs84mZdba823W1XL5c65416l4=;
        b=2P6ueOQFk4Qf07jX9vUBkQQnPThrq2BCDyRzbDN5U0Im3jJNR41ilT4/4UzgpCJWkWPcuZ
        6Ebnxl2ujJQ2YKBQ==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: arm: perform irqentry in entry code
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524336123.626.6138578659838082283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a7b0872e964cf306fe26d9d49585a90486e32fdf
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a7b0872e964cf306fe26d9d49585a90486e32fdf
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 19 Oct 2021 18:17:17 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Mon, 25 Oct 2021 10:05:31 +01:00

irq: arm: perform irqentry in entry code

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
Reviewed-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/Kconfig             |  1 -
 arch/arm/kernel/entry-armv.S |  5 +----
 arch/arm/kernel/irq.c        | 14 ++++++++------
 drivers/irqchip/irq-nvic.c   | 17 ++++++++++++++++-
 4 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f18aff8..fc19642 100644
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
index 241b73d..3d0b616 100644
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
index 20ab1e6..b79975b 100644
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
index b31c4cf..b2bd962 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -37,10 +37,25 @@
 
 static struct irq_domain *nvic_irq_domain;
 
+static void __nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
+{
+	handle_domain_irq(nvic_irq_domain, hwirq, regs);
+}
+
+/*
+ * TODO: restructure the ARMv7M entry logic so that this entry logic can live
+ * in arch code.
+ */
 asmlinkage void __exception_irq_entry
 nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
 {
-	handle_domain_irq(nvic_irq_domain, hwirq, regs);
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs = set_irq_regs(regs);
+	__nvic_handle_irq(hwirq, regs);
+	set_irq_regs(old_regs);
+	irq_exit();
 }
 
 static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,

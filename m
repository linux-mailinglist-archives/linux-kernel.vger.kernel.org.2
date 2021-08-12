Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDAF3EA31B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhHLKs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbhHLKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D3CC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 03:47:02 -0700 (PDT)
Date:   Thu, 12 Aug 2021 10:47:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pb9z1g8yBiJMQvnskPfK7sODh8DKj+7QjG1mNgZiGBs=;
        b=4DD3H1HPTjQh9aJnwzuUmU1ndZD9qtxHca+sIILpWY7fRt1OQk9HvMb1pYMMtn1SMn6f2i
        9gvDnZN16fLfBTczi9kclXlxTX3PgVYFrNFChxoh8qnVTY0yW880ZWgGgfZDV2E3PnOO63
        k/chYNS+E2T36uhR4xUNFEdY6awYfiMqDGXZwPe3nEHWRvLE/H/9V1yrD5E/pJPkNIkRa2
        GLCMAC0+nXROpQTmplCdIEtHaDggTvDQVGAUMYg5g42G/Osg3i0teHcuuamir20SkCI/8r
        zRegXWeiY+TWbpPG+zr8+cGp3cY9qa8ic53BxXVzMTZV0lUHRN7aR9P0rn6Agg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pb9z1g8yBiJMQvnskPfK7sODh8DKj+7QjG1mNgZiGBs=;
        b=Pu/Ms7Da6h2rfxDEZGvf4u6YkgkdlKUDbAxHc3FisBfOAVU7h30TKoaYMFuj5TnTkFeMYI
        MOgkKdM4dxn40uAw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] mips: Bulk conversion to
 generic_handle_domain_irq()
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162876522064.395.4469398998853629641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     0661cb2af0ba628e40a288d134b64c5a9e001a3f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0661cb2af0ba628e40a288d134b64c5a9e001a3f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 17:42:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 11:39:40 +01:00

mips: Bulk conversion to generic_handle_domain_irq()

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/mips/ath25/ar2315.c      | 14 +++++++-------
 arch/mips/ath25/ar5312.c      | 13 ++++++-------
 arch/mips/lantiq/irq.c        |  2 +-
 arch/mips/pci/pci-ar2315.c    |  8 +++-----
 arch/mips/pci/pci-rt3883.c    |  5 ++---
 arch/mips/ralink/irq.c        |  2 +-
 arch/mips/sgi-ip27/ip27-irq.c | 16 ++++++----------
 arch/mips/sgi-ip30/ip30-irq.c |  8 +++-----
 8 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index 9dbed7b..76e43a7 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -69,24 +69,24 @@ static void ar2315_misc_irq_handler(struct irq_desc *desc)
 {
 	u32 pending = ar2315_rst_reg_read(AR2315_ISR) &
 		      ar2315_rst_reg_read(AR2315_IMR);
-	unsigned nr, misc_irq = 0;
+	unsigned nr;
+	int ret = 0;
 
 	if (pending) {
 		struct irq_domain *domain = irq_desc_get_handler_data(desc);
 
 		nr = __ffs(pending);
-		misc_irq = irq_find_mapping(domain, nr);
-	}
 
-	if (misc_irq) {
 		if (nr == AR2315_MISC_IRQ_GPIO)
 			ar2315_rst_reg_write(AR2315_ISR, AR2315_ISR_GPIO);
 		else if (nr == AR2315_MISC_IRQ_WATCHDOG)
 			ar2315_rst_reg_write(AR2315_ISR, AR2315_ISR_WD);
-		generic_handle_irq(misc_irq);
-	} else {
-		spurious_interrupt();
+
+		ret = generic_handle_domain_irq(domain, nr);
 	}
+
+	if (!pending || ret)
+		spurious_interrupt();
 }
 
 static void ar2315_misc_irq_unmask(struct irq_data *d)
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index 23c879f..822b639 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -73,22 +73,21 @@ static void ar5312_misc_irq_handler(struct irq_desc *desc)
 {
 	u32 pending = ar5312_rst_reg_read(AR5312_ISR) &
 		      ar5312_rst_reg_read(AR5312_IMR);
-	unsigned nr, misc_irq = 0;
+	unsigned nr;
+	int ret = 0;
 
 	if (pending) {
 		struct irq_domain *domain = irq_desc_get_handler_data(desc);
 
 		nr = __ffs(pending);
-		misc_irq = irq_find_mapping(domain, nr);
-	}
 
-	if (misc_irq) {
-		generic_handle_irq(misc_irq);
+		ret = generic_handle_domain_irq(domain, nr);
 		if (nr == AR5312_MISC_IRQ_TIMER)
 			ar5312_rst_reg_read(AR5312_TIMER);
-	} else {
-		spurious_interrupt();
 	}
+
+	if (!pending || ret)
+		spurious_interrupt();
 }
 
 /* Enable the specified AR5312_MISC_IRQ interrupt */
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index acfbdc0..b732495 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -300,7 +300,7 @@ static void ltq_hw_irq_handler(struct irq_desc *desc)
 	 */
 	irq = __fls(irq);
 	hwirq = irq + MIPS_CPU_IRQ_CASCADE + (INT_NUM_IM_OFFSET * module);
-	generic_handle_irq(irq_linear_revmap(ltq_domain, hwirq));
+	generic_handle_domain_irq(ltq_domain, hwirq);
 
 	/* if this is a EBU irq, we need to ack it or get a deadlock */
 	if (irq == LTQ_ICU_EBU_IRQ && !module && LTQ_EBU_PCC_ISTAT != 0)
diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index c1a655a..9a4bfb4 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -337,14 +337,12 @@ static void ar2315_pci_irq_handler(struct irq_desc *desc)
 	struct ar2315_pci_ctrl *apc = irq_desc_get_handler_data(desc);
 	u32 pending = ar2315_pci_reg_read(apc, AR2315_PCI_ISR) &
 		      ar2315_pci_reg_read(apc, AR2315_PCI_IMR);
-	unsigned pci_irq = 0;
+	int ret = 0;
 
 	if (pending)
-		pci_irq = irq_find_mapping(apc->domain, __ffs(pending));
+		ret = generic_handle_domain_irq(apc->domain, __ffs(pending));
 
-	if (pci_irq)
-		generic_handle_irq(pci_irq);
-	else
+	if (!pending || ret)
 		spurious_interrupt();
 }
 
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index c48e23c..d3c947f 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -140,10 +140,9 @@ static void rt3883_pci_irq_handler(struct irq_desc *desc)
 	}
 
 	while (pending) {
-		unsigned irq, bit = __ffs(pending);
+		unsigned bit = __ffs(pending);
 
-		irq = irq_find_mapping(rpc->irq_domain, bit);
-		generic_handle_irq(irq);
+		generic_handle_domain_irq(rpc->irq_domain, bit);
 
 		pending &= ~BIT(bit);
 	}
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 220ca0c..fa353bc 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -100,7 +100,7 @@ static void ralink_intc_irq_handler(struct irq_desc *desc)
 
 	if (pending) {
 		struct irq_domain *domain = irq_desc_get_handler_data(desc);
-		generic_handle_irq(irq_find_mapping(domain, __ffs(pending)));
+		generic_handle_domain_irq(domain, __ffs(pending));
 	} else {
 		spurious_interrupt();
 	}
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 95c1bff..a0dd3bd 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -190,7 +190,7 @@ static void ip27_do_irq_mask0(struct irq_desc *desc)
 	unsigned long *mask = per_cpu(irq_enable_mask, cpu);
 	struct irq_domain *domain;
 	u64 pend0;
-	int irq;
+	int ret;
 
 	/* copied from Irix intpend0() */
 	pend0 = LOCAL_HUB_L(PI_INT_PEND0);
@@ -216,10 +216,8 @@ static void ip27_do_irq_mask0(struct irq_desc *desc)
 #endif
 	{
 		domain = irq_desc_get_handler_data(desc);
-		irq = irq_linear_revmap(domain, __ffs(pend0));
-		if (irq)
-			generic_handle_irq(irq);
-		else
+		ret = generic_handle_domain_irq(domain, __ffs(pend0));
+		if (ret)
 			spurious_interrupt();
 	}
 
@@ -232,7 +230,7 @@ static void ip27_do_irq_mask1(struct irq_desc *desc)
 	unsigned long *mask = per_cpu(irq_enable_mask, cpu);
 	struct irq_domain *domain;
 	u64 pend1;
-	int irq;
+	int ret;
 
 	/* copied from Irix intpend0() */
 	pend1 = LOCAL_HUB_L(PI_INT_PEND1);
@@ -242,10 +240,8 @@ static void ip27_do_irq_mask1(struct irq_desc *desc)
 		return;
 
 	domain = irq_desc_get_handler_data(desc);
-	irq = irq_linear_revmap(domain, __ffs(pend1) + 64);
-	if (irq)
-		generic_handle_irq(irq);
-	else
+	ret = generic_handle_domain_irq(domain, __ffs(pend1) + 64);
+	if (ret)
 		spurious_interrupt();
 
 	LOCAL_HUB_L(PI_INT_PEND1);
diff --git a/arch/mips/sgi-ip30/ip30-irq.c b/arch/mips/sgi-ip30/ip30-irq.c
index ba87704..423c32c 100644
--- a/arch/mips/sgi-ip30/ip30-irq.c
+++ b/arch/mips/sgi-ip30/ip30-irq.c
@@ -99,7 +99,7 @@ static void ip30_normal_irq(struct irq_desc *desc)
 	int cpu = smp_processor_id();
 	struct irq_domain *domain;
 	u64 pend, mask;
-	int irq;
+	int ret;
 
 	pend = heart_read(&heart_regs->isr);
 	mask = (heart_read(&heart_regs->imr[cpu]) &
@@ -130,10 +130,8 @@ static void ip30_normal_irq(struct irq_desc *desc)
 #endif
 	{
 		domain = irq_desc_get_handler_data(desc);
-		irq = irq_linear_revmap(domain, __ffs(pend));
-		if (irq)
-			generic_handle_irq(irq);
-		else
+		ret = generic_handle_domain_irq(domain, __ffs(pend));
+		if (ret)
 			spurious_interrupt();
 	}
 }

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C833EA319
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhHLKsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:48:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57674 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbhHLKr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:28 -0400
Date:   Thu, 12 Aug 2021 10:47:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=if2xVcoNX/6ECoIVVjL2qkn3quNdpS9TC/vdeSyIkSE=;
        b=kha4j9pKwf3dbB3BcR1QZV6Hn8u6PUNiNLYemgBI5iQMCdpF+AnImqJk3yhmz6zjeSLXtk
        wYEZByKbkk2Q77JKF+pKL45Dk4VmqjHjiPuI0G85TCUhWpRhABOrRT6ZzQgMhiRuvpps46
        L5vrz37hyDl+hXJ9aQTW2UFI1XLwksfb/KxIzSZL2DWWZsKHsWAGDtTB8QZc4PhjUswYoD
        x1cly+HRK/67cNzdtpzUUD+0HvT6U9Ug7632X+Zal5CYsO9ML/+TdCDYzRQpogI3RsGFpT
        jyJCvMTlOXwPOhmWTpT6+sOBdwHE9XkRaW6TQw87M+Al5FzSdenpIY4SotmiAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=if2xVcoNX/6ECoIVVjL2qkn3quNdpS9TC/vdeSyIkSE=;
        b=+agUgTo1x8cZ93N+jLOG0+LdstB2jW7B/skuJPVaEMwd+lQy91ZDRJtkEQN+bySmoKX1Gh
        1QnZ9SNZazJb9hBg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] ARM: Bulk conversion to
 generic_handle_domain_irq()
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162876522175.395.14205082326623913568.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a1e5cd9650ed6000e1c0d7c940154e132ed26914
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a1e5cd9650ed6000e1c0d7c940154e132ed26914
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 17:42:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 11:39:39 +01:00

ARM: Bulk conversion to generic_handle_domain_irq()

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/common/sa1111.c           | 12 ++----------
 arch/arm/mach-pxa/pxa_cplds_irqs.c |  6 ++----
 arch/arm/mach-s3c/irq-s3c24xx.c    |  5 ++---
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index ff5e0d0..d17083c 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -196,14 +196,6 @@ static int sa1111_map_irq(struct sa1111 *sachip, irq_hw_number_t hwirq)
 	return irq_create_mapping(sachip->irqdomain, hwirq);
 }
 
-static void sa1111_handle_irqdomain(struct irq_domain *irqdomain, int irq)
-{
-	struct irq_desc *d = irq_to_desc(irq_linear_revmap(irqdomain, irq));
-
-	if (d)
-		generic_handle_irq_desc(d);
-}
-
 /*
  * SA1111 interrupt support.  Since clearing an IRQ while there are
  * active IRQs causes the interrupt output to pulse, the upper levels
@@ -234,11 +226,11 @@ static void sa1111_irq_handler(struct irq_desc *desc)
 
 	for (i = 0; stat0; i++, stat0 >>= 1)
 		if (stat0 & 1)
-			sa1111_handle_irqdomain(irqdomain, i);
+			generic_handle_domain_irq(irqdomain, i);
 
 	for (i = 32; stat1; i++, stat1 >>= 1)
 		if (stat1 & 1)
-			sa1111_handle_irqdomain(irqdomain, i);
+			generic_handle_domain_irq(irqdomain, i);
 
 	/* For level-based interrupts */
 	desc->irq_data.chip->irq_unmask(&desc->irq_data);
diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
index bddfc7c..eda5a47 100644
--- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
+++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
@@ -39,10 +39,8 @@ static irqreturn_t cplds_irq_handler(int in_irq, void *d)
 
 	do {
 		pending = readl(fpga->base + FPGA_IRQ_SET_CLR) & fpga->irq_mask;
-		for_each_set_bit(bit, &pending, CPLDS_NB_IRQ) {
-			generic_handle_irq(irq_find_mapping(fpga->irqdomain,
-							    bit));
-		}
+		for_each_set_bit(bit, &pending, CPLDS_NB_IRQ)
+			generic_handle_domain_irq(fpga->irqdomain, bit);
 	} while (pending);
 
 	return IRQ_HANDLED;
diff --git a/arch/arm/mach-s3c/irq-s3c24xx.c b/arch/arm/mach-s3c/irq-s3c24xx.c
index 0c631c1..3edc5f6 100644
--- a/arch/arm/mach-s3c/irq-s3c24xx.c
+++ b/arch/arm/mach-s3c/irq-s3c24xx.c
@@ -298,7 +298,7 @@ static void s3c_irq_demux(struct irq_desc *desc)
 	struct s3c_irq_data *irq_data = irq_desc_get_chip_data(desc);
 	struct s3c_irq_intc *intc = irq_data->intc;
 	struct s3c_irq_intc *sub_intc = irq_data->sub_intc;
-	unsigned int n, offset, irq;
+	unsigned int n, offset;
 	unsigned long src, msk;
 
 	/* we're using individual domains for the non-dt case
@@ -318,8 +318,7 @@ static void s3c_irq_demux(struct irq_desc *desc)
 	while (src) {
 		n = __ffs(src);
 		src &= ~(1 << n);
-		irq = irq_find_mapping(sub_intc->domain, offset + n);
-		generic_handle_irq(irq);
+		generic_handle_domain_irq(sub_intc->domain, offset + n);
 	}
 
 	chained_irq_exit(chip, desc);

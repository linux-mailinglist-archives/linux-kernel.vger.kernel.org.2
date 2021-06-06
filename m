Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4CC39CF14
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFFMpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhFFMpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6E4C061767
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:43:48 -0700 (PDT)
Date:   Sun, 06 Jun 2021 12:43:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ky2rafi7B9BLiTdHEuUYiQ2MjJbWRhQk9MriymunN/g=;
        b=fNSNRAwlVs4tq/9VWdvPnIEDU6q1IMIa4zcstIjSGZX86fk1Ooa1zyej7sXx+F9i5ep13P
        59oirX9JFrYdFrNixtscGessyib+VgAcOVUMZd6K9sSng7fHYFGHMMVSxjW+FCnoCFRr4/
        ilmudQSv01zZ2vter/SXGgq3mYS3XY+y36WWSIUyZ0x7B/B6c2dHXZA1eVYXwZ0XdNx375
        AuMbcpeDdVak4PoHwwc/Iabtya8ysyYlCEDHlPzBsjAd6mDid8XfEbgh8k9oGa4b2wwNEJ
        icKEdw5yeu5COm+qLJ7kpHXmehYQKySV+byewA3dxudstxnAMUq68CNvo8O7kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ky2rafi7B9BLiTdHEuUYiQ2MjJbWRhQk9MriymunN/g=;
        b=k3RuA6eEc/Ftq2rYB7Pbg5QipkA/Qtqf2canjA/8FrcXmWbxvS8x3oIHrdfCacMX31NrcX
        Bwu4G/2fQKWw3yAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Bulk conversion to
 generic_handle_domain_irq()
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298342429.29796.18285342948279820467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     dcb10b426d70fa739927103bec8ae544180fc073
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/dcb10b426d70fa739927103bec8ae544180fc073
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 17:42:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 06 Jun 2021 13:20:51 +01:00

irqchip: Bulk conversion to generic_handle_domain_irq()

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/exynos-combiner.c      | 10 ++++------
 drivers/irqchip/irq-al-fic.c           |  7 ++-----
 drivers/irqchip/irq-armada-370-xp.c    | 19 ++++++++-----------
 drivers/irqchip/irq-aspeed-i2c-ic.c    |  8 +++-----
 drivers/irqchip/irq-aspeed-scu-ic.c    |  6 ++----
 drivers/irqchip/irq-ath79-misc.c       |  2 +-
 drivers/irqchip/irq-bcm2835.c          |  2 +-
 drivers/irqchip/irq-bcm2836.c          |  2 +-
 drivers/irqchip/irq-bcm7038-l1.c       |  6 ++----
 drivers/irqchip/irq-bcm7120-l2.c       |  6 ++----
 drivers/irqchip/irq-brcmstb-l2.c       |  2 +-
 drivers/irqchip/irq-dw-apb-ictl.c      |  3 +--
 drivers/irqchip/irq-gic.c              | 13 +++++--------
 drivers/irqchip/irq-goldfish-pic.c     |  5 ++---
 drivers/irqchip/irq-i8259.c            |  4 +---
 drivers/irqchip/irq-idt3243x.c         |  6 ++----
 drivers/irqchip/irq-imgpdc.c           | 11 ++++-------
 drivers/irqchip/irq-imx-intmux.c       |  9 +++------
 drivers/irqchip/irq-imx-irqsteer.c     |  9 +++------
 drivers/irqchip/irq-ingenic-tcu.c      |  2 +-
 drivers/irqchip/irq-ingenic.c          |  3 +--
 drivers/irqchip/irq-keystone.c         | 14 ++++++--------
 drivers/irqchip/irq-loongson-htpic.c   |  2 +-
 drivers/irqchip/irq-loongson-htvec.c   |  4 ++--
 drivers/irqchip/irq-loongson-liointc.c |  2 +-
 drivers/irqchip/irq-lpc32xx.c          |  2 +-
 drivers/irqchip/irq-ls-scfg-msi.c      |  6 ++----
 drivers/irqchip/irq-ls1x.c             |  2 +-
 drivers/irqchip/irq-mips-gic.c         | 20 ++++++++++----------
 drivers/irqchip/irq-mscc-ocelot.c      |  2 +-
 drivers/irqchip/irq-mvebu-pic.c        |  7 ++-----
 drivers/irqchip/irq-mvebu-sei.c        | 13 ++++---------
 drivers/irqchip/irq-orion.c            |  2 +-
 drivers/irqchip/irq-partition-percpu.c |  9 +++------
 drivers/irqchip/irq-pruss-intc.c       |  9 +++------
 drivers/irqchip/irq-realtek-rtl.c      |  2 +-
 drivers/irqchip/irq-renesas-irqc.c     |  2 +-
 drivers/irqchip/irq-sifive-plic.c      |  8 +++-----
 drivers/irqchip/irq-stm32-exti.c       | 10 ++++------
 drivers/irqchip/irq-sunxi-nmi.c        |  3 +--
 drivers/irqchip/irq-tb10x.c            |  2 +-
 drivers/irqchip/irq-ti-sci-inta.c      |  9 +++------
 drivers/irqchip/irq-ts4800.c           |  3 +--
 drivers/irqchip/irq-versatile-fpga.c   |  2 +-
 drivers/irqchip/irq-vic.c              |  2 +-
 drivers/irqchip/irq-xilinx-intc.c      | 22 +++++-----------------
 drivers/irqchip/qcom-irq-combiner.c    |  6 +-----
 47 files changed, 111 insertions(+), 189 deletions(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 0b85d9a..1410612 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -66,8 +66,9 @@ static void combiner_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct combiner_chip_data *chip_data = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned int cascade_irq, combiner_irq;
+	unsigned int combiner_irq;
 	unsigned long status;
+	int ret;
 
 	chained_irq_enter(chip, desc);
 
@@ -80,12 +81,9 @@ static void combiner_handle_cascade_irq(struct irq_desc *desc)
 		goto out;
 
 	combiner_irq = chip_data->hwirq_offset + __ffs(status);
-	cascade_irq = irq_find_mapping(combiner_irq_domain, combiner_irq);
-
-	if (unlikely(!cascade_irq))
+	ret = generic_handle_domain_irq(combiner_irq_domain, combiner_irq);
+	if (unlikely(ret))
 		handle_bad_irq(desc);
-	else
-		generic_handle_irq(cascade_irq);
 
  out:
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
index 0b0a737..886de02 100644
--- a/drivers/irqchip/irq-al-fic.c
+++ b/drivers/irqchip/irq-al-fic.c
@@ -111,7 +111,6 @@ static void al_fic_irq_handler(struct irq_desc *desc)
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 	struct irq_chip_generic *gc = irq_get_domain_generic_chip(domain, 0);
 	unsigned long pending;
-	unsigned int irq;
 	u32 hwirq;
 
 	chained_irq_enter(irqchip, desc);
@@ -119,10 +118,8 @@ static void al_fic_irq_handler(struct irq_desc *desc)
 	pending = readl_relaxed(fic->base + AL_FIC_CAUSE);
 	pending &= ~gc->mask_cache;
 
-	for_each_set_bit(hwirq, &pending, NR_FIC_IRQS) {
-		irq = irq_find_mapping(domain, hwirq);
-		generic_handle_irq(irq);
-	}
+	for_each_set_bit(hwirq, &pending, NR_FIC_IRQS)
+		generic_handle_domain_irq(domain, hwirq);
 
 	chained_irq_exit(irqchip, desc);
 }
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 32938df..7557ab5 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -582,20 +582,19 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chained)
 
 	for (msinr = PCI_MSI_DOORBELL_START;
 	     msinr < PCI_MSI_DOORBELL_END; msinr++) {
-		int irq;
+		unsigned int irq;
 
 		if (!(msimask & BIT(msinr)))
 			continue;
 
-		if (is_chained) {
-			irq = irq_find_mapping(armada_370_xp_msi_inner_domain,
-					       msinr - PCI_MSI_DOORBELL_START);
-			generic_handle_irq(irq);
-		} else {
-			irq = msinr - PCI_MSI_DOORBELL_START;
+		irq = msinr - PCI_MSI_DOORBELL_START;
+
+		if (is_chained)
+			generic_handle_domain_irq(armada_370_xp_msi_inner_domain,
+						  irq);
+		else
 			handle_domain_irq(armada_370_xp_msi_inner_domain,
 					  irq, regs);
-		}
 	}
 }
 #else
@@ -606,7 +605,6 @@ static void armada_370_xp_mpic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long irqmap, irqn, irqsrc, cpuid;
-	unsigned int cascade_irq;
 
 	chained_irq_enter(chip, desc);
 
@@ -628,8 +626,7 @@ static void armada_370_xp_mpic_handle_cascade_irq(struct irq_desc *desc)
 			continue;
 		}
 
-		cascade_irq = irq_find_mapping(armada_370_xp_mpic_domain, irqn);
-		generic_handle_irq(cascade_irq);
+		generic_handle_domain_irq(armada_370_xp_mpic_domain, irqn);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-aspeed-i2c-ic.c
index 8d591c1..a47db16 100644
--- a/drivers/irqchip/irq-aspeed-i2c-ic.c
+++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
@@ -34,14 +34,12 @@ static void aspeed_i2c_ic_irq_handler(struct irq_desc *desc)
 	struct aspeed_i2c_ic *i2c_ic = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long bit, status;
-	unsigned int bus_irq;
 
 	chained_irq_enter(chip, desc);
 	status = readl(i2c_ic->base);
-	for_each_set_bit(bit, &status, ASPEED_I2C_IC_NUM_BUS) {
-		bus_irq = irq_find_mapping(i2c_ic->irq_domain, bit);
-		generic_handle_irq(bus_irq);
-	}
+	for_each_set_bit(bit, &status, ASPEED_I2C_IC_NUM_BUS)
+		generic_handle_domain_irq(i2c_ic->irq_domain, bit);
+
 	chained_irq_exit(chip, desc);
 }
 
diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index c90a334..f3c6855 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -44,7 +44,6 @@ struct aspeed_scu_ic {
 
 static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 {
-	unsigned int irq;
 	unsigned int sts;
 	unsigned long bit;
 	unsigned long enabled;
@@ -74,9 +73,8 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 	max = scu_ic->num_irqs + bit;
 
 	for_each_set_bit_from(bit, &status, max) {
-		irq = irq_find_mapping(scu_ic->irq_domain,
-				       bit - scu_ic->irq_shift);
-		generic_handle_irq(irq);
+		generic_handle_domain_irq(scu_ic->irq_domain,
+					  bit - scu_ic->irq_shift);
 
 		regmap_update_bits(scu_ic->scu, scu_ic->reg, mask,
 				   BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
diff --git a/drivers/irqchip/irq-ath79-misc.c b/drivers/irqchip/irq-ath79-misc.c
index 3d641bb..92f001a 100644
--- a/drivers/irqchip/irq-ath79-misc.c
+++ b/drivers/irqchip/irq-ath79-misc.c
@@ -50,7 +50,7 @@ static void ath79_misc_irq_handler(struct irq_desc *desc)
 	while (pending) {
 		int bit = __ffs(pending);
 
-		generic_handle_irq(irq_linear_revmap(domain, bit));
+		generic_handle_domain_irq(domain, bit);
 		pending &= ~BIT(bit);
 	}
 
diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index a1e004a..adc1556 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -254,7 +254,7 @@ static void bcm2836_chained_handle_irq(struct irq_desc *desc)
 	u32 hwirq;
 
 	while ((hwirq = get_next_armctrl_hwirq()) != ~0)
-		generic_handle_irq(irq_linear_revmap(intc.domain, hwirq));
+		generic_handle_domain_irq(intc.domain, hwirq);
 }
 
 IRQCHIP_DECLARE(bcm2835_armctrl_ic, "brcm,bcm2835-armctrl-ic",
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 25c9a9c..501facd 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -161,7 +161,7 @@ static void bcm2836_arm_irqchip_handle_ipi(struct irq_desc *desc)
 	mbox_val = readl_relaxed(intc.base + LOCAL_MAILBOX0_CLR0 + 16 * cpu);
 	if (mbox_val) {
 		int hwirq = ffs(mbox_val) - 1;
-		generic_handle_irq(irq_find_mapping(ipi_domain, hwirq));
+		generic_handle_domain_irq(ipi_domain, hwirq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 9dc9bf8..a035c38 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -145,10 +145,8 @@ static void bcm7038_l1_irq_handle(struct irq_desc *desc)
 			  ~cpu->mask_cache[idx];
 		raw_spin_unlock_irqrestore(&intc->lock, flags);
 
-		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
-			generic_handle_irq(irq_find_mapping(intc->domain,
-							    base + hwirq));
-		}
+		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD)
+			generic_handle_domain_irq(intc->domain, base + hwirq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index ad59656..f23d765 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -74,10 +74,8 @@ static void bcm7120_l2_intc_irq_handle(struct irq_desc *desc)
 					    data->irq_map_mask[idx];
 		irq_gc_unlock(gc);
 
-		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
-			generic_handle_irq(irq_find_mapping(b->domain,
-					   base + hwirq));
-		}
+		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD)
+			generic_handle_domain_irq(b->domain, base + hwirq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index cdd6a42..8e09115 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -110,7 +110,7 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 	do {
 		irq = ffs(status) - 1;
 		status &= ~(1 << irq);
-		generic_handle_irq(irq_linear_revmap(b->domain, irq));
+		generic_handle_domain_irq(b->domain, irq);
 	} while (status);
 out:
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index 54b09d6..a67266e 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -62,9 +62,8 @@ static void dw_apb_ictl_handle_irq_cascaded(struct irq_desc *desc)
 
 		while (stat) {
 			u32 hwirq = ffs(stat) - 1;
-			u32 virq = irq_find_mapping(d, gc->irq_base + hwirq);
+			generic_handle_domain_irq(d, gc->irq_base + hwirq);
 
-			generic_handle_irq(virq);
 			stat &= ~BIT(hwirq);
 		}
 	}
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b1d9c22..46c9c5f 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -375,8 +375,9 @@ static void gic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct gic_chip_data *chip_data = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned int cascade_irq, gic_irq;
+	unsigned int gic_irq;
 	unsigned long status;
+	int ret;
 
 	chained_irq_enter(chip, desc);
 
@@ -386,14 +387,10 @@ static void gic_handle_cascade_irq(struct irq_desc *desc)
 	if (gic_irq == GICC_INT_SPURIOUS)
 		goto out;
 
-	cascade_irq = irq_find_mapping(chip_data->domain, gic_irq);
-	if (unlikely(gic_irq < 32 || gic_irq > 1020)) {
+	isb();
+	ret = generic_handle_domain_irq(chip_data->domain, gic_irq);
+	if (unlikely(ret))
 		handle_bad_irq(desc);
-	} else {
-		isb();
-		generic_handle_irq(cascade_irq);
-	}
-
  out:
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/irqchip/irq-goldfish-pic.c b/drivers/irqchip/irq-goldfish-pic.c
index 4f02153..513f6ed 100644
--- a/drivers/irqchip/irq-goldfish-pic.c
+++ b/drivers/irqchip/irq-goldfish-pic.c
@@ -34,15 +34,14 @@ static void goldfish_pic_cascade(struct irq_desc *desc)
 {
 	struct goldfish_pic_data *gfpic = irq_desc_get_handler_data(desc);
 	struct irq_chip *host_chip = irq_desc_get_chip(desc);
-	u32 pending, hwirq, virq;
+	u32 pending, hwirq;
 
 	chained_irq_enter(host_chip, desc);
 
 	pending = readl(gfpic->base + GFPIC_REG_IRQ_PENDING);
 	while (pending) {
 		hwirq = __fls(pending);
-		virq = irq_linear_revmap(gfpic->irq_domain, hwirq);
-		generic_handle_irq(virq);
+		generic_handle_domain_irq(gfpic->irq_domain, hwirq);
 		pending &= ~(1 << hwirq);
 	}
 
diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index b6f6aa7..b70ce0d 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -333,13 +333,11 @@ static void i8259_irq_dispatch(struct irq_desc *desc)
 {
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
 	int hwirq = i8259_poll();
-	unsigned int irq;
 
 	if (hwirq < 0)
 		return;
 
-	irq = irq_linear_revmap(domain, hwirq);
-	generic_handle_irq(irq);
+	generic_handle_domain_irq(domain, hwirq);
 }
 
 int __init i8259_of_init(struct device_node *node, struct device_node *parent)
diff --git a/drivers/irqchip/irq-idt3243x.c b/drivers/irqchip/irq-idt3243x.c
index f099682..0732a0e 100644
--- a/drivers/irqchip/irq-idt3243x.c
+++ b/drivers/irqchip/irq-idt3243x.c
@@ -28,7 +28,7 @@ static void idt_irq_dispatch(struct irq_desc *desc)
 {
 	struct idt_pic_data *idtpic = irq_desc_get_handler_data(desc);
 	struct irq_chip *host_chip = irq_desc_get_chip(desc);
-	u32 pending, hwirq, virq;
+	u32 pending, hwirq;
 
 	chained_irq_enter(host_chip, desc);
 
@@ -36,9 +36,7 @@ static void idt_irq_dispatch(struct irq_desc *desc)
 	pending &= ~idtpic->gc->mask_cache;
 	while (pending) {
 		hwirq = __fls(pending);
-		virq = irq_linear_revmap(idtpic->irq_domain, hwirq);
-		if (virq)
-			generic_handle_irq(virq);
+		generic_handle_domain_irq(idtpic->irq_domain, hwirq);
 		pending &= ~(1 << hwirq);
 	}
 
diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index 698d07f..646dfbf 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -223,7 +223,7 @@ static void pdc_intc_perip_isr(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct pdc_intc_priv *priv;
-	unsigned int i, irq_no;
+	unsigned int i;
 
 	priv = (struct pdc_intc_priv *)irq_desc_get_handler_data(desc);
 
@@ -237,14 +237,13 @@ static void pdc_intc_perip_isr(struct irq_desc *desc)
 found:
 
 	/* pass on the interrupt */
-	irq_no = irq_linear_revmap(priv->domain, i);
-	generic_handle_irq(irq_no);
+	generic_handle_domain_irq(priv->domain, i);
 }
 
 static void pdc_intc_syswake_isr(struct irq_desc *desc)
 {
 	struct pdc_intc_priv *priv;
-	unsigned int syswake, irq_no;
+	unsigned int syswake;
 	unsigned int status;
 
 	priv = (struct pdc_intc_priv *)irq_desc_get_handler_data(desc);
@@ -258,9 +257,7 @@ static void pdc_intc_syswake_isr(struct irq_desc *desc)
 		if (!(status & 1))
 			continue;
 
-		irq_no = irq_linear_revmap(priv->domain,
-					   syswake_to_hwirq(syswake));
-		generic_handle_irq(irq_no);
+		generic_handle_domain_irq(priv->domain, syswake_to_hwirq(syswake));
 	}
 }
 
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index 7709f97..e86ff74 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -182,18 +182,15 @@ static void imx_intmux_irq_handler(struct irq_desc *desc)
 	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
 						irqchip_data[idx]);
 	unsigned long irqstat;
-	int pos, virq;
+	int pos;
 
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
 
 	/* read the interrupt source pending status of this channel */
 	irqstat = readl_relaxed(data->regs + CHANIPR(idx));
 
-	for_each_set_bit(pos, &irqstat, 32) {
-		virq = irq_find_mapping(irqchip_data->domain, pos);
-		if (virq)
-			generic_handle_irq(virq);
-	}
+	for_each_set_bit(pos, &irqstat, 32)
+		generic_handle_domain_irq(irqchip_data->domain, pos);
 
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
 }
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 1edf769..8d91a02 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -122,7 +122,7 @@ static void imx_irqsteer_irq_handler(struct irq_desc *desc)
 	for (i = 0; i < 2; i++, hwirq += 32) {
 		int idx = imx_irqsteer_get_reg_index(data, hwirq);
 		unsigned long irqmap;
-		int pos, virq;
+		int pos;
 
 		if (hwirq >= data->reg_num * 32)
 			break;
@@ -130,11 +130,8 @@ static void imx_irqsteer_irq_handler(struct irq_desc *desc)
 		irqmap = readl_relaxed(data->regs +
 				       CHANSTATUS(idx, data->reg_num));
 
-		for_each_set_bit(pos, &irqmap, 32) {
-			virq = irq_find_mapping(data->domain, pos + hwirq);
-			if (virq)
-				generic_handle_irq(virq);
-		}
+		for_each_set_bit(pos, &irqmap, 32)
+			generic_handle_domain_irq(data->domain, pos + hwirq);
 	}
 
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
diff --git a/drivers/irqchip/irq-ingenic-tcu.c b/drivers/irqchip/irq-ingenic-tcu.c
index b938d1d..34a7d26 100644
--- a/drivers/irqchip/irq-ingenic-tcu.c
+++ b/drivers/irqchip/irq-ingenic-tcu.c
@@ -38,7 +38,7 @@ static void ingenic_tcu_intc_cascade(struct irq_desc *desc)
 	irq_reg &= ~irq_mask;
 
 	for_each_set_bit(i, (unsigned long *)&irq_reg, 32)
-		generic_handle_irq(irq_linear_revmap(domain, i));
+		generic_handle_domain_irq(domain, i);
 
 	chained_irq_exit(irq_chip, desc);
 }
diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index ea36bb0..cee839c 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -49,8 +49,7 @@ static irqreturn_t intc_cascade(int irq, void *data)
 		while (pending) {
 			int bit = __fls(pending);
 
-			irq = irq_linear_revmap(domain, bit + (i * 32));
-			generic_handle_irq(irq);
+			generic_handle_domain_irq(domain, bit + (i * 32));
 			pending &= ~BIT(bit);
 		}
 	}
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index 8118ebe..d47c804 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -89,7 +89,7 @@ static irqreturn_t keystone_irq_handler(int irq, void *keystone_irq)
 	struct keystone_irq_device *kirq = keystone_irq;
 	unsigned long wa_lock_flags;
 	unsigned long pending;
-	int src, virq;
+	int src, err;
 
 	dev_dbg(kirq->dev, "start irq %d\n", irq);
 
@@ -104,16 +104,14 @@ static irqreturn_t keystone_irq_handler(int irq, void *keystone_irq)
 
 	for (src = 0; src < KEYSTONE_N_IRQ; src++) {
 		if (BIT(src) & pending) {
-			virq = irq_find_mapping(kirq->irqd, src);
-			dev_dbg(kirq->dev, "dispatch bit %d, virq %d\n",
-				src, virq);
-			if (!virq)
-				dev_warn(kirq->dev, "spurious irq detected hwirq %d, virq %d\n",
-					 src, virq);
 			raw_spin_lock_irqsave(&kirq->wa_lock, wa_lock_flags);
-			generic_handle_irq(virq);
+			err = generic_handle_domain_irq(kirq->irqd, src);
 			raw_spin_unlock_irqrestore(&kirq->wa_lock,
 						   wa_lock_flags);
+
+			if (err)
+				dev_warn_ratelimited(kirq->dev, "spurious irq detected hwirq %d\n",
+						     src);
 		}
 	}
 
diff --git a/drivers/irqchip/irq-loongson-htpic.c b/drivers/irqchip/irq-loongson-htpic.c
index 1b801c4..f4abdf1 100644
--- a/drivers/irqchip/irq-loongson-htpic.c
+++ b/drivers/irqchip/irq-loongson-htpic.c
@@ -48,7 +48,7 @@ static void htpic_irq_dispatch(struct irq_desc *desc)
 			break;
 		}
 
-		generic_handle_irq(irq_linear_revmap(priv->domain, bit));
+		generic_handle_domain_irq(priv->domain, bit);
 		pending &= ~BIT(bit);
 	}
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 6392aaf..60a335d 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -47,8 +47,8 @@ static void htvec_irq_dispatch(struct irq_desc *desc)
 		while (pending) {
 			int bit = __ffs(pending);
 
-			generic_handle_irq(irq_linear_revmap(priv->htvec_domain, bit +
-							     VEC_COUNT_PER_REG * i));
+			generic_handle_domain_irq(priv->htvec_domain,
+						  bit + VEC_COUNT_PER_REG * i);
 			pending &= ~BIT(bit);
 			handled = true;
 		}
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 8ccb304..649c583 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -73,7 +73,7 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
 	while (pending) {
 		int bit = __ffs(pending);
 
-		generic_handle_irq(irq_find_mapping(gc->domain, bit));
+		generic_handle_domain_irq(gc->domain, bit);
 		pending &= ~BIT(bit);
 	}
 
diff --git a/drivers/irqchip/irq-lpc32xx.c b/drivers/irqchip/irq-lpc32xx.c
index 7d9b388..5e6f6e2 100644
--- a/drivers/irqchip/irq-lpc32xx.c
+++ b/drivers/irqchip/irq-lpc32xx.c
@@ -141,7 +141,7 @@ static void lpc32xx_sic_handler(struct irq_desc *desc)
 	while (hwirq) {
 		irq = __ffs(hwirq);
 		hwirq &= ~BIT(irq);
-		generic_handle_irq(irq_find_mapping(ic->domain, irq));
+		generic_handle_domain_irq(ic->domain, irq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 61dbfda..55322da 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -194,7 +194,7 @@ static void ls_scfg_msi_irq_handler(struct irq_desc *desc)
 	struct ls_scfg_msir *msir = irq_desc_get_handler_data(desc);
 	struct ls_scfg_msi *msi_data = msir->msi_data;
 	unsigned long val;
-	int pos, size, virq, hwirq;
+	int pos, size, hwirq;
 
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
 
@@ -206,9 +206,7 @@ static void ls_scfg_msi_irq_handler(struct irq_desc *desc)
 	for_each_set_bit_from(pos, &val, size) {
 		hwirq = ((msir->bit_end - pos) << msi_data->cfg->ibs_shift) |
 			msir->srs;
-		virq = irq_find_mapping(msi_data->parent, hwirq);
-		if (virq)
-			generic_handle_irq(virq);
+		generic_handle_domain_irq(msi_data->parent, hwirq);
 	}
 
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
diff --git a/drivers/irqchip/irq-ls1x.c b/drivers/irqchip/irq-ls1x.c
index 353111a..77a3f7d 100644
--- a/drivers/irqchip/irq-ls1x.c
+++ b/drivers/irqchip/irq-ls1x.c
@@ -50,7 +50,7 @@ static void ls1x_chained_handle_irq(struct irq_desc *desc)
 	while (pending) {
 		int bit = __ffs(pending);
 
-		generic_handle_irq(irq_find_mapping(priv->domain, bit));
+		generic_handle_domain_irq(priv->domain, bit);
 		pending &= ~BIT(bit);
 	}
 
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index a2cbf0a..b146e06 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -148,7 +148,7 @@ int gic_get_c0_fdc_int(void)
 
 static void gic_handle_shared_int(bool chained)
 {
-	unsigned int intr, virq;
+	unsigned int intr;
 	unsigned long *pcpu_mask;
 	DECLARE_BITMAP(pending, GIC_MAX_INTRS);
 
@@ -165,12 +165,12 @@ static void gic_handle_shared_int(bool chained)
 	bitmap_and(pending, pending, pcpu_mask, gic_shared_intrs);
 
 	for_each_set_bit(intr, pending, gic_shared_intrs) {
-		virq = irq_linear_revmap(gic_irq_domain,
-					 GIC_SHARED_TO_HWIRQ(intr));
 		if (chained)
-			generic_handle_irq(virq);
+			generic_handle_domain_irq(gic_irq_domain,
+						  GIC_SHARED_TO_HWIRQ(intr));
 		else
-			do_IRQ(virq);
+			do_IRQ(irq_find_mapping(gic_irq_domain,
+						GIC_SHARED_TO_HWIRQ(intr)));
 	}
 }
 
@@ -308,7 +308,7 @@ static struct irq_chip gic_edge_irq_controller = {
 static void gic_handle_local_int(bool chained)
 {
 	unsigned long pending, masked;
-	unsigned int intr, virq;
+	unsigned int intr;
 
 	pending = read_gic_vl_pend();
 	masked = read_gic_vl_mask();
@@ -316,12 +316,12 @@ static void gic_handle_local_int(bool chained)
 	bitmap_and(&pending, &pending, &masked, GIC_NUM_LOCAL_INTRS);
 
 	for_each_set_bit(intr, &pending, GIC_NUM_LOCAL_INTRS) {
-		virq = irq_linear_revmap(gic_irq_domain,
-					 GIC_LOCAL_TO_HWIRQ(intr));
 		if (chained)
-			generic_handle_irq(virq);
+			generic_handle_domain_irq(gic_irq_domain,
+						  GIC_LOCAL_TO_HWIRQ(intr));
 		else
-			do_IRQ(virq);
+			do_IRQ(irq_find_mapping(gic_irq_domain,
+						GIC_LOCAL_TO_HWIRQ(intr)));
 	}
 }
 
diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 8235d98..4d0c353 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -107,7 +107,7 @@ static void ocelot_irq_handler(struct irq_desc *desc)
 	while (reg) {
 		u32 hwirq = __fls(reg);
 
-		generic_handle_irq(irq_find_mapping(d, hwirq));
+		generic_handle_domain_irq(d, hwirq);
 		reg &= ~(BIT(hwirq));
 	}
 
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index eec6395..dc1cee4 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -91,15 +91,12 @@ static void mvebu_pic_handle_cascade_irq(struct irq_desc *desc)
 	struct mvebu_pic *pic = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long irqmap, irqn;
-	unsigned int cascade_irq;
 
 	irqmap = readl_relaxed(pic->base + PIC_CAUSE);
 	chained_irq_enter(chip, desc);
 
-	for_each_set_bit(irqn, &irqmap, BITS_PER_LONG) {
-		cascade_irq = irq_find_mapping(pic->domain, irqn);
-		generic_handle_irq(cascade_irq);
-	}
+	for_each_set_bit(irqn, &irqmap, BITS_PER_LONG)
+		generic_handle_domain_irq(pic->domain, irqn);
 
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index 3a7b7a7..4ecef6d 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -337,17 +337,12 @@ static void mvebu_sei_handle_cascade_irq(struct irq_desc *desc)
 		irqmap = readl_relaxed(sei->base + GICP_SECR(idx));
 		for_each_set_bit(bit, &irqmap, SEI_IRQ_COUNT_PER_REG) {
 			unsigned long hwirq;
-			unsigned int virq;
+			int err;
 
 			hwirq = idx * SEI_IRQ_COUNT_PER_REG + bit;
-			virq = irq_find_mapping(sei->sei_domain, hwirq);
-			if (likely(virq)) {
-				generic_handle_irq(virq);
-				continue;
-			}
-
-			dev_warn(sei->dev,
-				 "Spurious IRQ detected (hwirq %lu)\n", hwirq);
+			err = generic_handle_domain_irq(sei->sei_domain, hwirq);
+			if (unlikely(err))
+				dev_warn(sei->dev, "Spurious IRQ detected (hwirq %lu)\n", hwirq);
 		}
 	}
 
diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index c4b5ffb..b6868f7 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -117,7 +117,7 @@ static void orion_bridge_irq_handler(struct irq_desc *desc)
 	while (stat) {
 		u32 hwirq = __fls(stat);
 
-		generic_handle_irq(irq_find_mapping(d, gc->irq_base + hwirq));
+		generic_handle_domain_irq(d, gc->irq_base + hwirq);
 		stat &= ~(1 << hwirq);
 	}
 }
diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-partition-percpu.c
index 0c4c8ed..89c23a1 100644
--- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -124,13 +124,10 @@ static void partition_handle_irq(struct irq_desc *desc)
 			break;
 	}
 
-	if (unlikely(hwirq == part->nr_parts)) {
+	if (unlikely(hwirq == part->nr_parts))
 		handle_bad_irq(desc);
-	} else {
-		unsigned int irq;
-		irq = irq_find_mapping(part->domain, hwirq);
-		generic_handle_irq(irq);
-	}
+	else
+		generic_handle_domain_irq(part->domain, hwirq);
 
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 92fb578..fa8d89b 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -488,8 +488,7 @@ static void pruss_intc_irq_handler(struct irq_desc *desc)
 
 	while (true) {
 		u32 hipir;
-		unsigned int virq;
-		int hwirq;
+		int hwirq, err;
 
 		/* get highest priority pending PRUSS system event */
 		hipir = pruss_intc_read_reg(intc, PRU_INTC_HIPIR(host_irq));
@@ -497,16 +496,14 @@ static void pruss_intc_irq_handler(struct irq_desc *desc)
 			break;
 
 		hwirq = hipir & GENMASK(9, 0);
-		virq = irq_find_mapping(intc->domain, hwirq);
+		err = generic_handle_domain_irq(intc->domain, hwirq);
 
 		/*
 		 * NOTE: manually ACK any system events that do not have a
 		 * handler mapped yet
 		 */
-		if (WARN_ON_ONCE(!virq))
+		if (WARN_ON_ONCE(err))
 			pruss_intc_write_reg(intc, PRU_INTC_SICR, hwirq);
-		else
-			generic_handle_irq(virq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index b57c67d..fd9f275 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -85,7 +85,7 @@ static void realtek_irq_dispatch(struct irq_desc *desc)
 		goto out;
 	}
 	domain = irq_desc_get_handler_data(desc);
-	generic_handle_irq(irq_find_mapping(domain, __ffs(pending)));
+	generic_handle_domain_irq(domain, __ffs(pending));
 
 out:
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 11abc09..07a6d8b 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -115,7 +115,7 @@ static irqreturn_t irqc_irq_handler(int irq, void *dev_id)
 	if (ioread32(p->iomem + DETECT_STATUS) & bit) {
 		iowrite32(bit, p->iomem + DETECT_STATUS);
 		irqc_dbg(i, "demux2");
-		generic_handle_irq(irq_find_mapping(p->irq_domain, i->hw_irq));
+		generic_handle_domain_irq(p->irq_domain, i->hw_irq);
 		return IRQ_HANDLED;
 	}
 	return IRQ_NONE;
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 97d4d04..cf74cfa 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -233,13 +233,11 @@ static void plic_handle_irq(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	while ((hwirq = readl(claim))) {
-		int irq = irq_find_mapping(handler->priv->irqdomain, hwirq);
-
-		if (unlikely(irq <= 0))
+		int err = generic_handle_domain_irq(handler->priv->irqdomain,
+						    hwirq);
+		if (unlikely(err))
 			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
 					hwirq);
-		else
-			generic_handle_irq(irq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 4704f2e..33c7671 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -257,7 +257,7 @@ static void stm32_irq_handler(struct irq_desc *desc)
 {
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned int virq, nbanks = domain->gc->num_chips;
+	unsigned int nbanks = domain->gc->num_chips;
 	struct irq_chip_generic *gc;
 	unsigned long pending;
 	int n, i, irq_base = 0;
@@ -268,11 +268,9 @@ static void stm32_irq_handler(struct irq_desc *desc)
 		gc = irq_get_domain_generic_chip(domain, irq_base);
 
 		while ((pending = stm32_exti_pending(gc))) {
-			for_each_set_bit(n, &pending, IRQS_PER_BANK) {
-				virq = irq_find_mapping(domain, irq_base + n);
-				generic_handle_irq(virq);
-			}
-		}
+			for_each_set_bit(n, &pending, IRQS_PER_BANK)
+				generic_handle_domain_irq(domain, irq_base + n);
+ 		}
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 9f2bd0c..21d4979 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -88,10 +88,9 @@ static void sunxi_sc_nmi_handle_irq(struct irq_desc *desc)
 {
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned int virq = irq_find_mapping(domain, 0);
 
 	chained_irq_enter(chip, desc);
-	generic_handle_irq(virq);
+	generic_handle_domain_irq(domain, 0);
 	chained_irq_exit(chip, desc);
 }
 
diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index 9a63b02..8a0e692 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -91,7 +91,7 @@ static void tb10x_irq_cascade(struct irq_desc *desc)
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
 	unsigned int irq = irq_desc_get_irq(desc);
 
-	generic_handle_irq(irq_find_mapping(domain, irq));
+	generic_handle_domain_irq(domain, irq);
 }
 
 static int __init of_tb10x_init_irq(struct device_node *ictl,
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index ca1f593..97f454e 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -147,7 +147,7 @@ static void ti_sci_inta_irq_handler(struct irq_desc *desc)
 	struct ti_sci_inta_vint_desc *vint_desc;
 	struct ti_sci_inta_irq_domain *inta;
 	struct irq_domain *domain;
-	unsigned int virq, bit;
+	unsigned int bit;
 	unsigned long val;
 
 	vint_desc = irq_desc_get_handler_data(desc);
@@ -159,11 +159,8 @@ static void ti_sci_inta_irq_handler(struct irq_desc *desc)
 	val = readq_relaxed(inta->base + vint_desc->vint_id * 0x1000 +
 			    VINT_STATUS_MASKED_OFFSET);
 
-	for_each_set_bit(bit, &val, MAX_EVENTS_PER_VINT) {
-		virq = irq_find_mapping(domain, vint_desc->events[bit].hwirq);
-		if (virq)
-			generic_handle_irq(virq);
-	}
+	for_each_set_bit(bit, &val, MAX_EVENTS_PER_VINT)
+		generic_handle_domain_irq(domain, vint_desc->events[bit].hwirq);
 
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
 }
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 2325fb3..34337a6 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -79,10 +79,9 @@ static void ts4800_ic_chained_handle_irq(struct irq_desc *desc)
 
 	do {
 		unsigned int bit = __ffs(status);
-		int irq = irq_find_mapping(data->domain, bit);
 
+		generic_handle_domain_irq(data->domain, bit);
 		status &= ~(1 << bit);
-		generic_handle_irq(irq);
 	} while (status);
 
 out:
diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index f138673..75be350 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -85,7 +85,7 @@ static void fpga_irq_handle(struct irq_desc *desc)
 		unsigned int irq = ffs(status) - 1;
 
 		status &= ~(1 << irq);
-		generic_handle_irq(irq_find_mapping(f->domain, irq));
+		generic_handle_domain_irq(f->domain, irq);
 	} while (status);
 
 out:
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 62f3d29..1e1f2d1 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -225,7 +225,7 @@ static void vic_handle_irq_cascaded(struct irq_desc *desc)
 
 	while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
 		hwirq = ffs(stat) - 1;
-		generic_handle_irq(irq_find_mapping(vic->domain, hwirq));
+		generic_handle_domain_irq(vic->domain, hwirq);
 	}
 
 	chained_irq_exit(host_chip, desc);
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 8cd1bfc..875ff52 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -110,20 +110,6 @@ static struct irq_chip intc_dev = {
 	.irq_mask_ack = intc_mask_ack,
 };
 
-static unsigned int xintc_get_irq_local(struct xintc_irq_chip *irqc)
-{
-	unsigned int irq = 0;
-	u32 hwirq;
-
-	hwirq = xintc_read(irqc, IVR);
-	if (hwirq != -1U)
-		irq = irq_find_mapping(irqc->root_domain, hwirq);
-
-	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
-
-	return irq;
-}
-
 unsigned int xintc_get_irq(void)
 {
 	unsigned int irq = -1;
@@ -169,10 +155,12 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 	irqc = irq_data_get_irq_handler_data(&desc->irq_data);
 	chained_irq_enter(chip, desc);
 	do {
-		pending = xintc_get_irq_local(irqc);
-		if (pending == 0)
+		u32 hwirq = xintc_read(irqc, IVR);
+
+		if (hwirq == -1U)
 			break;
-		generic_handle_irq(pending);
+
+		generic_handle_domain_irq(irqc->root_domain, hwirq);
 	} while (true);
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index aa54bfc..18e696d 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -53,7 +53,6 @@ static void combiner_handle_irq(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	for (reg = 0; reg < combiner->nregs; reg++) {
-		int virq;
 		int hwirq;
 		u32 bit;
 		u32 status;
@@ -70,10 +69,7 @@ static void combiner_handle_irq(struct irq_desc *desc)
 			bit = __ffs(status);
 			status &= ~(1 << bit);
 			hwirq = irq_nr(reg, bit);
-			virq = irq_find_mapping(combiner->domain, hwirq);
-			if (virq > 0)
-				generic_handle_irq(virq);
-
+			generic_handle_domain_irq(combiner->domain, hwirq);
 		}
 	}
 

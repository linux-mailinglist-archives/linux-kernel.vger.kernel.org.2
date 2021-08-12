Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516173EA31A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbhHLKsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:48:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57704 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbhHLKr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:29 -0400
Date:   Thu, 12 Aug 2021 10:47:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765223;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vwgVqFVeXyhcD837PeRhcZPzGe6D4kLnkRVcLArxVho=;
        b=aDZA7umhxLlrOrKmrDEGlJuK3eSUDOJ61z09uRYojBqsLZwmQo0L5IADCFl0QpMGLduMa/
        uMrRuJCQIsB9JfBJXM+gmV6Z7fYreFxs+G4569AI5jGGKY4oqx3c+FMlSXXhirke/M/7Ue
        UfBpXovhYIjUfzY02YQ3ClU+fmoOZcYje7aioHS2Fjxb0IZVBg2Enmm8y988nrJ3V/Wyry
        PlutpfVgSGhgxjkNiQDLnj29j4Tx3x5yltTwMCyMp13wi0DSwY1h1wwH8yxugKrqCPjLd3
        V3Unv0Y1EggL6xDTg+VslhHMhTxLXTeILMiLnKo+Fghh1o2JOxpmcVyL+lyFcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765223;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vwgVqFVeXyhcD837PeRhcZPzGe6D4kLnkRVcLArxVho=;
        b=uLoEzmZqQCW9tX+vfHQdZ+JYWsz6KlCjZhtNAW1huvzyyW+1vhVy5shKjY5A9tkMdowi+I
        j3yvIG1uNFDXgRBA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] pinctrl: Bulk conversion to
 generic_handle_domain_irq()
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162876522301.395.12932967265058699769.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a9cb09b7be84a7adc9e6f4aaf8d770933d65f953
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a9cb09b7be84a7adc9e6f4aaf8d770933d65f953
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 17:42:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 11:39:39 +01:00

pinctrl: Bulk conversion to generic_handle_domain_irq()

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pinctrl/actions/pinctrl-owl.c      |  5 +---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c      |  4 +--
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c   |  3 +--
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c     |  3 +--
 drivers/pinctrl/intel/pinctrl-baytrail.c   |  7 +-----
 drivers/pinctrl/intel/pinctrl-cherryview.c |  5 +---
 drivers/pinctrl/intel/pinctrl-lynxpoint.c  |  8 +------
 drivers/pinctrl/mediatek/mtk-eint.c        |  5 +---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c  |  2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c  |  2 +-
 drivers/pinctrl/pinctrl-amd.c              |  6 +----
 drivers/pinctrl/pinctrl-at91.c             |  6 +----
 drivers/pinctrl/pinctrl-equilibrium.c      |  2 +-
 drivers/pinctrl/pinctrl-ingenic.c          |  2 +-
 drivers/pinctrl/pinctrl-microchip-sgpio.c  |  2 +-
 drivers/pinctrl/pinctrl-ocelot.c           |  3 +--
 drivers/pinctrl/pinctrl-oxnas.c            |  2 +-
 drivers/pinctrl/pinctrl-pic32.c            |  2 +-
 drivers/pinctrl/pinctrl-pistachio.c        |  2 +-
 drivers/pinctrl/pinctrl-rockchip.c         | 15 ++++---------
 drivers/pinctrl/pinctrl-single.c           |  4 +--
 drivers/pinctrl/pinctrl-st.c               |  2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c         |  4 +---
 drivers/pinctrl/samsung/pinctrl-exynos.c   | 15 ++++++-------
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c  | 25 ++++++++-------------
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c  | 17 +++++---------
 drivers/pinctrl/spear/pinctrl-plgpio.c     |  3 +--
 drivers/pinctrl/sunxi/pinctrl-sunxi.c      |  8 ++-----
 28 files changed, 64 insertions(+), 100 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index c8b3e39..781f220 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.c
+++ b/drivers/pinctrl/actions/pinctrl-owl.c
@@ -833,7 +833,7 @@ static void owl_gpio_irq_handler(struct irq_desc *desc)
 	unsigned int parent = irq_desc_get_irq(desc);
 	const struct owl_gpio_port *port;
 	void __iomem *base;
-	unsigned int pin, irq, offset = 0, i;
+	unsigned int pin, offset = 0, i;
 	unsigned long pending_irq;
 
 	chained_irq_enter(chip, desc);
@@ -849,8 +849,7 @@ static void owl_gpio_irq_handler(struct irq_desc *desc)
 		pending_irq = readl_relaxed(base + port->intc_pd);
 
 		for_each_set_bit(pin, &pending_irq, port->pins) {
-			irq = irq_find_mapping(domain, offset + pin);
-			generic_handle_irq(irq);
+			generic_handle_domain_irq(domain, offset + pin);
 
 			/* clear pending interrupt */
 			owl_gpio_update_reg(base + port->intc_pd, pin, true);
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 2c87af1..8b34d2c 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -395,8 +395,8 @@ static void bcm2835_gpio_irq_handle_bank(struct bcm2835_pinctrl *pc,
 	events &= pc->enabled_irq_map[bank];
 	for_each_set_bit(offset, &events, 32) {
 		gpio = (32 * bank) + offset;
-		generic_handle_irq(irq_linear_revmap(pc->gpio_chip.irq.domain,
-						     gpio));
+		generic_handle_domain_irq(pc->gpio_chip.irq.domain,
+					  gpio);
 	}
 }
 
diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index dc511b9..a7a0dd6 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -176,7 +176,6 @@ static void iproc_gpio_irq_handler(struct irq_desc *desc)
 
 		for_each_set_bit(bit, &val, NGPIOS_PER_BANK) {
 			unsigned pin = NGPIOS_PER_BANK * i + bit;
-			int child_irq = irq_find_mapping(gc->irq.domain, pin);
 
 			/*
 			 * Clear the interrupt before invoking the
@@ -185,7 +184,7 @@ static void iproc_gpio_irq_handler(struct irq_desc *desc)
 			writel(BIT(bit), chip->base + (i * GPIO_BANK_SIZE) +
 			       IPROC_GPIO_INT_CLR_OFFSET);
 
-			generic_handle_irq(child_irq);
+			generic_handle_domain_irq(gc->irq.domain, pin);
 		}
 	}
 
diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
index a00a42a..e031428 100644
--- a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
@@ -155,8 +155,7 @@ static irqreturn_t nsp_gpio_irq_handler(int irq, void *data)
 		int_bits = level | event;
 
 		for_each_set_bit(bit, &int_bits, gc->ngpio)
-			generic_handle_irq(
-				irq_linear_revmap(gc->irq.domain, bit));
+			generic_handle_domain_irq(gc->irq.domain, bit);
 	}
 
 	return  int_bits ? IRQ_HANDLED : IRQ_NONE;
diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 394a421..8f23d12 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1444,7 +1444,6 @@ static void byt_gpio_irq_handler(struct irq_desc *desc)
 	u32 base, pin;
 	void __iomem *reg;
 	unsigned long pending;
-	unsigned int virq;
 
 	/* check from GPIO controller which pin triggered the interrupt */
 	for (base = 0; base < vg->chip.ngpio; base += 32) {
@@ -1460,10 +1459,8 @@ static void byt_gpio_irq_handler(struct irq_desc *desc)
 		raw_spin_lock(&byt_lock);
 		pending = readl(reg);
 		raw_spin_unlock(&byt_lock);
-		for_each_set_bit(pin, &pending, 32) {
-			virq = irq_find_mapping(vg->chip.irq.domain, base + pin);
-			generic_handle_irq(virq);
-		}
+		for_each_set_bit(pin, &pending, 32)
+			generic_handle_domain_irq(vg->chip.irq.domain, base + pin);
 	}
 	chip->irq_eoi(data);
 }
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 2ed17cd..9800990 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1409,11 +1409,10 @@ static void chv_gpio_irq_handler(struct irq_desc *desc)
 	raw_spin_unlock_irqrestore(&chv_lock, flags);
 
 	for_each_set_bit(intr_line, &pending, community->nirqs) {
-		unsigned int irq, offset;
+		unsigned int offset;
 
 		offset = cctx->intr_lines[intr_line];
-		irq = irq_find_mapping(gc->irq.domain, offset);
-		generic_handle_irq(irq);
+		generic_handle_domain_irq(gc->irq.domain, offset);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index 0a48ca4..561fa32 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -653,12 +653,8 @@ static void lp_gpio_irq_handler(struct irq_desc *desc)
 		/* Only interrupts that are enabled */
 		pending = ioread32(reg) & ioread32(ena);
 
-		for_each_set_bit(pin, &pending, 32) {
-			unsigned int irq;
-
-			irq = irq_find_mapping(lg->chip.irq.domain, base + pin);
-			generic_handle_irq(irq);
-		}
+		for_each_set_bit(pin, &pending, 32)
+			generic_handle_domain_irq(lg->chip.irq.domain, base + pin);
 	}
 	chip->irq_eoi(data);
 }
diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
index 3b9b5db..f7b54a5 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.c
+++ b/drivers/pinctrl/mediatek/mtk-eint.c
@@ -319,7 +319,7 @@ static void mtk_eint_irq_handler(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct mtk_eint *eint = irq_desc_get_handler_data(desc);
 	unsigned int status, eint_num;
-	int offset, mask_offset, index, virq;
+	int offset, mask_offset, index;
 	void __iomem *reg =  mtk_eint_get_offset(eint, 0, eint->regs->stat);
 	int dual_edge, start_level, curr_level;
 
@@ -331,7 +331,6 @@ static void mtk_eint_irq_handler(struct irq_desc *desc)
 			offset = __ffs(status);
 			mask_offset = eint_num >> 5;
 			index = eint_num + offset;
-			virq = irq_find_mapping(eint->domain, index);
 			status &= ~BIT(offset);
 
 			/*
@@ -361,7 +360,7 @@ static void mtk_eint_irq_handler(struct irq_desc *desc)
 								 index);
 			}
 
-			generic_handle_irq(virq);
+			generic_handle_domain_irq(eint->domain, index);
 
 			if (dual_edge) {
 				curr_level = mtk_eint_flip_edge(eint, index);
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index abfe11c..39828e9 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -815,7 +815,7 @@ static void nmk_gpio_irq_handler(struct irq_desc *desc)
 	while (status) {
 		int bit = __ffs(status);
 
-		generic_handle_irq(irq_find_mapping(chip->irq.domain, bit));
+		generic_handle_domain_irq(chip->irq.domain, bit);
 		status &= ~BIT(bit);
 	}
 
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index bb1ea47..4d81908 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -231,7 +231,7 @@ static void npcmgpio_irq_handler(struct irq_desc *desc)
 
 	sts &= en;
 	for_each_set_bit(bit, (const void *)&sts, NPCM7XX_GPIO_PER_BANK)
-		generic_handle_irq(irq_linear_revmap(gc->irq.domain, bit));
+		generic_handle_domain_irq(gc->irq.domain, bit);
 	chained_irq_exit(chip, desc);
 }
 
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index a76be6c..11625ed 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -621,14 +621,12 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
 			if (!(regval & PIN_IRQ_PENDING) ||
 			    !(regval & BIT(INTERRUPT_MASK_OFF)))
 				continue;
-			irq = irq_find_mapping(gc->irq.domain, irqnr + i);
-			if (irq != 0)
-				generic_handle_irq(irq);
+			generic_handle_domain_irq(gc->irq.domain, irqnr + i);
 
 			/* Clear interrupt.
 			 * We must read the pin register again, in case the
 			 * value was changed while executing
-			 * generic_handle_irq() above.
+			 * generic_handle_domain_irq() above.
 			 * If we didn't find a mapping for the interrupt,
 			 * disable it in order to avoid a system hang caused
 			 * by an interrupt storm.
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 72e6df7..6022496 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1712,10 +1712,8 @@ static void gpio_irq_handler(struct irq_desc *desc)
 			continue;
 		}
 
-		for_each_set_bit(n, &isr, BITS_PER_LONG) {
-			generic_handle_irq(irq_find_mapping(
-					   gpio_chip->irq.domain, n));
-		}
+		for_each_set_bit(n, &isr, BITS_PER_LONG)
+			generic_handle_domain_irq(gpio_chip->irq.domain, n);
 	}
 	chained_irq_exit(chip, desc);
 	/* now it may re-trigger */
diff --git a/drivers/pinctrl/pinctrl-equilibrium.c b/drivers/pinctrl/pinctrl-equilibrium.c
index 38cc20f..fb713f9 100644
--- a/drivers/pinctrl/pinctrl-equilibrium.c
+++ b/drivers/pinctrl/pinctrl-equilibrium.c
@@ -155,7 +155,7 @@ static void eqbr_irq_handler(struct irq_desc *desc)
 	pins = readl(gctrl->membase + GPIO_IRNCR);
 
 	for_each_set_bit(offset, &pins, gc->ngpio)
-		generic_handle_irq(irq_find_mapping(gc->irq.domain, offset));
+		generic_handle_domain_irq(gc->irq.domain, offset);
 
 	chained_irq_exit(ic, desc);
 }
diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 983ba98..ce9cc71 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -3080,7 +3080,7 @@ static void ingenic_gpio_irq_handler(struct irq_desc *desc)
 		flag = ingenic_gpio_read_reg(jzgc, JZ4730_GPIO_GPFR);
 
 	for_each_set_bit(i, &flag, 32)
-		generic_handle_irq(irq_linear_revmap(gc->irq.domain, i));
+		generic_handle_domain_irq(gc->irq.domain, i);
 	chained_irq_exit(irq_chip, desc);
 }
 
diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index 165cb7a..072bccd 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -673,7 +673,7 @@ static void sgpio_irq_handler(struct irq_desc *desc)
 
 		for_each_set_bit(port, &val, SGPIO_BITS_PER_WORD) {
 			gpio = sgpio_addr_to_pin(priv, port, bit);
-			generic_handle_irq(irq_linear_revmap(chip->irq.domain, gpio));
+			generic_handle_domain_irq(chip->irq.domain, gpio);
 		}
 
 		chained_irq_exit(parent_chip, desc);
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index e470c16..0a36ec8 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1290,8 +1290,7 @@ static void ocelot_irq_handler(struct irq_desc *desc)
 
 		for_each_set_bit(irq, &irqs,
 				 min(32U, info->desc->npins - 32 * i))
-			generic_handle_irq(irq_linear_revmap(chip->irq.domain,
-							     irq + 32 * i));
+			generic_handle_domain_irq(chip->irq.domain, irq + 32 * i);
 
 		chained_irq_exit(parent_chip, desc);
 	}
diff --git a/drivers/pinctrl/pinctrl-oxnas.c b/drivers/pinctrl/pinctrl-oxnas.c
index 5a31227..cebd810 100644
--- a/drivers/pinctrl/pinctrl-oxnas.c
+++ b/drivers/pinctrl/pinctrl-oxnas.c
@@ -1055,7 +1055,7 @@ static void oxnas_gpio_irq_handler(struct irq_desc *desc)
 	stat = readl(bank->reg_base + IRQ_PENDING);
 
 	for_each_set_bit(pin, &stat, BITS_PER_LONG)
-		generic_handle_irq(irq_linear_revmap(gc->irq.domain, pin));
+		generic_handle_domain_irq(gc->irq.domain, pin);
 
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/pinctrl/pinctrl-pic32.c b/drivers/pinctrl/pinctrl-pic32.c
index a6e2a4a..748dabd 100644
--- a/drivers/pinctrl/pinctrl-pic32.c
+++ b/drivers/pinctrl/pinctrl-pic32.c
@@ -2101,7 +2101,7 @@ static void pic32_gpio_irq_handler(struct irq_desc *desc)
 	pending = pic32_gpio_get_pending(gc, stat);
 
 	for_each_set_bit(pin, &pending, BITS_PER_LONG)
-		generic_handle_irq(irq_linear_revmap(gc->irq.domain, pin));
+		generic_handle_domain_irq(gc->irq.domain, pin);
 
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
index ec761ba..8d271c6 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -1306,7 +1306,7 @@ static void pistachio_gpio_irq_handler(struct irq_desc *desc)
 	pending = gpio_readl(bank, GPIO_INTERRUPT_STATUS) &
 		gpio_readl(bank, GPIO_INTERRUPT_EN);
 	for_each_set_bit(pin, &pending, 16)
-		generic_handle_irq(irq_linear_revmap(gc->irq.domain, pin));
+		generic_handle_domain_irq(gc->irq.domain, pin);
 	chained_irq_exit(chip, desc);
 }
 
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 067fc42..d67aa53 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2951,18 +2951,11 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 	pend = readl_relaxed(bank->reg_base + GPIO_INT_STATUS);
 
 	while (pend) {
-		unsigned int irq, virq;
+		unsigned int irq;
+		int ret;
 
 		irq = __ffs(pend);
 		pend &= ~BIT(irq);
-		virq = irq_find_mapping(bank->domain, irq);
-
-		if (!virq) {
-			dev_err(bank->drvdata->dev, "unmapped irq %d\n", irq);
-			continue;
-		}
-
-		dev_dbg(bank->drvdata->dev, "handling irq %d\n", irq);
 
 		/*
 		 * Triggering IRQ on both rising and falling edge
@@ -2993,7 +2986,9 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 			} while ((data & BIT(irq)) != (data_old & BIT(irq)));
 		}
 
-		generic_handle_irq(virq);
+		ret = generic_handle_domain_irq(bank->domain, irq);
+		if (unlikely(ret))
+			dev_err_ratelimited(bank->drvdata->dev, "unmapped irq %d\n", irq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index e3aa647..aa6e722 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1491,8 +1491,8 @@ static int pcs_irq_handle(struct pcs_soc_data *pcs_soc)
 		mask = pcs->read(pcswi->reg);
 		raw_spin_unlock(&pcs->lock);
 		if (mask & pcs_soc->irq_status_mask) {
-			generic_handle_irq(irq_find_mapping(pcs->domain,
-							    pcswi->hwirq));
+			generic_handle_domain_irq(pcs->domain,
+						  pcswi->hwirq);
 			count++;
 		}
 	}
diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 43d9e6c..fa3edb4 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1420,7 +1420,7 @@ static void __gpio_irq_handler(struct st_gpio_bank *bank)
 					continue;
 			}
 
-			generic_handle_irq(irq_find_mapping(bank->gpio_chip.irq.domain, n));
+			generic_handle_domain_irq(bank->gpio_chip.irq.domain, n);
 		}
 	}
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index d70caec..8476a8a 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1177,7 +1177,6 @@ static void msm_gpio_irq_handler(struct irq_desc *desc)
 	const struct msm_pingroup *g;
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int irq_pin;
 	int handled = 0;
 	u32 val;
 	int i;
@@ -1192,8 +1191,7 @@ static void msm_gpio_irq_handler(struct irq_desc *desc)
 		g = &pctrl->soc->groups[i];
 		val = msm_readl_intr_status(pctrl, g);
 		if (val & BIT(g->intr_status_bit)) {
-			irq_pin = irq_find_mapping(gc->irq.domain, i);
-			generic_handle_irq(irq_pin);
+			generic_handle_domain_irq(gc->irq.domain, i);
 			handled++;
 		}
 	}
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 2b99f41..0489c89 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -246,7 +246,8 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *data)
 {
 	struct samsung_pinctrl_drv_data *d = data;
 	struct samsung_pin_bank *bank = d->pin_banks;
-	unsigned int svc, group, pin, virq;
+	unsigned int svc, group, pin;
+	int ret;
 
 	svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
 	group = EXYNOS_SVC_GROUP(svc);
@@ -256,10 +257,10 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *data)
 		return IRQ_HANDLED;
 	bank += (group - 1);
 
-	virq = irq_linear_revmap(bank->irq_domain, pin);
-	if (!virq)
+	ret = generic_handle_domain_irq(bank->irq_domain, pin);
+	if (ret)
 		return IRQ_NONE;
-	generic_handle_irq(virq);
+
 	return IRQ_HANDLED;
 }
 
@@ -473,12 +474,10 @@ static void exynos_irq_eint0_15(struct irq_desc *desc)
 	struct exynos_weint_data *eintd = irq_desc_get_handler_data(desc);
 	struct samsung_pin_bank *bank = eintd->bank;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int eint_irq;
 
 	chained_irq_enter(chip, desc);
 
-	eint_irq = irq_linear_revmap(bank->irq_domain, eintd->irq);
-	generic_handle_irq(eint_irq);
+	generic_handle_domain_irq(bank->irq_domain, eintd->irq);
 
 	chained_irq_exit(chip, desc);
 }
@@ -490,7 +489,7 @@ static inline void exynos_irq_demux_eint(unsigned int pend,
 
 	while (pend) {
 		irq = fls(pend) - 1;
-		generic_handle_irq(irq_find_mapping(domain, irq));
+		generic_handle_domain_irq(domain, irq);
 		pend &= ~(1 << irq);
 	}
 }
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
index 00d77d6..ac1eba3 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -234,14 +234,12 @@ static void s3c2410_demux_eint0_3(struct irq_desc *desc)
 {
 	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct s3c24xx_eint_data *eint_data = irq_desc_get_handler_data(desc);
-	unsigned int virq;
+	int ret;
 
 	/* the first 4 eints have a simple 1 to 1 mapping */
-	virq = irq_linear_revmap(eint_data->domains[data->hwirq], data->hwirq);
+	ret = generic_handle_domain_irq(eint_data->domains[data->hwirq], data->hwirq);
 	/* Something must be really wrong if an unmapped EINT is unmasked */
-	BUG_ON(!virq);
-
-	generic_handle_irq(virq);
+	BUG_ON(ret);
 }
 
 /* Handling of EINTs 0-3 on S3C2412 and S3C2413 */
@@ -290,16 +288,14 @@ static void s3c2412_demux_eint0_3(struct irq_desc *desc)
 	struct s3c24xx_eint_data *eint_data = irq_desc_get_handler_data(desc);
 	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
-	unsigned int virq;
+	int ret;
 
 	chained_irq_enter(chip, desc);
 
 	/* the first 4 eints have a simple 1 to 1 mapping */
-	virq = irq_linear_revmap(eint_data->domains[data->hwirq], data->hwirq);
+	ret = generic_handle_domain_irq(eint_data->domains[data->hwirq], data->hwirq);
 	/* Something must be really wrong if an unmapped EINT is unmasked */
-	BUG_ON(!virq);
-
-	generic_handle_irq(virq);
+	BUG_ON(ret);
 
 	chained_irq_exit(chip, desc);
 }
@@ -364,15 +360,14 @@ static inline void s3c24xx_demux_eint(struct irq_desc *desc,
 	pend &= range;
 
 	while (pend) {
-		unsigned int virq, irq;
+		unsigned int irq;
+		int ret;
 
 		irq = __ffs(pend);
 		pend &= ~(1 << irq);
-		virq = irq_linear_revmap(data->domains[irq], irq - offset);
+		ret = generic_handle_domain_irq(data->domains[irq], irq - offset);
 		/* Something is really wrong if an unmapped EINT is unmasked */
-		BUG_ON(!virq);
-
-		generic_handle_irq(virq);
+		BUG_ON(ret);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
index 53e2a64..c5f95a1 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
@@ -414,7 +414,7 @@ static void s3c64xx_eint_gpio_irq(struct irq_desc *desc)
 		unsigned int svc;
 		unsigned int group;
 		unsigned int pin;
-		unsigned int virq;
+		int ret;
 
 		svc = readl(drvdata->virt_base + SERVICE_REG);
 		group = SVC_GROUP(svc);
@@ -431,14 +431,12 @@ static void s3c64xx_eint_gpio_irq(struct irq_desc *desc)
 				pin -= 8;
 		}
 
-		virq = irq_linear_revmap(data->domains[group], pin);
+		ret = generic_handle_domain_irq(data->domains[group], pin);
 		/*
 		 * Something must be really wrong if an unmapped EINT
 		 * was unmasked...
 		 */
-		BUG_ON(!virq);
-
-		generic_handle_irq(virq);
+		BUG_ON(ret);
 	} while (1);
 
 	chained_irq_exit(chip, desc);
@@ -607,18 +605,17 @@ static inline void s3c64xx_irq_demux_eint(struct irq_desc *desc, u32 range)
 	pend &= range;
 
 	while (pend) {
-		unsigned int virq, irq;
+		unsigned int irq;
+		int ret;
 
 		irq = fls(pend) - 1;
 		pend &= ~(1 << irq);
-		virq = irq_linear_revmap(data->domains[irq], data->pins[irq]);
+		ret = generic_handle_domain_irq(data->domains[irq], data->pins[irq]);
 		/*
 		 * Something must be really wrong if an unmapped EINT
 		 * was unmasked...
 		 */
-		BUG_ON(!virq);
-
-		generic_handle_irq(virq);
+		BUG_ON(ret);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/pinctrl-plgpio.c
index 1ebbc49..43bb334 100644
--- a/drivers/pinctrl/spear/pinctrl-plgpio.c
+++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
@@ -400,8 +400,7 @@ static void plgpio_irq_handler(struct irq_desc *desc)
 
 			/* get correct irq line number */
 			pin = i * MAX_GPIO_PER_REG + pin;
-			generic_handle_irq(
-				irq_find_mapping(gc->irq.domain, pin));
+			generic_handle_domain_irq(gc->irq.domain, pin);
 		}
 	}
 	chained_irq_exit(irqchip, desc);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index dc8d39a..baa4058 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1149,11 +1149,9 @@ static void sunxi_pinctrl_irq_handler(struct irq_desc *desc)
 	if (val) {
 		int irqoffset;
 
-		for_each_set_bit(irqoffset, &val, IRQ_PER_BANK) {
-			int pin_irq = irq_find_mapping(pctl->domain,
-						       bank * IRQ_PER_BANK + irqoffset);
-			generic_handle_irq(pin_irq);
-		}
+		for_each_set_bit(irqoffset, &val, IRQ_PER_BANK)
+			generic_handle_domain_irq(pctl->domain,
+						  bank * IRQ_PER_BANK + irqoffset);
 	}
 
 	chained_irq_exit(chip, desc);

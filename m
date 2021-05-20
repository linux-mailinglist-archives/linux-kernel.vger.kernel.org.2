Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177D038B4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhETQ6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233818AbhETQ6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:58:41 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E35E61353;
        Thu, 20 May 2021 16:57:19 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgs-002d7b-Hu; Thu, 20 May 2021 17:38:30 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
Subject: [PATCH 29/39] pinctrl: Bulk conversion to generic_handle_domain_irq()
Date:   Thu, 20 May 2021 17:37:41 +0100
Message-Id: <20210520163751.27325-30-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520163751.27325-1-maz@kernel.org>
References: <20210520163751.27325-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, ley.foon.tan@intel.com, chris@zankel.net, jcmvbkbc@gmail.com, vgupta@synopsys.com, tsbogend@alpha.franken.de, robert.jarzmik@free.fr, linux@armlinux.org.uk, krzysztof.kozlowski@canonical.com, ysato@users.sourceforge.jp, dalias@libc.org, geert@linux-m68k.org, alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch, robdclark@gmail.com, linus.walleij@linaro.org, lee.jones@linaro.org, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, bgolaszewski@baylibre.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pinctrl/actions/pinctrl-owl.c      |  5 ++---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c      |  4 ++--
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c   |  3 +--
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c     |  3 +--
 drivers/pinctrl/intel/pinctrl-baytrail.c   |  7 ++----
 drivers/pinctrl/intel/pinctrl-cherryview.c |  5 ++---
 drivers/pinctrl/intel/pinctrl-lynxpoint.c  |  8 ++-----
 drivers/pinctrl/mediatek/mtk-eint.c        |  5 ++---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c  |  2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c  |  2 +-
 drivers/pinctrl/pinctrl-amd.c              |  6 ++----
 drivers/pinctrl/pinctrl-at91.c             |  6 ++----
 drivers/pinctrl/pinctrl-equilibrium.c      |  2 +-
 drivers/pinctrl/pinctrl-ingenic.c          |  2 +-
 drivers/pinctrl/pinctrl-microchip-sgpio.c  |  2 +-
 drivers/pinctrl/pinctrl-ocelot.c           |  3 +--
 drivers/pinctrl/pinctrl-oxnas.c            |  2 +-
 drivers/pinctrl/pinctrl-pic32.c            |  2 +-
 drivers/pinctrl/pinctrl-pistachio.c        |  2 +-
 drivers/pinctrl/pinctrl-rockchip.c         | 15 +++++--------
 drivers/pinctrl/pinctrl-single.c           |  4 ++--
 drivers/pinctrl/pinctrl-st.c               |  2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c         |  4 +---
 drivers/pinctrl/samsung/pinctrl-exynos.c   | 15 ++++++-------
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c  | 25 +++++++++-------------
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c  | 17 ++++++---------
 drivers/pinctrl/spear/pinctrl-plgpio.c     |  3 +--
 drivers/pinctrl/sunxi/pinctrl-sunxi.c      |  8 +++----
 28 files changed, 64 insertions(+), 100 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index c8b3e396ea27..781f2200ed58 100644
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
index 1d21129f7751..fd8db72aa01e 100644
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
index e2bd2dce6bb4..be3918a0d250 100644
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
index a00a42a61a90..e03142895f61 100644
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
index 394a421a19d5..8f23d126c6a7 100644
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
index 2ed17cdf946d..980099028cf8 100644
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
index 0a48ca46ab59..561fa322b0b4 100644
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
index 3b9b5dbd7968..f7b54a551764 100644
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
index abfe11c7b49f..39828e9c3120 100644
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
index 2535ca720668..8afc8839fe69 100644
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
index 2d4acf21117c..386217012003 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -591,14 +591,12 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
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
index fc61aaec34cc..50ff37cdee3f 100644
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
index a194d8089b6f..da218b23985e 100644
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
index 983ba9865f77..ce9cc719c395 100644
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
index c12fa57ebd12..51f81976c136 100644
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
index 2fd18e356d0c..c15d7c8593ab 100644
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
index 5a312279b3c7..cebd810bd6d1 100644
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
index a6e2a4a4ca95..748dabd8db6e 100644
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
index ec761ba2a2da..8d271c6b0ca4 100644
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
index 067fc4208de4..d67aa53d0dce 100644
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
index 2c9c9835f375..bd318571e4f8 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1488,8 +1488,8 @@ static int pcs_irq_handle(struct pcs_soc_data *pcs_soc)
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
index 43d9e6c7fd81..fa3edb4b898a 100644
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
index d70caecd21d2..8476a8ac4451 100644
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
index 2b99f4130e1e..0489c899b401 100644
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
index 00d77d6946b5..ac1eba30cf40 100644
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
index 53e2a6412add..c5f95a1071ae 100644
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
index 1ebbc49b16f1..43bb334af1e1 100644
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
index dc8d39ae045b..baa4058e024e 100644
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
-- 
2.30.2


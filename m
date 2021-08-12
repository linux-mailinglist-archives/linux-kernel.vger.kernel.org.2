Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C870F3EA31F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbhHLKtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:49:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57708 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbhHLKra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:30 -0400
Date:   Thu, 12 Aug 2021 10:47:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5qrBbS7Qq0+GfpgcHCZ5K0Kk07d+KdJmqNFA/YsAiD8=;
        b=duvX80sNWS1ep9B2FcvKC0gIRbjFlWPjKHsXChV2jSUE/iRPMeEJsytv9RiyoK37PtAtwL
        rJEaeLydHlPgFG7lpPumrJbqn/8l9SKTrePyMWLM27aE1svg2XQnLnyrh8IpNOIIwyNIAS
        KFeTsY1BGGGiTZN/nxoy2xwvp/ndb2dxg8v7pwzwI6aJ9uJWCJj3wukiqfQ4XUd2NnCYfm
        0x2Q8rGU2ZcodiLjITqRZGy7Z4SFdPvDh50P6mekx8GyA3GWupVdhNLwJRDyGUG98Mm2e+
        PmDh6twn/EfdaN6qcrzxbWARS/gKdvM87qKFazHQ/IKRECcDNglm4d+GVzPYZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5qrBbS7Qq0+GfpgcHCZ5K0Kk07d+KdJmqNFA/YsAiD8=;
        b=J9Ow0fQAHdVCltsRkbeT4CWuVNqNmGfk0XWdr1ISZHlBWii5UiKqc9kqfbeR82bLgyNFPz
        xAz6H1COmUFQfACg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: Bulk conversion to
 generic_handle_domain_irq()
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162876522360.395.16429887750742731317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     dbd1c54fc82051bf7f3271b43517281f5b2cff51
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/dbd1c54fc82051bf7f3271b43517281f5b2cff51
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 17:42:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 11:39:38 +01:00

gpio: Bulk conversion to generic_handle_domain_irq()

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpio/gpio-104-dio-48e.c  |  4 ++--
 drivers/gpio/gpio-104-idi-48.c   |  4 ++--
 drivers/gpio/gpio-104-idio-16.c  |  2 +-
 drivers/gpio/gpio-altera.c       | 11 +++++------
 drivers/gpio/gpio-aspeed-sgpio.c |  9 +++------
 drivers/gpio/gpio-aspeed.c       |  9 +++------
 drivers/gpio/gpio-ath79.c        |  7 ++-----
 drivers/gpio/gpio-bcm-kona.c     |  6 ++----
 drivers/gpio/gpio-brcmstb.c      |  5 ++---
 drivers/gpio/gpio-cadence.c      |  2 +-
 drivers/gpio/gpio-davinci.c      |  3 +--
 drivers/gpio/gpio-dln2.c         | 22 +++++++++-------------
 drivers/gpio/gpio-em.c           |  2 +-
 drivers/gpio/gpio-ep93xx.c       |  8 ++++----
 drivers/gpio/gpio-ftgpio010.c    |  3 +--
 drivers/gpio/gpio-hisi.c         |  4 ++--
 drivers/gpio/gpio-hlwd.c         |  7 ++-----
 drivers/gpio/gpio-merrifield.c   |  8 ++------
 drivers/gpio/gpio-mpc8xxx.c      |  2 +-
 drivers/gpio/gpio-mt7621.c       |  4 +---
 drivers/gpio/gpio-mxc.c          |  2 +-
 drivers/gpio/gpio-mxs.c          |  2 +-
 drivers/gpio/gpio-omap.c         |  3 +--
 drivers/gpio/gpio-pci-idio-16.c  |  2 +-
 drivers/gpio/gpio-pcie-idio-24.c |  3 +--
 drivers/gpio/gpio-pl061.c        |  4 ++--
 drivers/gpio/gpio-pxa.c          |  9 ++++-----
 drivers/gpio/gpio-rcar.c         |  4 ++--
 drivers/gpio/gpio-rda.c          |  8 +++-----
 drivers/gpio/gpio-realtek-otto.c |  7 ++-----
 drivers/gpio/gpio-sch.c          |  2 +-
 drivers/gpio/gpio-sodaville.c    |  2 +-
 drivers/gpio/gpio-sprd.c         | 12 ++++--------
 drivers/gpio/gpio-tb10x.c        |  2 +-
 drivers/gpio/gpio-tegra.c        |  9 ++++-----
 drivers/gpio/gpio-tegra186.c     |  9 +++------
 drivers/gpio/gpio-tqmx86.c       | 10 ++++------
 drivers/gpio/gpio-vf610.c        |  2 +-
 drivers/gpio/gpio-ws16c48.c      |  4 ++--
 drivers/gpio/gpio-xgs-iproc.c    |  2 +-
 drivers/gpio/gpio-xilinx.c       |  2 +-
 drivers/gpio/gpio-xlp.c          |  3 +--
 drivers/gpio/gpio-zynq.c         |  8 ++------
 43 files changed, 91 insertions(+), 142 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 71c0bea..6bf4104 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -336,8 +336,8 @@ static irqreturn_t dio48e_irq_handler(int irq, void *dev_id)
 	unsigned long gpio;
 
 	for_each_set_bit(gpio, &irq_mask, 2)
-		generic_handle_irq(irq_find_mapping(chip->irq.domain,
-			19 + gpio*24));
+		generic_handle_domain_irq(chip->irq.domain,
+					  19 + gpio*24);
 
 	raw_spin_lock(&dio48egpio->lock);
 
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index b132afa..34be7dd 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -223,8 +223,8 @@ static irqreturn_t idi_48_irq_handler(int irq, void *dev_id)
 		for_each_set_bit(bit_num, &irq_mask, 8) {
 			gpio = bit_num + boundary * 8;
 
-			generic_handle_irq(irq_find_mapping(chip->irq.domain,
-				gpio));
+			generic_handle_domain_irq(chip->irq.domain,
+						  gpio);
 		}
 	}
 
diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index 55b4029..c68ed1a 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -208,7 +208,7 @@ static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
 	int gpio;
 
 	for_each_set_bit(gpio, &idio16gpio->irq_mask, chip->ngpio)
-		generic_handle_irq(irq_find_mapping(chip->irq.domain, gpio));
+		generic_handle_domain_irq(chip->irq.domain, gpio);
 
 	raw_spin_lock(&idio16gpio->lock);
 
diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index b7932ec..b59fae9 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -201,9 +201,8 @@ static void altera_gpio_irq_edge_handler(struct irq_desc *desc)
 	      (readl(mm_gc->regs + ALTERA_GPIO_EDGE_CAP) &
 	      readl(mm_gc->regs + ALTERA_GPIO_IRQ_MASK)))) {
 		writel(status, mm_gc->regs + ALTERA_GPIO_EDGE_CAP);
-		for_each_set_bit(i, &status, mm_gc->gc.ngpio) {
-			generic_handle_irq(irq_find_mapping(irqdomain, i));
-		}
+		for_each_set_bit(i, &status, mm_gc->gc.ngpio)
+			generic_handle_domain_irq(irqdomain, i);
 	}
 
 	chained_irq_exit(chip, desc);
@@ -228,9 +227,9 @@ static void altera_gpio_irq_leveL_high_handler(struct irq_desc *desc)
 	status = readl(mm_gc->regs + ALTERA_GPIO_DATA);
 	status &= readl(mm_gc->regs + ALTERA_GPIO_IRQ_MASK);
 
-	for_each_set_bit(i, &status, mm_gc->gc.ngpio) {
-		generic_handle_irq(irq_find_mapping(irqdomain, i));
-	}
+	for_each_set_bit(i, &status, mm_gc->gc.ngpio)
+		generic_handle_domain_irq(irqdomain, i);
+
 	chained_irq_exit(chip, desc);
 }
 
diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 64e54f8..a99ece1 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -392,7 +392,7 @@ static void aspeed_sgpio_irq_handler(struct irq_desc *desc)
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct irq_chip *ic = irq_desc_get_chip(desc);
 	struct aspeed_sgpio *data = gpiochip_get_data(gc);
-	unsigned int i, p, girq;
+	unsigned int i, p;
 	unsigned long reg;
 
 	chained_irq_enter(ic, desc);
@@ -402,11 +402,8 @@ static void aspeed_sgpio_irq_handler(struct irq_desc *desc)
 
 		reg = ioread32(bank_reg(data, bank, reg_irq_status));
 
-		for_each_set_bit(p, &reg, 32) {
-			girq = irq_find_mapping(gc->irq.domain, i * 32 + p);
-			generic_handle_irq(girq);
-		}
-
+		for_each_set_bit(p, &reg, 32)
+			generic_handle_domain_irq(gc->irq.domain, i * 32 + p);
 	}
 
 	chained_irq_exit(ic, desc);
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index b966f5e..3c8f20c 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -661,7 +661,7 @@ static void aspeed_gpio_irq_handler(struct irq_desc *desc)
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct irq_chip *ic = irq_desc_get_chip(desc);
 	struct aspeed_gpio *data = gpiochip_get_data(gc);
-	unsigned int i, p, girq, banks;
+	unsigned int i, p, banks;
 	unsigned long reg;
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
 
@@ -673,11 +673,8 @@ static void aspeed_gpio_irq_handler(struct irq_desc *desc)
 
 		reg = ioread32(bank_reg(data, bank, reg_irq_status));
 
-		for_each_set_bit(p, &reg, 32) {
-			girq = irq_find_mapping(gc->irq.domain, i * 32 + p);
-			generic_handle_irq(girq);
-		}
-
+		for_each_set_bit(p, &reg, 32)
+			generic_handle_domain_irq(gc->irq.domain, i * 32 + p);
 	}
 
 	chained_irq_exit(ic, desc);
diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index 9b780dc..3958c6d 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -204,11 +204,8 @@ static void ath79_gpio_irq_handler(struct irq_desc *desc)
 
 	raw_spin_unlock_irqrestore(&ctrl->lock, flags);
 
-	if (pending) {
-		for_each_set_bit(irq, &pending, gc->ngpio)
-			generic_handle_irq(
-				irq_linear_revmap(gc->irq.domain, irq));
-	}
+	for_each_set_bit(irq, &pending, gc->ngpio)
+		generic_handle_domain_irq(gc->irq.domain, irq);
 
 	chained_irq_exit(irqchip, desc);
 }
diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 1e6b427..d329a14 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -466,9 +466,6 @@ static void bcm_kona_gpio_irq_handler(struct irq_desc *desc)
 		    (~(readl(reg_base + GPIO_INT_MASK(bank_id)))))) {
 		for_each_set_bit(bit, &sta, 32) {
 			int hwirq = GPIO_PER_BANK * bank_id + bit;
-			int child_irq =
-				irq_find_mapping(bank->kona_gpio->irq_domain,
-						 hwirq);
 			/*
 			 * Clear interrupt before handler is called so we don't
 			 * miss any interrupt occurred during executing them.
@@ -476,7 +473,8 @@ static void bcm_kona_gpio_irq_handler(struct irq_desc *desc)
 			writel(readl(reg_base + GPIO_INT_STATUS(bank_id)) |
 			       BIT(bit), reg_base + GPIO_INT_STATUS(bank_id));
 			/* Invoke interrupt handler */
-			generic_handle_irq(child_irq);
+			generic_handle_domain_irq(bank->kona_gpio->irq_domain,
+						  hwirq);
 		}
 	}
 
diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index fcfc1a1..74b7c91 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -277,15 +277,14 @@ static void brcmstb_gpio_irq_bank_handler(struct brcmstb_gpio_bank *bank)
 	unsigned long status;
 
 	while ((status = brcmstb_gpio_get_active_irqs(bank))) {
-		unsigned int irq, offset;
+		unsigned int offset;
 
 		for_each_set_bit(offset, &status, 32) {
 			if (offset >= bank->width)
 				dev_warn(&priv->pdev->dev,
 					 "IRQ for invalid GPIO (bank=%d, offset=%d)\n",
 					 bank->id, offset);
-			irq = irq_linear_revmap(domain, hwbase + offset);
-			generic_handle_irq(irq);
+			generic_handle_domain_irq(domain, hwbase + offset);
 		}
 	}
 }
diff --git a/drivers/gpio/gpio-cadence.c b/drivers/gpio/gpio-cadence.c
index 4ab3fcd..562f8f7 100644
--- a/drivers/gpio/gpio-cadence.c
+++ b/drivers/gpio/gpio-cadence.c
@@ -133,7 +133,7 @@ static void cdns_gpio_irq_handler(struct irq_desc *desc)
 		~ioread32(cgpio->regs + CDNS_GPIO_IRQ_MASK);
 
 	for_each_set_bit(hwirq, &status, chip->ngpio)
-		generic_handle_irq(irq_find_mapping(chip->irq.domain, hwirq));
+		generic_handle_domain_irq(chip->irq.domain, hwirq);
 
 	chained_irq_exit(irqchip, desc);
 }
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 6f21385..cb5afaa 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -369,8 +369,7 @@ static void gpio_irq_handler(struct irq_desc *desc)
 			 */
 			hw_irq = (bank_num / 2) * 32 + bit;
 
-			generic_handle_irq(
-				irq_find_mapping(d->irq_domain, hw_irq));
+			generic_handle_domain_irq(d->irq_domain, hw_irq);
 		}
 	}
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
diff --git a/drivers/gpio/gpio-dln2.c b/drivers/gpio/gpio-dln2.c
index 4c5f6d0..026903e 100644
--- a/drivers/gpio/gpio-dln2.c
+++ b/drivers/gpio/gpio-dln2.c
@@ -395,7 +395,7 @@ static struct irq_chip dln2_gpio_irqchip = {
 static void dln2_gpio_event(struct platform_device *pdev, u16 echo,
 			    const void *data, int len)
 {
-	int pin, irq;
+	int pin, ret;
 
 	const struct {
 		__le16 count;
@@ -416,24 +416,20 @@ static void dln2_gpio_event(struct platform_device *pdev, u16 echo,
 		return;
 	}
 
-	irq = irq_find_mapping(dln2->gpio.irq.domain, pin);
-	if (!irq) {
-		dev_err(dln2->gpio.parent, "pin %d not mapped to IRQ\n", pin);
-		return;
-	}
-
 	switch (dln2->irq_type[pin]) {
 	case DLN2_GPIO_EVENT_CHANGE_RISING:
-		if (event->value)
-			generic_handle_irq(irq);
+		if (!event->value)
+			return;
 		break;
 	case DLN2_GPIO_EVENT_CHANGE_FALLING:
-		if (!event->value)
-			generic_handle_irq(irq);
+		if (event->value)
+			return;
 		break;
-	default:
-		generic_handle_irq(irq);
 	}
+
+	ret = generic_handle_domain_irq(dln2->gpio.irq.domain, pin);
+	if (unlikely(ret))
+		dev_err(dln2->gpio.parent, "pin %d not mapped to IRQ\n", pin);
 }
 
 static int dln2_gpio_probe(struct platform_device *pdev)
diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 17a243c..90b336e 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -173,7 +173,7 @@ static irqreturn_t em_gio_irq_handler(int irq, void *dev_id)
 	while ((pending = em_gio_read(p, GIO_MST))) {
 		offset = __ffs(pending);
 		em_gio_write(p, GIO_IIR, BIT(offset));
-		generic_handle_irq(irq_find_mapping(p->irq_domain, offset));
+		generic_handle_domain_irq(p->irq_domain, offset);
 		irqs_handled++;
 	}
 
diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index ef148b2..2e17797 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -128,13 +128,13 @@ static void ep93xx_gpio_ab_irq_handler(struct irq_desc *desc)
 	 */
 	stat = readb(epg->base + EP93XX_GPIO_A_INT_STATUS);
 	for_each_set_bit(offset, &stat, 8)
-		generic_handle_irq(irq_find_mapping(epg->gc[0].gc.irq.domain,
-						    offset));
+		generic_handle_domain_irq(epg->gc[0].gc.irq.domain,
+					  offset);
 
 	stat = readb(epg->base + EP93XX_GPIO_B_INT_STATUS);
 	for_each_set_bit(offset, &stat, 8)
-		generic_handle_irq(irq_find_mapping(epg->gc[1].gc.irq.domain,
-						    offset));
+		generic_handle_domain_irq(epg->gc[1].gc.irq.domain,
+					  offset);
 
 	chained_irq_exit(irqchip, desc);
 }
diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index 4031164..b90a45c 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -149,8 +149,7 @@ static void ftgpio_gpio_irq_handler(struct irq_desc *desc)
 	stat = readl(g->base + GPIO_INT_STAT_RAW);
 	if (stat)
 		for_each_set_bit(offset, &stat, gc->ngpio)
-			generic_handle_irq(irq_find_mapping(gc->irq.domain,
-							    offset));
+			generic_handle_domain_irq(gc->irq.domain, offset);
 
 	chained_irq_exit(irqchip, desc);
 }
diff --git a/drivers/gpio/gpio-hisi.c b/drivers/gpio/gpio-hisi.c
index ad3d4da..3caabef 100644
--- a/drivers/gpio/gpio-hisi.c
+++ b/drivers/gpio/gpio-hisi.c
@@ -186,8 +186,8 @@ static void hisi_gpio_irq_handler(struct irq_desc *desc)
 
 	chained_irq_enter(irq_c, desc);
 	for_each_set_bit(hwirq, &irq_msk, HISI_GPIO_LINE_NUM_MAX)
-		generic_handle_irq(irq_find_mapping(hisi_gpio->chip.irq.domain,
-						    hwirq));
+		generic_handle_domain_irq(hisi_gpio->chip.irq.domain,
+					  hwirq);
 	chained_irq_exit(irq_c, desc);
 }
 
diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
index 4a17599..641719a 100644
--- a/drivers/gpio/gpio-hlwd.c
+++ b/drivers/gpio/gpio-hlwd.c
@@ -97,11 +97,8 @@ static void hlwd_gpio_irqhandler(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	for_each_set_bit(hwirq, &pending, 32) {
-		int irq = irq_find_mapping(hlwd->gpioc.irq.domain, hwirq);
-
-		generic_handle_irq(irq);
-	}
+	for_each_set_bit(hwirq, &pending, 32)
+		generic_handle_domain_irq(hlwd->gpioc.irq.domain, hwirq);
 
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 22f3ce2..42c4d9d 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -359,12 +359,8 @@ static void mrfld_irq_handler(struct irq_desc *desc)
 		/* Only interrupts that are enabled */
 		pending &= enabled;
 
-		for_each_set_bit(gpio, &pending, 32) {
-			unsigned int irq;
-
-			irq = irq_find_mapping(gc->irq.domain, base + gpio);
-			generic_handle_irq(irq);
-		}
+		for_each_set_bit(gpio, &pending, 32)
+			generic_handle_domain_irq(gc->irq.domain, base + gpio);
 	}
 
 	chained_irq_exit(irqchip, desc);
diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 4b9157a..d05fd81 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -120,7 +120,7 @@ static irqreturn_t mpc8xxx_gpio_irq_cascade(int irq, void *data)
 	mask = gc->read_reg(mpc8xxx_gc->regs + GPIO_IER)
 		& gc->read_reg(mpc8xxx_gc->regs + GPIO_IMR);
 	for_each_set_bit(i, &mask, 32)
-		generic_handle_irq(irq_linear_revmap(mpc8xxx_gc->irq, 31 - i));
+		generic_handle_domain_irq(mpc8xxx_gc->irq, 31 - i);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index 82fb20d..10c0a9b 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -95,9 +95,7 @@ mediatek_gpio_irq_handler(int irq, void *data)
 	pending = mtk_gpio_r32(rg, GPIO_REG_STAT);
 
 	for_each_set_bit(bit, &pending, MTK_BANK_WIDTH) {
-		u32 map = irq_find_mapping(gc->irq.domain, bit);
-
-		generic_handle_irq(map);
+		generic_handle_domain_irq(gc->irq.domain, bit);
 		mtk_gpio_w32(rg, GPIO_REG_STAT, BIT(bit));
 		ret |= IRQ_HANDLED;
 	}
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index b9fdf05..c871602 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -241,7 +241,7 @@ static void mxc_gpio_irq_handler(struct mxc_gpio_port *port, u32 irq_stat)
 		if (port->both_edges & (1 << irqoffset))
 			mxc_flip_edge(port, irqoffset);
 
-		generic_handle_irq(irq_find_mapping(port->domain, irqoffset));
+		generic_handle_domain_irq(port->domain, irqoffset);
 
 		irq_stat &= ~(1 << irqoffset);
 	}
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 31a336b..c5166cd 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -157,7 +157,7 @@ static void mxs_gpio_irq_handler(struct irq_desc *desc)
 		if (port->both_edges & (1 << irqoffset))
 			mxs_flip_edge(port, irqoffset);
 
-		generic_handle_irq(irq_find_mapping(port->domain, irqoffset));
+		generic_handle_domain_irq(port->domain, irqoffset);
 		irq_stat &= ~(1 << irqoffset);
 	}
 }
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ca23f72..415e8df 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -611,8 +611,7 @@ static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
 
 			raw_spin_lock_irqsave(&bank->wa_lock, wa_lock_flags);
 
-			generic_handle_irq(irq_find_mapping(bank->chip.irq.domain,
-							    bit));
+			generic_handle_domain_irq(bank->chip.irq.domain, bit);
 
 			raw_spin_unlock_irqrestore(&bank->wa_lock,
 						   wa_lock_flags);
diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 9acec76..71a13a3 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -260,7 +260,7 @@ static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	for_each_set_bit(gpio, &idio16gpio->irq_mask, chip->ngpio)
-		generic_handle_irq(irq_find_mapping(chip->irq.domain, gpio));
+		generic_handle_domain_irq(chip->irq.domain, gpio);
 
 	raw_spin_lock(&idio16gpio->lock);
 
diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 2a07fd9..8a9b98f 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -468,8 +468,7 @@ static irqreturn_t idio_24_irq_handler(int irq, void *dev_id)
 	irq_mask = idio24gpio->irq_mask & irq_status;
 
 	for_each_set_bit(gpio, &irq_mask, chip->ngpio - 24)
-		generic_handle_irq(irq_find_mapping(chip->irq.domain,
-			gpio + 24));
+		generic_handle_domain_irq(chip->irq.domain, gpio + 24);
 
 	raw_spin_lock(&idio24gpio->lock);
 
diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index f1b53dd..4ecab70 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -223,8 +223,8 @@ static void pl061_irq_handler(struct irq_desc *desc)
 	pending = readb(pl061->base + GPIOMIS);
 	if (pending) {
 		for_each_set_bit(offset, &pending, PL061_GPIO_NR)
-			generic_handle_irq(irq_find_mapping(gc->irq.domain,
-							    offset));
+			generic_handle_domain_irq(gc->irq.domain,
+						  offset);
 	}
 
 	chained_irq_exit(irqchip, desc);
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 0cb6600..382468e 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -455,9 +455,8 @@ static irqreturn_t pxa_gpio_demux_handler(int in_irq, void *d)
 			for_each_set_bit(n, &gedr, BITS_PER_LONG) {
 				loop = 1;
 
-				generic_handle_irq(
-					irq_find_mapping(pchip->irqdomain,
-							 gpio + n));
+				generic_handle_domain_irq(pchip->irqdomain,
+							  gpio + n);
 			}
 		}
 		handled += loop;
@@ -471,9 +470,9 @@ static irqreturn_t pxa_gpio_direct_handler(int in_irq, void *d)
 	struct pxa_gpio_chip *pchip = d;
 
 	if (in_irq == pchip->irq0) {
-		generic_handle_irq(irq_find_mapping(pchip->irqdomain, 0));
+		generic_handle_domain_irq(pchip->irqdomain, 0);
 	} else if (in_irq == pchip->irq1) {
-		generic_handle_irq(irq_find_mapping(pchip->irqdomain, 1));
+		generic_handle_domain_irq(pchip->irqdomain, 1);
 	} else {
 		pr_err("%s() unknown irq %d\n", __func__, in_irq);
 		return IRQ_NONE;
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index e7092d5..b378aba 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -213,8 +213,8 @@ static irqreturn_t gpio_rcar_irq_handler(int irq, void *dev_id)
 			  gpio_rcar_read(p, INTMSK))) {
 		offset = __ffs(pending);
 		gpio_rcar_write(p, INTCLR, BIT(offset));
-		generic_handle_irq(irq_find_mapping(p->gpio_chip.irq.domain,
-						    offset));
+		generic_handle_domain_irq(p->gpio_chip.irq.domain,
+					  offset);
 		irqs_handled++;
 	}
 
diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
index 28dcbb5..4638464 100644
--- a/drivers/gpio/gpio-rda.c
+++ b/drivers/gpio/gpio-rda.c
@@ -181,7 +181,7 @@ static void rda_gpio_irq_handler(struct irq_desc *desc)
 	struct irq_chip *ic = irq_desc_get_chip(desc);
 	struct rda_gpio *rda_gpio = gpiochip_get_data(chip);
 	unsigned long status;
-	u32 n, girq;
+	u32 n;
 
 	chained_irq_enter(ic, desc);
 
@@ -189,10 +189,8 @@ static void rda_gpio_irq_handler(struct irq_desc *desc)
 	/* Only lower 8 bits are capable of generating interrupts */
 	status &= RDA_GPIO_IRQ_MASK;
 
-	for_each_set_bit(n, &status, RDA_GPIO_BANK_NR) {
-		girq = irq_find_mapping(chip->irq.domain, n);
-		generic_handle_irq(girq);
-	}
+	for_each_set_bit(n, &status, RDA_GPIO_BANK_NR)
+		generic_handle_domain_irq(chip->irq.domain, n);
 
 	chained_irq_exit(ic, desc);
 }
diff --git a/drivers/gpio/gpio-realtek-otto.c b/drivers/gpio/gpio-realtek-otto.c
index cb64fb5..eeeb39b 100644
--- a/drivers/gpio/gpio-realtek-otto.c
+++ b/drivers/gpio/gpio-realtek-otto.c
@@ -196,7 +196,6 @@ static void realtek_gpio_irq_handler(struct irq_desc *desc)
 	struct irq_chip *irq_chip = irq_desc_get_chip(desc);
 	unsigned int lines_done;
 	unsigned int port_pin_count;
-	unsigned int irq;
 	unsigned long status;
 	int offset;
 
@@ -205,10 +204,8 @@ static void realtek_gpio_irq_handler(struct irq_desc *desc)
 	for (lines_done = 0; lines_done < gc->ngpio; lines_done += 8) {
 		status = realtek_gpio_read_isr(ctrl, lines_done / 8);
 		port_pin_count = min(gc->ngpio - lines_done, 8U);
-		for_each_set_bit(offset, &status, port_pin_count) {
-			irq = irq_find_mapping(gc->irq.domain, offset);
-			generic_handle_irq(irq);
-		}
+		for_each_set_bit(offset, &status, port_pin_count)
+			generic_handle_domain_irq(gc->irq.domain, offset);
 	}
 
 	chained_irq_exit(irq_chip, desc);
diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index a6f0421..0600f71 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -259,7 +259,7 @@ static u32 sch_gpio_gpe_handler(acpi_handle gpe_device, u32 gpe, void *context)
 
 	pending = (resume_status << sch->resume_base) | core_status;
 	for_each_set_bit(offset, &pending, sch->chip.ngpio)
-		generic_handle_irq(irq_find_mapping(gc->irq.domain, offset));
+		generic_handle_domain_irq(gc->irq.domain, offset);
 
 	/* Set returning value depending on whether we handled an interrupt */
 	ret = pending ? ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
diff --git a/drivers/gpio/gpio-sodaville.c b/drivers/gpio/gpio-sodaville.c
index aed988e..c2a2c76 100644
--- a/drivers/gpio/gpio-sodaville.c
+++ b/drivers/gpio/gpio-sodaville.c
@@ -84,7 +84,7 @@ static irqreturn_t sdv_gpio_pub_irq_handler(int irq, void *data)
 		return IRQ_NONE;
 
 	for_each_set_bit(irq_bit, &irq_stat, 32)
-		generic_handle_irq(irq_find_mapping(sd->id, irq_bit));
+		generic_handle_domain_irq(sd->id, irq_bit);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index 25c37ed..9dd9dab 100644
--- a/drivers/gpio/gpio-sprd.c
+++ b/drivers/gpio/gpio-sprd.c
@@ -189,7 +189,7 @@ static void sprd_gpio_irq_handler(struct irq_desc *desc)
 	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
 	struct irq_chip *ic = irq_desc_get_chip(desc);
 	struct sprd_gpio *sprd_gpio = gpiochip_get_data(chip);
-	u32 bank, n, girq;
+	u32 bank, n;
 
 	chained_irq_enter(ic, desc);
 
@@ -198,13 +198,9 @@ static void sprd_gpio_irq_handler(struct irq_desc *desc)
 		unsigned long reg = readl_relaxed(base + SPRD_GPIO_MIS) &
 			SPRD_GPIO_BANK_MASK;
 
-		for_each_set_bit(n, &reg, SPRD_GPIO_BANK_NR) {
-			girq = irq_find_mapping(chip->irq.domain,
-						bank * SPRD_GPIO_BANK_NR + n);
-
-			generic_handle_irq(girq);
-		}
-
+		for_each_set_bit(n, &reg, SPRD_GPIO_BANK_NR)
+			generic_handle_domain_irq(chip->irq.domain,
+						  bank * SPRD_GPIO_BANK_NR + n);
 	}
 	chained_irq_exit(ic, desc);
 }
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 866201c..718a508 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -100,7 +100,7 @@ static irqreturn_t tb10x_gpio_irq_cascade(int irq, void *data)
 	int i;
 
 	for_each_set_bit(i, &bits, 32)
-		generic_handle_irq(irq_find_mapping(tb10x_gpio->domain, i));
+		generic_handle_domain_irq(tb10x_gpio->domain, i);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 0025f61..7f5bc10 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -408,6 +408,8 @@ static void tegra_gpio_irq_handler(struct irq_desc *desc)
 		lvl = tegra_gpio_readl(tgi, GPIO_INT_LVL(tgi, gpio));
 
 		for_each_set_bit(pin, &sta, 8) {
+			int ret;
+
 			tegra_gpio_writel(tgi, 1 << pin,
 					  GPIO_INT_CLR(tgi, gpio));
 
@@ -420,11 +422,8 @@ static void tegra_gpio_irq_handler(struct irq_desc *desc)
 				chained_irq_exit(chip, desc);
 			}
 
-			irq = irq_find_mapping(domain, gpio + pin);
-			if (WARN_ON(irq == 0))
-				continue;
-
-			generic_handle_irq(irq);
+			ret = generic_handle_domain_irq(domain, gpio + pin);
+			WARN_RATELIMIT(ret, "hwirq = %d", gpio + pin);
 		}
 	}
 
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index d38980b..05c90d7 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -456,7 +456,7 @@ static void tegra186_gpio_irq(struct irq_desc *desc)
 
 	for (i = 0; i < gpio->soc->num_ports; i++) {
 		const struct tegra_gpio_port *port = &gpio->soc->ports[i];
-		unsigned int pin, irq;
+		unsigned int pin;
 		unsigned long value;
 		void __iomem *base;
 
@@ -469,11 +469,8 @@ static void tegra186_gpio_irq(struct irq_desc *desc)
 		value = readl(base + TEGRA186_GPIO_INTERRUPT_STATUS(1));
 
 		for_each_set_bit(pin, &value, port->pins) {
-			irq = irq_find_mapping(domain, offset + pin);
-			if (WARN_ON(irq == 0))
-				continue;
-
-			generic_handle_irq(irq);
+			int ret = generic_handle_domain_irq(domain, offset + pin);
+			WARN_RATELIMIT(ret, "hwirq = %d", offset + pin);
 		}
 
 skip:
diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
index 5022e0a..e80ff42 100644
--- a/drivers/gpio/gpio-tqmx86.c
+++ b/drivers/gpio/gpio-tqmx86.c
@@ -183,7 +183,7 @@ static void tqmx86_gpio_irq_handler(struct irq_desc *desc)
 	struct tqmx86_gpio_data *gpio = gpiochip_get_data(chip);
 	struct irq_chip *irq_chip = irq_desc_get_chip(desc);
 	unsigned long irq_bits;
-	int i = 0, child_irq;
+	int i = 0;
 	u8 irq_status;
 
 	chained_irq_enter(irq_chip, desc);
@@ -192,11 +192,9 @@ static void tqmx86_gpio_irq_handler(struct irq_desc *desc)
 	tqmx86_gpio_write(gpio, irq_status, TQMX86_GPIIS);
 
 	irq_bits = irq_status;
-	for_each_set_bit(i, &irq_bits, TQMX86_NGPI) {
-		child_irq = irq_find_mapping(gpio->chip.irq.domain,
-					     i + TQMX86_NGPO);
-		generic_handle_irq(child_irq);
-	}
+	for_each_set_bit(i, &irq_bits, TQMX86_NGPI)
+		generic_handle_domain_irq(gpio->chip.irq.domain,
+					  i + TQMX86_NGPO);
 
 	chained_irq_exit(irq_chip, desc);
 }
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 58776f2..e0f2b67 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -149,7 +149,7 @@ static void vf610_gpio_irq_handler(struct irq_desc *desc)
 	for_each_set_bit(pin, &irq_isfr, VF610_GPIO_PER_PORT) {
 		vf610_gpio_writel(BIT(pin), port->base + PORT_ISFR);
 
-		generic_handle_irq(irq_find_mapping(port->gc.irq.domain, pin));
+		generic_handle_domain_irq(port->gc.irq.domain, pin);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index 2d89d05..bb02a82 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -339,8 +339,8 @@ static irqreturn_t ws16c48_irq_handler(int irq, void *dev_id)
 		for_each_set_bit(port, &int_pending, 3) {
 			int_id = inb(ws16c48gpio->base + 8 + port);
 			for_each_set_bit(gpio, &int_id, 8)
-				generic_handle_irq(irq_find_mapping(
-					chip->irq.domain, gpio + 8*port));
+				generic_handle_domain_irq(chip->irq.domain,
+							  gpio + 8*port);
 		}
 
 		int_pending = inb(ws16c48gpio->base + 6) & 0x7;
diff --git a/drivers/gpio/gpio-xgs-iproc.c b/drivers/gpio/gpio-xgs-iproc.c
index ad5489a..fa9b4d8 100644
--- a/drivers/gpio/gpio-xgs-iproc.c
+++ b/drivers/gpio/gpio-xgs-iproc.c
@@ -185,7 +185,7 @@ static irqreturn_t iproc_gpio_irq_handler(int irq, void *data)
 		int_bits = level | event;
 
 		for_each_set_bit(bit, &int_bits, gc->ngpio)
-			generic_handle_irq(irq_linear_revmap(gc->irq.domain, bit));
+			generic_handle_domain_irq(gc->irq.domain, bit);
 	}
 
 	return int_bits ? IRQ_HANDLED : IRQ_NONE;
diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index c329c3a..a1b6633 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -538,7 +538,7 @@ static void xgpio_irqhandler(struct irq_desc *desc)
 
 	for_each_set_bit(bit, all, 64) {
 		irq_offset = xgpio_from_bit(chip, bit);
-		generic_handle_irq(irq_find_mapping(gc->irq.domain, irq_offset));
+		generic_handle_domain_irq(gc->irq.domain, irq_offset);
 	}
 
 	chained_irq_exit(irqchip, desc);
diff --git a/drivers/gpio/gpio-xlp.c b/drivers/gpio/gpio-xlp.c
index d7b16bb..0d94d3a 100644
--- a/drivers/gpio/gpio-xlp.c
+++ b/drivers/gpio/gpio-xlp.c
@@ -216,8 +216,7 @@ static void xlp_gpio_generic_handler(struct irq_desc *desc)
 		}
 
 		if (gpio_stat & BIT(gpio % XLP_GPIO_REGSZ))
-			generic_handle_irq(irq_find_mapping(
-						priv->chip.irq.domain, gpio));
+			generic_handle_domain_irq(priv->chip.irq.domain, gpio);
 	}
 	chained_irq_exit(irqchip, desc);
 }
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index f0cb8cc..06c6401 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -628,12 +628,8 @@ static void zynq_gpio_handle_bank_irq(struct zynq_gpio *gpio,
 	if (!pending)
 		return;
 
-	for_each_set_bit(offset, &pending, 32) {
-		unsigned int gpio_irq;
-
-		gpio_irq = irq_find_mapping(irqdomain, offset + bank_offset);
-		generic_handle_irq(gpio_irq);
-	}
+	for_each_set_bit(offset, &pending, 32)
+		generic_handle_domain_irq(irqdomain, offset + bank_offset);
 }
 
 /**

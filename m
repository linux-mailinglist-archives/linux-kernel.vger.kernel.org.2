Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5505B3F0C31
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhHRT60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbhHRT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:57:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC29C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:57:02 -0700 (PDT)
Date:   Wed, 18 Aug 2021 19:57:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629316621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXI2rSfOsuBcL45yrH/3jtqsMsKd6pr11OdxWquF1os=;
        b=z0M9+oPVKH7Fqjcm4qeHHV3d8or7gm5ZXehmaO01v93VPaVRrnOzvAa823Uo9WIHrb2kcQ
        02c1uMXFkwk1CrLAs9xAJcQnKk2YY2SshohbOb21l4RdFFsITxA/Mp7EktIGc7LBCTIsFr
        oSQkJwc0KmyhbaSHugq42A0TXD6druWSkd3NMGpAFfLgVhnqSZsyWqUk6CbmgM5wcHLWW6
        /Xr/g07vjlWRNO4NrvqBF3y1mDFfxpc1ry0zW8L7JG8KfeeOizi/S9auVf4BJJMMCVeUNE
        bfW0VxkEo76yCvL8iphFuUX5Hlqn5WzruwruVfg5rw0B9rmKC/miFio+ksAYXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629316621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXI2rSfOsuBcL45yrH/3jtqsMsKd6pr11OdxWquF1os=;
        b=FNVFan2rEJPyFcsvdfdQOt+PeEcHZUcLQRzkxAVhYIBkCS03xttmDLjAWQGLBNcn96qQZS
        6ONlwqjBFG92y+Ag==
From:   "irqchip-bot for Jianqun Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio/rockchip: use struct
 rockchip_gpio_regs for gpio controller
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>, maz@kernel.org,
        tglx@linutronix.de
In-Reply-To: <20210816012111.1119125-1-jay.xu@rock-chips.com>
References: <20210816012111.1119125-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Message-ID: <162931662043.25758.14739755055580429338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     ff96a8c21cdbf4a36fbad341af3a41db44bbf878
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ff96a8c21cdbf4a36fbad341af3a41db44bbf878
Author:        Jianqun Xu <jay.xu@rock-chips.com>
AuthorDate:    Mon, 16 Aug 2021 09:21:11 +08:00
Committer:     Linus Walleij <linus.walleij@linaro.org>
CommitterDate: Tue, 17 Aug 2021 01:01:49 +02:00

gpio/rockchip: use struct rockchip_gpio_regs for gpio controller

Store register offsets in the struct rockchip_gpio_regs, this patch
prepare for the driver update for new gpio controller.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Link: https://lore.kernel.org/r/20210816012111.1119125-1-jay.xu@rock-chips.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-rockchip.c       | 86 +++++++++++++++--------------
 drivers/pinctrl/pinctrl-rockchip.h | 38 +++++++++++++-
 2 files changed, 85 insertions(+), 39 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index b455fcf..d6c07a9 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -24,19 +24,21 @@
 #include "../pinctrl/core.h"
 #include "../pinctrl/pinctrl-rockchip.h"
 
-/* GPIO control registers */
-#define GPIO_SWPORT_DR		0x00
-#define GPIO_SWPORT_DDR		0x04
-#define GPIO_INTEN		0x30
-#define GPIO_INTMASK		0x34
-#define GPIO_INTTYPE_LEVEL	0x38
-#define GPIO_INT_POLARITY	0x3c
-#define GPIO_INT_STATUS		0x40
-#define GPIO_INT_RAWSTATUS	0x44
-#define GPIO_DEBOUNCE		0x48
-#define GPIO_PORTS_EOI		0x4c
-#define GPIO_EXT_PORT		0x50
-#define GPIO_LS_SYNC		0x60
+#define GPIO_TYPE_V1		(0)           /* GPIO Version ID reserved */
+
+static const struct rockchip_gpio_regs gpio_regs_v1 = {
+	.port_dr = 0x00,
+	.port_ddr = 0x04,
+	.int_en = 0x30,
+	.int_mask = 0x34,
+	.int_type = 0x38,
+	.int_polarity = 0x3c,
+	.int_status = 0x40,
+	.int_rawstatus = 0x44,
+	.debounce = 0x48,
+	.port_eoi = 0x4c,
+	.ext_port = 0x50,
+};
 
 static int rockchip_gpio_get_direction(struct gpio_chip *chip,
 				       unsigned int offset)
@@ -44,7 +46,7 @@ static int rockchip_gpio_get_direction(struct gpio_chip *chip,
 	struct rockchip_pin_bank *bank = gpiochip_get_data(chip);
 	u32 data;
 
-	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
+	data = readl_relaxed(bank->reg_base + bank->gpio_regs->port_ddr);
 	if (data & BIT(offset))
 		return GPIO_LINE_DIRECTION_OUT;
 
@@ -60,13 +62,13 @@ static int rockchip_gpio_set_direction(struct gpio_chip *chip,
 
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
-	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
+	data = readl_relaxed(bank->reg_base + bank->gpio_regs->port_ddr);
 	/* set bit to 1 for output, 0 for input */
 	if (!input)
 		data |= BIT(offset);
 	else
 		data &= ~BIT(offset);
-	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
+	writel_relaxed(data, bank->reg_base + bank->gpio_regs->port_ddr);
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
 
@@ -77,7 +79,7 @@ static void rockchip_gpio_set(struct gpio_chip *gc, unsigned int offset,
 			      int value)
 {
 	struct rockchip_pin_bank *bank = gpiochip_get_data(gc);
-	void __iomem *reg = bank->reg_base + GPIO_SWPORT_DR;
+	void __iomem *reg = bank->reg_base + bank->gpio_regs->port_dr;
 	unsigned long flags;
 	u32 data;
 
@@ -97,9 +99,10 @@ static int rockchip_gpio_get(struct gpio_chip *gc, unsigned int offset)
 	struct rockchip_pin_bank *bank = gpiochip_get_data(gc);
 	u32 data;
 
-	data = readl(bank->reg_base + GPIO_EXT_PORT);
+	data = readl(bank->reg_base + bank->gpio_regs->ext_port);
 	data >>= offset;
 	data &= 1;
+
 	return data;
 }
 
@@ -107,7 +110,7 @@ static void rockchip_gpio_set_debounce(struct gpio_chip *gc,
 				       unsigned int offset, bool enable)
 {
 	struct rockchip_pin_bank *bank = gpiochip_get_data(gc);
-	void __iomem *reg = bank->reg_base + GPIO_DEBOUNCE;
+	void __iomem *reg = bank->reg_base + bank->gpio_regs->debounce;
 	unsigned long flags;
 	u32 data;
 
@@ -207,7 +210,7 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	pend = readl_relaxed(bank->reg_base + GPIO_INT_STATUS);
+	pend = readl_relaxed(bank->reg_base + bank->gpio_regs->int_status);
 
 	while (pend) {
 		unsigned int irq, virq;
@@ -231,24 +234,26 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 			u32 data, data_old, polarity;
 			unsigned long flags;
 
-			data = readl_relaxed(bank->reg_base + GPIO_EXT_PORT);
+			data = readl_relaxed(bank->reg_base +
+					     bank->gpio_regs->ext_port);
 			do {
 				raw_spin_lock_irqsave(&bank->slock, flags);
 
 				polarity = readl_relaxed(bank->reg_base +
-							 GPIO_INT_POLARITY);
+							 bank->gpio_regs->int_polarity);
 				if (data & BIT(irq))
 					polarity &= ~BIT(irq);
 				else
 					polarity |= BIT(irq);
 				writel(polarity,
-				       bank->reg_base + GPIO_INT_POLARITY);
+				       bank->reg_base +
+				       bank->gpio_regs->int_polarity);
 
 				raw_spin_unlock_irqrestore(&bank->slock, flags);
 
 				data_old = data;
 				data = readl_relaxed(bank->reg_base +
-						     GPIO_EXT_PORT);
+						     bank->gpio_regs->ext_port);
 			} while ((data & BIT(irq)) != (data_old & BIT(irq)));
 		}
 
@@ -270,9 +275,9 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
-	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
+	data = readl_relaxed(bank->reg_base + bank->gpio_regs->port_ddr);
 	data &= ~mask;
-	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
+	writel_relaxed(data, bank->reg_base + bank->gpio_regs->port_ddr);
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
 
@@ -284,8 +289,8 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	raw_spin_lock_irqsave(&bank->slock, flags);
 	irq_gc_lock(gc);
 
-	level = readl_relaxed(gc->reg_base + GPIO_INTTYPE_LEVEL);
-	polarity = readl_relaxed(gc->reg_base + GPIO_INT_POLARITY);
+	level = readl_relaxed(gc->reg_base + bank->gpio_regs->int_type);
+	polarity = readl_relaxed(gc->reg_base + bank->gpio_regs->int_polarity);
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_BOTH:
@@ -296,7 +301,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 		 * Determine gpio state. If 1 next interrupt should be falling
 		 * otherwise rising.
 		 */
-		data = readl(bank->reg_base + GPIO_EXT_PORT);
+		data = readl(bank->reg_base + bank->gpio_regs->ext_port);
 		if (data & mask)
 			polarity &= ~mask;
 		else
@@ -329,8 +334,8 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	writel_relaxed(level, gc->reg_base + GPIO_INTTYPE_LEVEL);
-	writel_relaxed(polarity, gc->reg_base + GPIO_INT_POLARITY);
+	writel_relaxed(level, gc->reg_base + bank->gpio_regs->int_type);
+	writel_relaxed(polarity, gc->reg_base + bank->gpio_regs->int_polarity);
 
 	irq_gc_unlock(gc);
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
@@ -343,8 +348,8 @@ static void rockchip_irq_suspend(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct rockchip_pin_bank *bank = gc->private;
 
-	bank->saved_masks = irq_reg_readl(gc, GPIO_INTMASK);
-	irq_reg_writel(gc, ~gc->wake_active, GPIO_INTMASK);
+	bank->saved_masks = irq_reg_readl(gc, bank->gpio_regs->int_mask);
+	irq_reg_writel(gc, ~gc->wake_active, bank->gpio_regs->int_mask);
 }
 
 static void rockchip_irq_resume(struct irq_data *d)
@@ -352,7 +357,7 @@ static void rockchip_irq_resume(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct rockchip_pin_bank *bank = gc->private;
 
-	irq_reg_writel(gc, bank->saved_masks, GPIO_INTMASK);
+	irq_reg_writel(gc, bank->saved_masks, bank->gpio_regs->int_mask);
 }
 
 static void rockchip_irq_enable(struct irq_data *d)
@@ -400,8 +405,8 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
 	gc = irq_get_domain_generic_chip(bank->domain, 0);
 	gc->reg_base = bank->reg_base;
 	gc->private = bank;
-	gc->chip_types[0].regs.mask = GPIO_INTMASK;
-	gc->chip_types[0].regs.ack = GPIO_PORTS_EOI;
+	gc->chip_types[0].regs.mask = bank->gpio_regs->int_mask;
+	gc->chip_types[0].regs.ack = bank->gpio_regs->port_eoi;
 	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
 	gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
 	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
@@ -418,9 +423,9 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
 	 * Our driver only uses the concept of masked and always keeps
 	 * things enabled, so for us that's all masked and all enabled.
 	 */
-	writel_relaxed(0xffffffff, bank->reg_base + GPIO_INTMASK);
-	writel_relaxed(0xffffffff, bank->reg_base + GPIO_PORTS_EOI);
-	writel_relaxed(0xffffffff, bank->reg_base + GPIO_INTEN);
+	writel_relaxed(0xffffffff, bank->reg_base + bank->gpio_regs->int_mask);
+	writel_relaxed(0xffffffff, bank->reg_base + bank->gpio_regs->port_eoi);
+	writel_relaxed(0xffffffff, bank->reg_base + bank->gpio_regs->int_en);
 	gc->mask_cache = 0xffffffff;
 
 	irq_set_chained_handler_and_data(bank->irq,
@@ -510,6 +515,9 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 
 	bank->irq = irq_of_parse_and_map(bank->of_node, 0);
 
+	bank->gpio_regs = &gpio_regs_v1;
+	bank->gpio_type = GPIO_TYPE_V1;
+
 	bank->clk = of_clk_get(bank->of_node, 0);
 	if (!IS_ERR(bank->clk))
 		return clk_prepare_enable(bank->clk);
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
index 4aa3d2f..1b774b6 100644
--- a/drivers/pinctrl/pinctrl-rockchip.h
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -33,6 +33,42 @@ enum rockchip_pinctrl_type {
 };
 
 /**
+ * struct rockchip_gpio_regs
+ * @port_dr: data register
+ * @port_ddr: data direction register
+ * @int_en: interrupt enable
+ * @int_mask: interrupt mask
+ * @int_type: interrupt trigger type, such as high, low, edge trriger type.
+ * @int_polarity: interrupt polarity enable register
+ * @int_bothedge: interrupt bothedge enable register
+ * @int_status: interrupt status register
+ * @int_rawstatus: int_status = int_rawstatus & int_mask
+ * @debounce: enable debounce for interrupt signal
+ * @dbclk_div_en: enable divider for debounce clock
+ * @dbclk_div_con: setting for divider of debounce clock
+ * @port_eoi: end of interrupt of the port
+ * @ext_port: port data from external
+ * @version_id: controller version register
+ */
+struct rockchip_gpio_regs {
+	u32 port_dr;
+	u32 port_ddr;
+	u32 int_en;
+	u32 int_mask;
+	u32 int_type;
+	u32 int_polarity;
+	u32 int_bothedge;
+	u32 int_status;
+	u32 int_rawstatus;
+	u32 debounce;
+	u32 dbclk_div_en;
+	u32 dbclk_div_con;
+	u32 port_eoi;
+	u32 ext_port;
+	u32 version_id;
+};
+
+/**
  * struct rockchip_iomux
  * @type: iomux variant using IOMUX_* constants
  * @offset: if initialized to -1 it will be autocalculated, by specifying
@@ -126,6 +162,8 @@ struct rockchip_pin_bank {
 	struct gpio_chip		gpio_chip;
 	struct pinctrl_gpio_range	grange;
 	raw_spinlock_t			slock;
+	const struct rockchip_gpio_regs	*gpio_regs;
+	u32				gpio_type;
 	u32				toggle_edge_mode;
 	u32				recalced_mask;
 	u32				route_mask;

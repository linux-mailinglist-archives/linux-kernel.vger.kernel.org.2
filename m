Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671554352EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhJTSt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:49:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54592 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhJTSt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:49:26 -0400
Date:   Wed, 20 Oct 2021 18:47:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634755630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZ3Z5ujWGkmuGuadjS5mfBrgxp6Mm2SSxLRDo3a8jz8=;
        b=i/Ny2Eg61mbaFYqmk3vzULxChBqHZuw2DMKQyzT64fCFkNxu3wCFZjZddCQs4K6IACwDxm
        Ij9BTXyoH353SHa2AcozkD8FWoCmb2tezxaGFY5DSlWz3A3mjjwmVGhWPgL1L2a3RGlyL+
        URVW62i1DSzp064OVI+a06TjPrD1JRahZTmD3I934xnwZv7LdLT8APXoo6urkymyCZC3i+
        3/Kfb6tqvpMIjG/hxd8p3whjN4U9OUAS/4zUjDcyheSyW6YijPryZ8qiiWbHl16E/zIxr+
        smoc214x3QAte5AgwYqLe6T0HkUqycsLEa8SSLRS4Dv6cI3ePH1E1Rtf+lDoHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634755630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZ3Z5ujWGkmuGuadjS5mfBrgxp6Mm2SSxLRDo3a8jz8=;
        b=Haj0r/cTOq30arpmFGDZs3OV27EpHPiZ3XVHoEV7nvuXLgunzLAcLCaBVWIvIp49gmB/IB
        Wm++Mv4DAQvC8dAg==
From:   "irqchip-bot for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mchp-eic: Add support for the
 Microchip EIC
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210927063657.2157676-3-claudiu.beznea@microchip.com>
References: <20210927063657.2157676-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Message-ID: <163475562901.25758.12216499672782971572.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     00fa3461c86dd289b441d4d5a6bb236064bd207b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/00fa3461c86dd289b441d4d5a6bb236064bd207b
Author:        Claudiu Beznea <claudiu.beznea@microchip.com>
AuthorDate:    Mon, 27 Sep 2021 09:36:57 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 19:40:54 +01:00

irqchip/mchp-eic: Add support for the Microchip EIC

Add support for Microchip External Interrupt Controller. The controller
supports 2 external interrupt lines. For every external input there is
a connection to GIC. The interrupt controllers contains only 4
registers:
- EIC_GFCS (read only): which indicates that glitch filter configuration
  is ready (not addressed in this implementation)
- EIC_SCFG0R, EIC_SCFG1R (read, write): allows per interrupt specific
  settings: enable, polarity/edge settings, glitch filter settings
- EIC_WPMR, EIC_WPSR: enables write protection mode specific settings
  (which are architecture specific) for the controller and are not
  addressed in this implementation

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210927063657.2157676-3-claudiu.beznea@microchip.com
---
 MAINTAINERS                    |   6 +-
 drivers/irqchip/Kconfig        |   8 +-
 drivers/irqchip/Makefile       |   1 +-
 drivers/irqchip/irq-mchp-eic.c | 280 ++++++++++++++++++++++++++++++++-
 4 files changed, 295 insertions(+)
 create mode 100644 drivers/irqchip/irq-mchp-eic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index abdcbcf..64d7e98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12254,6 +12254,12 @@ L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/atmel-ecc.*
 
+MICROCHIP EIC DRIVER
+M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/irqchip/irq-mchp-eic.c
+
 MICROCHIP I2C DRIVER
 M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
 L:	linux-i2c@vger.kernel.org
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index aca7b59..8df8ffb 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -602,4 +602,12 @@ config APPLE_AIC
 	  Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
 	  such as the M1.
 
+config MCHP_EIC
+	bool "Microchip External Interrupt Controller"
+	depends on ARCH_AT91 || COMPILE_TEST
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support for Microchip External Interrupt Controller.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index f88cbf3..c1f611c 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -116,3 +116,4 @@ obj-$(CONFIG_MACH_REALTEK_RTL)		+= irq-realtek-rtl.o
 obj-$(CONFIG_WPCM450_AIC)		+= irq-wpcm450-aic.o
 obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
+obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
diff --git a/drivers/irqchip/irq-mchp-eic.c b/drivers/irqchip/irq-mchp-eic.c
new file mode 100644
index 0000000..09b7a8c
--- /dev/null
+++ b/drivers/irqchip/irq-mchp-eic.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Microchip External Interrupt Controller driver
+ *
+ * Copyright (C) 2021 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/syscore_ops.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define MCHP_EIC_GFCS			(0x0)
+#define MCHP_EIC_SCFG(x)		(0x4 + (x) * 0x4)
+#define MCHP_EIC_SCFG_EN		BIT(16)
+#define MCHP_EIC_SCFG_LVL		BIT(9)
+#define MCHP_EIC_SCFG_POL		BIT(8)
+
+#define MCHP_EIC_NIRQ			(2)
+
+/*
+ * struct mchp_eic - EIC private data structure
+ * @base: base address
+ * @clk: peripheral clock
+ * @domain: irq domain
+ * @irqs: irqs b/w eic and gic
+ * @scfg: backup for scfg registers (necessary for backup and self-refresh mode)
+ * @wakeup_source: wakeup source mask
+ */
+struct mchp_eic {
+	void __iomem *base;
+	struct clk *clk;
+	struct irq_domain *domain;
+	u32 irqs[MCHP_EIC_NIRQ];
+	u32 scfg[MCHP_EIC_NIRQ];
+	u32 wakeup_source;
+};
+
+static struct mchp_eic *eic;
+
+static void mchp_eic_irq_mask(struct irq_data *d)
+{
+	unsigned int tmp;
+
+	tmp = readl_relaxed(eic->base + MCHP_EIC_SCFG(d->hwirq));
+	tmp &= ~MCHP_EIC_SCFG_EN;
+	writel_relaxed(tmp, eic->base + MCHP_EIC_SCFG(d->hwirq));
+
+	irq_chip_mask_parent(d);
+}
+
+static void mchp_eic_irq_unmask(struct irq_data *d)
+{
+	unsigned int tmp;
+
+	tmp = readl_relaxed(eic->base + MCHP_EIC_SCFG(d->hwirq));
+	tmp |= MCHP_EIC_SCFG_EN;
+	writel_relaxed(tmp, eic->base + MCHP_EIC_SCFG(d->hwirq));
+
+	irq_chip_unmask_parent(d);
+}
+
+static int mchp_eic_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int parent_irq_type;
+	unsigned int tmp;
+
+	tmp = readl_relaxed(eic->base + MCHP_EIC_SCFG(d->hwirq));
+	tmp &= ~(MCHP_EIC_SCFG_POL | MCHP_EIC_SCFG_LVL);
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		tmp |= MCHP_EIC_SCFG_POL | MCHP_EIC_SCFG_LVL;
+		parent_irq_type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		tmp |= MCHP_EIC_SCFG_LVL;
+		parent_irq_type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		parent_irq_type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		tmp |= MCHP_EIC_SCFG_POL;
+		parent_irq_type = IRQ_TYPE_EDGE_RISING;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel_relaxed(tmp, eic->base + MCHP_EIC_SCFG(d->hwirq));
+
+	return irq_chip_set_type_parent(d, parent_irq_type);
+}
+
+static int mchp_eic_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	irq_set_irq_wake(eic->irqs[d->hwirq], on);
+	if (on)
+		eic->wakeup_source |= BIT(d->hwirq);
+	else
+		eic->wakeup_source &= ~BIT(d->hwirq);
+
+	return 0;
+}
+
+static int mchp_eic_irq_suspend(void)
+{
+	unsigned int hwirq;
+
+	for (hwirq = 0; hwirq < MCHP_EIC_NIRQ; hwirq++)
+		eic->scfg[hwirq] = readl_relaxed(eic->base +
+						 MCHP_EIC_SCFG(hwirq));
+
+	if (!eic->wakeup_source)
+		clk_disable_unprepare(eic->clk);
+
+	return 0;
+}
+
+static void mchp_eic_irq_resume(void)
+{
+	unsigned int hwirq;
+
+	if (!eic->wakeup_source)
+		clk_prepare_enable(eic->clk);
+
+	for (hwirq = 0; hwirq < MCHP_EIC_NIRQ; hwirq++)
+		writel_relaxed(eic->scfg[hwirq], eic->base +
+			       MCHP_EIC_SCFG(hwirq));
+}
+
+static struct syscore_ops mchp_eic_syscore_ops = {
+	.suspend = mchp_eic_irq_suspend,
+	.resume = mchp_eic_irq_resume,
+};
+
+static struct irq_chip mchp_eic_chip = {
+	.name		= "eic",
+	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SET_TYPE_MASKED,
+	.irq_mask	= mchp_eic_irq_mask,
+	.irq_unmask	= mchp_eic_irq_unmask,
+	.irq_set_type	= mchp_eic_irq_set_type,
+	.irq_ack	= irq_chip_ack_parent,
+	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_retrigger	= irq_chip_retrigger_hierarchy,
+	.irq_set_wake	= mchp_eic_irq_set_wake,
+};
+
+static int mchp_eic_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *data)
+{
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	if (WARN_ON(nr_irqs != 1))
+		return -EINVAL;
+
+	ret = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
+	if (ret || hwirq >= MCHP_EIC_NIRQ)
+		return ret;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &mchp_eic_chip, eic);
+
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 3;
+	parent_fwspec.param[0] = GIC_SPI;
+	parent_fwspec.param[1] = eic->irqs[hwirq];
+	parent_fwspec.param[2] = type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
+}
+
+static const struct irq_domain_ops mchp_eic_domain_ops = {
+	.translate	= irq_domain_translate_twocell,
+	.alloc		= mchp_eic_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static int mchp_eic_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *parent_domain = NULL;
+	int ret, i;
+
+	eic = kzalloc(sizeof(*eic), GFP_KERNEL);
+	if (!eic)
+		return -ENOMEM;
+
+	eic->base = of_iomap(node, 0);
+	if (IS_ERR(eic->base)) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		ret = -ENODEV;
+		goto unmap;
+	}
+
+	eic->clk = of_clk_get_by_name(node, "pclk");
+	if (IS_ERR(eic->clk)) {
+		ret = PTR_ERR(eic->clk);
+		goto unmap;
+	}
+
+	ret = clk_prepare_enable(eic->clk);
+	if (ret)
+		goto unmap;
+
+	for (i = 0; i < MCHP_EIC_NIRQ; i++) {
+		struct of_phandle_args irq;
+
+		/* Disable it, if any. */
+		writel_relaxed(0UL, eic->base + MCHP_EIC_SCFG(i));
+
+		ret = of_irq_parse_one(node, i, &irq);
+		if (ret)
+			goto clk_unprepare;
+
+		if (WARN_ON(irq.args_count != 3)) {
+			ret = -EINVAL;
+			goto clk_unprepare;
+		}
+
+		eic->irqs[i] = irq.args[1];
+	}
+
+	eic->domain = irq_domain_add_hierarchy(parent_domain, 0, MCHP_EIC_NIRQ,
+					       node, &mchp_eic_domain_ops, eic);
+	if (!eic->domain) {
+		pr_err("%pOF: Failed to add domain\n", node);
+		ret = -ENODEV;
+		goto clk_unprepare;
+	}
+
+	register_syscore_ops(&mchp_eic_syscore_ops);
+
+	pr_info("%pOF: EIC registered, nr_irqs %u\n", node, MCHP_EIC_NIRQ);
+
+	return 0;
+
+clk_unprepare:
+	clk_disable_unprepare(eic->clk);
+unmap:
+	iounmap(eic->base);
+free:
+	kfree(eic);
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(mchp_eic)
+IRQCHIP_MATCH("microchip,sama7g5-eic", mchp_eic_init)
+IRQCHIP_PLATFORM_DRIVER_END(mchp_eic)
+
+MODULE_DESCRIPTION("Microchip External Interrupt Controller");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea@microchip.com>");

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E982B418F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 08:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhI0GjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 02:39:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11814 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhI0GjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 02:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632724664; x=1664260664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pd6znKOClYvXLoMT72LWF5QQ+4FbG+AKSJsptVKbCUU=;
  b=qoQMFOrTaLPl9owqUzrt0Am4vglHdXlmohf3i4k18AcTsa4OeuI1IMJS
   sfCk/Ao234NnpQu6kmBhlanZseVqyfs5hJjBrwi4AUp519jBz2mDtR4A2
   Qqqy/1iE/hQliwH3EGv5TqVVyvwr0ytIM22MKIrEl8ejKxBaxm00eHcHw
   AXV9gC79ehJGLw3o4ebHbI7JIOMo0rLE5Uvjn2HYlOliT5GCQDovlyBA1
   mdf1qXo8pgOhY0KuopNhtnwhelzpGUsyBbst+GZaQGJ4ryrD9jF3CK6Dd
   fIbYKA5mC/pxv17pScBII7S8hEnUpgaQuOOas14JituxxuJ9HFpSlDZs7
   Q==;
IronPort-SDR: KqOR23J2+N4zTeUst619E2NBt8Z/7xZ5yrbTt+7DoHRVlhqjPIOpQf5r+hAfQ/oVSgbcrsguzz
 ZPJbGPC2D5lUVYazkhbVFv7ao5PBVYBDmiqPzKoZ0MbVim5/sBxQAXI/mAr8JXB7rkDoGhzfA/
 q2XqEJcvBvkJ1qAuS+fsuSHtevzNcI2weVRbTQLeanCDGVtCuL7fnrgJXMl4+ByUVbq1GunZZG
 H/pt4KK50cX2olsPp4WL924izKPhwg3s4JKjPZuyl3trVv8kjGj1YsSdst10F4YX2L6iDmkTpt
 5y0EsTBDQIzEJWFp+IuyLFBq
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="130749944"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Sep 2021 23:37:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 26 Sep 2021 23:37:43 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 26 Sep 2021 23:37:41 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 2/2] irqchip/mchp-eic: add support
Date:   Mon, 27 Sep 2021 09:36:57 +0300
Message-ID: <20210927063657.2157676-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927063657.2157676-1-claudiu.beznea@microchip.com>
References: <20210927063657.2157676-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 MAINTAINERS                    |   6 +
 drivers/irqchip/Kconfig        |   8 +
 drivers/irqchip/Makefile       |   1 +
 drivers/irqchip/irq-mchp-eic.c | 280 +++++++++++++++++++++++++++++++++
 4 files changed, 295 insertions(+)
 create mode 100644 drivers/irqchip/irq-mchp-eic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..18e41192b311 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12253,6 +12253,12 @@ L:	linux-crypto@vger.kernel.org
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
index 4d5924e9f766..450c7b8ab30f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -601,4 +601,12 @@ config APPLE_AIC
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
index f88cbf36a9d2..c1f611cbfbf8 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -116,3 +116,4 @@ obj-$(CONFIG_MACH_REALTEK_RTL)		+= irq-realtek-rtl.o
 obj-$(CONFIG_WPCM450_AIC)		+= irq-wpcm450-aic.o
 obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
+obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
diff --git a/drivers/irqchip/irq-mchp-eic.c b/drivers/irqchip/irq-mchp-eic.c
new file mode 100644
index 000000000000..09b7a8cdb611
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
-- 
2.25.1


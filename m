Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B9840360D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349480AbhIHIZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:25:49 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:60273 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348794AbhIHIZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631089476; x=1662625476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CL803+H9r0bBc0YlUYvi4inAUp/+fZDOIeBm6G27KQo=;
  b=KWMU5dQux5NRPUWokexCyPxfeFdPf7anc18HUZmKGtJ4I4LUQe5w0I1q
   zXVoC0OGD4Xjb6HZnRh5uQ/8HNZr/+VxXIoV7+3+dEpfKiWzrBcMgyeQy
   EMvz+IGex5JWYtKvp2ELRizFfjnwOckTGGegR8sB9rhpe3Z+NIbpq80uj
   VvceQe66L1kE8q2CYK1iNA0/jvBr66EXlciUigPF9iCSTBAtgdzzvEG4s
   JsGsoKrwtRfCj13ScTsePhStyemMHyZVu8f3oANWTe1ngYNSCaxY6lEG1
   ahuJf9B5IP1otpaaRdqqSo8HFvWM4EnKfoe3Z7OERWU2trM9YMruUsdCP
   Q==;
IronPort-SDR: a1bywzcGqjsrX3ClZGU4HRFnGAWO4s1g1I0eUQwo6S7Lc2qtYm/sv9jVEwl4dGWc5LrHpCqnOM
 g1IBRQua/oWlDId1CtV0wfZNHAcOQJXtjQ2AKWrnLML9jC1jjOAPilSdDUTxYcBnTJu3J+U3gi
 FGtXDLaJODDdMAvSa+IyJ+tPEmGYYUpaMOuhlfQDpVNejNiTg62Ghh3rE7T8QBPmFb7fyQ0plY
 F8qLuFHqcZ/uY2AmhRy6wS5sZVOHERO/aeIDPQaPemlpRKUpsYwKxUmzSSniE5nIW0x2BtRruM
 ZTI9n3wSFPJZIiUG6gfg6pdQ
X-IronPort-AV: E=Sophos;i="5.85,277,1624345200"; 
   d="scan'208";a="128593945"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2021 01:24:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Sep 2021 01:24:35 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 8 Sep 2021 01:24:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/2] irqchip/mchp-eic: add support
Date:   Wed, 8 Sep 2021 11:23:50 +0300
Message-ID: <20210908082350.106948-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908082350.106948-1-claudiu.beznea@microchip.com>
References: <20210908082350.106948-1-claudiu.beznea@microchip.com>
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
 drivers/irqchip/irq-mchp-eic.c | 314 +++++++++++++++++++++++++++++++++
 4 files changed, 329 insertions(+)
 create mode 100644 drivers/irqchip/irq-mchp-eic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c9467d2839f5..7e20a840b7dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12149,6 +12149,12 @@ L:	linux-crypto@vger.kernel.org
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
index 000000000000..ab24a464b929
--- /dev/null
+++ b/drivers/irqchip/irq-mchp-eic.c
@@ -0,0 +1,314 @@
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
+ * @dev: eic device
+ * @clk: peripheral clock
+ * @domain: irq domain
+ * @irqs: irqs b/w eic and gic
+ * @scfg: backup for scfg registers (necessary for backup and self-refresh mode)
+ * @wakeup_source: wakeup source mask
+ */
+struct mchp_eic {
+	void __iomem *base;
+	struct device *dev;
+	struct clk *clk;
+	struct irq_domain *domain;
+	u32 irqs[MCHP_EIC_NIRQ];
+	u32 scfg[MCHP_EIC_NIRQ];
+	u32 wakeup_source;
+};
+
+static void mchp_eic_irq_mask(struct irq_data *d)
+{
+	struct mchp_eic *eic = irq_data_get_irq_chip_data(d);
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
+	struct mchp_eic *eic = irq_data_get_irq_chip_data(d);
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
+	struct mchp_eic *eic = irq_data_get_irq_chip_data(d);
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
+	struct mchp_eic *eic = irq_data_get_irq_chip_data(d);
+
+	irq_set_irq_wake(eic->irqs[d->hwirq], on);
+	if (on)
+		eic->wakeup_source |= BIT(d->hwirq);
+	else
+		eic->wakeup_source &= ~BIT(d->hwirq);
+
+	return 0;
+}
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
+static int mchp_eic_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	if (!is_of_node(fwspec->fwnode))
+		return -EINVAL;
+
+	if (fwspec->param_count != 2 || fwspec->param[0] >= MCHP_EIC_NIRQ)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1];
+
+	return 0;
+}
+
+static int mchp_eic_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *data)
+{
+	struct mchp_eic *eic = domain->host_data;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	if (WARN_ON(nr_irqs != 1))
+		return -EINVAL;
+
+	ret = mchp_eic_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
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
+	.translate	= mchp_eic_domain_translate,
+	.alloc		= mchp_eic_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static int mchp_eic_probe(struct platform_device *pdev)
+{
+	struct irq_domain *parent_domain = NULL;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *gic_node;
+	struct mchp_eic *eic;
+	int ret, i;
+
+	eic = devm_kzalloc(dev, sizeof(*eic), GFP_KERNEL);
+	if (!eic)
+		return -ENOMEM;
+
+	eic->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(eic->base))
+		return PTR_ERR(eic->base);
+
+	gic_node = of_irq_find_parent(np);
+	if (gic_node)
+		parent_domain = irq_find_host(gic_node);
+	of_node_put(gic_node);
+	if (!parent_domain)
+		return -ENODEV;
+
+	eic->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(eic->clk))
+		return PTR_ERR(eic->clk);
+
+	ret = clk_prepare_enable(eic->clk);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < MCHP_EIC_NIRQ; i++) {
+		struct of_phandle_args irq;
+
+		/* Disable it, if any. */
+		writel_relaxed(0UL, eic->base + MCHP_EIC_SCFG(i));
+
+		ret = of_irq_parse_one(np, i, &irq);
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
+					       np, &mchp_eic_domain_ops, eic);
+	if (!eic->domain) {
+		ret = dev_err_probe(dev, -ENOMEM, "Failed to add domain\n");
+		goto clk_unprepare;
+	}
+
+	eic->dev = dev;
+	platform_set_drvdata(pdev, eic);
+
+	dev_info(dev, "EIC registered, nr_irqs %u\n", MCHP_EIC_NIRQ);
+
+	return 0;
+
+clk_unprepare:
+	clk_disable_unprepare(eic->clk);
+	return ret;
+}
+
+static int __maybe_unused mchp_eic_suspend(struct device *dev)
+{
+	struct mchp_eic *eic = dev_get_drvdata(dev);
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
+static int __maybe_unused mchp_eic_resume(struct device *dev)
+{
+	struct mchp_eic *eic = dev_get_drvdata(dev);
+	unsigned int hwirq;
+
+	if (!eic->wakeup_source)
+		clk_prepare_enable(eic->clk);
+
+	for (hwirq = 0; hwirq < MCHP_EIC_NIRQ; hwirq++)
+		writel_relaxed(eic->scfg[hwirq], eic->base +
+			       MCHP_EIC_SCFG(hwirq));
+
+	return 0;
+}
+
+static const struct dev_pm_ops mchp_eic_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mchp_eic_suspend, mchp_eic_resume)
+};
+
+static const struct of_device_id mchp_eic_dt_ids[] = {
+	{ .compatible = "microchip,sama7g5-eic", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mchp_eic_dt_ids);
+
+static struct platform_driver mchp_eic_device_driver = {
+	.probe		= mchp_eic_probe,
+	.driver		= {
+		.name = "mchp-eic",
+		.of_match_table = of_match_ptr(mchp_eic_dt_ids),
+		.pm = pm_ptr(&mchp_eic_pm_ops),
+	},
+};
+builtin_platform_driver(mchp_eic_device_driver);
+
+MODULE_DESCRIPTION("Microchip External Interrupt Controller");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea@microchip.com>");
-- 
2.25.1


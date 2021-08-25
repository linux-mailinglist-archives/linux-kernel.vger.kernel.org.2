Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B993F6F42
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbhHYGQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238999AbhHYGQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:16:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 352C0613B1;
        Wed, 25 Aug 2021 06:15:28 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3 10/10] irqchip: Add Loongson PCH LPC controller support
Date:   Wed, 25 Aug 2021 14:11:52 +0800
Message-Id: <20210825061152.3396398-11-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825061152.3396398-1-chenhuacai@loongson.cn>
References: <20210825061152.3396398-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are preparing to add new Loongson (based on LoongArch, not MIPS)
support. This patch add Loongson PCH LPC interrupt controller support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/Kconfig                |   8 +
 drivers/irqchip/Makefile               |   1 +
 drivers/irqchip/irq-loongson-pch-lpc.c | 204 +++++++++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 895b19fcea59..2ba0f341d976 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -592,6 +592,14 @@ config LOONGSON_PCH_MSI
 	help
 	  Support for the Loongson PCH MSI Controller.
 
+config LOONGSON_PCH_LPC
+	bool "Loongson PCH LPC Controller"
+	depends on MACH_LOONGSON64
+	default MACH_LOONGSON64
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support for the Loongson PCH LPC Controller.
+
 config MST_IRQ
 	bool "MStar Interrupt Controller"
 	depends on ARCH_MEDIATEK || ARCH_MSTARV7 || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index eb3fdc6fe808..6fd07980fa47 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
 obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
 obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
+obj-$(CONFIG_LOONGSON_PCH_LPC)		+= irq-loongson-pch-lpc.o
 obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
 obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
 obj-$(CONFIG_MACH_REALTEK_RTL)		+= irq-realtek-rtl.o
diff --git a/drivers/irqchip/irq-loongson-pch-lpc.c b/drivers/irqchip/irq-loongson-pch-lpc.c
new file mode 100644
index 000000000000..14e927548610
--- /dev/null
+++ b/drivers/irqchip/irq-loongson-pch-lpc.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Loongson LPC Interrupt Controller support
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#define pr_fmt(fmt) "lpc: " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/syscore_ops.h>
+
+/* Registers */
+#define LPC_INT_CTL		0x00
+#define LPC_INT_ENA		0x04
+#define LPC_INT_STS		0x08
+#define LPC_INT_CLR		0x0c
+#define LPC_INT_POL		0x10
+#define LPC_COUNT		16
+
+struct pch_lpc {
+	void __iomem		*base;
+	struct irq_domain	*lpc_domain;
+	struct fwnode_handle	*domain_handle;
+	raw_spinlock_t		lpc_lock;
+	u32			saved_reg_ctl;
+	u32			saved_reg_ena;
+	u32			saved_reg_pol;
+};
+
+struct pch_lpc *pch_lpc_priv;
+
+static void ack_lpc_irq(struct irq_data *d)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pch_lpc_priv->lpc_lock, flags);
+	writel(0x1 << d->irq, pch_lpc_priv->base + LPC_INT_CLR);
+	raw_spin_unlock_irqrestore(&pch_lpc_priv->lpc_lock, flags);
+}
+static void mask_lpc_irq(struct irq_data *d)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pch_lpc_priv->lpc_lock, flags);
+	writel(readl(pch_lpc_priv->base + LPC_INT_ENA) & (~(0x1 << (d->irq))),
+			pch_lpc_priv->base + LPC_INT_ENA);
+	raw_spin_unlock_irqrestore(&pch_lpc_priv->lpc_lock, flags);
+}
+
+static void mask_ack_lpc_irq(struct irq_data *d)
+{
+}
+
+static void unmask_lpc_irq(struct irq_data *d)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pch_lpc_priv->lpc_lock, flags);
+	writel(readl(pch_lpc_priv->base + LPC_INT_ENA) | (0x1 << (d->irq)),
+			pch_lpc_priv->base + LPC_INT_ENA);
+	raw_spin_unlock_irqrestore(&pch_lpc_priv->lpc_lock, flags);
+}
+
+static struct irq_chip pch_lpc_irq_chip = {
+	.name			= "PCH LPC",
+	.irq_mask		= mask_lpc_irq,
+	.irq_unmask		= unmask_lpc_irq,
+	.irq_ack		= ack_lpc_irq,
+	.irq_mask_ack		= mask_ack_lpc_irq,
+	.irq_eoi		= unmask_lpc_irq,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+};
+
+static void lpc_irq_dispatch(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 pending;
+
+	chained_irq_enter(chip, desc);
+
+	pending = readl(pch_lpc_priv->base + LPC_INT_ENA);
+	pending &= readl(pch_lpc_priv->base + LPC_INT_STS);
+	if (!pending)
+		spurious_interrupt();
+
+	while (pending) {
+		int bit = __ffs(pending);
+
+		generic_handle_irq(bit);
+		pending &= ~BIT(bit);
+	}
+	chained_irq_exit(chip, desc);
+}
+
+static int pch_lpc_map(struct irq_domain *d, unsigned int irq,
+			irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &pch_lpc_irq_chip, handle_level_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops pch_lpc_domain_ops = {
+	.map = pch_lpc_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static void pch_lpc_reset(struct pch_lpc *priv)
+{
+	/* Enable the LPC interrupt, bit31: en  bit30: edge */
+	writel(0x80000000, priv->base + LPC_INT_CTL);
+	writel(0, priv->base + LPC_INT_ENA);
+	/* Clear all 18-bit interrpt bit */
+	writel(0x3ffff, priv->base + LPC_INT_CLR);
+}
+
+static int pch_lpc_disabled(struct pch_lpc *priv)
+{
+	return (readl(priv->base + LPC_INT_ENA) == 0xffffffff) &&
+			(readl(priv->base + LPC_INT_STS) == 0xffffffff);
+}
+
+static int pch_lpc_suspend(void)
+{
+	pch_lpc_priv->saved_reg_ctl = readl(pch_lpc_priv->base + LPC_INT_CTL);
+	pch_lpc_priv->saved_reg_ena = readl(pch_lpc_priv->base + LPC_INT_ENA);
+	pch_lpc_priv->saved_reg_pol = readl(pch_lpc_priv->base + LPC_INT_POL);
+	return 0;
+}
+
+static void pch_lpc_resume(void)
+{
+	writel(pch_lpc_priv->saved_reg_ctl, pch_lpc_priv->base + LPC_INT_CTL);
+	writel(pch_lpc_priv->saved_reg_ena, pch_lpc_priv->base + LPC_INT_ENA);
+	writel(pch_lpc_priv->saved_reg_pol, pch_lpc_priv->base + LPC_INT_POL);
+}
+
+static struct syscore_ops pch_lpc_syscore_ops = {
+	.suspend = pch_lpc_suspend,
+	.resume = pch_lpc_resume,
+};
+
+struct fwnode_handle *pch_lpc_acpi_init(struct fwnode_handle *parent,
+					struct acpi_madt_lpc_pic *acpi_pchlpc)
+{
+	int parent_irq;
+	struct pch_lpc *priv;
+	struct irq_fwspec fwspec;
+
+	if (!acpi_pchlpc)
+		return NULL;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	raw_spin_lock_init(&priv->lpc_lock);
+
+	priv->base = ioremap(acpi_pchlpc->address, acpi_pchlpc->size);
+	if (!priv->base)
+		goto free_priv;
+
+	if (pch_lpc_disabled(priv)) {
+		pr_err("Failed to get LPC status\n");
+		goto iounmap_base;
+	}
+
+	priv->domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchlpc);
+	if (!priv->domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		goto iounmap_base;
+	}
+	priv->lpc_domain = irq_domain_add_legacy(NULL, LPC_COUNT, 0, 0,
+						&pch_lpc_domain_ops, priv);
+	if (!priv->lpc_domain) {
+		pr_err("Failed to create IRQ domain\n");
+		goto iounmap_base;
+	}
+	pch_lpc_reset(priv);
+
+	fwspec.fwnode = parent;
+	fwspec.param[0] = GSI_MIN_PCH_IRQ + acpi_pchlpc->cascade;
+	fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
+	fwspec.param_count = 2;
+	parent_irq = irq_create_fwspec_mapping(&fwspec);
+	irq_set_chained_handler_and_data(parent_irq, lpc_irq_dispatch, priv);
+	pch_lpc_priv = priv;
+
+	register_syscore_ops(&pch_lpc_syscore_ops);
+
+	return priv->domain_handle;
+
+iounmap_base:
+	iounmap(priv->base);
+free_priv:
+	kfree(priv);
+
+	return NULL;
+}
-- 
2.27.0


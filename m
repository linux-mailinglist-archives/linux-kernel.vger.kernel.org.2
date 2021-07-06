Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A6C3BC503
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 05:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhGFDOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 23:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229827AbhGFDOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 23:14:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6D446197F;
        Tue,  6 Jul 2021 03:11:22 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6/9] irqchip/loongson-liointc: Add ACPI init support
Date:   Tue,  6 Jul 2021 11:09:01 +0800
Message-Id: <20210706030904.1411775-7-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706030904.1411775-1-chenhuacai@loongson.cn>
References: <20210706030904.1411775-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are preparing to add new Loongson (based on LoongArch, not MIPS)
support. LoongArch use ACPI other than DT as its boot protocol, so
add ACPI init support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-liointc.c | 140 +++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 649c58391618..591fc1192e73 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2020, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *			Jianmin Lv <lvjianmin@loongson.cn>
+ *			Huacai Chen <chenhuacai@loongson.cn>
  *  Loongson Local IO Interrupt Controller support
  */
 
@@ -19,7 +21,7 @@
 #include <loongson.h>
 
 #define LIOINTC_CHIP_IRQ	32
-#define LIOINTC_NUM_PARENT 4
+#define LIOINTC_NUM_PARENT	4
 #define LIOINTC_NUM_CORES	4
 
 #define LIOINTC_INTC_CHIP_START	0x20
@@ -53,7 +55,7 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
 	struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_chip_generic *gc = handler->priv->gc;
-	int core = get_ebase_cpunum() % LIOINTC_NUM_CORES;
+	int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
 	u32 pending;
 
 	chained_irq_enter(chip, desc);
@@ -143,8 +145,12 @@ static void liointc_resume(struct irq_chip_generic *gc)
 	irq_gc_unlock_irqrestore(gc, flags);
 }
 
-static const char * const parent_names[] = {"int0", "int1", "int2", "int3"};
-static const char * const core_reg_names[] = {"isr0", "isr1", "isr2", "isr3"};
+static int parent_irq[LIOINTC_NUM_PARENT];
+static u32 parent_int_map[LIOINTC_NUM_PARENT];
+static const char *const parent_names[] = {"int0", "int1", "int2", "int3"};
+static const char *const core_reg_names[] = {"isr0", "isr1", "isr2", "isr3"};
+
+#ifdef CONFIG_OF
 
 static void __iomem *liointc_get_reg_byname(struct device_node *node,
 						const char *name)
@@ -165,8 +171,6 @@ static int __init liointc_of_init(struct device_node *node,
 	struct irq_chip_type *ct;
 	struct liointc_priv *priv;
 	void __iomem *base;
-	u32 of_parent_int_map[LIOINTC_NUM_PARENT];
-	int parent_irq[LIOINTC_NUM_PARENT];
 	bool have_parent = FALSE;
 	int sz, i, err = 0;
 
@@ -210,7 +214,7 @@ static int __init liointc_of_init(struct device_node *node,
 
 	sz = of_property_read_variable_u32_array(node,
 						"loongson,parent_int_map",
-						&of_parent_int_map[0],
+						&parent_int_map[0],
 						LIOINTC_NUM_PARENT,
 						LIOINTC_NUM_PARENT);
 	if (sz < 4) {
@@ -220,7 +224,7 @@ static int __init liointc_of_init(struct device_node *node,
 	}
 
 	for (i = 0; i < LIOINTC_NUM_PARENT; i++)
-		priv->handler[i].parent_int_map = of_parent_int_map[i];
+		priv->handler[i].parent_int_map = parent_int_map[i];
 
 	/* Setup IRQ domain */
 	domain = irq_domain_add_linear(node, 32,
@@ -310,3 +314,123 @@ static int __init liointc_of_init(struct device_node *node,
 IRQCHIP_DECLARE(loongson_liointc_1_0, "loongson,liointc-1.0", liointc_of_init);
 IRQCHIP_DECLARE(loongson_liointc_1_0a, "loongson,liointc-1.0a", liointc_of_init);
 IRQCHIP_DECLARE(loongson_liointc_2_0, "loongson,liointc-2.0", liointc_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+
+struct fwnode_handle *liointc_acpi_init(struct acpi_madt_lio_pic *acpi_liointc)
+{
+	int i, err;
+	void __iomem *base;
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	struct irq_domain *domain;
+	struct liointc_priv *priv;
+	struct fwnode_handle *domain_handle;
+
+	parent_int_map[0] = acpi_liointc->cascade_map[0];
+	parent_int_map[1] = acpi_liointc->cascade_map[1];
+
+	parent_irq[0] = LOONGSON_CPU_IRQ_BASE + acpi_liointc->cascade[0];
+	if (!cpu_has_extioi)
+		parent_irq[1] = LOONGSON_CPU_IRQ_BASE + acpi_liointc->cascade[1];
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	base = ioremap(acpi_liointc->address, acpi_liointc->size);
+	if (!base)
+		goto out_free_priv;
+
+	for (i = 0; i < LIOINTC_NUM_CORES; i++)
+		priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
+
+	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)priv);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		return NULL;
+	}
+
+	for (i = 0; i < LIOINTC_NUM_PARENT; i++)
+		priv->handler[i].parent_int_map = parent_int_map[i];
+
+	/* Setup IRQ domain */
+	domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
+					&irq_generic_chip_ops, priv);
+	if (!domain) {
+		pr_err("loongson-liointc: cannot add IRQ domain\n");
+		goto out_iounmap;
+	}
+
+	err = irq_alloc_domain_generic_chips(domain, LIOINTC_CHIP_IRQ, 1,
+					"LIOINTC", handle_level_irq,
+					0, IRQ_NOPROBE, 0);
+	if (err) {
+		pr_err("loongson-liointc: unable to register IRQ domain\n");
+		goto out_free_domain;
+	}
+
+
+	/* Disable all IRQs */
+	writel(0xffffffff, base + LIOINTC_REG_INTC_DISABLE);
+	/* Set to level triggered */
+	writel(0x0, base + LIOINTC_REG_INTC_EDGE);
+
+	/* Generate parent INT part of map cache */
+	for (i = 0; i < LIOINTC_NUM_PARENT; i++) {
+		u32 pending = priv->handler[i].parent_int_map;
+
+		while (pending) {
+			int bit = __ffs(pending);
+
+			priv->map_cache[bit] = BIT(i) << LIOINTC_SHIFT_INTx;
+			pending &= ~BIT(bit);
+		}
+	}
+
+	for (i = 0; i < LIOINTC_CHIP_IRQ; i++) {
+		/* Generate core part of map cache */
+		priv->map_cache[i] |= BIT(loongson_sysconf.boot_cpu_id);
+		writeb(priv->map_cache[i], base + i);
+	}
+
+	gc = irq_get_domain_generic_chip(domain, 0);
+	gc->private = priv;
+	gc->reg_base = base;
+	gc->domain = domain;
+	gc->resume = liointc_resume;
+
+	ct = gc->chip_types;
+	ct->regs.enable = LIOINTC_REG_INTC_ENABLE;
+	ct->regs.disable = LIOINTC_REG_INTC_DISABLE;
+	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
+	ct->chip.irq_mask = irq_gc_mask_disable_reg;
+	ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
+
+	gc->mask_cache = 0;
+	priv->gc = gc;
+
+	for (i = 0; i < LIOINTC_NUM_PARENT; i++) {
+		if (parent_irq[i] <= 0)
+			continue;
+
+		priv->handler[i].priv = priv;
+		irq_set_chained_handler_and_data(parent_irq[i],
+				liointc_chained_handle_irq, &priv->handler[i]);
+	}
+
+	return domain_handle;
+
+out_free_domain:
+	irq_domain_remove(domain);
+out_iounmap:
+	iounmap(base);
+out_free_priv:
+	kfree(priv);
+
+	return NULL;
+}
+
+#endif
-- 
2.27.0


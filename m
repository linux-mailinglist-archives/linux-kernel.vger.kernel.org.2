Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF65E3ECFD5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhHPH7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234533AbhHPH64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:58:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72CE861AE2;
        Mon, 16 Aug 2021 07:58:22 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 07/10] irqchip/loongson-liointc: Add ACPI init support
Date:   Mon, 16 Aug 2021 15:52:49 +0800
Message-Id: <20210816075252.4003406-8-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210816075252.4003406-1-chenhuacai@loongson.cn>
References: <20210816075252.4003406-1-chenhuacai@loongson.cn>
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
 drivers/irqchip/irq-loongson-liointc.c | 197 +++++++++++++++----------
 1 file changed, 117 insertions(+), 80 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 649c58391618..5a03a7de2e2a 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -16,10 +16,10 @@
 #include <linux/smp.h>
 #include <linux/irqchip/chained_irq.h>
 
-#include <loongson.h>
+#include <asm/loongson.h>
 
 #define LIOINTC_CHIP_IRQ	32
-#define LIOINTC_NUM_PARENT 4
+#define LIOINTC_NUM_PARENT	4
 #define LIOINTC_NUM_CORES	4
 
 #define LIOINTC_INTC_CHIP_START	0x20
@@ -41,6 +41,7 @@ struct liointc_handler_data {
 };
 
 struct liointc_priv {
+	struct fwnode_handle    	*domain_handle;
 	struct irq_chip_generic		*gc;
 	struct liointc_handler_data	handler[LIOINTC_NUM_PARENT];
 	void __iomem			*core_isr[LIOINTC_NUM_CORES];
@@ -53,7 +54,7 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
 	struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_chip_generic *gc = handler->priv->gc;
-	int core = get_ebase_cpunum() % LIOINTC_NUM_CORES;
+	int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
 	u32 pending;
 
 	chained_irq_enter(chip, desc);
@@ -143,97 +144,61 @@ static void liointc_resume(struct irq_chip_generic *gc)
 	irq_gc_unlock_irqrestore(gc, flags);
 }
 
-static const char * const parent_names[] = {"int0", "int1", "int2", "int3"};
-static const char * const core_reg_names[] = {"isr0", "isr1", "isr2", "isr3"};
+static int parent_irq[LIOINTC_NUM_PARENT];
+static u32 parent_int_map[LIOINTC_NUM_PARENT];
+static const char *const parent_names[] = {"int0", "int1", "int2", "int3"};
+static const char *const core_reg_names[] = {"isr0", "isr1", "isr2", "isr3"};
 
-static void __iomem *liointc_get_reg_byname(struct device_node *node,
-						const char *name)
-{
-	int index = of_property_match_string(node, "reg-names", name);
-
-	if (index < 0)
-		return NULL;
-
-	return of_iomap(node, index);
-}
-
-static int __init liointc_of_init(struct device_node *node,
-				  struct device_node *parent)
+static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
+		struct fwnode_handle *domain_handle, struct device_node *node)
 {
+	int i, index, err;
+	void __iomem *base;
+	struct irq_chip_type *ct;
 	struct irq_chip_generic *gc;
 	struct irq_domain *domain;
-	struct irq_chip_type *ct;
 	struct liointc_priv *priv;
-	void __iomem *base;
-	u32 of_parent_int_map[LIOINTC_NUM_PARENT];
-	int parent_irq[LIOINTC_NUM_PARENT];
-	bool have_parent = FALSE;
-	int sz, i, err = 0;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	if (of_device_is_compatible(node, "loongson,liointc-2.0")) {
-		base = liointc_get_reg_byname(node, "main");
-		if (!base) {
-			err = -ENODEV;
-			goto out_free_priv;
-		}
+	base = ioremap(addr, size);
+	if (!base)
+		goto out_free_priv;
 
-		for (i = 0; i < LIOINTC_NUM_CORES; i++)
-			priv->core_isr[i] = liointc_get_reg_byname(node, core_reg_names[i]);
-		if (!priv->core_isr[0]) {
-			err = -ENODEV;
-			goto out_iounmap_base;
-		}
-	} else {
-		base = of_iomap(node, 0);
-		if (!base) {
-			err = -ENODEV;
-			goto out_free_priv;
-		}
+	priv->domain_handle = domain_handle;
 
-		for (i = 0; i < LIOINTC_NUM_CORES; i++)
-			priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
-	}
+	for (i = 0; i < LIOINTC_NUM_CORES; i++)
+		priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
 
-	for (i = 0; i < LIOINTC_NUM_PARENT; i++) {
-		parent_irq[i] = of_irq_get_byname(node, parent_names[i]);
-		if (parent_irq[i] > 0)
-			have_parent = TRUE;
-	}
-	if (!have_parent) {
-		err = -ENODEV;
-		goto out_iounmap_isr;
-	}
+	for (i = 0; i < LIOINTC_NUM_PARENT; i++)
+		priv->handler[i].parent_int_map = parent_int_map[i];
 
-	sz = of_property_read_variable_u32_array(node,
-						"loongson,parent_int_map",
-						&of_parent_int_map[0],
-						LIOINTC_NUM_PARENT,
-						LIOINTC_NUM_PARENT);
-	if (sz < 4) {
-		pr_err("loongson-liointc: No parent_int_map\n");
-		err = -ENODEV;
-		goto out_iounmap_isr;
-	}
+#ifdef CONFIG_OF
+	if (revision > 1) {
+		for (i = 0; i < LIOINTC_NUM_CORES; i++) {
+			index = of_property_match_string(node, "reg-names", core_reg_names[i]);
 
-	for (i = 0; i < LIOINTC_NUM_PARENT; i++)
-		priv->handler[i].parent_int_map = of_parent_int_map[i];
+			if (index < 0)
+				return -EINVAL;
+
+			priv->core_isr[i] = of_iomap(node, index);
+		}
+	}
+#endif
 
 	/* Setup IRQ domain */
-	domain = irq_domain_add_linear(node, 32,
+	domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
 					&irq_generic_chip_ops, priv);
 	if (!domain) {
 		pr_err("loongson-liointc: cannot add IRQ domain\n");
-		err = -EINVAL;
-		goto out_iounmap_isr;
+		goto out_iounmap;
 	}
 
-	err = irq_alloc_domain_generic_chips(domain, 32, 1,
-					node->full_name, handle_level_irq,
-					IRQ_NOPROBE, 0, 0);
+	err = irq_alloc_domain_generic_chips(domain, LIOINTC_CHIP_IRQ, 1,
+					(node ? node->full_name : "LIOINTC"),
+					handle_level_irq, 0, IRQ_NOPROBE, 0);
 	if (err) {
 		pr_err("loongson-liointc: unable to register IRQ domain\n");
 		goto out_free_domain;
@@ -293,20 +258,92 @@ static int __init liointc_of_init(struct device_node *node,
 
 out_free_domain:
 	irq_domain_remove(domain);
-out_iounmap_isr:
-	for (i = 0; i < LIOINTC_NUM_CORES; i++) {
-		if (!priv->core_isr[i])
-			continue;
-		iounmap(priv->core_isr[i]);
-	}
-out_iounmap_base:
+out_iounmap:
 	iounmap(base);
 out_free_priv:
 	kfree(priv);
 
-	return err;
+	return -EINVAL;
+}
+
+#ifdef CONFIG_OF
+
+static int __init liointc_of_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	bool have_parent = FALSE;
+	int sz, i, index, revision, err = 0;
+	struct resource res;
+
+	if (!of_device_is_compatible(node, "loongson,liointc-2.0")) {
+		index = 0;
+		revision = 1;
+	} else {
+		index = of_property_match_string(node, "reg-names", "main");
+		revision = 2;
+	}
+
+	if (of_address_to_resource(node, index, &res))
+		return -EINVAL;
+
+	for (i = 0; i < LIOINTC_NUM_PARENT; i++) {
+		parent_irq[i] = of_irq_get_byname(node, parent_names[i]);
+		if (parent_irq[i] > 0)
+			have_parent = TRUE;
+	}
+	if (!have_parent)
+		return -ENODEV;
+
+	sz = of_property_read_variable_u32_array(node,
+						"loongson,parent_int_map",
+						&parent_int_map[0],
+						LIOINTC_NUM_PARENT,
+						LIOINTC_NUM_PARENT);
+	if (sz < 4) {
+		pr_err("loongson-liointc: No parent_int_map\n");
+		return -ENODEV;
+	}
+
+	err = liointc_init(res.start, resource_size(&res),
+			revision, of_node_to_fwnode(node), node);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
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
+	int ret;
+	struct fwnode_handle *domain_handle;
+
+	parent_int_map[0] = acpi_liointc->cascade_map[0];
+	parent_int_map[1] = acpi_liointc->cascade_map[1];
+
+	parent_irq[0] = LOONGSON_CPU_IRQ_BASE + acpi_liointc->cascade[0];
+	if (!cpu_has_extioi)
+		parent_irq[1] = LOONGSON_CPU_IRQ_BASE + acpi_liointc->cascade[1];
+
+	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_liointc);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		return NULL;
+	}
+
+	ret = liointc_init(acpi_liointc->address, acpi_liointc->size,
+			   1, domain_handle, NULL);
+	if (ret < 0)
+		return NULL;
+
+	return domain_handle;
+}
+
+#endif
-- 
2.27.0


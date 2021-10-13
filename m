Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42042B444
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 06:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhJMEgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 00:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230336AbhJMEgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 00:36:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7E8660C4A;
        Wed, 13 Oct 2021 04:34:11 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V7 05/10] irqchip/loongson-htvec: Add ACPI init support
Date:   Wed, 13 Oct 2021 12:27:07 +0800
Message-Id: <20211013042712.3077468-6-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211013042712.3077468-1-chenhuacai@loongson.cn>
References: <20211013042712.3077468-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are preparing to add new Loongson (based on LoongArch, not compatible
with old MIPS-based Loongson) support. LoongArch use ACPI other than DT
as its boot protocol, so add ACPI init support.

HTVECINTC stands for "HyperTransport Interrupts" that described in
Section 14.3 of "Loongson 3A5000 Processor Reference Manual". For more
information please refer Documentation/loongarch/irq-chip-model.rst.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-htvec.c | 115 +++++++++++++++++++--------
 1 file changed, 81 insertions(+), 34 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 60a335d7e64e..f573e4e61390 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -20,7 +20,6 @@
 /* Registers */
 #define HTVEC_EN_OFF		0x20
 #define HTVEC_MAX_PARENT_IRQ	8
-
 #define VEC_COUNT_PER_REG	32
 #define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
 #define VEC_REG_BIT(irq_id)	((irq_id) % VEC_COUNT_PER_REG)
@@ -30,8 +29,11 @@ struct htvec {
 	void __iomem		*base;
 	struct irq_domain	*htvec_domain;
 	raw_spinlock_t		htvec_lock;
+	struct fwnode_handle	*domain_handle;
 };
 
+static struct htvec *htvec_priv;
+
 static void htvec_irq_dispatch(struct irq_desc *desc)
 {
 	int i;
@@ -155,64 +157,109 @@ static void htvec_reset(struct htvec *priv)
 	}
 }
 
-static int htvec_of_init(struct device_node *node,
-				struct device_node *parent)
+static int htvec_init(phys_addr_t addr, unsigned long size,
+		int num_parents, int parent_irq[], struct fwnode_handle *domain_handle)
 {
+	int i;
 	struct htvec *priv;
-	int err, parent_irq[8], i;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->num_parents = num_parents;
+	priv->base = ioremap(addr, size);
+	priv->domain_handle = domain_handle;
 	raw_spin_lock_init(&priv->htvec_lock);
-	priv->base = of_iomap(node, 0);
-	if (!priv->base) {
-		err = -ENOMEM;
-		goto free_priv;
-	}
-
-	/* Interrupt may come from any of the 8 interrupt lines */
-	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
-		parent_irq[i] = irq_of_parse_and_map(node, i);
-		if (parent_irq[i] <= 0)
-			break;
-
-		priv->num_parents++;
-	}
-
-	if (!priv->num_parents) {
-		pr_err("Failed to get parent irqs\n");
-		err = -ENODEV;
-		goto iounmap_base;
-	}
 
-	priv->htvec_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+	/* Setup IRQ domain */
+	priv->htvec_domain = irq_domain_create_linear(priv->domain_handle,
 					(VEC_COUNT_PER_REG * priv->num_parents),
 					&htvec_domain_ops, priv);
 	if (!priv->htvec_domain) {
-		pr_err("Failed to create IRQ domain\n");
-		err = -ENOMEM;
-		goto irq_dispose;
+		pr_err("loongson-htvec: cannot add IRQ domain\n");
+		goto iounmap_base;
 	}
 
 	htvec_reset(priv);
 
-	for (i = 0; i < priv->num_parents; i++)
+	for (i = 0; i < priv->num_parents; i++) {
 		irq_set_chained_handler_and_data(parent_irq[i],
 						 htvec_irq_dispatch, priv);
+	}
+
+	htvec_priv = priv;
 
 	return 0;
 
-irq_dispose:
-	for (; i > 0; i--)
-		irq_dispose_mapping(parent_irq[i - 1]);
 iounmap_base:
 	iounmap(priv->base);
-free_priv:
+	priv->domain_handle = NULL;
 	kfree(priv);
 
-	return err;
+	return -EINVAL;
+}
+
+#ifdef CONFIG_OF
+
+static int htvec_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	int i, err;
+	int num_parents, parent_irq[8];
+	struct resource res;
+
+	if (of_address_to_resource(node, 0, &res))
+		return -EINVAL;
+
+	/* Interrupt may come from any of the 8 interrupt lines */
+	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
+		parent_irq[i] = irq_of_parse_and_map(node, i);
+		if (parent_irq[i] <= 0)
+			break;
+
+		num_parents++;
+	}
+
+	err = htvec_init(res.start, resource_size(&res),
+			num_parents, parent_irq, of_node_to_fwnode(node));
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 IRQCHIP_DECLARE(htvec, "loongson,htvec-1.0", htvec_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+
+struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
+				   struct acpi_madt_ht_pic *acpi_htvec)
+{
+	int i, ret;
+	int num_parents, parent_irq[8];
+	struct fwnode_handle *domain_handle;
+
+	num_parents = HTVEC_MAX_PARENT_IRQ;
+
+	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_htvec);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		return NULL;
+	}
+
+	/* Interrupt may come from any of the 8 interrupt lines */
+	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++)
+		parent_irq[i] = irq_create_mapping(parent, acpi_htvec->cascade[i]);
+
+	ret = htvec_init(acpi_htvec->address, acpi_htvec->size,
+			num_parents, parent_irq, domain_handle);
+	if (ret < 0)
+		return NULL;
+
+	return irq_find_matching_fwnode(domain_handle, DOMAIN_BUS_ANY);
+}
+
+#endif
-- 
2.27.0


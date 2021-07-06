Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5433BC4FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 05:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhGFDMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 23:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhGFDMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 23:12:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B58F6197F;
        Tue,  6 Jul 2021 03:09:42 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 3/9] irqchip/loongson-pch-pic: Add ACPI init support
Date:   Tue,  6 Jul 2021 11:08:58 +0800
Message-Id: <20210706030904.1411775-4-chenhuacai@loongson.cn>
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
 drivers/irqchip/irq-loongson-pch-pic.c | 120 ++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index a4eb8a2181c7..62382611995b 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2020, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *			Jianmin Lv <lvjianmin@loongson.cn>
+ *			Huacai Chen <chenhuacai@loongson.cn>
  *  Loongson PCH PIC support
  */
 
@@ -15,6 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/syscore_ops.h>
 
 /* Registers */
 #define PCH_PIC_MASK		0x20
@@ -32,14 +35,23 @@
 #define PIC_COUNT		(PIC_COUNT_PER_REG * PIC_REG_COUNT)
 #define PIC_REG_IDX(irq_id)	((irq_id) / PIC_COUNT_PER_REG)
 #define PIC_REG_BIT(irq_id)	((irq_id) % PIC_COUNT_PER_REG)
+#define PCH_PIC_SIZE		0x400
+
+static int nr_pch_pics;
 
 struct pch_pic {
 	void __iomem		*base;
 	struct irq_domain	*pic_domain;
+	struct fwnode_handle	*domain_handle;
 	u32			ht_vec_base;
 	raw_spinlock_t		pic_lock;
+	u32			saved_vec_en[PIC_REG_COUNT];
+	u32			saved_vec_pol[PIC_REG_COUNT];
+	u32			saved_vec_edge[PIC_REG_COUNT];
 };
 
+struct pch_pic *pch_pic_priv[4];
+
 static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
 {
 	u32 reg;
@@ -137,6 +149,7 @@ static struct irq_chip pch_pic_irq_chip = {
 	.irq_ack		= pch_pic_ack_irq,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_set_type		= pch_pic_set_type,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
@@ -180,7 +193,7 @@ static void pch_pic_reset(struct pch_pic *priv)
 	int i;
 
 	for (i = 0; i < PIC_COUNT; i++) {
-		/* Write vectored ID */
+		/* Write vector ID */
 		writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(i));
 		/* Hardcode route to HT0 Lo */
 		writeb(1, priv->base + PCH_INT_ROUTE(i));
@@ -198,6 +211,48 @@ static void pch_pic_reset(struct pch_pic *priv)
 	}
 }
 
+static int pch_pic_suspend(void)
+{
+	int i, j;
+
+	for (i = 0; i < nr_pch_pics; i++) {
+		for (j = 0; j < PIC_REG_COUNT; j++) {
+			pch_pic_priv[i]->saved_vec_pol[j] =
+				readl(pch_pic_priv[i]->base + PCH_PIC_POL + 4 * j);
+			pch_pic_priv[i]->saved_vec_edge[j] =
+				readl(pch_pic_priv[i]->base + PCH_PIC_EDGE + 4 * j);
+			pch_pic_priv[i]->saved_vec_en[j] =
+				readl(pch_pic_priv[i]->base + PCH_PIC_MASK + 4 * j);
+		}
+	}
+
+	return 0;
+}
+
+static void pch_pic_resume(void)
+{
+	int i, j;
+
+	for (i = 0; i < nr_pch_pics; i++) {
+		pch_pic_reset(pch_pic_priv[i]);
+		for (j = 0; j < PIC_REG_COUNT; j++) {
+			writel(pch_pic_priv[i]->saved_vec_pol[j],
+					pch_pic_priv[i]->base + PCH_PIC_POL + 4 * j);
+			writel(pch_pic_priv[i]->saved_vec_edge[j],
+					pch_pic_priv[i]->base + PCH_PIC_EDGE + 4 * j);
+			writel(pch_pic_priv[i]->saved_vec_en[j],
+					pch_pic_priv[i]->base + PCH_PIC_MASK + 4 * j);
+		}
+	}
+}
+
+static struct syscore_ops pch_pic_syscore_ops = {
+	.suspend =  pch_pic_suspend,
+	.resume =  pch_pic_resume,
+};
+
+#ifdef CONFIG_OF
+
 static int pch_pic_of_init(struct device_node *node,
 				struct device_node *parent)
 {
@@ -242,6 +297,9 @@ static int pch_pic_of_init(struct device_node *node,
 	}
 
 	pch_pic_reset(priv);
+	pch_pic_priv[0] = priv;
+
+	register_syscore_ops(&pch_pic_syscore_ops);
 
 	return 0;
 
@@ -254,3 +312,63 @@ static int pch_pic_of_init(struct device_node *node,
 }
 
 IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0", pch_pic_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+
+struct fwnode_handle *pch_pic_acpi_init(struct fwnode_handle *parent,
+					struct acpi_madt_bio_pic *acpi_pchpic)
+{
+	int count;
+	struct pch_pic *priv;
+	struct irq_domain *parent_domain;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	raw_spin_lock_init(&priv->pic_lock);
+	priv->base = ioremap(acpi_pchpic->address, acpi_pchpic->size);
+	if (!priv->base)
+		goto free_priv;
+
+	priv->domain_handle = irq_domain_alloc_fwnode(priv->base);
+	if (!priv->domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		goto iounmap_base;
+	}
+
+	priv->ht_vec_base = acpi_pchpic->gsi_base;
+	count = ((readq(priv->base) >> 48) & 0xff) + 1;
+	parent_domain = irq_find_matching_fwnode(parent, DOMAIN_BUS_ANY);
+	if (!parent_domain) {
+		pr_err("Failed to find the parent domain\n");
+		goto iounmap_base;
+	}
+
+	priv->pic_domain = irq_domain_create_hierarchy(parent_domain, 0,
+						count, priv->domain_handle,
+						&pch_pic_domain_ops, priv);
+
+	if (!priv->pic_domain) {
+		pr_err("Failed to create IRQ domain\n");
+		goto iounmap_base;
+	}
+
+	pch_pic_reset(priv);
+	pch_pic_priv[nr_pch_pics++] = priv;
+
+	register_syscore_ops(&pch_pic_syscore_ops);
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
+
+#endif
-- 
2.27.0


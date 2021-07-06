Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C8C3BC501
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 05:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhGFDNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 23:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhGFDNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 23:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E46426197E;
        Tue,  6 Jul 2021 03:10:51 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 5/9] irqchip/loongson-htvec: Add ACPI init support
Date:   Tue,  6 Jul 2021 11:09:00 +0800
Message-Id: <20210706030904.1411775-6-chenhuacai@loongson.cn>
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
 drivers/irqchip/irq-loongson-htvec.c | 102 ++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 60a335d7e64e..69452d4a33c0 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2020, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *			Jianmin Lv <lvjianmin@loongson.cn>
+ *			Huacai Chen <chenhuacai@loongson.cn>
  *  Loongson HyperTransport Interrupt Vector support
  */
 
@@ -16,22 +18,27 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/syscore_ops.h>
 
 /* Registers */
 #define HTVEC_EN_OFF		0x20
 #define HTVEC_MAX_PARENT_IRQ	8
-
 #define VEC_COUNT_PER_REG	32
 #define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
 #define VEC_REG_BIT(irq_id)	((irq_id) % VEC_COUNT_PER_REG)
+#define HTVEC_SIZE		0x400
 
 struct htvec {
 	int			num_parents;
 	void __iomem		*base;
 	struct irq_domain	*htvec_domain;
 	raw_spinlock_t		htvec_lock;
+	struct fwnode_handle	*domain_handle;
+	u32			saved_vec_en[HTVEC_MAX_PARENT_IRQ];
 };
 
+struct htvec *htvec_priv;
+
 static void htvec_irq_dispatch(struct irq_desc *desc)
 {
 	int i;
@@ -155,6 +162,31 @@ static void htvec_reset(struct htvec *priv)
 	}
 }
 
+static int htvec_suspend(void)
+{
+	int i;
+
+	for (i = 0; i < htvec_priv->num_parents; i++)
+		htvec_priv->saved_vec_en[i] = readl(htvec_priv->base + HTVEC_EN_OFF + 4 * i);
+
+	return 0;
+}
+
+static void htvec_resume(void)
+{
+	int i;
+
+	for (i = 0; i < htvec_priv->num_parents; i++)
+		writel(htvec_priv->saved_vec_en[i], htvec_priv->base + HTVEC_EN_OFF + 4 * i);
+}
+
+static struct syscore_ops htvec_syscore_ops = {
+	.suspend = htvec_suspend,
+	.resume = htvec_resume,
+};
+
+#ifdef CONFIG_OF
+
 static int htvec_of_init(struct device_node *node,
 				struct device_node *parent)
 {
@@ -202,6 +234,10 @@ static int htvec_of_init(struct device_node *node,
 		irq_set_chained_handler_and_data(parent_irq[i],
 						 htvec_irq_dispatch, priv);
 
+	htvec_priv = priv;
+
+	register_syscore_ops(&htvec_syscore_ops);
+
 	return 0;
 
 irq_dispose:
@@ -216,3 +252,67 @@ static int htvec_of_init(struct device_node *node,
 }
 
 IRQCHIP_DECLARE(htvec, "loongson,htvec-1.0", htvec_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+
+struct fwnode_handle *htvec_acpi_init(struct fwnode_handle *parent,
+					struct acpi_madt_ht_pic *acpi_htvec)
+{
+	int i, parent_irq[8];
+	struct htvec *priv;
+	struct irq_fwspec fwspec;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	priv->num_parents = HTVEC_MAX_PARENT_IRQ;
+	priv->base = ioremap(acpi_htvec->address, acpi_htvec->size);
+
+	/* Interrupt may come from any of the 8 interrupt lines */
+	for (i = 0; i < priv->num_parents; i++)
+		parent_irq[i] = acpi_htvec->cascade[i];
+
+	priv->domain_handle = irq_domain_alloc_fwnode(priv->base);
+	if (!priv->domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		goto iounmap_base;
+	}
+
+	/* Setup IRQ domain */
+	priv->htvec_domain = irq_domain_create_linear(priv->domain_handle,
+					(VEC_COUNT_PER_REG * priv->num_parents),
+					&htvec_domain_ops, priv);
+	if (!priv->htvec_domain) {
+		pr_err("loongson-htvec: cannot add IRQ domain\n");
+		goto iounmap_base;
+	}
+
+	htvec_reset(priv);
+
+	for (i = 0; i < priv->num_parents; i++) {
+		fwspec.fwnode = parent;
+		fwspec.param[0] = parent_irq[i];
+		fwspec.param_count = 1;
+		parent_irq[i] = irq_create_fwspec_mapping(&fwspec);
+		irq_set_chained_handler_and_data(parent_irq[i],
+						 htvec_irq_dispatch, priv);
+	}
+
+	htvec_priv = priv;
+
+	register_syscore_ops(&htvec_syscore_ops);
+
+	return htvec_priv->domain_handle;
+
+iounmap_base:
+	iounmap(priv->base);
+	priv->domain_handle = NULL;
+	kfree(priv);
+
+	return NULL;
+}
+
+#endif
-- 
2.27.0


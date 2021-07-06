Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C3A3BC4FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 05:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhGFDMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 23:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhGFDMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 23:12:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5877E6197F;
        Tue,  6 Jul 2021 03:10:06 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 4/9] irqchip/loongson-pch-msi: Add ACPI init support
Date:   Tue,  6 Jul 2021 11:08:59 +0800
Message-Id: <20210706030904.1411775-5-chenhuacai@loongson.cn>
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
 drivers/irqchip/irq-loongson-pch-msi.c | 69 ++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 32562b7e681b..adfa30046f0a 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2020, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *			Jianmin Lv <lvjianmin@loongson.cn>
+ *			Huacai Chen <chenhuacai@loongson.cn>
  *  Loongson PCH MSI support
  */
 
@@ -21,6 +23,7 @@ struct pch_msi_data {
 	u32		irq_first;	/* The vector number that MSIs starts */
 	u32		num_irqs;	/* The number of vectors for MSIs */
 	unsigned long	*msi_map;
+	struct fwnode_handle *domain_handle;
 };
 
 static void pch_msi_mask_msi_irq(struct irq_data *d)
@@ -159,7 +162,12 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
 {
 	struct irq_domain *middle_domain, *msi_domain;
 
-	middle_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+	if (node)
+		priv->domain_handle = of_node_to_fwnode(node);
+	else
+		priv->domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)priv);
+
+	middle_domain = irq_domain_create_linear(priv->domain_handle,
 						priv->num_irqs,
 						&pch_msi_middle_domain_ops,
 						priv);
@@ -171,7 +179,7 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
 	middle_domain->parent = parent;
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
 
-	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
+	msi_domain = pci_msi_create_irq_domain(priv->domain_handle,
 					       &pch_msi_domain_info,
 					       middle_domain);
 	if (!msi_domain) {
@@ -183,8 +191,9 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
 	return 0;
 }
 
-static int pch_msi_init(struct device_node *node,
-			    struct device_node *parent)
+#ifdef CONFIG_OF
+
+int pch_msi_of_init(struct device_node *node, struct device_node *parent)
 {
 	struct pch_msi_data *priv;
 	struct irq_domain *parent_domain;
@@ -247,4 +256,54 @@ static int pch_msi_init(struct device_node *node,
 	return ret;
 }
 
-IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_init);
+IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+
+struct fwnode_handle *pch_msi_acpi_init(struct fwnode_handle *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi)
+{
+	int ret;
+	struct pch_msi_data *priv;
+	struct irq_domain *parent_domain;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	mutex_init(&priv->msi_map_lock);
+
+	priv->doorbell = acpi_pchmsi->msg_address;
+	priv->irq_first = acpi_pchmsi->start;
+	priv->num_irqs = acpi_pchmsi->count;
+
+	parent_domain = irq_find_matching_fwnode(parent, DOMAIN_BUS_ANY);
+	if (!parent_domain) {
+		pr_err("Failed to find the parent domain\n");
+		return NULL;
+	}
+
+	priv->msi_map = bitmap_zalloc(priv->num_irqs, GFP_KERNEL);
+	if (!priv->msi_map)
+		goto err_priv;
+
+	pr_debug("Registering %d MSIs, starting at %d\n",
+		 priv->num_irqs, priv->irq_first);
+
+	ret = pch_msi_init_domains(priv, NULL, parent_domain);
+	if (ret)
+		goto err_map;
+
+	return priv->domain_handle;
+
+err_map:
+	kfree(priv->msi_map);
+err_priv:
+	kfree(priv);
+
+	return NULL;
+}
+
+#endif
-- 
2.27.0


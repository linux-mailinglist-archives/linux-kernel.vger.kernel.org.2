Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECC6331220
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhCHP0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:26:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40097 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230246AbhCHP0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:26:11 -0500
X-UUID: f9f9acf31296440885f04522b3f5b548-20210308
X-UUID: f9f9acf31296440885f04522b3f5b548-20210308
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1398100812; Mon, 08 Mar 2021 23:26:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 23:26:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 23:26:06 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     <yj.chiang@mediatek.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3] irqchip/irq-mst: Support polarity configuration
Date:   Mon, 8 Mar 2021 23:26:05 +0800
Message-ID: <20210308152605.26122-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support irq polarity configuration and save and restore the config
when system suspend and resume.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 drivers/irqchip/irq-mst-intc.c | 92 ++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mst-intc.c b/drivers/irqchip/irq-mst-intc.c
index 143657b0cf28..50f3ef8bc610 100644
--- a/drivers/irqchip/irq-mst-intc.c
+++ b/drivers/irqchip/irq-mst-intc.c
@@ -13,15 +13,27 @@
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
 
-#define INTC_MASK	0x0
-#define INTC_EOI	0x20
+#define MST_INTC_MAX_IRQS	64
+
+#define INTC_MASK		0x0
+#define INTC_REV_POLARITY	0x10
+#define INTC_EOI		0x20
+
+#ifdef CONFIG_PM_SLEEP
+static LIST_HEAD(mst_intc_list);
+#endif
 
 struct mst_intc_chip_data {
 	raw_spinlock_t	lock;
 	unsigned int	irq_start, nr_irqs;
 	void __iomem	*base;
 	bool		no_eoi;
+#ifdef CONFIG_PM_SLEEP
+	struct list_head entry;
+	u16 saved_polarity_conf[DIV_ROUND_UP(MST_INTC_MAX_IRQS, 16)];
+#endif
 };
 
 static void mst_set_irq(struct irq_data *d, u32 offset)
@@ -78,6 +90,19 @@ static void mst_intc_eoi_irq(struct irq_data *d)
 	irq_chip_eoi_parent(d);
 }
 
+static int mst_irq_chip_set_type(struct irq_data *data, unsigned int type)
+{
+	if (type != IRQ_TYPE_LEVEL_LOW && type != IRQ_TYPE_LEVEL_HIGH)
+		return -EINVAL;
+
+	if (type == IRQ_TYPE_LEVEL_LOW) {
+		mst_set_irq(data, INTC_REV_POLARITY);
+		type = IRQ_TYPE_LEVEL_HIGH;
+	}
+
+	return irq_chip_set_type_parent(data, type);
+}
+
 static struct irq_chip mst_intc_chip = {
 	.name			= "mst-intc",
 	.irq_mask		= mst_intc_mask_irq,
@@ -87,13 +112,62 @@ static struct irq_chip mst_intc_chip = {
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
-	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_type		= mst_irq_chip_set_type,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static void mst_intc_polarity_save(struct mst_intc_chip_data *cd)
+{
+	int i;
+	void __iomem *addr = cd->base + INTC_REV_POLARITY;
+
+	for (i = 0; i < DIV_ROUND_UP(cd->nr_irqs, 16); i++)
+		cd->saved_polarity_conf[i] = readw_relaxed(addr + i * 4);
+}
+
+static void mst_intc_polarity_restore(struct mst_intc_chip_data *cd)
+{
+	int i;
+	void __iomem *addr = cd->base + INTC_REV_POLARITY;
+
+	for (i = 0; i < DIV_ROUND_UP(cd->nr_irqs, 16); i++)
+		writew_relaxed(cd->saved_polarity_conf[i], addr + i * 4);
+}
+
+static void mst_irq_resume(void)
+{
+	struct mst_intc_chip_data *cd;
+
+	list_for_each_entry(cd, &mst_intc_list, entry)
+		mst_intc_polarity_restore(cd);
+}
+
+static int mst_irq_suspend(void)
+{
+	struct mst_intc_chip_data *cd;
+
+	list_for_each_entry(cd, &mst_intc_list, entry)
+		mst_intc_polarity_save(cd);
+	return 0;
+}
+
+static struct syscore_ops mst_irq_syscore_ops = {
+	.suspend	= mst_irq_suspend,
+	.resume		= mst_irq_resume,
+};
+
+static int __init mst_irq_pm_init(void)
+{
+	register_syscore_ops(&mst_irq_syscore_ops);
+	return 0;
+}
+late_initcall(mst_irq_pm_init);
+#endif
+
 static int mst_intc_domain_translate(struct irq_domain *d,
 				     struct irq_fwspec *fwspec,
 				     unsigned long *hwirq,
@@ -145,6 +219,14 @@ static int mst_intc_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	parent_fwspec = *fwspec;
 	parent_fwspec.fwnode = domain->parent->fwnode;
 	parent_fwspec.param[1] = cd->irq_start + hwirq;
+
+	/*
+	 * If the irq signal is active low, configure it to active high
+	 * to meet GIC SPI spec in mst_irq_chip_set_type via REV_POLARITY bit
+	 */
+	if (fwspec->param[2] == IRQ_TYPE_LEVEL_LOW)
+		parent_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
+
 	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_fwspec);
 }
 
@@ -193,6 +275,10 @@ static int __init mst_intc_of_init(struct device_node *dn,
 		return -ENOMEM;
 	}
 
+#ifdef CONFIG_PM_SLEEP
+	INIT_LIST_HEAD(&cd->entry);
+	list_add_tail(&cd->entry, &mst_intc_list);
+#endif
 	return 0;
 }
 
-- 
2.18.0


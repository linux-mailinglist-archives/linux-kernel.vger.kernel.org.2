Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C85D356C41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352256AbhDGMi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:38:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36354 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbhDGMiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:38:22 -0400
Date:   Wed, 07 Apr 2021 12:38:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617799092;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaFZi29CffhAuB6uGASxhytX3Dz7YuzUWLBEgH9bgdQ=;
        b=F3n7KIBAUx/101DqiofXuk4aWYCfscjdEtGX0duTPBxn8k0SGiM0zBMA0zi+38QOpN/lVk
        WC07jKREG+T1tvgJuaf56Y4Dea2qOVt7vE7DdyIZO3XDSwCUg97VVpuwagKJFLwDhBb91p
        9p+Wu/3rV0a3mCBVxMyZrR3GNUKgD25hh91RXHwat1kBQ1uV0ajHOoG4IjHZiAfxvGuU27
        THL0DW/o8l5Hjahk4v4RLBjwZdemPqHMuSvcXIyH9RMWJ+lQ2jX8eaECbDyqOChbQ8JVHN
        25i6Aj8LFf6sgCksfd5//s+qkKrDjq86iGY1dy7zxezULeXCIRDv6TZyzqVw/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617799092;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaFZi29CffhAuB6uGASxhytX3Dz7YuzUWLBEgH9bgdQ=;
        b=RTvuTndJO3/1s3j2HakIFry3BDZdz+HX3jxtYT8HoWSXqzlGpol01JvGWb1F9cwVrBv1f9
        91u8Ut1Il5ioVxCQ==
From:   "irqchip-bot for Mark-PK Tsai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-mst: Support polarity configuration
Cc:     "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210315131848.31840-1-mark-pk.tsai@mediatek.com>
References: <20210315131848.31840-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Message-ID: <161779909144.29796.14650133568061146967.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     ea4aeaa5c88906eb3ca3d7d3d17a45605d2dd0de
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ea4aeaa5c88906eb3ca3d7d3d17a45605d2dd0de
Author:        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
AuthorDate:    Mon, 15 Mar 2021 21:18:48 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Apr 2021 13:26:00 +01:00

irqchip/irq-mst: Support polarity configuration

Support irq polarity configuration and save and restore the config
when system suspend and resume.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
[maz: fixed irq_set_type callback]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210315131848.31840-1-mark-pk.tsai@mediatek.com
---
 drivers/irqchip/irq-mst-intc.c | 98 +++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mst-intc.c b/drivers/irqchip/irq-mst-intc.c
index 143657b..f6133ae 100644
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
@@ -78,6 +90,24 @@ static void mst_intc_eoi_irq(struct irq_data *d)
 	irq_chip_eoi_parent(d);
 }
 
+static int mst_irq_chip_set_type(struct irq_data *data, unsigned int type)
+{
+	switch (type) {
+	case IRQ_TYPE_LEVEL_LOW:
+	case IRQ_TYPE_EDGE_FALLING:
+		mst_set_irq(data, INTC_REV_POLARITY);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_EDGE_RISING:
+		mst_clear_irq(data, INTC_REV_POLARITY);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return irq_chip_set_type_parent(data, IRQ_TYPE_LEVEL_HIGH);
+}
+
 static struct irq_chip mst_intc_chip = {
 	.name			= "mst-intc",
 	.irq_mask		= mst_intc_mask_irq,
@@ -87,13 +117,62 @@ static struct irq_chip mst_intc_chip = {
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
@@ -145,6 +224,15 @@ static int mst_intc_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	parent_fwspec = *fwspec;
 	parent_fwspec.fwnode = domain->parent->fwnode;
 	parent_fwspec.param[1] = cd->irq_start + hwirq;
+
+	/*
+	 * mst-intc latch the interrupt request if it's edge triggered,
+	 * so the output signal to parent GIC is always level sensitive.
+	 * And if the irq signal is active low, configure it to active high
+	 * to meet GIC SPI spec in mst_irq_chip_set_type via REV_POLARITY bit.
+	 */
+	parent_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
+
 	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_fwspec);
 }
 
@@ -193,6 +281,10 @@ static int __init mst_intc_of_init(struct device_node *dn,
 		return -ENOMEM;
 	}
 
+#ifdef CONFIG_PM_SLEEP
+	INIT_LIST_HEAD(&cd->entry);
+	list_add_tail(&cd->entry, &mst_intc_list);
+#endif
 	return 0;
 }
 

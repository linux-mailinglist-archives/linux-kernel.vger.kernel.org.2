Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E64365901
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 14:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhDTMfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 08:35:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:48734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231758AbhDTMfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:35:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3D9EB2DD;
        Tue, 20 Apr 2021 12:34:46 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: Add support for IDT 79rc3243x interrupt controller
Date:   Tue, 20 Apr 2021 14:34:41 +0200
Message-Id: <20210420123441.24179-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDT 79rc3243x SoCs have rather simple interrupt controllers connected
to the MIPS CPU interrupt lines. Each of them has room for up to
32 interrupts.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 drivers/irqchip/Kconfig        |   5 ++
 drivers/irqchip/Makefile       |   1 +
 drivers/irqchip/irq-idt3243x.c | 124 +++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 drivers/irqchip/irq-idt3243x.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e74fa206240a..55562b36bf3c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -586,4 +586,9 @@ config MST_IRQ
 	help
 	  Support MStar Interrupt Controller.
 
+config IRQ_IDT3243X
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c59b95a0532c..341891443eec 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -113,3 +113,4 @@ obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
 obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
 obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
 obj-$(CONFIG_MACH_REALTEK_RTL)		+= irq-realtek-rtl.o
+obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
diff --git a/drivers/irqchip/irq-idt3243x.c b/drivers/irqchip/irq-idt3243x.c
new file mode 100644
index 000000000000..61caf21ef46c
--- /dev/null
+++ b/drivers/irqchip/irq-idt3243x.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for IDT/Renesas 79RC3243x Interrupt Controller.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define IDT_PIC_NR_IRQS		32
+
+#define IDT_PIC_IRQ_PEND		0x00
+#define IDT_PIC_IRQ_MASK		0x08
+
+struct idt_pic_data {
+	void __iomem *base;
+	struct irq_domain *irq_domain;
+	struct irq_chip_generic *gc;
+};
+
+static void idt_irq_dispatch(struct irq_desc *desc)
+{
+	struct idt_pic_data *idtpic = irq_desc_get_handler_data(desc);
+	struct irq_chip *host_chip = irq_desc_get_chip(desc);
+	u32 pending, hwirq, virq;
+
+	chained_irq_enter(host_chip, desc);
+
+	pending = irq_reg_readl(idtpic->gc, IDT_PIC_IRQ_PEND);
+	pending &= ~idtpic->gc->mask_cache;
+	while (pending) {
+		hwirq = __fls(pending);
+		virq = irq_linear_revmap(idtpic->irq_domain, hwirq);
+		if (virq)
+			generic_handle_irq(virq);
+		pending &= ~(1 << hwirq);
+	}
+
+	chained_irq_exit(host_chip, desc);
+}
+
+static int idt_pic_init(struct device_node *of_node, struct device_node *parent)
+{
+	struct irq_domain *domain;
+	struct idt_pic_data *idtpic;
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	unsigned int parent_irq;
+	int ret = 0;
+
+	idtpic = kzalloc(sizeof(*idtpic), GFP_KERNEL);
+	if (!idtpic) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	parent_irq = irq_of_parse_and_map(of_node, 0);
+	if (!parent_irq) {
+		pr_err("Failed to map parent IRQ!\n");
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	idtpic->base = of_iomap(of_node, 0);
+	if (!idtpic->base) {
+		pr_err("Failed to map base address!\n");
+		ret = -ENOMEM;
+		goto out_unmap_irq;
+	}
+
+	domain = irq_domain_add_linear(of_node, IDT_PIC_NR_IRQS,
+				       &irq_generic_chip_ops, NULL);
+	if (!domain) {
+		pr_err("Failed to add irqdomain!\n");
+		ret = -ENOMEM;
+		goto out_iounmap;
+	}
+	idtpic->irq_domain = domain;
+
+	ret = irq_alloc_domain_generic_chips(domain, 32, 1, "IDTPIC",
+					     handle_level_irq, 0,
+					     IRQ_NOPROBE | IRQ_LEVEL, 0);
+	if (ret)
+		goto out_domain_remove;
+
+	gc = irq_get_domain_generic_chip(domain, 0);
+	gc->reg_base = idtpic->base;
+	gc->private = idtpic;
+
+	ct = gc->chip_types;
+	ct->regs.mask = IDT_PIC_IRQ_MASK;
+	ct->chip.irq_mask = irq_gc_mask_set_bit;
+	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
+	idtpic->gc = gc;
+
+	/* Mask interrupts. */
+	writel(0xffffffff, idtpic->base + IDT_PIC_IRQ_MASK);
+	gc->mask_cache = 0xffffffff;
+
+	irq_set_chained_handler_and_data(parent_irq,
+					 idt_irq_dispatch, idtpic);
+
+	return 0;
+
+out_domain_remove:
+	irq_domain_remove(domain);
+out_iounmap:
+	iounmap(idtpic->base);
+out_unmap_irq:
+	irq_dispose_mapping(parent_irq);
+out_free:
+	kfree(idtpic);
+out_err:
+	pr_err("Failed to initialize! (errno = %d)\n", ret);
+	return ret;
+}
+
+IRQCHIP_DECLARE(idt_pic, "idt,3243x-pic", idt_pic_init);
-- 
2.29.2


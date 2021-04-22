Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE7E3682FE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbhDVPIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbhDVPIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:08:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F07C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 08:07:38 -0700 (PDT)
Date:   Thu, 22 Apr 2021 15:07:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619104055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpvXvO2otG35pYK2JYPRvv76NQ7+V0wihOYgfIXsyEw=;
        b=B/F3ceMrWC9EoX2lqsDuQPUOMJsDJuoPsBV00RTdIuieSfwGOlYDYEdENIIIlcdTqJtsDQ
        s96LVZqdxoj0LQramKuidewHbgoqe+myI8h3vH4K7yZ8Yew+I7+X1MVZMJd1OtwKXEir8H
        kMV/VFjzvYe7oIaOVxiUSrr2kFbJtR5TX21JLwn5qdnvre/MYmZEmKvLibqJ67GP93GO/Z
        WUech/B38BfYtJ/KHyI9okRG59iRVUspE6MjrXuTq85cOEJm7PiJS/dYxaklokEGmOUXQp
        Jy+BcER7WgMmrVxQ5s4PmVQjwZmWvgLiH9ufm0YyPcB1ttwStm5o+1o7riFEKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619104055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpvXvO2otG35pYK2JYPRvv76NQ7+V0wihOYgfIXsyEw=;
        b=OxYAcEhMzc6mfWV6mBX7S32QD/pJ6XorXJZZbjgOQWJ+OFYUAZ6+zp+v6QBJ+MVcDny+Vp
        emHnFGLJqZT39BBg==
From:   "irqchip-bot for Thomas Bogendoerfer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Add support for IDT 79rc3243x
 interrupt controller
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210422145330.73452-1-tsbogend@alpha.franken.de>
References: <20210422145330.73452-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Message-ID: <161910405518.29796.9569507894831873897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     529ea36818112530791a2ec083a1a3066be6174c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/529ea36818112530791a2ec083a1a3066be6174c
Author:        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
AuthorDate:    Thu, 22 Apr 2021 16:53:28 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 22 Apr 2021 16:03:18 +01:00

irqchip: Add support for IDT 79rc3243x interrupt controller

IDT 79rc3243x SoCs have rather simple interrupt controllers connected
to the MIPS CPU interrupt lines. Each of them has room for up to
32 interrupts.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210422145330.73452-1-tsbogend@alpha.franken.de
---
 drivers/irqchip/Kconfig        |   5 +-
 drivers/irqchip/Makefile       |   1 +-
 drivers/irqchip/irq-idt3243x.c | 124 ++++++++++++++++++++++++++++++++-
 3 files changed, 130 insertions(+)
 create mode 100644 drivers/irqchip/irq-idt3243x.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 715eb43..18b0d0b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -583,4 +583,9 @@ config WPCM450_AIC
 	help
 	  Support for the interrupt controller in the Nuvoton WPCM450 BMC SoC.
 
+config IRQ_IDT3243X
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index bef5793..1857360 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -114,3 +114,4 @@ obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
 obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
 obj-$(CONFIG_MACH_REALTEK_RTL)		+= irq-realtek-rtl.o
 obj-$(CONFIG_WPCM450_AIC)		+= irq-wpcm450-aic.o
+obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
diff --git a/drivers/irqchip/irq-idt3243x.c b/drivers/irqchip/irq-idt3243x.c
new file mode 100644
index 0000000..f099682
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
+IRQCHIP_DECLARE(idt_pic, "idt,32434-pic", idt_pic_init);

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7051D30F737
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbhBDQGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:06:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41664 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbhBDQDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:03:37 -0500
Date:   Thu, 04 Feb 2021 16:02:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612454571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+vIYEIIpEGWRqPEeDrDS+eSHQalzX3Yq2SLDQU9enGc=;
        b=hxUZooqj1oTPtSCPOO2k35Gw0bZn1IbDt/Jh5fSsd76mqEgfeNyIcMHeDY3G+SjIIRLTjy
        FlkaWQo1aqwkTQxYAqq9gLhV0wr9p4Z4KJ4RdSihK9zL2FjVj5Ia3y63t3g4CMuvuIogGi
        NqsXXMrAUea1owmWxT5VbKP4fnw8pEJb6v85oUVifZYI2UTnBvW0+ybmm4U/L7Z1ZEYwwe
        ip76pkltlyE9xWGU4FUnYAkP5prpBJAhJaUim8t6C5B/GgJ5BILQ2QsEZQLWNHKN4vn4PB
        QRa4K5aOS6mahtizDR9JINlSsv3nUtPcEHtnAJ92H5C2K3nFXog0fA7sJKuTCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612454571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+vIYEIIpEGWRqPEeDrDS+eSHQalzX3Yq2SLDQU9enGc=;
        b=UupMHkkw59IEtfHdoNojorbmD26aXYN11xmfTbAEpfmXqGkICk9pnKa1Il9QvM3Vy3m4DL
        bfp5PoU6mWPQcnCg==
From:   "irqchip-bot for Bert Vermeulen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Add support for Realtek
 RTL838x/RTL839x interrupt controller
Cc:     Bert Vermeulen <bert@biot.com>,
        Birger Koblitz <mail@birger-koblitz.de>,
        John Crispin <john@phrozen.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210122204224.509124-3-bert@biot.com>
References: <20210122204224.509124-3-bert@biot.com>
MIME-Version: 1.0
Message-ID: <161245457098.23325.778659941105501999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9f3a0f34b84ad1b9a8f2bdae44b66f16685b2143
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9f3a0f34b84ad1b9a8f2bdae44b66f16685b2143
Author:        Bert Vermeulen <bert@biot.com>
AuthorDate:    Fri, 22 Jan 2021 21:42:24 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 04 Feb 2021 10:36:15 

irqchip: Add support for Realtek RTL838x/RTL839x interrupt controller

This is a standard IRQ driver with only status and mask registers.

The mapping from SoC interrupts (18-31) to MIPS core interrupts is
done via an interrupt-map in device tree.

Signed-off-by: Bert Vermeulen <bert@biot.com>
Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Acked-by: John Crispin <john@phrozen.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210122204224.509124-3-bert@biot.com
---
 drivers/irqchip/Makefile          |   1 +-
 drivers/irqchip/irq-realtek-rtl.c | 180 +++++++++++++++++++++++++++++-
 2 files changed, 181 insertions(+)
 create mode 100644 drivers/irqchip/irq-realtek-rtl.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 2a1994d..c59b95a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -112,3 +112,4 @@ obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
 obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
 obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
 obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
+obj-$(CONFIG_MACH_REALTEK_RTL)		+= irq-realtek-rtl.o
diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
new file mode 100644
index 0000000..b57c67d
--- /dev/null
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Birger Koblitz <mail@birger-koblitz.de>
+ * Copyright (C) 2020 Bert Vermeulen <bert@biot.com>
+ * Copyright (C) 2020 John Crispin <john@phrozen.org>
+ */
+
+#include <linux/of_irq.h>
+#include <linux/irqchip.h>
+#include <linux/spinlock.h>
+#include <linux/of_address.h>
+#include <linux/irqchip/chained_irq.h>
+
+/* Global Interrupt Mask Register */
+#define RTL_ICTL_GIMR		0x00
+/* Global Interrupt Status Register */
+#define RTL_ICTL_GISR		0x04
+/* Interrupt Routing Registers */
+#define RTL_ICTL_IRR0		0x08
+#define RTL_ICTL_IRR1		0x0c
+#define RTL_ICTL_IRR2		0x10
+#define RTL_ICTL_IRR3		0x14
+
+#define REG(x)		(realtek_ictl_base + x)
+
+static DEFINE_RAW_SPINLOCK(irq_lock);
+static void __iomem *realtek_ictl_base;
+
+static void realtek_ictl_unmask_irq(struct irq_data *i)
+{
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&irq_lock, flags);
+
+	value = readl(REG(RTL_ICTL_GIMR));
+	value |= BIT(i->hwirq);
+	writel(value, REG(RTL_ICTL_GIMR));
+
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+}
+
+static void realtek_ictl_mask_irq(struct irq_data *i)
+{
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&irq_lock, flags);
+
+	value = readl(REG(RTL_ICTL_GIMR));
+	value &= ~BIT(i->hwirq);
+	writel(value, REG(RTL_ICTL_GIMR));
+
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+}
+
+static struct irq_chip realtek_ictl_irq = {
+	.name = "realtek-rtl-intc",
+	.irq_mask = realtek_ictl_mask_irq,
+	.irq_unmask = realtek_ictl_unmask_irq,
+};
+
+static int intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(hw, &realtek_ictl_irq, handle_level_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops irq_domain_ops = {
+	.map = intc_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static void realtek_irq_dispatch(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_domain *domain;
+	unsigned int pending;
+
+	chained_irq_enter(chip, desc);
+	pending = readl(REG(RTL_ICTL_GIMR)) & readl(REG(RTL_ICTL_GISR));
+	if (unlikely(!pending)) {
+		spurious_interrupt();
+		goto out;
+	}
+	domain = irq_desc_get_handler_data(desc);
+	generic_handle_irq(irq_find_mapping(domain, __ffs(pending)));
+
+out:
+	chained_irq_exit(chip, desc);
+}
+
+/*
+ * SoC interrupts are cascaded to MIPS CPU interrupts according to the
+ * interrupt-map in the device tree. Each SoC interrupt gets 4 bits for
+ * the CPU interrupt in an Interrupt Routing Register. Max 32 SoC interrupts
+ * thus go into 4 IRRs.
+ */
+static int __init map_interrupts(struct device_node *node, struct irq_domain *domain)
+{
+	struct device_node *cpu_ictl;
+	const __be32 *imap;
+	u32 imaplen, soc_int, cpu_int, tmp, regs[4];
+	int ret, i, irr_regs[] = {
+		RTL_ICTL_IRR3,
+		RTL_ICTL_IRR2,
+		RTL_ICTL_IRR1,
+		RTL_ICTL_IRR0,
+	};
+	u8 mips_irqs_set;
+
+	ret = of_property_read_u32(node, "#address-cells", &tmp);
+	if (ret || tmp)
+		return -EINVAL;
+
+	imap = of_get_property(node, "interrupt-map", &imaplen);
+	if (!imap || imaplen % 3)
+		return -EINVAL;
+
+	mips_irqs_set = 0;
+	memset(regs, 0, sizeof(regs));
+	for (i = 0; i < imaplen; i += 3 * sizeof(u32)) {
+		soc_int = be32_to_cpup(imap);
+		if (soc_int > 31)
+			return -EINVAL;
+
+		cpu_ictl = of_find_node_by_phandle(be32_to_cpup(imap + 1));
+		if (!cpu_ictl)
+			return -EINVAL;
+		ret = of_property_read_u32(cpu_ictl, "#interrupt-cells", &tmp);
+		if (ret || tmp != 1)
+			return -EINVAL;
+		of_node_put(cpu_ictl);
+
+		cpu_int = be32_to_cpup(imap + 2);
+		if (cpu_int > 7)
+			return -EINVAL;
+
+		if (!(mips_irqs_set & BIT(cpu_int))) {
+			irq_set_chained_handler_and_data(cpu_int, realtek_irq_dispatch,
+							 domain);
+			mips_irqs_set |= BIT(cpu_int);
+		}
+
+		regs[(soc_int * 4) / 32] |= cpu_int << (soc_int * 4) % 32;
+		imap += 3;
+	}
+
+	for (i = 0; i < 4; i++)
+		writel(regs[i], REG(irr_regs[i]));
+
+	return 0;
+}
+
+static int __init realtek_rtl_of_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *domain;
+	int ret;
+
+	realtek_ictl_base = of_iomap(node, 0);
+	if (!realtek_ictl_base)
+		return -ENXIO;
+
+	/* Disable all cascaded interrupts */
+	writel(0, REG(RTL_ICTL_GIMR));
+
+	domain = irq_domain_add_simple(node, 32, 0,
+				       &irq_domain_ops, NULL);
+
+	ret = map_interrupts(node, domain);
+	if (ret) {
+		pr_err("invalid interrupt map\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(realtek_rtl_intc, "realtek,rtl-intc", realtek_rtl_of_init);

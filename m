Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A330FEBA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBDUpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:45:36 -0500
Received: from marcansoft.com ([212.63.210.85]:33612 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhBDUmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:42:37 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8A1E742862;
        Thu,  4 Feb 2021 20:40:55 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Hector Martin <marcan@marcan.st>, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 15/18] irqchip/apple-aic: Add support for the Apple Interrupt Controller
Date:   Fri,  5 Feb 2021 05:39:48 +0900
Message-Id: <20210204203951.52105-16-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204203951.52105-1-marcan@marcan.st>
References: <20210204203951.52105-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the root interrupt controller used on Apple ARM SoCs such as the
M1. This irqchip driver performs multiple functions:

* Discriminates between IRQs and FIQs

* Drives the AIC peripheral itself (which handles IRQs)

* Dispatches FIQs to downstream hard-wired clients (currently the ARM
  timer).

This patch introduces basic UP irqchip support, without SMP/IPI support.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 MAINTAINERS                     |   1 +
 drivers/irqchip/Kconfig         |  10 +
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-apple-aic.c | 316 ++++++++++++++++++++++++++++++++
 4 files changed, 328 insertions(+)
 create mode 100644 drivers/irqchip/irq-apple-aic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f3d4661731c8..3a54ee5747d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1635,6 +1635,7 @@ C:	irc://chat.freenode.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/AAPL.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml
+F:	drivers/irqchip/irq-apple-aic.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
 
 ARM/ARTPEC MACHINE SUPPORT
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b147f22a78f4..288c01a9abd4 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -590,4 +590,14 @@ config MST_IRQ
 	help
 	  Support MStar Interrupt Controller.
 
+config APPLE_AIC
+	bool "Apple Interrupt Controller (AIC)"
+	depends on ARCH_APPLE || COMPILE_TEST
+	default ARCH_APPLE
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
+	  such as the M1.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 0ac93bfaec61..0e2ba7c2dce7 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -113,3 +113,4 @@ obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
 obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
 obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
 obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
+obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
new file mode 100644
index 000000000000..533e3ce9f432
--- /dev/null
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2021 Hector Martin <marcan@marcan.st>
+ *
+ * Based on irq-lpc32xx:
+ *   Copyright 2015-2016 Vladimir Zapolskiy <vz@mleia.com>
+ * Based on irq-bcm2836:
+ *   Copyright 2015 Broadcom
+ */
+
+/*
+ * AIC is a fairly simple interrupt controller with the following features:
+ *
+ * - 896 level-triggered hardware IRQs
+ *   - Single mask bit per IRQ
+ *   - Per-IRQ affinity setting
+ *   - Automatic masking on event delivery (auto-ack)
+ *   - Software triggering (ORed with hw line)
+ * - 2 per-CPU IPIs (meant as "self" and "other", but they are interchangeable if not symmetric)
+ * - Automatic prioritization (single event/ack register per CPU, lower IRQs = higher priority)
+ * - Automatic masking on ack
+ * - Default "this CPU" register view and explicit per-CPU views
+ *
+ * In addition, this driver also handles FIQs, as these are routed to the same IRQ vector. These
+ * are used for Fast IPIs (TODO) and the ARMv8 timer IRQs.
+ *
+ * Implementation notes:
+ *
+ * - This driver creates one IRQ domain for HW IRQs and the timer FIQs
+ * - FIQ hwirq numbers are assigned after true hwirqs, and are per-cpu
+ * - DT bindings use 3-cell form (like GIC):
+ *   - <0 nr flags> - hwirq #nr
+ *   - <1 nr flags> - FIQ #nr
+ *     - nr=0  physical timer
+ *     - nr=1  virtual timer
+ *   - <2 nr flags> - IPI #nr
+ *     - nr=0  other IPI
+ *     - nr=1  self IPI
+ *
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <asm/exception.h>
+
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+
+#define AIC_INFO		0x0004
+#define AIC_INFO_NR_HW(i)	((i) & 0x0000ffff)
+
+#define AIC_CONFIG		0x0010
+
+#define AIC_WHOAMI		0x2000
+#define AIC_EVENT		0x2004
+
+#define AIC_EVENT_TYPE_HW	1
+#define AIC_EVENT_TYPE_IPI	4
+#define AIC_EVENT_IPI_OTHER	1
+#define AIC_EVENT_IPI_SELF	2
+
+#define AIC_IPI_SEND		0x2008
+#define AIC_IPI_ACK		0x200c
+#define AIC_IPI_MASK_SET	0x2024
+#define AIC_IPI_MASK_CLR	0x2028
+
+#define AIC_IPI_SEND_CPU(cpu)	BIT(cpu)
+
+#define AIC_IPI_OTHER		BIT(0)
+#define AIC_IPI_SELF		BIT(31)
+
+#define AIC_TARGET_CPU		0x3000
+#define AIC_SW_SET		0x4000
+#define AIC_SW_CLR		0x4080
+#define AIC_MASK_SET		0x4100
+#define AIC_MASK_CLR		0x4180
+
+#define AIC_CPU_IPI_SET(cpu)	(0x5008 + (cpu << 7))
+#define AIC_CPU_IPI_CLR(cpu)	(0x500c + (cpu << 7))
+#define AIC_CPU_IPI_MASK_SET(cpu) (0x5024 + (cpu << 7))
+#define AIC_CPU_IPI_MASK_CLR(cpu) (0x5028 + (cpu << 7))
+
+#define MASK_REG(x)		(4 * ((x) >> 5))
+#define MASK_BIT(x)		BIT((x) & 0x1f)
+
+#define AIC_NR_FIQ		2
+#define AIC_NR_IPI		2
+
+/*
+ * Max 31 bits in IPI SEND register (top bit is self).
+ * >=32-core chips will need code changes anyway.
+ */
+#define AIC_MAX_CPUS 31
+
+struct aic_irq_chip {
+	void __iomem *base;
+	struct irq_domain *hw_domain;
+	int nr_hw;
+};
+
+static struct aic_irq_chip *aic_irqc;
+
+static inline u32 aic_ic_read(struct aic_irq_chip *ic, u32 reg)
+{
+	return readl(ic->base + reg);
+}
+
+static inline void aic_ic_write(struct aic_irq_chip *ic, u32 reg, u32 val)
+{
+	writel(val, ic->base + reg);
+}
+
+/* These functions do nothing for FIQs, because they have no masks */
+static void aic_irq_mask(struct irq_data *d)
+{
+	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
+
+	if (d->hwirq < ic->nr_hw)
+		aic_ic_write(ic, AIC_MASK_SET + MASK_REG(d->hwirq),
+			     MASK_BIT(d->hwirq));
+}
+
+static void aic_irq_unmask(struct irq_data *d)
+{
+	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
+
+	if (d->hwirq < ic->nr_hw)
+		aic_ic_write(ic, AIC_MASK_CLR + MASK_REG(d->hwirq),
+			     MASK_BIT(d->hwirq));
+}
+
+static void aic_irq_eoi(struct irq_data *d)
+{
+	/*
+	 * Reading the interrupt reason automatically acknowledges and masks
+	 * the IRQ, so we just unmask it here if needed.
+	 */
+	if (!irqd_irq_disabled(d) && !irqd_irq_masked(d))
+		aic_irq_unmask(d);
+}
+
+static void aic_handle_irq(struct pt_regs *regs)
+{
+	struct aic_irq_chip *ic = aic_irqc;
+	u32 event = aic_ic_read(ic, AIC_EVENT);
+
+	while (event) {
+		u32 type = event >> 16, irq = event & 0xffff;
+
+		/* AIC_EVENT is read-sensitive, ensure it happens before we proceed */
+		isb();
+
+		if (type == AIC_EVENT_TYPE_HW) {
+			handle_domain_irq(aic_irqc->hw_domain, irq, regs);
+		} else if (type == AIC_EVENT_TYPE_IPI) {
+			handle_domain_irq(aic_irqc->hw_domain,
+					  ic->nr_hw + AIC_NR_FIQ + irq - 1, regs);
+		} else {
+			pr_err("spurious IRQ event %d, %d\n", type, irq);
+		}
+
+		event = aic_ic_read(ic, AIC_EVENT);
+	}
+}
+
+#define TIMER_FIRING(x)                                                        \
+	(((x) & (ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_MASK |            \
+		 ARCH_TIMER_CTRL_IT_STAT)) ==                                  \
+	 (ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_STAT))
+
+static void aic_handle_fiq(struct pt_regs *regs)
+{
+	/*
+	 * It would be really nice to find a system register that lets us get the FIQ source
+	 * state without having to peek down into clients...
+	 */
+	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0))) {
+		handle_domain_irq(aic_irqc->hw_domain,
+				  aic_irqc->nr_hw + AIC_TMR_PHYS, regs);
+	}
+
+	if (TIMER_FIRING(read_sysreg(cntv_ctl_el0))) {
+		handle_domain_irq(aic_irqc->hw_domain,
+				  aic_irqc->nr_hw + AIC_TMR_VIRT, regs);
+	}
+}
+
+static void __exception_irq_entry aic_handle_irq_or_fiq(struct pt_regs *regs)
+{
+	u64 isr = read_sysreg(isr_el1);
+
+	if (isr & PSR_F_BIT)
+		aic_handle_fiq(regs);
+
+	if (isr & PSR_I_BIT)
+		aic_handle_irq(regs);
+}
+
+static struct irq_chip aic_chip = {
+	.name = "AIC",
+	.irq_mask = aic_irq_mask,
+	.irq_unmask = aic_irq_unmask,
+	.irq_eoi = aic_irq_eoi,
+};
+
+static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
+			      irq_hw_number_t hw)
+{
+	struct aic_irq_chip *ic = id->host_data;
+
+	irq_set_chip_data(irq, ic);
+	if (hw < ic->nr_hw) {
+		irq_set_chip_and_handler(irq, &aic_chip, handle_fasteoi_irq);
+	} else {
+		irq_set_percpu_devid(irq);
+		irq_set_chip_and_handler(irq, &aic_chip,
+					 handle_percpu_devid_irq);
+	}
+	irq_set_status_flags(irq, IRQ_LEVEL);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static void aic_irq_domain_unmap(struct irq_domain *id, unsigned int irq)
+{
+	irq_set_chip_and_handler(irq, NULL, NULL);
+}
+
+static int aic_irq_domain_xlate(struct irq_domain *id,
+				struct device_node *ctrlr, const u32 *intspec,
+				unsigned int intsize,
+				irq_hw_number_t *out_hwirq,
+				unsigned int *out_type)
+{
+	struct aic_irq_chip *ic = id->host_data;
+
+	if (intsize != 3)
+		return -EINVAL;
+
+	if (intspec[0] == AIC_IRQ && intspec[1] < ic->nr_hw)
+		*out_hwirq = intspec[1];
+	else if (intspec[0] == AIC_FIQ && intspec[1] < AIC_NR_FIQ)
+		*out_hwirq = ic->nr_hw + intspec[1];
+	else if (intspec[0] == AIC_IPI && intspec[1] < AIC_NR_IPI)
+		*out_hwirq = ic->nr_hw + AIC_NR_FIQ + intspec[1];
+	else
+		return -EINVAL;
+
+	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static const struct irq_domain_ops aic_irq_domain_ops = {
+	.map = aic_irq_domain_map,
+	.unmap = aic_irq_domain_unmap,
+	.xlate = aic_irq_domain_xlate,
+};
+
+static int __init aic_of_ic_init(struct device_node *node,
+				 struct device_node *parent)
+{
+	int i;
+	void __iomem *regs;
+	u32 info;
+	struct aic_irq_chip *irqc;
+
+	regs = of_iomap(node, 0);
+	if (WARN_ON(!regs))
+		return -EIO;
+
+	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
+	if (!irqc)
+		return -ENOMEM;
+
+	aic_irqc = irqc;
+	irqc->base = regs;
+
+	info = aic_ic_read(irqc, AIC_INFO);
+	irqc->nr_hw = AIC_INFO_NR_HW(info);
+
+	irqc->hw_domain =
+		irq_domain_add_linear(node,
+				      irqc->nr_hw + AIC_NR_FIQ + AIC_NR_IPI,
+				      &aic_irq_domain_ops, irqc);
+	if (WARN_ON(!irqc->hw_domain)) {
+		iounmap(irqc->base);
+		kfree(irqc);
+		return -ENODEV;
+	}
+
+	irq_domain_update_bus_token(irqc->hw_domain, DOMAIN_BUS_WIRED);
+
+	set_handle_irq(aic_handle_irq_or_fiq);
+
+	for (i = 0; i < BITS_TO_LONGS(irqc->nr_hw); i++)
+		aic_ic_write(irqc, AIC_MASK_SET + i * 4, ~0);
+	for (i = 0; i < BITS_TO_LONGS(irqc->nr_hw); i++)
+		aic_ic_write(irqc, AIC_SW_CLR + i * 4, ~0);
+	for (i = 0; i < irqc->nr_hw; i++)
+		aic_ic_write(irqc, AIC_TARGET_CPU + i * 4, 1);
+
+	pr_info("AIC: initialized with %d IRQs, %d FIQs, %d IPIs\n",
+		irqc->nr_hw, AIC_NR_FIQ, AIC_NR_IPI);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(apple_m1_aic, "AAPL,aic", aic_of_ic_init);
-- 
2.30.0


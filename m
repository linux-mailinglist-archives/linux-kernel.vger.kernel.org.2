Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095DC3BC505
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 05:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhGFDOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 23:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229827AbhGFDOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 23:14:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92BEB6197F;
        Tue,  6 Jul 2021 03:11:38 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 7/9] irqchip: Add LoongArch CPU interrupt controller support
Date:   Tue,  6 Jul 2021 11:09:02 +0800
Message-Id: <20210706030904.1411775-8-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706030904.1411775-1-chenhuacai@loongson.cn>
References: <20210706030904.1411775-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are preparing to add new Loongson (based on LoongArch, not MIPS)
support. This patch add LoongArch CPU interrupt controller support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/Kconfig             | 10 ++++
 drivers/irqchip/Makefile            |  1 +
 drivers/irqchip/irq-loongarch-cpu.c | 87 +++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 084bc4c2eebd..443c3a7a0cc1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -528,6 +528,16 @@ config EXYNOS_IRQ_COMBINER
 	  Say yes here to add support for the IRQ combiner devices embedded
 	  in Samsung Exynos chips.
 
+config IRQ_LOONGARCH_CPU
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	help
+	  Support for the LoongArch CPU Interrupt Controller. For details of
+	  irq chip hierarchy on LoongArch platforms please read the document
+	  Documentation/loongarch/irq-chip-model.rst.
+
 config LOONGSON_LIOINTC
 	bool "Loongson Local I/O Interrupt Controller"
 	depends on MACH_LOONGSON64
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index f88cbf36a9d2..4e34eebe180b 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
+obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
new file mode 100644
index 000000000000..918d61a5a980
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Loongson Technologies, Inc.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+
+#include <asm/setup.h>
+#include <asm/loongarchregs.h>
+
+static struct irq_domain *irq_domain;
+
+static inline void unmask_loongarch_irq(struct irq_data *d)
+{
+	set_csr_ecfg(ECFGF(d->hwirq));
+}
+
+static inline void mask_loongarch_irq(struct irq_data *d)
+{
+	clear_csr_ecfg(ECFGF(d->hwirq));
+}
+
+#define enable_loongarch_irq  unmask_loongarch_irq
+#define disable_loongarch_irq mask_loongarch_irq
+
+static struct irq_chip loongarch_cpu_irq_controller = {
+	.name		= "LoongArch",
+	.irq_ack	= mask_loongarch_irq,
+	.irq_mask	= mask_loongarch_irq,
+	.irq_mask_ack	= mask_loongarch_irq,
+	.irq_unmask	= unmask_loongarch_irq,
+	.irq_eoi	= unmask_loongarch_irq,
+	.irq_enable	= enable_loongarch_irq,
+	.irq_disable	= disable_loongarch_irq,
+};
+
+asmlinkage void __weak plat_irq_dispatch(int irq)
+{
+	do_IRQ(irq_linear_revmap(irq_domain, irq));
+}
+
+static int loongarch_cpu_intc_map(struct irq_domain *d, unsigned int irq,
+			     irq_hw_number_t hwirq)
+{
+	struct irq_chip *chip;
+
+	chip = &loongarch_cpu_irq_controller;
+	set_vi_handler(EXCCODE_INT_START + hwirq, plat_irq_dispatch);
+	irq_set_chip_and_handler(irq, chip, handle_percpu_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
+	.map = loongarch_cpu_intc_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+
+int __init loongarch_cpu_irq_init(struct device_node *of_node, struct device_node *parent)
+{
+	int i;
+
+	/* Mask interrupts. */
+	clear_csr_ecfg(ECFG0_IM);
+	clear_csr_estat(ESTATF_IP);
+
+	irq_alloc_descs(-1, LOONGSON_CPU_IRQ_BASE, EXCCODE_INT_NUM, 0);
+
+	for (i = LOONGSON_CPU_IRQ_BASE; i <= LOONGSON_CPU_LAST_IRQ; i++)
+		irq_set_noprobe(i);
+
+	irq_domain = irq_domain_add_legacy(of_node, EXCCODE_INT_NUM,
+		     LOONGSON_CPU_IRQ_BASE, 0, &loongarch_cpu_intc_irq_domain_ops, NULL);
+
+	if (!irq_domain)
+		panic("Failed to add irqdomain for loongarch CPU");
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(cpu_intc, "loongson,cpu-interrupt-controller", loongarch_cpu_irq_init);
-- 
2.27.0


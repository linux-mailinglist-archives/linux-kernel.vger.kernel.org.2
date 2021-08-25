Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53113F6F40
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbhHYGPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238897AbhHYGPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:15:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AB006138B;
        Wed, 25 Aug 2021 06:14:58 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3 08/10] irqchip: Add LoongArch CPU interrupt controller support
Date:   Wed, 25 Aug 2021 14:11:50 +0800
Message-Id: <20210825061152.3396398-9-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825061152.3396398-1-chenhuacai@loongson.cn>
References: <20210825061152.3396398-1-chenhuacai@loongson.cn>
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
 drivers/irqchip/irq-loongarch-cpu.c | 76 +++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
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
index 000000000000..8e9e8d39cb22
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+
+#include <asm/loongarch.h>
+#include <asm/setup.h>
+
+static struct irq_domain *irq_domain;
+
+static inline void enable_loongarch_irq(struct irq_data *d)
+{
+	set_csr_ecfg(ECFGF(d->hwirq));
+}
+
+#define eoi_loongarch_irq enable_loongarch_irq
+
+static inline void disable_loongarch_irq(struct irq_data *d)
+{
+	clear_csr_ecfg(ECFGF(d->hwirq));
+}
+
+#define ack_loongarch_irq disable_loongarch_irq
+
+static struct irq_chip loongarch_cpu_irq_controller = {
+	.name		= "LoongArch",
+	.irq_ack	= ack_loongarch_irq,
+	.irq_eoi	= eoi_loongarch_irq,
+	.irq_enable	= enable_loongarch_irq,
+	.irq_disable	= disable_loongarch_irq,
+};
+
+asmlinkage void default_handle_irq(int irq)
+{
+	do_IRQ(irq_linear_revmap(irq_domain, irq));
+}
+
+static int loongarch_cpu_intc_map(struct irq_domain *d, unsigned int irq,
+			     irq_hw_number_t hwirq)
+{
+	struct irq_chip *chip;
+
+	irq_set_noprobe(irq);
+	chip = &loongarch_cpu_irq_controller;
+	set_vi_handler(EXCCODE_INT_START + hwirq, default_handle_irq);
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
+int __init loongarch_cpu_irq_init(void)
+{
+	/* Mask interrupts. */
+	clear_csr_ecfg(ECFG0_IM);
+	clear_csr_estat(ESTATF_IP);
+
+	irq_domain = irq_domain_add_simple(NULL, EXCCODE_INT_NUM,
+		     LOONGSON_CPU_IRQ_BASE, &loongarch_cpu_intc_irq_domain_ops, NULL);
+
+	if (!irq_domain)
+		panic("Failed to add irqdomain for LoongArch CPU");
+
+	return 0;
+}
-- 
2.27.0


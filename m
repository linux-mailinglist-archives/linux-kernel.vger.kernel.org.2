Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE72B30FEB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhBDUpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:45:19 -0500
Received: from marcansoft.com ([212.63.210.85]:33356 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhBDUmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:42:09 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3A1C942864;
        Thu,  4 Feb 2021 20:40:59 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Hector Martin <marcan@marcan.st>, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 16/18] irqchip/apple-aic: Add SMP / IPI support
Date:   Fri,  5 Feb 2021 05:39:49 +0900
Message-Id: <20210204203951.52105-17-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204203951.52105-1-marcan@marcan.st>
References: <20210204203951.52105-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the hardware IRQ controller only supports two IPIs per CPU and
Linux needs more, we implement 32 virtual IPIs using software and funnel
them through a single hardware IPI.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/irqchip/irq-apple-aic.c | 195 +++++++++++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 533e3ce9f432..daeffcca67ca 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -26,7 +26,9 @@
  *
  * Implementation notes:
  *
- * - This driver creates one IRQ domain for HW IRQs and the timer FIQs
+ * - This driver creates two IRQ domains, one for HW IRQs and the timer FIQs, and one for IPIs
+ * - Since Linux needs more than 2 IPIs, we implement a software IRQ controller and funnel all IPIs
+ *   into one per-CPU IPI (the second "self" IPI is unused).
  * - FIQ hwirq numbers are assigned after true hwirqs, and are per-cpu
  * - DT bindings use 3-cell form (like GIC):
  *   - <0 nr flags> - hwirq #nr
@@ -34,8 +36,8 @@
  *     - nr=0  physical timer
  *     - nr=1  virtual timer
  *   - <2 nr flags> - IPI #nr
- *     - nr=0  other IPI
- *     - nr=1  self IPI
+ *     - nr=0  other IPI (used internally for the virtual IPIs)
+ *     - nr=1  self IPI (unused)
  *
  */
 
@@ -91,6 +93,7 @@
 
 #define AIC_NR_FIQ		2
 #define AIC_NR_IPI		2
+#define AIC_NR_SWIPI		32
 
 /*
  * Max 31 bits in IPI SEND register (top bit is self).
@@ -101,9 +104,14 @@
 struct aic_irq_chip {
 	void __iomem *base;
 	struct irq_domain *hw_domain;
+	struct irq_domain *ipi_domain;
 	int nr_hw;
+	int ipi_hwirq;
 };
 
+atomic_t aic_vipi_flag[AIC_MAX_CPUS];
+atomic_t aic_vipi_mask[AIC_MAX_CPUS];
+
 static struct aic_irq_chip *aic_irqc;
 
 static inline u32 aic_ic_read(struct aic_irq_chip *ic, u32 reg)
@@ -159,6 +167,11 @@ static void aic_handle_irq(struct pt_regs *regs)
 		if (type == AIC_EVENT_TYPE_HW) {
 			handle_domain_irq(aic_irqc->hw_domain, irq, regs);
 		} else if (type == AIC_EVENT_TYPE_IPI) {
+			/*
+			 * Ensure loads from normal memory are ordered with respect to the wmb()
+			 * in aic_ipi_send_mask().
+			 */
+			rmb();
 			handle_domain_irq(aic_irqc->hw_domain,
 					  ic->nr_hw + AIC_NR_FIQ + irq - 1, regs);
 		} else {
@@ -202,11 +215,33 @@ static void __exception_irq_entry aic_handle_irq_or_fiq(struct pt_regs *regs)
 		aic_handle_irq(regs);
 }
 
+static int aic_irq_set_affinity(struct irq_data *d,
+				const struct cpumask *mask_val, bool force)
+{
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
+	int cpu;
+
+	if (hwirq > ic->nr_hw)
+		return -EINVAL;
+
+	if (force)
+		cpu = cpumask_first(mask_val);
+	else
+		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+
+	aic_ic_write(ic, AIC_TARGET_CPU + hwirq * 4, BIT(cpu));
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK;
+}
+
 static struct irq_chip aic_chip = {
 	.name = "AIC",
 	.irq_mask = aic_irq_mask,
 	.irq_unmask = aic_irq_unmask,
 	.irq_eoi = aic_irq_eoi,
+	.irq_set_affinity = aic_irq_set_affinity,
 };
 
 static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
@@ -264,6 +299,149 @@ static const struct irq_domain_ops aic_irq_domain_ops = {
 	.xlate = aic_irq_domain_xlate,
 };
 
+static void aic_ipi_mask(struct irq_data *d)
+{
+	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
+	u32 irq_bit = BIT(irqd_to_hwirq(d));
+	int this_cpu = smp_processor_id();
+
+	atomic_and(~irq_bit, &aic_vipi_mask[this_cpu]);
+
+	if (!atomic_read(&aic_vipi_mask[this_cpu]))
+		aic_ic_write(ic, AIC_IPI_MASK_SET, AIC_IPI_OTHER);
+}
+
+static void aic_ipi_unmask(struct irq_data *d)
+{
+	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
+	u32 irq_bit = BIT(irqd_to_hwirq(d));
+	int this_cpu = smp_processor_id();
+
+	/* Make sure the kernel's idea of logical CPU order is the same as AIC's */
+	WARN_ON(aic_ic_read(ic, AIC_WHOAMI) != this_cpu);
+
+	atomic_or(irq_bit, &aic_vipi_mask[this_cpu]);
+
+	aic_ic_write(ic, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+}
+
+static void aic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
+{
+	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
+	u32 irq_bit = BIT(irqd_to_hwirq(d));
+	u32 send = 0;
+	int cpu;
+
+	for_each_cpu(cpu, mask) {
+		if (atomic_read(&aic_vipi_mask[cpu]) & irq_bit) {
+			atomic_or(irq_bit, &aic_vipi_flag[cpu]);
+			send |= AIC_IPI_SEND_CPU(cpu);
+		}
+	}
+
+	if (send) {
+		/*
+		 * Ensure that stores to Normal memory are visible to the
+		 * other CPUs before issuing the IPI.
+		 */
+		wmb();
+		aic_ic_write(ic, AIC_IPI_SEND, send);
+	}
+}
+
+static struct irq_chip ipi_chip = {
+	.name = "AIC-IPI",
+	.irq_mask = aic_ipi_mask,
+	.irq_unmask = aic_ipi_unmask,
+	.ipi_send_mask = aic_ipi_send_mask,
+};
+
+static void aic_handle_ipi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int this_cpu = smp_processor_id();
+	int i;
+	unsigned long firing;
+
+	chained_irq_enter(chip, desc);
+	aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
+
+	firing = atomic_xchg(&aic_vipi_flag[this_cpu], 0);
+
+	for_each_set_bit(i, &firing, AIC_NR_SWIPI) {
+		generic_handle_irq(irq_find_mapping(aic_irqc->ipi_domain, i));
+	}
+
+	aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+	chained_irq_exit(chip, desc);
+}
+
+static int aic_ipi_alloc(struct irq_domain *d, unsigned int virq,
+			 unsigned int nr_irqs, void *args)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_set_percpu_devid(virq + i);
+		irq_domain_set_info(d, virq + i, i, &ipi_chip, d->host_data,
+				    handle_percpu_devid_irq, NULL, NULL);
+	}
+
+	return 0;
+}
+
+static void aic_ipi_free(struct irq_domain *d, unsigned int virq,
+			 unsigned int nr_irqs)
+{
+	/* Not freeing IPIs */
+}
+
+static const struct irq_domain_ops aic_ipi_domain_ops = {
+	.alloc = aic_ipi_alloc,
+	.free = aic_ipi_free,
+};
+
+static int aic_init_smp(struct aic_irq_chip *irqc, struct device_node *node)
+{
+	struct irq_fwspec ipi_fwspec = {
+		.fwnode         = irqc->hw_domain->fwnode,
+		.param_count    = 3,
+		.param          = {
+			[0]     = AIC_IPI,
+			[1]     = 0,
+			[2]     = 0,
+		},
+	};
+	int base_ipi, mux_irq;
+
+	mux_irq = irq_create_fwspec_mapping(&ipi_fwspec);
+	if (WARN_ON(mux_irq <= 0))
+		return -ENODEV;
+
+	irqc->ipi_domain =
+		irq_domain_create_linear(irqc->hw_domain->fwnode, AIC_NR_SWIPI,
+					 &aic_ipi_domain_ops, irqc);
+	if (WARN_ON(!irqc->ipi_domain))
+		return -ENODEV;
+
+	irqc->ipi_domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
+	irq_domain_update_bus_token(irqc->ipi_domain, DOMAIN_BUS_IPI);
+
+	base_ipi = __irq_domain_alloc_irqs(irqc->ipi_domain, -1, AIC_NR_SWIPI,
+					   NUMA_NO_NODE, NULL, false, NULL);
+
+	if (WARN_ON(!base_ipi)) {
+		irq_domain_remove(irqc->ipi_domain);
+		return -ENODEV;
+	}
+
+	set_smp_ipi_range(base_ipi, AIC_NR_SWIPI);
+
+	irq_set_chained_handler_and_data(mux_irq, aic_handle_ipi, NULL);
+
+	return 0;
+}
+
 static int __init aic_of_ic_init(struct device_node *node,
 				 struct device_node *parent)
 {
@@ -298,6 +476,13 @@ static int __init aic_of_ic_init(struct device_node *node,
 
 	irq_domain_update_bus_token(irqc->hw_domain, DOMAIN_BUS_WIRED);
 
+	if (aic_init_smp(irqc, node)) {
+		irq_domain_remove(irqc->hw_domain);
+		iounmap(irqc->base);
+		kfree(irqc);
+		return -ENODEV;
+	}
+
 	set_handle_irq(aic_handle_irq_or_fiq);
 
 	for (i = 0; i < BITS_TO_LONGS(irqc->nr_hw); i++)
@@ -307,8 +492,8 @@ static int __init aic_of_ic_init(struct device_node *node,
 	for (i = 0; i < irqc->nr_hw; i++)
 		aic_ic_write(irqc, AIC_TARGET_CPU + i * 4, 1);
 
-	pr_info("AIC: initialized with %d IRQs, %d FIQs, %d IPIs\n",
-		irqc->nr_hw, AIC_NR_FIQ, AIC_NR_IPI);
+	pr_info("AIC: initialized with %d IRQs, %d FIQs, %d IPIs, %d vIPIs\n",
+		irqc->nr_hw, AIC_NR_FIQ, AIC_NR_IPI, AIC_NR_SWIPI);
 
 	return 0;
 }
-- 
2.30.0


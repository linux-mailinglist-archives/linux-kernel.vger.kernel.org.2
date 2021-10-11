Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46459428DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbhJKN0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236854AbhJKN0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:26:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9184360F4B;
        Mon, 11 Oct 2021 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633958693;
        bh=9m+DpA2gtePLN7XyZpxzMA7snyaATDs0wGR8pRq60OM=;
        h=From:To:Cc:Subject:Date:From;
        b=OknVS/UUtvpIldUY9L+Z5/8DtV814XWzm+/jNAeRChjsxzyMUQ0RYU60pVl4RwFx/
         eBe1v/X5SNCXq7gTbsewcqr5rmZw+8E9C/ssUtkl7X4UN6Jqrlvy8tsgJaNDqnbyqu
         ovpckISFNQ9lAKSg0UZDCuxDcmCWkVY615NTXVDdg0wFN4QWr5wPpu62fEJMesu9T2
         k6RuyB3LVKcmGfR60gbAZkemvQVGs59TkLCCrIKbgmNAvW3ajWqdxPcw4TyhHe4nVb
         0el3/hwHYEV6ZH06dmcUFGp9GnkgjlPvXBs7MpvaiWFfHv3Z8ezaZA93i+vUEkD5nK
         AoiLvYQRROjcA==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 1/2] irqchip/sifive-plic: Fix duplicate mask/unmask for claim/complete
Date:   Mon, 11 Oct 2021 21:24:30 +0800
Message-Id: <20211011132431.2792797-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

PLIC only has enable-registers not mask/unmask registers. Mixing
mask/unmask with irq_eoi is wrong, because readl(claim) could mask
irq by hardware. We only need mask/unmask to fixup the hardware
which couldn't claim + mask correctly.

If hardware supports claim + mask, it would cause unnecessary
mask/umak operations.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@wdc.com>
---
 drivers/irqchip/irq-sifive-plic.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index cf74cfa82045..0fa46912f452 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -64,6 +64,7 @@ struct plic_priv {
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
+	bool claim_mask_support;
 };
 
 struct plic_handler {
@@ -111,7 +112,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 	}
 }
 
-static void plic_irq_unmask(struct irq_data *d)
+static void plic_irq_enable(struct irq_data *d)
 {
 	struct cpumask amask;
 	unsigned int cpu;
@@ -125,7 +126,7 @@ static void plic_irq_unmask(struct irq_data *d)
 	plic_irq_toggle(cpumask_of(cpu), d, 1);
 }
 
-static void plic_irq_mask(struct irq_data *d)
+static void plic_irq_disable(struct irq_data *d)
 {
 	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
@@ -168,8 +169,8 @@ static void plic_irq_eoi(struct irq_data *d)
 
 static struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
-	.irq_mask	= plic_irq_mask,
-	.irq_unmask	= plic_irq_unmask,
+	.irq_enable	= plic_irq_enable,
+	.irq_disable	= plic_irq_disable,
 	.irq_eoi	= plic_irq_eoi,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = plic_set_affinity,
@@ -181,6 +182,11 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 {
 	struct plic_priv *priv = d->host_data;
 
+	if (!priv->claim_mask_support) {
+		plic_chip.irq_mask	= plic_irq_disable;
+		plic_chip.irq_unmask	= plic_irq_enable;
+	}
+
 	irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
 			    handle_fasteoi_irq, NULL, NULL);
 	irq_set_noprobe(irq);
@@ -298,6 +304,8 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!nr_contexts))
 		goto out_iounmap;
 
+	priv->claim_mask_support = of_property_read_bool(node, "claim-mask-support");
+
 	error = -ENOMEM;
 	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
 			&plic_irqdomain_ops, priv);
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC1A42FFE0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 05:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243546AbhJPDYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 23:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239723AbhJPDYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 23:24:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30EAF61152;
        Sat, 16 Oct 2021 03:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634354537;
        bh=g0Z1DAJuKWrr2LBtNixnHCE9ToQiLilpVHL/S0gpHRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fspSGS1ju4paK8moQbmaH0af8r4KkMbt9VV4NtouyY4R/K7FxhafIar3DpUS0fiHo
         O5nfhfVKTVEx07achdRqGPBXtP+mK3FFH4KLYhtTv5R3ltZYB/q1rXZMr8EvqJbY7B
         dxTDb1euG1kYyd7Uv8MGBORVc6UAotlcs06WdRa1OfsatyyPfsuCDVd6WiCkigJCsL
         SrCAKGY5krnZM+vTiIjiaN1bIdPVWDhRVJqrR6MrrQUsqiOgaB5i/dIZ7vmNeePFJg
         7AI+lymXtfbrSyItc2dT9ykzk0RKoNhWrFW+Apdj7rpHLvMZHaEqbTrMqR2ZQ4UZIq
         /fkv2UId4FqLQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com,
        heiko@sntech.de, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 1/3] irqchip/sifive-plic: Add thead,c900-plic support
Date:   Sat, 16 Oct 2021 11:21:58 +0800
Message-Id: <20211016032200.2869998-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211016032200.2869998-1-guoren@kernel.org>
References: <20211016032200.2869998-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

1) The irq_mask/unmask() is used by handle_fasteoi_irq() is mostly
for ONESHOT irqs and there is no limitation in the RISC-V PLIC driver
due to use of irq_mask/unmask() callbacks. In fact, a lot of irqchip
drivers using handle_fasteoi_irq() also implement irq_mask/unmask().

2) The C9xx PLIC does not comply with the interrupt claim/completion
process defined by the RISC-V PLIC specification because C9xx PLIC
will mask an IRQ when it is claimed by PLIC driver (i.e. readl(claim)
and the IRQ will be unmasked upon completion by PLIC driver (i.e.
writel(claim). This behaviour breaks the handling of IRQS_ONESHOT by
the generic handle_fasteoi_irq() used in the PLIC driver.

3) This patch adds an errata fix for IRQS_ONESHOT handling on
C9xx PLIC by using irq_enable/disable() callbacks instead of
irq_mask/unmask().

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Atish Patra <atish.patra@wdc.com>

---

Changes since V4:
 - Update comment by Anup

Changes since V3:
 - Rename "c9xx" to "c900"
 - Add sifive_plic_chip and thead_plic_chip for difference

Changes since V2:
 - Add a separate compatible string "thead,c9xx-plic"
 - set irq_mask/unmask of "plic_chip" to NULL and point
   irq_enable/disable of "plic_chip" to plic_irq_mask/unmask
 - Add a detailed comment block in plic_init() about the
   differences in Claim/Completion process of RISC-V PLIC and C9xx
   PLIC.
---
 drivers/irqchip/irq-sifive-plic.c | 34 +++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index cf74cfa82045..960b29d02070 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -166,7 +166,7 @@ static void plic_irq_eoi(struct irq_data *d)
 	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
 }
 
-static struct irq_chip plic_chip = {
+static struct irq_chip sifive_plic_chip = {
 	.name		= "SiFive PLIC",
 	.irq_mask	= plic_irq_mask,
 	.irq_unmask	= plic_irq_unmask,
@@ -176,12 +176,32 @@ static struct irq_chip plic_chip = {
 #endif
 };
 
+/*
+ * The C9xx PLIC does not comply with the interrupt claim/completion
+ * process defined by the RISC-V PLIC specification because C9xx PLIC
+ * will mask an IRQ when it is claimed by PLIC driver (i.e. readl(claim)
+ * and the IRQ will be unmasked upon completion by PLIC driver (i.e.
+ * writel(claim). This behaviour breaks the handling of IRQS_ONESHOT by
+ * the generic handle_fasteoi_irq() used in the PLIC driver.
+ */
+static struct irq_chip thead_plic_chip = {
+	.name		= "T-Head PLIC",
+	.irq_disable	= plic_irq_mask,
+	.irq_enable	= plic_irq_unmask,
+	.irq_eoi	= plic_irq_eoi,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = plic_set_affinity,
+#endif
+};
+
+static struct irq_chip *def_plic_chip = &sifive_plic_chip;
+
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
 	struct plic_priv *priv = d->host_data;
 
-	irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
+	irq_domain_set_info(d, irq, hwirq, def_plic_chip, d->host_data,
 			    handle_fasteoi_irq, NULL, NULL);
 	irq_set_noprobe(irq);
 	irq_set_affinity(irq, &priv->lmask);
@@ -390,5 +410,15 @@ static int __init plic_init(struct device_node *node,
 	return error;
 }
 
+static int __init thead_c900_plic_init(struct device_node *node,
+		struct device_node *parent)
+{
+	def_plic_chip = &thead_plic_chip;
+
+	return plic_init(node, parent);
+}
+
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
+IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", thead_c900_plic_init);
+IRQCHIP_DECLARE(allwinner_sun20i_d1_plic, "allwinner,sun20i-d1-plic", thead_c900_plic_init);
-- 
2.25.1


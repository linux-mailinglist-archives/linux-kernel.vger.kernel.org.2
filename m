Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F23F42A856
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 17:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbhJLPgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 11:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237449AbhJLPgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:36:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D98EE61074;
        Tue, 12 Oct 2021 15:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634052887;
        bh=6W6iHtb0gBp1lkXoNCKov43WbKN2Zd1lRk8xkWaz6QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eWlwJ56npUHtTb2/do9cb/DEEJmL/Yx7tRUMtFBhd+kqagYFHTNqxKyLecJ3laX2r
         VoJB2UH2obniDyu5aNU3o0g8SU6zjrhS0UCUDgXrj5D6rnfYJFN41VWbhnyYCNWzN8
         75odFUkGJaQVjKrKqM/rHMPQIJSlsKjTbRQYaVLvlkx9IYWOlwn1y5e+ayZ7oHuvB3
         pJo9nRcOqXgy97bH9ay28nYMQS1DOFghl+Y3lEuhOPhLWxmQ4NPaFCH9teMGEZZH2g
         2U3HNw9sTCkMk3ExXpKqhzSuKH30oXP1loZaF0QQp3w08FlRhZj5tSvhivFBHZv79W
         K1bvAQT3y9EZg==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 2/2] irqchip/sifive-plic: Add thead,c9xx-plic support
Date:   Tue, 12 Oct 2021 23:34:32 +0800
Message-Id: <20211012153432.2817285-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012153432.2817285-1-guoren@kernel.org>
References: <20211012153432.2817285-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

thead,c9xx-plic would mask IRQ with readl(claim), so it needn't
mask/unmask which needed in RISC-V PLIC.

When in IRQS_ONESHOT & IRQCHIP_EOI_THREADED path, unnecessary mask
operation would cause a blocking irq bug in thead,c9xx-plic. Because
when IRQ is disabled in c9xx, writel(hwirq, claim) would be invalid.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Atish Patra <atish.patra@wdc.com>

---

Changes since V2:
 - Add a separate compatible string "thead,c9xx-plic"
 - set irq_mask/unmask of "plic_chip" to NULL and point
   irq_enable/disable of "plic_chip" to plic_irq_mask/unmask
 - Add a detailed comment block in plic_init() about the
   differences in Claim/Completion process of RISC-V PLIC and C9xx
   PLIC.
---
 drivers/irqchip/irq-sifive-plic.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index cf74cfa82045..3756b1c147c3 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -79,6 +79,7 @@ struct plic_handler {
 };
 static int plic_parent_irq __ro_after_init;
 static bool plic_cpuhp_setup_done __ro_after_init;
+static bool disable_mask_unmask __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
 static inline void plic_toggle(struct plic_handler *handler,
@@ -181,6 +182,13 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 {
 	struct plic_priv *priv = d->host_data;
 
+	if (disable_mask_unmask) {
+		plic_chip.irq_mask	= NULL;
+		plic_chip.irq_unmask	= NULL;
+		plic_chip.irq_enable	= plic_irq_unmask;
+		plic_chip.irq_disable	= plic_irq_mask;
+	}
+
 	irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
 			    handle_fasteoi_irq, NULL, NULL);
 	irq_set_noprobe(irq);
@@ -390,5 +398,14 @@ static int __init plic_init(struct device_node *node,
 	return error;
 }
 
+static int __init thead_c9xx_plic_init(struct device_node *node,
+		struct device_node *parent)
+{
+	disable_mask_unmask = true;
+
+	return plic_init(node, parent);
+}
+
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
+IRQCHIP_DECLARE(thead_c9xx_plic, "thead,c9xx-plic", thead_c9xx_plic_init);
-- 
2.25.1


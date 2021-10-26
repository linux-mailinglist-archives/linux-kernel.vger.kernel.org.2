Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA44A43AEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhJZJ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:27:50 -0400
Received: from foss.arm.com ([217.140.110.172]:55346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234769AbhJZJ1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:27:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C9B01063;
        Tue, 26 Oct 2021 02:25:21 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 84FFE3F70D;
        Tue, 26 Oct 2021 02:25:18 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, maz@kernel.org, nickhu@andestech.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vgupta@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org
Subject: [PATCH v2 02/17] irq: mips: simplify bcm6345_l1_irq_handle()
Date:   Tue, 26 Oct 2021 10:24:49 +0100
Message-Id: <20211026092504.27071-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211026092504.27071-1-mark.rutland@arm.com>
References: <20211026092504.27071-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As bcm6345_l1_irq_handle() only needs to know /whether/ an IRQ was
resolved, and doesn't need to know the specific IRQ, it's simpler for it
to call generic_handle_domain_irq() directly and check the return code,
so let's do that.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-bcm6345-l1.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index 1bd0621c4ce2..fd079215c17f 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -132,16 +132,12 @@ static void bcm6345_l1_irq_handle(struct irq_desc *desc)
 		int base = idx * IRQS_PER_WORD;
 		unsigned long pending;
 		irq_hw_number_t hwirq;
-		unsigned int irq;
 
 		pending = __raw_readl(cpu->map_base + reg_status(intc, idx));
 		pending &= __raw_readl(cpu->map_base + reg_enable(intc, idx));
 
 		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
-			irq = irq_linear_revmap(intc->domain, base + hwirq);
-			if (irq)
-				generic_handle_irq(irq);
-			else
+			if (generic_handle_domain_irq(intc->domain, base + hwirq))
 				spurious_interrupt();
 		}
 	}
-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E52943AEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhJZJ1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:27:48 -0400
Received: from foss.arm.com ([217.140.110.172]:55316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234758AbhJZJ1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:27:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DDC1101E;
        Tue, 26 Oct 2021 02:25:17 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2A393F70D;
        Tue, 26 Oct 2021 02:25:14 -0700 (PDT)
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
Subject: [PATCH v2 01/17] irq: mips: avoid nested irq_enter()
Date:   Tue, 26 Oct 2021 10:24:48 +0100
Message-Id: <20211026092504.27071-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211026092504.27071-1-mark.rutland@arm.com>
References: <20211026092504.27071-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As bcm6345_l1_irq_handle() is a chained irqchip handler, it will be
invoked within the context of the root irqchip handler, which must have
entered IRQ context already.

When bcm6345_l1_irq_handle() calls arch/mips's do_IRQ() , this will nest
another call to irq_enter(), and the resulting nested increment to
`rcu_data.dynticks_nmi_nesting` will cause rcu_is_cpu_rrupt_from_idle()
to fail to identify wakeups from idle, resulting in failure to preempt,
and RCU stalls.

Chained irqchip handlers must invoke IRQ handlers by way of thee core
irqchip code, i.e. generic_handle_irq() or generic_handle_domain_irq()
and should not call do_IRQ(), which is intended only for root irqchip
handlers.

Fix bcm6345_l1_irq_handle() by calling generic_handle_irq() directly.

Fixes: c7c42ec2baa1de7a ("irqchips/bmips: Add bcm6345-l1 interrupt controller")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-bcm6345-l1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index e3483789f4df..1bd0621c4ce2 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -140,7 +140,7 @@ static void bcm6345_l1_irq_handle(struct irq_desc *desc)
 		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
 			irq = irq_linear_revmap(intc->domain, base + hwirq);
 			if (irq)
-				do_IRQ(irq);
+				generic_handle_irq(irq);
 			else
 				spurious_interrupt();
 		}
-- 
2.11.0


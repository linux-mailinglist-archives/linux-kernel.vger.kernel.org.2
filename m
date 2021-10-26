Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7598543AFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbhJZKTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbhJZKSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC3AC061243
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:16:12 -0700 (PDT)
Date:   Tue, 26 Oct 2021 10:16:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4OOCVjKHu3W3KUF8PnMtt0sRUDhN2PjZZqJztkhBiBk=;
        b=jL3UrlG0llKCBUqoxaNtRWe5/rlRYZeZsByWwMjpNDoTgmQM3qWY8JyKgFomKKoenUT0dB
        mJx7IKknoStj+bAWfOAuipwbv4nme03DNFp6u0d+9OH6jgkZlY05CCA60K1bDMM705ddM/
        lJIMUdT2BwLYNfS3qWKUr1V9bgtJ5p2VuJDOt5upcQzuwXNHWaU7ObinTIff5gf8Kle7Y6
        aLlK25PK+5dI9K43+QfRMNTbJGR3xN6vqpsRNMHMPS2uQBamU4932DwznbjA0IHyJwgdd9
        kNq2v5D2PQw4EjHiBJ1usH9b/f/N5fBO3sfNMDzSrXl8+gae0ko6iaL/yowOWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4OOCVjKHu3W3KUF8PnMtt0sRUDhN2PjZZqJztkhBiBk=;
        b=wY3DklEIQGBYB+wY5FqiZTY5RcbpMCns9XjWYewzqD8T1Orz7zojetqCzAJQ+42ivzVm5N
        l98lR77u/xhR7kCQ==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: mips: avoid nested irq_enter()
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524337054.626.7489285313123192852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     c65b52d02f6c1a06ddb20cba175ad49eccd6410d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c65b52d02f6c1a06ddb20cba175ad49eccd6410d
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 20 Oct 2021 17:25:22 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Mon, 25 Oct 2021 10:01:39 +01:00

irq: mips: avoid nested irq_enter()

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
index e348378..1bd0621 100644
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

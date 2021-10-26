Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9B443AFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhJZKTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:19:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60750 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbhJZKSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:35 -0400
Date:   Tue, 26 Oct 2021 10:16:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8m+cEkzF/MpumfBWGY9RLLHXFnAcCQ80P1SgSid+F3w=;
        b=WcOFxSj4U74RuKyurfBu1ADIAYse8ib3waTVXDPMR1/M2ul2ui32gTyFotAUNcWrKxlMc4
        tu3IJo3pccng2ICE1y346eNxP2UEBwOMZRZpQCyPEN6qdhtxbVYtCE2v0QBDNRJmE34mwx
        XEsDDsYlAvpp0WLlWBP0UHMC8RxmD03oayn4FFN7v1/y0+K4Rz1f1NsPP/qzBVj/mBoevx
        9DGzexbu87ufbQ3VHrAJw/XJ2zwSslIiijDKsdXIwtSt72IUYuOmlX7eZ2TeDi9j5BvAwS
        LFl4+d2tSZJ6SRtsT609l3SFZUsjs1SHYf8G/nU/fu0Aw3mzGYM0i/Gr4ei7CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8m+cEkzF/MpumfBWGY9RLLHXFnAcCQ80P1SgSid+F3w=;
        b=PRID5HTlvZDR6GLQHKdVlbpe1i8EurZb5gQ8m4YBY56OvXLDTViBGq42Z/C/YDat/+9NuT
        R/RRlXM4zpcqhMCQ==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: mips: simplify bcm6345_l1_irq_handle()
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524336977.626.1760359199273294703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     46b61c88e1075829103874c95f13160e3b9e1618
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/46b61c88e1075829103874c95f13160e3b9e1618
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Fri, 22 Oct 2021 15:27:06 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Mon, 25 Oct 2021 10:04:53 +01:00

irq: mips: simplify bcm6345_l1_irq_handle()

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
index 1bd0621..fd07921 100644
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

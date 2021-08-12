Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EE63EA74A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbhHLPOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbhHLPNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:13:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEC0C0617A8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:13:05 -0700 (PDT)
Date:   Thu, 12 Aug 2021 15:13:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zBJh4t1pgOWe+Kxmpd0RGuQYT84bkxt9U30t4s1aI3I=;
        b=3V5Mdk+/Z+hG3d6g4/mpPsi03ttYNUYbiqRJn9ZaJNFQAibGe6O/yiOSMbmIa43lztaS+M
        1+QM5eI+mEV/bbT5BbXWxyLHFUyX9OHKpKIJdynvemsKt5hLcjhmS4Bqy/5aOPQz5czsZ3
        MyEchtKOu9W4tKSPuyZ64BMGmAIDelrJ7QtFzGW6ZHNBeg/lPavUE2HufF4iLaOc+nuHiT
        XYXBkgvrwDexHZW22DKt84l3lpsLvQoaeZ26Tppt8ag8uU2ZAEIVKk7tNEP6BbdOugXvPt
        9CCtTsndVEoWDPgsuVU9oAklnHkkPnWu1wxvauV14PEzKazqdIkILgLXG2hh7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zBJh4t1pgOWe+Kxmpd0RGuQYT84bkxt9U30t4s1aI3I=;
        b=APpVZgJN/5Dd4d0KzoUwsQ0IHaicsTz4+TzTp5jn4Notk8BIfUKbjeVGW9Yo69EvJwFE00
        SPVkYuocl1ze0wCA==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Employ ack_irq() and eoi_irq()
 where relevant
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210629125010.458872-4-valentin.schneider@arm.com>
References: <20210629125010.458872-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162878118334.395.13782445093876679056.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     1b7a900c4da182de2022bee7cbf347d84291dda3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1b7a900c4da182de2022bee7cbf347d84291dda3
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 29 Jun 2021 13:50:00 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 15:48:20 +01:00

genirq: Employ ack_irq() and eoi_irq() where relevant

This can easily be coccinelle'd to replace all existing chip->irq_{ack,
eoi} callsites, however not all callsites benefit from this
replacement: fasteoi flow handlers for instance only deal with an
->irq_eoi() callback. Instead, only patch callsites that can benefit from
the added functionality.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210629125010.458872-4-valentin.schneider@arm.com
---
 kernel/irq/chip.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 793dbd8..4d3bde5 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -429,10 +429,12 @@ static inline void mask_ack_irq(struct irq_desc *desc)
 	if (desc->irq_data.chip->irq_mask_ack) {
 		desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
 		irq_state_set_masked(desc);
+		if (desc->irq_data.chip->flags & IRQCHIP_AUTOMASKS_FLOW)
+			irq_state_set_flow_masked(desc);
 	} else {
 		mask_irq(desc);
 		if (desc->irq_data.chip->irq_ack)
-			desc->irq_data.chip->irq_ack(&desc->irq_data);
+			ack_irq(desc);
 	}
 }
 
@@ -463,7 +465,7 @@ void unmask_threaded_irq(struct irq_desc *desc)
 	struct irq_chip *chip = desc->irq_data.chip;
 
 	if (chip->flags & IRQCHIP_EOI_THREADED)
-		chip->irq_eoi(&desc->irq_data);
+		eoi_irq(desc);
 
 	unmask_irq(desc);
 }
@@ -680,7 +682,7 @@ EXPORT_SYMBOL_GPL(handle_level_irq);
 static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 {
 	if (!(desc->istate & IRQS_ONESHOT)) {
-		chip->irq_eoi(&desc->irq_data);
+		eoi_irq(desc);
 		return;
 	}
 	/*
@@ -691,10 +693,10 @@ static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 	 */
 	if (!irqd_irq_disabled(&desc->irq_data) &&
 	    irqd_irq_masked(&desc->irq_data) && !desc->threads_oneshot) {
-		chip->irq_eoi(&desc->irq_data);
+		eoi_irq(desc);
 		unmask_irq(desc);
 	} else if (!(chip->flags & IRQCHIP_EOI_THREADED)) {
-		chip->irq_eoi(&desc->irq_data);
+		eoi_irq(desc);
 	}
 }
 

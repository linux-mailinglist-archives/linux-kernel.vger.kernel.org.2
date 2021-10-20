Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36C5435509
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhJTVOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:14:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55522 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJTVO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:29 -0400
Date:   Wed, 20 Oct 2021 21:12:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9dtOweAVfwFTJ6u7F9lsZCuI/nhtUDHnFCAm9dxzGTg=;
        b=M8eQUYZc4VNnz9kuo6L7P2e42Jg5BkHzO9V9txAy6qCvLTDqbEoOTCNz3QH43Cqa0TkuOG
        sxedoLTwghDCH5cWmuuM3ZqPALw+n349GkFYs9aE81PDmTz6NoV+VkrBWOwkpV8yWzibR0
        Do3XB6WHWW/ttLccrNNeJWfssMJIaErZq/d1vFfJzKm1ZlKXtSBBzZHGDJXuAfI5AKqiCH
        dH7tyyzmpTnKMAoW9Mh2ZkblsOrRVSg1Wm/SraIC1bnfr6lHRC/9HOBo283NSc//QAm8Yi
        WTRaoon+nUccTedGTtT3Arsa4KAtj8+DHoaJ0YEVoOSt5RPXCQcGar2r7qfNXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9dtOweAVfwFTJ6u7F9lsZCuI/nhtUDHnFCAm9dxzGTg=;
        b=RpMQwzLhhxJh5Ddk6blEi1EcyKH9Qx1lfSxvbcVFhPXRMSZjGQSk2mx45Y8o5W5tNF17KR
        q52tIfi39T0IvsCw==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Export
 irq_gc_{unmask_enable,mask_disable}_reg
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211020184859.2705451-8-f.fainelli@gmail.com>
References: <20211020184859.2705451-8-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <163476433323.25758.7243978134973371508.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     fcd0f63dec4abc281988ac08b83ca3ae6946c13b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/fcd0f63dec4abc281988ac08b83ca3ae6946c13b
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Wed, 20 Oct 2021 11:48:53 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 20:06:33 +01:00

genirq: Export irq_gc_{unmask_enable,mask_disable}_reg

In order to allow drivers/irqchip/irq-brcmstb-l2.c to be built as a
module we need to export: irq_gc_unmask_enable_reg() and
irq_gc_mask_disable_reg().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020184859.2705451-8-f.fainelli@gmail.com
---
 kernel/irq/generic-chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index cc7cdd2..4c011c2 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -44,6 +44,7 @@ void irq_gc_mask_disable_reg(struct irq_data *d)
 	*ct->mask_cache &= ~mask;
 	irq_gc_unlock(gc);
 }
+EXPORT_SYMBOL_GPL(irq_gc_mask_disable_reg);
 
 /**
  * irq_gc_mask_set_bit - Mask chip via setting bit in mask register
@@ -103,6 +104,7 @@ void irq_gc_unmask_enable_reg(struct irq_data *d)
 	*ct->mask_cache |= mask;
 	irq_gc_unlock(gc);
 }
+EXPORT_SYMBOL_GPL(irq_gc_unmask_enable_reg);
 
 /**
  * irq_gc_ack_set_bit - Ack pending interrupt via setting bit

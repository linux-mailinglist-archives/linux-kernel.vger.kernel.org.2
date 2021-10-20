Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A7143550C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhJTVOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhJTVOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB202C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:12:16 -0700 (PDT)
Date:   Wed, 20 Oct 2021 21:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ofwk+6+dBq2n+F/yX/OrpS/UbHf5zguGNV9hj/iyNho=;
        b=BpkAJ2D4knQdso7s5PcjWliVmoAJ/R0sJbHBHWh36onUTYwxRJQ4PgexE2PJTrdDEkkPdX
        VGQfRpNQt9VlkcGRekDOsA31pmHy/qSwEzv45gANqI977BRIGpLpO+W1arrqTjwtFuukM9
        t7JG7wufA+ZinXr8pOLhpvm4WUBGumowLaDhmrBSzR/AlOnMoKXRW9zF4fHzRwVOI6SWNp
        g6Fu39aK5y3atez1y+XXrdRe37WjxHkRtGWXi0YlVbACkx1kPnU8+g4dQ3pblvAghiXgpx
        NveVypJlwrl6USJOb4zXIZjtrWOhwYKDzKBnIYOYEQmH0l1KlYkglVSF//DH8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ofwk+6+dBq2n+F/yX/OrpS/UbHf5zguGNV9hj/iyNho=;
        b=mDNDBdWWfAwf/2+hlaVh4GX5he2boY1uvO1qvLU2vyZ779lQf3I7trkILornEN9WXaLOb2
        q0P3/sOqHGJE7oCQ==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-bcm7038-l1: Restrict affinity
 setting to MIPS
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211020184859.2705451-6-f.fainelli@gmail.com>
References: <20211020184859.2705451-6-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <163476433456.25758.298027771225902304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     3578fd47137c405b6fb9f90e2e6d1654c71f5e1e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3578fd47137c405b6fb9f90e2e6d1654c71f5e1e
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Wed, 20 Oct 2021 11:48:51 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 20:06:33 +01:00

irqchip/irq-bcm7038-l1: Restrict affinity setting to MIPS

Only MIPS based platforms using this interrupt controller as first level
interrupt controller can actually change the affinity of interrupts by
re-programming the affinity mask of the interrupt controller and use
another word group to have another CPU process the interrupt.

When this interrupt is used as a second level interrupt controller on
ARM/ARM64 there is no way to change the interrupt affinity. This fixes a
NULL pointer de-reference while trying to change the affinity since
there is only a single word group in that case, and we would have been
overruning the intc->cpus[] array.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020184859.2705451-6-f.fainelli@gmail.com
---
 drivers/irqchip/irq-bcm7038-l1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 3c4e348..357570d 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -191,6 +191,7 @@ static void bcm7038_l1_mask(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&intc->lock, flags);
 }
 
+#if defined(CONFIG_MIPS) && defined(CONFIG_SMP)
 static int bcm7038_l1_set_affinity(struct irq_data *d,
 				   const struct cpumask *dest,
 				   bool force)
@@ -217,6 +218,7 @@ static int bcm7038_l1_set_affinity(struct irq_data *d,
 
 	return 0;
 }
+#endif
 
 static int __init bcm7038_l1_init_one(struct device_node *dn,
 				      unsigned int idx,
@@ -365,7 +367,9 @@ static struct irq_chip bcm7038_l1_irq_chip = {
 	.name			= "bcm7038-l1",
 	.irq_mask		= bcm7038_l1_mask,
 	.irq_unmask		= bcm7038_l1_unmask,
+#if defined(CONFIG_SMP) && defined(CONFIG_MIPS)
 	.irq_set_affinity	= bcm7038_l1_set_affinity,
+#endif
 #ifdef CONFIG_PM_SLEEP
 	.irq_set_wake		= bcm7038_l1_set_wake,
 #endif

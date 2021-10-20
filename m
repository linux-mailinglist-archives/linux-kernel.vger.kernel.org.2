Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF5D43550E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhJTVOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:14:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55522 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhJTVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:32 -0400
Date:   Wed, 20 Oct 2021 21:12:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AobMEmM1lyRCp5biDQ0Kowy6E26P7Bt94DTOFuI6xt4=;
        b=xR0vwdmgTabB7f+pq5KOh6C0mKvgPWYz/BkDyNwsKWh+zY99Yk3lsI6qcVgXXHvuF6B8di
        dlBgsASCY3td7W7KzHEbDNxNGFj5fK/ImD6U0rqtX7muI+1mL+Z4evkrw1Hrf0SumxnwoC
        ZXRRW8DdUAJRVH9664O0X8ceshhU7dQlWWdDdll2/gS5AJ4Ap0mlrtC8dh71R9tkfE9QgA
        RkTJTGSLQlIk0mAe08uCHLHFY3LFeqTydO6zSIAENJn6uA0ycxysB0FOSuPA16wcdAy5LN
        BqleAU1pm4gZyMpEOurei4GcrEZ5ocl/41SWYDcvIeFensAHBb/adVaLkGoWFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AobMEmM1lyRCp5biDQ0Kowy6E26P7Bt94DTOFuI6xt4=;
        b=rJXUy6Fz5b1zcUHeIxFCCSnDDzJubtSUUznAG/hbrspNPXf6/8zyIGXWYyEbZ4cOwMYhp4
        RtPn8gOhiH/BeTCQ==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-bcm7038-l1: Remove .irq_cpu_offline()
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211020184859.2705451-3-f.fainelli@gmail.com>
References: <20211020184859.2705451-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <163476433657.25758.9670573641442125357.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     57de689ce7829219db007dca5c88ae023a8be2d3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/57de689ce7829219db007dca5c88ae023a8be2d3
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Wed, 20 Oct 2021 11:48:48 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 20:06:32 +01:00

irqchip/irq-bcm7038-l1: Remove .irq_cpu_offline()

With arch/mips/kernel/smp-bmips.c having been migrated away from
irq_cpu_offline() and use irq_migrate_all_off_this_cpu() instead, we no
longer need to implement an .irq_cpu_offline() callback. This is a
necessary change to facilitate the building of this driver as a module.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020184859.2705451-3-f.fainelli@gmail.com
---
 drivers/irqchip/irq-bcm7038-l1.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index a035c38..7501562 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -221,33 +221,6 @@ static int bcm7038_l1_set_affinity(struct irq_data *d,
 	return 0;
 }
 
-#ifdef CONFIG_SMP
-static void bcm7038_l1_cpu_offline(struct irq_data *d)
-{
-	struct cpumask *mask = irq_data_get_affinity_mask(d);
-	int cpu = smp_processor_id();
-	cpumask_t new_affinity;
-
-	/* This CPU was not on the affinity mask */
-	if (!cpumask_test_cpu(cpu, mask))
-		return;
-
-	if (cpumask_weight(mask) > 1) {
-		/*
-		 * Multiple CPU affinity, remove this CPU from the affinity
-		 * mask
-		 */
-		cpumask_copy(&new_affinity, mask);
-		cpumask_clear_cpu(cpu, &new_affinity);
-	} else {
-		/* Only CPU, put on the lowest online CPU */
-		cpumask_clear(&new_affinity);
-		cpumask_set_cpu(cpumask_first(cpu_online_mask), &new_affinity);
-	}
-	irq_set_affinity_locked(d, &new_affinity, false);
-}
-#endif
-
 static int __init bcm7038_l1_init_one(struct device_node *dn,
 				      unsigned int idx,
 				      struct bcm7038_l1_chip *intc)
@@ -396,9 +369,6 @@ static struct irq_chip bcm7038_l1_irq_chip = {
 	.irq_mask		= bcm7038_l1_mask,
 	.irq_unmask		= bcm7038_l1_unmask,
 	.irq_set_affinity	= bcm7038_l1_set_affinity,
-#ifdef CONFIG_SMP
-	.irq_cpu_offline	= bcm7038_l1_cpu_offline,
-#endif
 #ifdef CONFIG_PM_SLEEP
 	.irq_set_wake		= bcm7038_l1_set_wake,
 #endif

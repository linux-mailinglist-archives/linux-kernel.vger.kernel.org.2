Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5565D435506
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhJTVOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhJTVO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65334C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:12:13 -0700 (PDT)
Date:   Wed, 20 Oct 2021 21:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A+qrFAS5X9BSbgxWxujg4bl50iY3kNneLegSXlHzm3g=;
        b=3wW7XGqc8+23H71js5ZRYpFW2W+9f29+ZnVEjNVQ1ZesHRy4Abtz1Hx5OgZ3R0wZb+MXfE
        vp637TBYMsQrssBjh2qPqAYs393OhJgpSED7dcJrbKMwynlW5LS7pVsFuadRVq9l1cNIlK
        YoKSXSpKFE7D7cBbZTMqGN2fV0wPVujXWuo2VyaEbLQG3VnlX7b5DAcyN6xhXCjD7Gyrr3
        Ca5KeSFSDZbQbmhrVxPYHdefizu4inFXaq5epV2hf0lAPkodwb1bnmU4MeCTS6zEJ/5//g
        X1ZqERRaG/Y2KSNtbGPnliyFMbwlW/g1+VM3+f5g/1t1vtyhIZQ+1jdlrU30Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A+qrFAS5X9BSbgxWxujg4bl50iY3kNneLegSXlHzm3g=;
        b=LzqWRqQ2ZeN5PDQA7YnN2c0Yh1QuUypjbRe6r/BNM7sjyiVko9YsXUwahLR50M7JezO8J3
        Ejt/bIIU3YxHQlAg==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-bcm7120-l2: Switch to
 IRQCHIP_PLATFORM_DRIVER
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211020184859.2705451-11-f.fainelli@gmail.com>
References: <20211020184859.2705451-11-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <163476433117.25758.2308201719627997968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     3ac268d5ed2233d4a2db541d8fd744ccc13f46b0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3ac268d5ed2233d4a2db541d8fd744ccc13f46b0
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Wed, 20 Oct 2021 11:48:56 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 20:06:34 +01:00

irqchip/irq-bcm7120-l2: Switch to IRQCHIP_PLATFORM_DRIVER

Allow the user selection and building of this interrupt controller
driver as a module since it is used on ARM/ARM64 based systems as a
second level interrupt controller hanging off the ARM GIC and is
therefore loadable during boot.

To avoid using of_irq_count() which is not exported towards module,
switch the driver to use the platform_device provided by the irqchip
platform driver code and resolve the number of interrupts using
platform_irq_count().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020184859.2705451-11-f.fainelli@gmail.com
---
 drivers/irqchip/Kconfig          |  4 +++-
 drivers/irqchip/irq-bcm7120-l2.c | 21 +++++++++++++++------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 30018cc..b2f483b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -123,7 +123,9 @@ config BCM7038_L1_IRQ
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config BCM7120_L2_IRQ
-	bool
+	tristate "Broadcom STB 7120-style L2 interrupt controller driver"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index f23d765..d80e67a 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -220,6 +220,7 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct bcm7120_l2_intc_data *data;
+	struct platform_device *pdev;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 	int ret = 0;
@@ -230,7 +231,13 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 	if (!data)
 		return -ENOMEM;
 
-	data->num_parent_irqs = of_irq_count(dn);
+	pdev = of_find_device_by_node(dn);
+	if (!pdev) {
+		ret = -ENODEV;
+		goto out_free_data;
+	}
+
+	data->num_parent_irqs = platform_irq_count(pdev);
 	if (data->num_parent_irqs <= 0) {
 		pr_err("invalid number of parent interrupts\n");
 		ret = -ENOMEM;
@@ -329,6 +336,7 @@ out_unmap:
 		if (data->map_base[idx])
 			iounmap(data->map_base[idx]);
 	}
+out_free_data:
 	kfree(data);
 	return ret;
 }
@@ -347,8 +355,9 @@ static int __init bcm7120_l2_intc_probe_3380(struct device_node *dn,
 				     "BCM3380 L2");
 }
 
-IRQCHIP_DECLARE(bcm7120_l2_intc, "brcm,bcm7120-l2-intc",
-		bcm7120_l2_intc_probe_7120);
-
-IRQCHIP_DECLARE(bcm3380_l2_intc, "brcm,bcm3380-l2-intc",
-		bcm7120_l2_intc_probe_3380);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(bcm7120_l2)
+IRQCHIP_MATCH("brcm,bcm7120-l2-intc", bcm7120_l2_intc_probe_7120)
+IRQCHIP_MATCH("brcm,bcm3380-l2-intc", bcm7120_l2_intc_probe_3380)
+IRQCHIP_PLATFORM_DRIVER_END(bcm7120_l2)
+MODULE_DESCRIPTION("Broadcom STB 7120-style L2 interrupt controller driver");
+MODULE_LICENSE("GPL v2");

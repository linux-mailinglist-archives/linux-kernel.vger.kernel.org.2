Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F166943550A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhJTVOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:14:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhJTVOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:30 -0400
Date:   Wed, 20 Oct 2021 21:12:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6XhjpemffkC9NiXUQc1a9b5htdY3wuiZWBVnWmA5Ns=;
        b=xi72P/MzxpARizNTvDW3COdBFRElLxki0eA2RzQARPEwSD2yRoslXFzlZJNIniewpIB2bj
        zohIODJUblDiN7brUCTcwuA5clspq/CiqH3G/yXv3EBthK15TajY5cg+KjM1ggwNCvRxk/
        fBPj7f0hyz7KB4nQAiHzqvdbFWMC3jfjwa6QFwIeUHCrohNlgetlr7ZBujM9IkSclRTAU1
        NOj6z2DjZg2Wu2E2jdfU+iDkSKosUZKyuUkR55+EIdQQVM0/mnLO2gI4tSHRnxOK4tdNxd
        kF0H0SvEySkRvO1ObyKKArCNT4u3XDe7mYpRDoTR7GRuDRjKULYoXBwKJ0YWOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6XhjpemffkC9NiXUQc1a9b5htdY3wuiZWBVnWmA5Ns=;
        b=/mdHqnPgRG1OtAmn0v1P/YzGTsxvuiBeNqSKPHde56gqeeQOXOhHbeeZpcYb8jONnl7KwL
        bTfnl/gGA8IPHGBQ==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-bcm7038-l1: Switch to
 IRQCHIP_PLATFORM_DRIVER
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211020184859.2705451-7-f.fainelli@gmail.com>
References: <20211020184859.2705451-7-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <163476433391.25758.13332568997699245598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     c057c799e379f940b0e14dc83f96540a4c27730a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c057c799e379f940b0e14dc83f96540a4c27730a
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Wed, 20 Oct 2021 11:48:52 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 20:06:33 +01:00

irqchip/irq-bcm7038-l1: Switch to IRQCHIP_PLATFORM_DRIVER

Allow the user selection and building of this interrupt controller
driver as a module since it is used on ARM/ARM64 based systems as a
second level interrupt controller hanging off the ARM GIC and is
therefore loadable during boot.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020184859.2705451-7-f.fainelli@gmail.com
---
 drivers/irqchip/Kconfig          | 4 +++-
 drivers/irqchip/irq-bcm7038-l1.c | 6 +++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 6a4496f..f3b5377 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -115,7 +115,9 @@ config BCM6345_L1_IRQ
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config BCM7038_L1_IRQ
-	bool
+	tristate "Broadcom STB 7038-style L1/L2 interrupt controller driver"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 357570d..a62b962 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -455,4 +455,8 @@ out_free:
 	return ret;
 }
 
-IRQCHIP_DECLARE(bcm7038_l1, "brcm,bcm7038-l1-intc", bcm7038_l1_of_init);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(bcm7038_l1)
+IRQCHIP_MATCH("brcm,bcm7038-l1-intc", bcm7038_l1_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(bcm7038_l1)
+MODULE_DESCRIPTION("Broadcom STB 7038-style L1/L2 interrupt controller");
+MODULE_LICENSE("GPL v2");

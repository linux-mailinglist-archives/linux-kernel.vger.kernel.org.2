Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24978435508
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhJTVOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhJTVO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76F8C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:12:14 -0700 (PDT)
Date:   Wed, 20 Oct 2021 21:12:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klAPfJjyd4j2sv8QeD767xMNOMbrMbUb3Gd1SKALJ6k=;
        b=prmXdiN4Npn53vNsmIW+09ZhlTzfJ7OfLDzBuM9jHRsf5wxzsR2uCbgWZ1ZzhnHQqrFRCf
        T/9x+DFve3y3DV0iNuMDeQVt88jjJtqkZtVfZZBH5+p1HqUtHmujoQZNmco6qaByLlHviZ
        Vk2GryhPP72R9awi09ot2/Y/ZooxQ7b+Ht21rljkVgIOkwH3N1sVzUOOmMWiqrYD4ITX15
        YcUQETgleE1wzLUEKR8Ws2KgHlvWCttMLBulejX4W+7jsE3rbC1sblr04u8tCYcbY64m0p
        bxxFSLUiwkQiahT68pl6uV4xqh0Cg5t9+8wyH5xNLxL59BHpNRK3TaKeYNAo/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klAPfJjyd4j2sv8QeD767xMNOMbrMbUb3Gd1SKALJ6k=;
        b=UmOiVvwuNJawISfPVKVjvNV5yUfQqcj5m9V53u2v3IdTgMoVeq4Oik+dp20OOJwqqXZDgz
        L0fgfppD7tM2KsDQ==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-brcmstb-l2: Switch to
 IRQCHIP_PLATFORM_DRIVER
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211020184859.2705451-9-f.fainelli@gmail.com>
References: <20211020184859.2705451-9-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <163476433252.25758.9066023199471484289.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     51d9db5c8fbbed160081d4cb5c193abdf67ded05
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/51d9db5c8fbbed160081d4cb5c193abdf67ded05
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Wed, 20 Oct 2021 11:48:54 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 20:06:33 +01:00

irqchip/irq-brcmstb-l2: Switch to IRQCHIP_PLATFORM_DRIVER

Allow the user selection and building of this interrupt controller
driver as a module since it is used on ARM/ARM64 based systems as a
second level interrupt controller hanging off the ARM GIC and is
therefore loadable during boot.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020184859.2705451-9-f.fainelli@gmail.com
---
 drivers/irqchip/Kconfig          |  4 +++-
 drivers/irqchip/irq-brcmstb-l2.c | 16 +++++++++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f3b5377..30018cc 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -128,7 +128,9 @@ config BCM7120_L2_IRQ
 	select IRQ_DOMAIN
 
 config BRCMSTB_L2_IRQ
-	bool
+	tristate "Broadcom STB generic L2 interrupt controller driver"
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC
+	default ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 8e09115..e4efc08 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -275,16 +275,18 @@ static int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
 }
-IRQCHIP_DECLARE(brcmstb_l2_intc, "brcm,l2-intc", brcmstb_l2_edge_intc_of_init);
-IRQCHIP_DECLARE(brcmstb_hif_spi_l2_intc, "brcm,hif-spi-l2-intc",
-		brcmstb_l2_edge_intc_of_init);
-IRQCHIP_DECLARE(brcmstb_upg_aux_aon_l2_intc, "brcm,upg-aux-aon-l2-intc",
-		brcmstb_l2_edge_intc_of_init);
 
 static int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
 	struct device_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_lvl_intc_init);
 }
-IRQCHIP_DECLARE(bcm7271_l2_intc, "brcm,bcm7271-l2-intc",
-	brcmstb_l2_lvl_intc_of_init);
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(brcmstb_l2)
+IRQCHIP_MATCH("brcm,l2-intc", brcmstb_l2_edge_intc_of_init)
+IRQCHIP_MATCH("brcm,hif-spi-l2-intc", brcmstb_l2_edge_intc_of_init)
+IRQCHIP_MATCH("brcm,upg-aux-aon-l2-intc", brcmstb_l2_edge_intc_of_init)
+IRQCHIP_MATCH("brcm,bcm7271-l2-intc", brcmstb_l2_lvl_intc_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(brcmstb_l2)
+MODULE_DESCRIPTION("Broadcom STB generic L2 interrupt controller");
+MODULE_LICENSE("GPL v2");

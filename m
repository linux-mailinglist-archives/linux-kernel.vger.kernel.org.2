Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7D6435504
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhJTVO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:14:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55492 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJTVO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:26 -0400
Date:   Wed, 20 Oct 2021 21:12:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JgXLLtHW2FgJCzGALZwOP7BcqjCOVBBHsILaVlu59uM=;
        b=u5WiDEcx2Cg6poX6eUmd9hNhgqwEmyJzxy80SqtfSwckVeeU4nDNfjDnqjVMXv1M7Mjzwh
        4vH/7DIU0uO2UXy2Uq711ehiKY8wVs7yumrPuXCH1fw/Td3spHhK5pRqzNmqKELqNljXpl
        l3HKblIGBJDQqRPtzmB1V4Y+HHKw32jwrxWQQfQPh1W9rG7/nQCiXixpPm033Dt/dLJ4ZF
        XZP0rkUfAEW4ilnlCx2xz17TtJsCDf0C1ZbsFCUvDf9g8sXFjzxdapglBzQqSkSSBMrGiA
        vYbHel+Zwt2JGc68TW0oeXSIqPkIACvfF4+ljlJxi/CoVv9V4UM9lOOCmJ6MlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JgXLLtHW2FgJCzGALZwOP7BcqjCOVBBHsILaVlu59uM=;
        b=JSaQluKYQuZtA3C3sn+tx323gmGIGypANTZ90qS2NwgfQKYaVQ7Lgky2+IV3M0SMWx/0TX
        xnTMEnG411U5XMAA==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] ARM: bcm: Removed forced select of
 interrupt controllers
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211020184859.2705451-13-f.fainelli@gmail.com>
References: <20211020184859.2705451-13-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <163476432980.25758.12034132474954742269.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     c40ef4c57599c30efc0c1e8ad6bec4f842295521
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c40ef4c57599c30efc0c1e8ad6bec4f842295521
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Wed, 20 Oct 2021 11:48:58 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 20:06:34 +01:00

ARM: bcm: Removed forced select of interrupt controllers

Now that the various second level interrupt controllers have been moved
to IRQCHIP_PLATFORM_DRIVER and they do default to ARCH_BRCMSTB and
ARCH_BCM2835 where relevant, remove their forced selection from the
machine entry to allow an user to build them as modules.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020184859.2705451-13-f.fainelli@gmail.com
---
 arch/arm/mach-bcm/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 2890e61..bd3f827 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -161,7 +161,6 @@ config ARCH_BCM2835
 	select ARM_TIMER_SP804
 	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
 	select BCM2835_TIMER
-	select BRCMSTB_L2_IRQ
 	select PINCTRL
 	select PINCTRL_BCM2835
 	select MFD_CORE
@@ -209,9 +208,6 @@ config ARCH_BRCMSTB
 	select ARM_GIC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
-	select BCM7038_L1_IRQ
-	select BRCMSTB_L2_IRQ
-	select BCM7120_L2_IRQ
 	select ZONE_DMA if ARM_LPAE
 	select SOC_BRCMSTB
 	select SOC_BUS

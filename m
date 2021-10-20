Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B50435505
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhJTVOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhJTVO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF948C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:12:12 -0700 (PDT)
Date:   Wed, 20 Oct 2021 21:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rwriwoGnsd4UZ0n9tdYKih7OaYBG3OCgF52t+w2992w=;
        b=DQ94G2/6tfwwrozVK7aJ7+Y/DVm7FCrNk5Fz8RwH/BK6ITm3Sm2B7G5Rw8dXtxpAAaUUFd
        quVv3uNYzegb3GTEkWMZB5XLPSK8w74eO8DN1+VJ5SIWBuLnIWQECb6E3BCpONHHSPH5kl
        ySYshKKMfTusryyhEnNwhClCR76rK1gqBlfqECXWy1pxsELf5NF5iug1FQLfXEErFnC70m
        f65d/gHSY4R7isck8gYgNh4pxZBQLrfXKuis9t0UWNPJz19WhfUBv1+YUYkP2XrySwrArw
        KXwLe6iwaVxy/3GPJvprYteuKapf0s75+ZOgKqJTOkJyNJDOHjEDpiY2zvi8wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rwriwoGnsd4UZ0n9tdYKih7OaYBG3OCgF52t+w2992w=;
        b=EozhWoQTnmmQgZsKoJRQhQAVE+0bldif195ZrLGQKC9GLye2OV+f/PGnWl/OeILUzc4QfO
        Qim2UYKhM8QP20AA==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64: broadcom: Removed forced select of
 interrupt controllers
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211020184859.2705451-12-f.fainelli@gmail.com>
References: <20211020184859.2705451-12-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <163476433049.25758.13306982724494992921.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9db71e8966bf7c80ab89d8d5b113d8daa3b237ea
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9db71e8966bf7c80ab89d8d5b113d8daa3b237ea
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Wed, 20 Oct 2021 11:48:57 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 20:06:34 +01:00

arm64: broadcom: Removed forced select of interrupt controllers

Now that the various second level interrupt controllers have been moved
to IRQCHIP_PLATFORM_DRIVER and they do default to ARCH_BRCMSTB and
ARCH_BCM2835 where relevant, remove their forced selection from the
machine entry to allow an user to build them as modules.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020184859.2705451-12-f.fainelli@gmail.com
---
 arch/arm64/Kconfig.platforms | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index ff2d83f..96a8196 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -44,7 +44,6 @@ config ARCH_BCM2835
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
-	select BRCMSTB_L2_IRQ
 	help
 	  This enables support for the Broadcom BCM2837 and BCM2711 SoC.
 	  These SoCs are used in the Raspberry Pi 3 and 4 devices.
@@ -82,8 +81,6 @@ config ARCH_BITMAIN
 config ARCH_BRCMSTB
 	bool "Broadcom Set-Top-Box SoCs"
 	select ARCH_HAS_RESET_CONTROLLER
-	select BCM7038_L1_IRQ
-	select BRCMSTB_L2_IRQ
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
 	help

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BACA378E92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbhEJNW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:22:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36792 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbhEJNRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:17:20 -0400
Date:   Mon, 10 May 2021 13:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620652567;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q6KVnXbmf+6Wr5gGDHtcLz8PP9XETxvKjKsceYsYg2A=;
        b=QcCDG5lInIf1YhlcsEvV0SAB1DTFlAVUcugZIfb62T0Y94eKVsMmblvbDn6I6o8l8i+NGp
        8nEr3R+be5xyAGQInkCW+cNtq1bMiAWKQg5A8Mb4DukNBtS6hgoGhyIA2aflAFwgm7b+6K
        7I6FuMs64YD2fFZitczGDhY59incfp+3BMaTHaizWF2reafCMYoipn5Xb8J4PMVRuz0x8m
        TgUg/chjsntYGnefg16PJ3cBKkf2hXVfFs9lD1NSIT2gGxmdkFqTogg8DJJ3urwuimYTKr
        kxr1rQwkjTPzjZBsf7i9M1ox0KKlDSs2IhH+KQJFUKUU3vMtWV9KFnbaRk/+PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620652567;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q6KVnXbmf+6Wr5gGDHtcLz8PP9XETxvKjKsceYsYg2A=;
        b=/dortAUd/DyG9RUl1hEG3hPikMSlEMUqwNKqp5lKZJRJz0wkclQWtsgZOajN0EhlNACCTb
        SZNr7mHZGOTzaABQ==
From:   "irqchip-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/apple-aic: APPLE_AIC should
 depend on ARCH_APPLE
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Hector Martin <marcan@marcan.st>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3Cf37e8daea37d50651d2164b0b3dad90780188548=2E16183?=
 =?utf-8?q?16398=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3Cf37e8daea37d50651d2164b0b3dad90780188548=2E161831?=
 =?utf-8?q?6398=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <162065256648.29796.16890348345829384399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5b44955dc19808fa209444ccb192343050e95ab0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5b44955dc19808fa209444ccb192343050e95ab0
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Tue, 13 Apr 2021 14:21:58 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 10 May 2021 14:12:48 +01:00

irqchip/apple-aic: APPLE_AIC should depend on ARCH_APPLE

The Apple Interrupt Controller is only present on Apple Silicon SoCs.
Hence add a dependency on ARCH_APPLE, to prevent asking the user about
this driver when configuring a kernel without Apple Silicon SoC support.

Drop the default, as ARCH_APPLE already selects APPLE_AIC.

Fixes: 76cde26394114f6a ("irqchip/apple-aic: Add support for the Apple Interrupt Controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/f37e8daea37d50651d2164b0b3dad90780188548.1618316398.git.geert+renesas@glider.be
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b90e825..62543a4 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -596,7 +596,7 @@ config IRQ_IDT3243X
 config APPLE_AIC
 	bool "Apple Interrupt Controller (AIC)"
 	depends on ARM64
-	default ARCH_APPLE
+	depends on ARCH_APPLE || COMPILE_TEST
 	help
 	  Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
 	  such as the M1.

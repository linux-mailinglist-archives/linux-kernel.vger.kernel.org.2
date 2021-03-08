Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B45331874
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCHU0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCHU0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:26:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0823BC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 12:25:59 -0800 (PST)
Date:   Mon, 08 Mar 2021 20:25:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615235156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tduRB/czap4Sci0WYKUEWU1vokzDBoj0L/zfRLZFyU4=;
        b=sxUlI04mmYrMv8jymvbn/CnF5hljESSP99YBSHb2pgUle5QVz/GzhX4ec1LTv6w5AC/tt3
        NlDgLPXXqvBKA7aACSh9hGzcUvu1MiQblxcmuXW0i88tzbzbtRBwjkPm2d9iys95dYxn6U
        A+z3pAzwMLM6QPSYskIx0anlJdAujWpHBZUxCU0XpOiQa8DoLmahNDOke//sbNa6J6uOfC
        4ClSyznarj8aD8VzCKgpinE/nkP9HUfW7k/WjriuA9Y0jK18ApH1p1vxqLgfIB/+lf4l8k
        31L2jtyN47XoGcUkCCbHO/Kkj8J5N4lvVhTyLYFWRTcfdD0wVx96Vtwky9d0Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615235156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tduRB/czap4Sci0WYKUEWU1vokzDBoj0L/zfRLZFyU4=;
        b=ZderxLtDOHCc17TmFhjAw+gK4eoeTZrnqV6WcF0iRbXxpotB5vQYdpG1Y+daK9If9QwL/i
        Aqg52P5Ju7dI3hCQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Do not blindly select
 CONFIG_GENERIC_IRQ_MULTI_HANDLER
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
In-Reply-To: <20210217142800.2547737-1-maz@kernel.org>
References: <20210217142800.2547737-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <161523515553.398.11800064890642825301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a79f7051cccb6f3bcd3d2a0a058c7d5c79bb0371
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a79f7051cccb6f3bcd3d2a0a058c7d5c79bb0371
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 17 Feb 2021 14:28:00 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 08 Mar 2021 20:18:41 

irqchip: Do not blindly select CONFIG_GENERIC_IRQ_MULTI_HANDLER

Implementing CONFIG_GENERIC_IRQ_MULTI_HANDLER is a decision that is
made at the architecture level, and shouldn't involve the irqchip
at all (we even provide a fallback helper when the option isn't
selected).

Drop all instances of such selection from non-arch code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210217142800.2547737-1-maz@kernel.org
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Hector Martin <marcan@marcan.st>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig |  9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e74fa20..15536e3 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -8,7 +8,6 @@ config IRQCHIP
 config ARM_GIC
 	bool
 	select IRQ_DOMAIN_HIERARCHY
-	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config ARM_GIC_PM
@@ -33,7 +32,6 @@ config GIC_NON_BANKED
 
 config ARM_GIC_V3
 	bool
-	select GENERIC_IRQ_MULTI_HANDLER
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -64,7 +62,6 @@ config ARM_NVIC
 config ARM_VIC
 	bool
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 
 config ARM_VIC_NR
 	int
@@ -99,14 +96,12 @@ config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config ATMEL_AIC5_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config I8259
@@ -153,7 +148,6 @@ config DW_APB_ICTL
 config FARADAY_FTINTC010
 	bool
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config HISILICON_IRQ_MBIGEN
@@ -169,7 +163,6 @@ config IMGPDC_IRQ
 config IXP4XX_IRQ
 	bool
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config MADERA_IRQ
@@ -186,7 +179,6 @@ config CLPS711X_IRQCHIP
 	bool
 	depends on ARCH_CLPS711X
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 	default y
 
@@ -205,7 +197,6 @@ config OMAP_IRQCHIP
 config ORION_IRQCHIP
 	bool
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 
 config PIC32_EVIC
 	bool

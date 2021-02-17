Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1172331DB79
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhBQO2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:28:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233328AbhBQO2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:28:50 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97DCE64E4A;
        Wed, 17 Feb 2021 14:28:10 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lCNoG-00EbxP-Gw; Wed, 17 Feb 2021 14:28:08 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com,
        marcan@marcan.st
Subject: [PATCH] irqchip: Do not blindly select CONFIG_GENERIC_IRQ_MULTI_HANDLER
Date:   Wed, 17 Feb 2021 14:28:00 +0000
Message-Id: <20210217142800.2547737-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, mark.rutland@arm.com, kernel-team@android.com, marcan@marcan.st
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementing CONFIG_GENERIC_IRQ_MULTI_HANDLER is a decision that is
made at the architecture level, and shouldn't involve the irqchip
at all (we even provide a fallback helper when the option isn't
selected).

Drop all instances of such selection from non-arch code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index da7b3cf63b07..1e3dba80ff0b 100644
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
-- 
2.30.0


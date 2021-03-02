Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C23532A43C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382916AbhCBK1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:27:43 -0500
Received: from foss.arm.com ([217.140.110.172]:48192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379933AbhCBKN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:13:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E151106F;
        Tue,  2 Mar 2021 02:12:21 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C5363F70D;
        Tue,  2 Mar 2021 02:12:20 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        mark.rutland@arm.com, maz@kernel.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCHv2 1/8] ARM: ep93xx: Select GENERIC_IRQ_MULTI_HANDLER directly
Date:   Tue,  2 Mar 2021 10:12:04 +0000
Message-Id: <20210302101211.2328-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210302101211.2328-1-mark.rutland@arm.com>
References: <20210302101211.2328-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

ep93xx currently relies of CONFIG_ARM_VIC to select
GENERIC_IRQ_MULTI_HANDLER. Given that this is logically a platform
architecture property, add the selection of GENERIC_IRQ_MULTI_HANDLER
at the platform level.

Further patches will remove the selection from the irqchip side.

Reported-by: Marc Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hector Martin <marcan@marcan.st>
Cc: James Morse <james.morse@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 853aab5ab327..5da96f5df48f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -348,6 +348,7 @@ config ARCH_EP93XX
 	select ARM_AMBA
 	imply ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
+	select GENERIC_IRQ_MULTI_HANDLER
 	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
-- 
2.11.0


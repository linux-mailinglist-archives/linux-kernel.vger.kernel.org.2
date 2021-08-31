Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8863FC4F9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbhHaJ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240630AbhHaJ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:29:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC2B7606A5;
        Tue, 31 Aug 2021 09:28:26 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V4 01/10] irqchip: Adjust Kconfig for Loongson
Date:   Tue, 31 Aug 2021 17:27:07 +0800
Message-Id: <20210831092716.4145604-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210831092716.4145604-1-chenhuacai@loongson.cn>
References: <20210831092716.4145604-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are preparing to add new Loongson (based on LoongArch, not compatible
with old MIPS-based Loongson) support. HTVEC will be shared by both old
and new Loongson processors, so we adjust its description. HTPIC is only
used by MIPS-based Loongson, so we add a MIPS dependency. PCH_PIC and
PCH_MSI will have some arch-specific code, so we remove the COMPILE_TEST
dependency to avoid build warnings.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4d5924e9f766..084bc4c2eebd 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -539,7 +539,7 @@ config LOONGSON_LIOINTC
 
 config LOONGSON_HTPIC
 	bool "Loongson3 HyperTransport PIC Controller"
-	depends on MACH_LOONGSON64
+	depends on (MACH_LOONGSON64 && MIPS)
 	default y
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_CHIP
@@ -547,16 +547,16 @@ config LOONGSON_HTPIC
 	  Support for the Loongson-3 HyperTransport PIC Controller.
 
 config LOONGSON_HTVEC
-	bool "Loongson3 HyperTransport Interrupt Vector Controller"
+	bool "Loongson HyperTransport Interrupt Vector Controller"
 	depends on MACH_LOONGSON64
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
 	help
-	  Support for the Loongson3 HyperTransport Interrupt Vector Controller.
+	  Support for the Loongson HyperTransport Interrupt Vector Controller.
 
 config LOONGSON_PCH_PIC
 	bool "Loongson PCH PIC Controller"
-	depends on MACH_LOONGSON64 || COMPILE_TEST
+	depends on MACH_LOONGSON64
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
 	select IRQ_FASTEOI_HIERARCHY_HANDLERS
@@ -565,7 +565,7 @@ config LOONGSON_PCH_PIC
 
 config LOONGSON_PCH_MSI
 	bool "Loongson PCH MSI Controller"
-	depends on MACH_LOONGSON64 || COMPILE_TEST
+	depends on MACH_LOONGSON64
 	depends on PCI
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
-- 
2.27.0


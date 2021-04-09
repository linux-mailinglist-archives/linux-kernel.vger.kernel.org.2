Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6FE359D05
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhDILRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:17:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49676 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDILRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617967018; x=1649503018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZrJGxZJvEsXnK5zB0VRt/gBq8pnNGDq/w4qYrIFNpWY=;
  b=Jj13vG18qAd1pdpXEQcPIV3ROX7ry83NTyMoaeYuMEa0Y2x0sQAIuVFm
   zYM+4NJGPGqNmtbUNhNeUvG5GxoIP66HboaZCHRvIUOV45P0oLXDMPR0C
   JOheSlAMyqoHNFcvhAt1gOlCQ7nz8rKHH/qVALmw8o2TlaBQV9kMlIWdX
   3/OpQPqXpiRKmm/j1/53XNpZUmhwuS8iBhzyrBKfkPUT1f9GyeSTUoLE7
   HZmeG7Ylgqvskojf350MAfpMk4YEl2mCDKpNdher9ETeKxVcUlk9n8gyN
   9/oEBEHutgW29zY8M4AW9emYh5Cpa2+Batp7zG5oomwbycCMd1qDaKgCR
   Q==;
IronPort-SDR: XAFChurWrXtLHYNr/AfcznOolxgXV5HnuXfvQ5MJn6VBEKzX/7T/XDiAbdpU3WdAde80jR+wjh
 aQrlSHv0q0I9/RjmXPoNfw0WRw7quUzQWqlFaM7kJqubZMA4Kx7WBDUCTwY2CGR2yac4NvKOY5
 jE6HhdCKT4fZNg39ki5X8CPj/aB+h/parEOb0wC/sYU9apbfpqp64VmG6S9+WbUPneKSK2fucs
 C0Kydumk9V3ZJdwao9BySTlyjJnGZOq5HUvebX5vf/PaJcDNQdkmPA6gzvvTy4CWIQ6jYLXXBt
 WhM=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="113022590"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:16:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:16:57 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:16:49 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 14/24] ARM: at91: pm: add support for 2.5V LDO regulator control
Date:   Fri, 9 Apr 2021 14:13:35 +0300
Message-ID: <20210409111345.294472-15-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to disable/enable 2.5V LDO regulator when entering/exiting
any ULP mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.h         |  1 +
 arch/arm/mach-at91/pm_suspend.S | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 666474088d55..53bdc9000e44 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -13,6 +13,7 @@
 #include <soc/at91/at91sam9_ddrsdr.h>
 #include <soc/at91/at91sam9_sdramc.h>
 #include <soc/at91/sama7-ddr.h>
+#include <soc/at91/sama7-sfrbu.h>
 
 #define AT91_MEMCTRL_MC		0
 #define AT91_MEMCTRL_SDRAMC	1
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 8b0b8619ee8a..9c9e08fd8300 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -83,6 +83,29 @@ tmp3	.req	r6
 
 	.endm
 
+/**
+ * Set state for 2.5V low power regulator
+ * @ena: 0 - disable regulator
+ *	 1 - enable regulator
+ *
+ * Side effects: overwrites r7, r8, r9, r10
+ */
+	.macro at91_2_5V_reg_set_low_power ena
+#ifdef CONFIG_SOC_SAMA7
+	ldr	r7, .sfrbu
+	mov	r8, #\ena
+	ldr	r9, [r7, #AT91_SFRBU_25LDOCR]
+	orr	r9, r9, #AT91_SFRBU_25LDOCR_LP
+	cmp	r8, #1
+	beq	lp_done_\ena
+	bic	r9, r9, #AT91_SFRBU_25LDOCR_LP
+lp_done_\ena:
+	ldr	r10, =AT91_SFRBU_25LDOCR_LDOANAKEY
+	orr	r9, r9, r10
+	str	r9, [r7, #AT91_SFRBU_25LDOCR]
+#endif
+	.endm
+
 	.text
 
 	.arm
@@ -906,6 +929,9 @@ save_mck:
 
 	at91_plla_disable
 
+	/* Enable low power mode for 2.5V regulator. */
+	at91_2_5V_reg_set_low_power 1
+
 	ldr	tmp3, .pm_mode
 	cmp	tmp3, #AT91_PM_ULP1
 	beq	ulp1_mode
@@ -918,6 +944,9 @@ ulp1_mode:
 	b	ulp_exit
 
 ulp_exit:
+	/* Disable low power mode for 2.5V regulator. */
+	at91_2_5V_reg_set_low_power 0
+
 	ldr	pmc, .pmc_base
 
 	at91_plla_enable
-- 
2.25.1


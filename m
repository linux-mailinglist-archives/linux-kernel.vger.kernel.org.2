Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4857241AAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbhI1IpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:45:11 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:14355 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239674AbhI1Io5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632818597; x=1664354597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=53R+iEvV0NWK/OowP0KDXrsaZ1JxuOi5YDFwA5ISfUA=;
  b=sQ1IoArkiJTn5mJI4LqDo5cg+Tjn0HZN1FlBs+gCWJcHj9FwnBHMaCqA
   4A59OBZQ7Lq9g1z3POdyvrruEQ2SOqDatjqOGObzMhwqMViniPgbxKhqB
   aPY3YQ+dLhEfHe0hYsk8yiA6r6iiXIZjziez3VBIgRKV5lGWKAIu3I3+O
   V4iGC5Glc03oA8zz/F1kgVJoka1hZ321VR/bbJgvrKOIGgT4OTqarqGjT
   NOg+TSH3+zvsXcmZ+XtCDDfqln8+1eoqErt69dsqPqOw+IU3qhLLdRz7t
   XmTQqCC4Myud9jrv2jhnQY1cSlslaWAbB+6ovbTkpHMBcRlEWvg6wuULT
   g==;
IronPort-SDR: STqlW0aSuHxJ4mrf3cX2sMTH9CtrhmDyi3iGJ9Vnuv/910hyRabe8FfJSfm5btAhu/tnt6S2em
 HxGzdl0pRXBleFD8Dcf2t2iihnM4hzjU5DUwtxIln8ppfQ28q4A/c8sPyF7V702NKez1SKvs9l
 03Egy4WSSlSnpT/1Lqo7ueyPJdJzAlDqPyiW7rs8gFuIEju7zK81gQUISDlHbuzszIIoesX9oj
 /q6DnFzIhCF2FVWEoqeaQvmPg2pypXO4+lk2z9hf1Rvzol3n8jUJN2X692T2POnsMrUpeDHiY4
 AbVVDqi2hny8uWQRNRkEohYV
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="130916788"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Sep 2021 01:43:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 28 Sep 2021 01:43:17 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 28 Sep 2021 01:43:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux@armlinux.org.uk>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] ARM: at91: pm: preload base address of controllers in tlb
Date:   Tue, 28 Sep 2021 11:42:57 +0300
Message-ID: <20210928084257.2188017-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928084257.2188017-1-claudiu.beznea@microchip.com>
References: <20210928084257.2188017-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In suspend/resume procedure for AT91 architecture different controllers
(PMC, SHDWC, RAM, RAM PHY, SFRBU) are accessed to do the proper settings
for power saving. Commit f0bbf17958e8 ("ARM: at91: pm: add self-refresh
support for sama7g5") introduced the access to RAMC PHY controller for
SAMA7G5. The access to this controller is done after RAMC ports are
closed, thus any TLB walk necessary for RAMC PHY virtual address will
fail. In the development branch this was not encountered. However, on
current kernel the issue is reproducible.

To solve the issue the previous mechanism of pre-loading the TLB with
the RAMC PHY virtual address has been used. However, only the addition
of this new pre-load breaks the functionality for ARMv5 based
devices (SAM9X60). This behavior has been encountered previously
while debugging this code and using the same mechanism for pre-loading
address for different controllers (e.g. pin controller, the assumption
being that other requested translations are replaced from TLB).

To solve this new issue the TBL flush + the extension of pre-loading
the rest of controllers to TBL (e.g. PMC, RAMC) has been added. The
rest of the controllers should have been pre-loaded previously, anyway.

Fixes: f0bbf17958e8 ("ARM: at91: pm: add self-refresh support for sama7g5")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 34f251fdb743..fdb4f63ecde4 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -1014,6 +1014,10 @@ ENTRY(at91_pm_suspend_in_sram)
 	mov	tmp1, #0
 	mcr	p15, 0, tmp1, c7, c10, 4
 
+	/* Flush tlb. */
+	mov	r4, #0
+	mcr	p15, 0, r4, c8, c7, 0
+
 	ldr	tmp1, [r0, #PM_DATA_PMC_MCKR_OFFSET]
 	str	tmp1, .mckr_offset
 	ldr	tmp1, [r0, #PM_DATA_PMC_VERSION]
@@ -1023,23 +1027,42 @@ ENTRY(at91_pm_suspend_in_sram)
 	ldr	tmp1, [r0, #PM_DATA_MODE]
 	str	tmp1, .pm_mode
 
+	/*
+	 * ldrne below are here to preload their address in the TLB as access
+	 * to RAM may be limited while in self-refresh.
+	 */
 	ldr	tmp1, [r0, #PM_DATA_PMC]
 	str	tmp1, .pmc_base
+	cmp	tmp1, #0
+	ldrne	tmp2, [tmp1, #0]
+
 	ldr	tmp1, [r0, #PM_DATA_RAMC0]
 	str	tmp1, .sramc_base
+	cmp	tmp1, #0
+	ldrne	tmp2, [tmp1, #0]
+
 	ldr	tmp1, [r0, #PM_DATA_RAMC1]
 	str	tmp1, .sramc1_base
+	cmp	tmp1, #0
+	ldrne	tmp2, [tmp1, #0]
+
+#ifndef CONFIG_SOC_SAM_V4_V5
+	/* ldrne below are here to preload their address in the TLB */
 	ldr	tmp1, [r0, #PM_DATA_RAMC_PHY]
 	str	tmp1, .sramc_phy_base
-	/* Both ldrne below are here to preload their address in the TLB */
+	cmp	tmp1, #0
+	ldrne	tmp2, [tmp1, #0]
+
 	ldr	tmp1, [r0, #PM_DATA_SHDWC]
 	str	tmp1, .shdwc
 	cmp	tmp1, #0
 	ldrne	tmp2, [tmp1, #0]
+
 	ldr	tmp1, [r0, #PM_DATA_SFRBU]
 	str	tmp1, .sfrbu
 	cmp	tmp1, #0
 	ldrne	tmp2, [tmp1, #0x10]
+#endif
 
 	/* Active the self-refresh mode */
 	at91_sramc_self_refresh_ena
-- 
2.25.1


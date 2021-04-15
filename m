Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E9E360799
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhDOKvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:51:36 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:54803 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbhDOKv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483866; x=1650019866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C7hxWt9DV3Pc9H4oOYS4u5rYRQhOWg1AJzI3K4Hdue4=;
  b=WM9tA25K0zXXCiYiS5rgbdHNnRCDaH1buc7czYodXm86ui5JLbjP+z1r
   wW0b0NDPIEN7bU9X6RyFhiNIgHIsr6ElNpj50X1ranVWFxQDKJFitV3V/
   rvFPL3GiaX7AvVH2Eh34+yzMYovQOHwLHsdL6TI3+hH57DphjnupaxSXT
   VV8PcEINokuKJU858Gjx2ORXTdx/JXLdmd3tcyFwvBvql6gPi1IiSoLrB
   lSd1mqCFCodRUmAwJP4j+E9El4PcSqyglAFlYxgp8xFO25FGpygFm/Gr1
   2LiNpMzFCc2M+hz9/h9rgN13+LZW6FxL7XN7/I1G1s2Q9fBgv8bC39/F5
   g==;
IronPort-SDR: wR6FXGhTP1jFx/zX5khIIqmmKBqBbmx6BiMhfqqyHmdFWHihmcf8CU/iBPjcwnMXR8ACaE8t/6
 WTs9GJS+goZm/nApUNOW0P1dxYuggcIU4LkB2SPF0mnZErUt52MNaMUA9aAWNC+rPXSB+zgV07
 v7nOmCHFqQ6p8Aw/dEGRVZ7jCi7od29HH/AcSKxBhhQKKbh0IunZweIN+BT5hOsSs3D51WvOM/
 SozB4MOxe5F8Wqqa4XlhMVR2oobcbI0HqG9d58Dw/lCeMifvkg8pqUavtw6uJR2dy5wo0a3gOZ
 K9c=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="113688174"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:51:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:51:03 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:51:01 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 06/24] ARM: at91: pm: use r7 instead of tmp1
Date:   Thu, 15 Apr 2021 13:49:52 +0300
Message-ID: <20210415105010.569620-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use r7 instead of tmp1 in macros. This prepares the filed for
next commits.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index b683c2caa40b..3d20c9880fee 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -31,30 +31,36 @@ tmp3	.req	r6
 
 /*
  * Wait until master oscillator has stabilized.
+ *
+ * Side effects: overwrites r7
  */
 	.macro wait_moscrdy
-1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
-	tst	tmp1, #AT91_PMC_MOSCS
+1:	ldr	r7, [pmc, #AT91_PMC_SR]
+	tst	r7, #AT91_PMC_MOSCS
 	beq	1b
 	.endm
 
 /*
  * Wait for main oscillator selection is done
+ *
+ * Side effects: overwrites r7
  */
 	.macro wait_moscsels
-1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
-	tst	tmp1, #AT91_PMC_MOSCSELS
+1:	ldr	r7, [pmc, #AT91_PMC_SR]
+	tst	r7, #AT91_PMC_MOSCSELS
 	beq	1b
 	.endm
 
 /*
  * Put the processor to enter the idle state
+ *
+ * Side effects: overwrites r7
  */
 	.macro at91_cpu_idle
 
 #if defined(CONFIG_CPU_V7)
-	mov	tmp1, #AT91_PMC_PCK
-	str	tmp1, [pmc, #AT91_PMC_SCDR]
+	mov	r7, #AT91_PMC_PCK
+	str	r7, [pmc, #AT91_PMC_SCDR]
 
 	dsb
 
-- 
2.25.1


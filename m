Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D910D359CF3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhDILQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:16:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49591 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhDILQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617966952; x=1649502952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C7hxWt9DV3Pc9H4oOYS4u5rYRQhOWg1AJzI3K4Hdue4=;
  b=e2eiYfRzAkJH4bjJJLR+wjunPSc1If9b4+blqN75SBQ8hrFI+3qWPptG
   7tyLAjNviEaaoGbJJzDMYd9QX9VT7stlfuwKQLWrUvZbolpB2x37TeSQq
   uVKwMZiptBK9AjHeJJ8R7FT5Nby4aqQXZ4am3cTXld8WmBl049Z+BYJFc
   CrEVYzJwExomTZ/v3yJLmcyiKlfsVShwvb14C8oGX5VtkWF3DzU35hrhO
   V5zNmCZGB6fX9kTp548ibmpe2BdMEqoQ93jyn5fZ0V6+YAyDjudxA4aYO
   hkwF/hlWOBCWrtVtKpyHkGFAcFcRK4/M1hXoFA1ffxdJNZHS4LhLpBtFC
   A==;
IronPort-SDR: e+usZbpB7ozNH9oTuIiR6FvvEsMlO+HSYU5d7LMxRuUTkBgPY7tFm1JulUXwRWdc2aSZDVG9MG
 jj30v8t0HWEzdtCFysgUFww/mnR50JOZgxAmaRRj4fTRb+bY+RPU1rdGs/iFsNrWB8HvKOLrNY
 Xwb+XHHXP5+gVW5Fb1XVhYpPUI4Bz/+CAEjLWUX4FWl2bPTW0bEfo9Wr7dzklG6reRk2+zHc03
 aS3CIFeQijoAHyy9UKxUkpvYpO56oVCnsdFbtmgnRiaCMuAoJXcuySNb/Ite0Ts/g9mh/z5f8W
 /UU=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="113022515"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:15:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:15:51 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:15:43 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 06/24] ARM: at91: pm: use r7 instead of tmp1
Date:   Fri, 9 Apr 2021 14:13:27 +0300
Message-ID: <20210409111345.294472-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
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


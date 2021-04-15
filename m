Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9411B3607A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhDOKvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:51:53 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49604 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhDOKvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483885; x=1650019885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5n/eIECTY9hFagkyjJsXISpsdO0v8XT2RhEXcNl0HII=;
  b=vsPxVl1Ny4OMDXZ3FV0p8MD5OJTrjNwSlwW+yCsW734Zl1SnX9zSt8bw
   cmPgKLbONoxMGB47TO/MQ21aYLiJQTVudmGPhNwAL0WUuG0ebOTurZVno
   nWzaqpGwoNyghCjSooLcMmFW+EUnJ3N/qYForFAysOlnddrkqdqAzjrY1
   rzDA6huJcn7eV391JT2Y9Vod9qcgYngD4bgjB8aq5YXnuPoPU0ZM43rCj
   YWCV7jfXiNfHC2F5/g01fomweolUhJp7kTPeFNvM2oiJgpxYnCFeNfeXj
   J5SwAtBHzAPj6UkSSTUT6PZ/xhYpHIRSUkFGEwSYdlzPlX8oQvM/HYnOz
   Q==;
IronPort-SDR: 6H4oUjQXAw/psqTbbWogwmu9lxNnzCeCtkx434BiNFp8+rvzGW8kzAgjY8yu3Ht/Vby96gEjrG
 roWsXcKuXVrbNsvXGB9o9TpwIw9GhjfoJki6wR72RGMwLg/uEWf01fFIKDd2tHMQfPtXguCn5g
 HwS2ihojrxMu8jnjpyy3yNPx/gVW5gNmI3BArBvkj8z4OmxS+IgCfMbS3OuIi5jeu4apLb8O8L
 m1ru1pRxXigCuG2poT+52XiBtaFJ0rE9KrDxLjJ0OgkxaGDkQMd4tfNtUAZSv37i5rrkj33T3h
 h+g=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="116551595"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:51:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:51:22 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:51:17 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 09/24] ARM: at91: pm: add support for waiting MCK1..4
Date:   Thu, 15 Apr 2021 13:49:55 +0300
Message-ID: <20210415105010.569620-10-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA7G5 has 5 master clocks 0..4. MCK0 is controlled differently than
MCK 1..4. MCK 1..4 should also be saved/restored in the last phase of
suspend/resume. Thus, adapt wait_mckrdy to support also MCK1..4.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 48 ++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 1f63bbfad728..7669b32d5257 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -22,11 +22,23 @@ tmp3	.req	r6
 
 /*
  * Wait until master clock is ready (after switching master clock source)
+ *
+ * @r_mckid:	register holding master clock identifier
+ *
+ * Side effects: overwrites r7, r8
  */
-	.macro wait_mckrdy
-1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
-	tst	tmp1, #AT91_PMC_MCKRDY
-	beq	1b
+	.macro wait_mckrdy r_mckid
+#ifdef CONFIG_SOC_SAMA7
+	cmp	\r_mckid, #0
+	beq	1f
+	mov	r7, #AT91_PMC_MCKXRDY
+	b	2f
+#endif
+1:	mov	r7, #AT91_PMC_MCKRDY
+2:	ldr	r8, [pmc, #AT91_PMC_SR]
+	and	r8, r7
+	cmp	r8, r7
+	bne	2b
 	.endm
 
 /*
@@ -231,7 +243,9 @@ sr_dis_exit:
 	bic	tmp1, tmp1, #AT91_PMC_PRES
 	orr	tmp1, tmp1, #AT91_PMC_PRES_64
 	str	tmp1, [pmc, tmp3]
-	wait_mckrdy
+
+	mov	tmp3, #0
+	wait_mckrdy tmp3
 	b	1f
 
 0:
@@ -267,10 +281,13 @@ sr_dis_exit:
 	bne	5f
 
 	/* Set lowest prescaler for fast resume. */
+	ldr	tmp3, .mckr_offset
 	ldr	tmp1, [pmc, tmp3]
 	bic	tmp1, tmp1, #AT91_PMC_PRES
 	str	tmp1, [pmc, tmp3]
-	wait_mckrdy
+
+	mov	tmp3, #0
+	wait_mckrdy tmp3
 	b	6f
 
 5:	/* Restore RC oscillator state */
@@ -307,6 +324,7 @@ sr_dis_exit:
 .macro at91_pm_ulp1_mode
 	ldr	pmc, .pmc_base
 	ldr	tmp2, .mckr_offset
+	mov	tmp3, #0
 
 	/* Save RC oscillator state and check if it is enabled. */
 	ldr	tmp1, [pmc, #AT91_PMC_SR]
@@ -348,7 +366,7 @@ sr_dis_exit:
 	orr	tmp1, tmp1, #AT91_PMC_CSS_MAIN
 	str	tmp1, [pmc, tmp2]
 
-	wait_mckrdy
+	wait_mckrdy tmp3
 
 	/* Enter the ULP1 mode by set WAITMODE bit in CKGR_MOR */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
@@ -361,7 +379,7 @@ sr_dis_exit:
 	nop
 	nop
 
-	wait_mckrdy
+	wait_mckrdy tmp3
 
 	/* Enable the crystal oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
@@ -377,7 +395,7 @@ sr_dis_exit:
 	bic	tmp1, tmp1, #AT91_PMC_CSS
 	str	tmp1, [pmc, tmp2]
 
-	wait_mckrdy
+	wait_mckrdy tmp3
 
 	/* Switch main clock source to crystal oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
@@ -394,7 +412,7 @@ sr_dis_exit:
 	orr	tmp1, tmp1, #AT91_PMC_CSS_MAIN
 	str	tmp1, [pmc, tmp2]
 
-	wait_mckrdy
+	wait_mckrdy tmp3
 
 	/* Restore RC oscillator state */
 	ldr	tmp1, .saved_osc_status
@@ -573,10 +591,12 @@ sr_dis_exit:
 save_mck:
 	str	tmp1, [pmc, tmp2]
 
-	wait_mckrdy
+	mov	tmp3, #0
+	wait_mckrdy tmp3
 
 	at91_plla_disable
 
+	ldr	tmp3, .pm_mode
 	cmp	tmp3, #AT91_PM_ULP1
 	beq	ulp1_mode
 
@@ -599,7 +619,8 @@ ulp_exit:
 	ldr	tmp2, .saved_mckr
 	str	tmp2, [pmc, tmp1]
 
-	wait_mckrdy
+	mov	tmp3, #0
+	wait_mckrdy tmp3
 
 .endm
 
@@ -611,7 +632,8 @@ ulp_exit:
 	bic	tmp1, tmp1, #AT91_PMC_CSS
 	str	tmp1, [pmc, tmp2]
 
-	wait_mckrdy
+	mov	tmp3, #0
+	wait_mckrdy tmp3
 
 	/*BUMEN*/
 	ldr	r0, .sfrbu
-- 
2.25.1


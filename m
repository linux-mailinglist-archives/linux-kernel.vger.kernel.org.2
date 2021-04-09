Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10E5359CFB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhDILQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:16:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31314 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhDILQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617966981; x=1649502981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5n/eIECTY9hFagkyjJsXISpsdO0v8XT2RhEXcNl0HII=;
  b=FxvYtMC5emo1poqzrX06oKPtFbkHNJZvM4kSbDpuTXLvruKhCadyVHK/
   Bf2n0/qR0f6hfwhdOcTiMt3aFeP+ITTAfrPCy7za52KouJDGEKPtHnYgd
   o5wF6VBsaRRZxatGgJf8QOr6+5/L2tkEtulelHKyGUPkouA0qEAGdWd2O
   vBWchohgXfr4/hcRpd3KbxKvnBmGsxLT0SQnKVTNMVZ7w4FUYJhKXkDmo
   abrNU1ho8sk3FZsgsfU249vJyIqf2SKhRY3rIcd1zIObpm5kX06ra1rQ0
   rwywMe9dpQlh0NNDuRL3eMrz1lQIBNWoVW0i2RmDMJC9gXwg94eC7NCx/
   w==;
IronPort-SDR: G7KL1GSRu0TB6V+aKTR7WwuNrpGp89j52uMFuk8bgjMvTl8ePaCEvXtDv6N7hkTRqeuIgLztfU
 XLgdJEvq+0GpdL2YqPsEb1H9nYwChc8K+4delijjc5mzsP3ke+LHzUVKsVTbSnDnmWEsE3Dn6y
 BiS8CFkTj+T34HWBAD4P/ztXGZhEYoDJF9kGqYbCcWm6pdE9nd/W+LG1o4g904MWhJPqobyN2W
 06fHRtyjxnSbrqBxPx3rVDQyN4fF6uJeaxuboR7YYkDjyXX9W+zCHb9Yq3Vq/LQMdzyupfmxMV
 nbU=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="116427644"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:16:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:16:15 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:16:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 09/24] ARM: at91: pm: add support for waiting MCK1..4
Date:   Fri, 9 Apr 2021 14:13:30 +0300
Message-ID: <20210409111345.294472-10-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
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


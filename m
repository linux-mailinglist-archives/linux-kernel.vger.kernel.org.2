Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FA634FEF7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhCaLAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:00:36 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:28755 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhCaK7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188386; x=1648724386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j2fGle16xNk/sUbS9KVc5rUQMDu4zNUWHMSGwOxir+Q=;
  b=TXlpLFhaEoOsRI4/VDr1Zg7GZTYCy5WTmRTytTzEzbB0Q6gHWW3gCZNK
   MXMB6EZP3ac7UxREI0q/oH5FuxPhmEvFzIKaZEny6kRaEEx2nj+E93u5o
   MxRXO6/WXgIgbRlY4IOaj8gikPM1tU0CrDQQykHvSh4QunoGWTi2Gd1gd
   0WW5oIHEbsFY9gzku7sBm9hpGTjzZQEa/q3Oh3L4PshfMtGLLENoLvMl+
   jnmJ5c0AfSrgt1vKLpZYMU2OLpyfNRakj3/PWu5C/AHWyDJSzEtuHK4nd
   JDxFrgfUwLX6yh/HNl8GM/5RMMH7Wm8M2lZy5AmQK2xKW7pEJSTdbuPeb
   A==;
IronPort-SDR: 4L5xH23fqkBfoN3FeLTPl7J1ILgrFaExuhXaMXaOah6ElQM52nJxteY8o4rTU3NUMzfPpeBRGt
 aC4tzADbvIhhHuiBjCWpuEccgiCM20ELOfzvM+sB/TV0/TlqFsB7fHTfT61sGS9yMOrq1gCZoy
 +O8vTfpHmm9X37qjXVCro663GYCpG9riCl7NeOo+nMKJJmClEyTaGa+6vZ3AfXZuMk/Z9OK4eR
 lScaE09qaOqzz2PCTmkM+56B8Ho5JDo6zk/uWHoCULe1Tm3yPidfXuuYlJqVSpUgql0+Oecpy7
 qbk=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="109198798"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:46 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:44 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 13/24] ARM: at91: pm: add support for MCK1..4 save/restore for ulp modes
Date:   Wed, 31 Mar 2021 13:58:57 +0300
Message-ID: <20210331105908.23027-14-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MCK1..4 save restore for ULP modes.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 126 ++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 84418120ba67..8b0b8619ee8a 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -765,7 +765,122 @@ sr_dis_exit:
 2:
 .endm
 
+/**
+ * at91_mckx_ps_enable:	save MCK1..4 settings and switch it to main clock
+ *
+ * Side effects: overwrites tmp1, tmp2
+ */
+.macro at91_mckx_ps_enable
+#ifdef CONFIG_SOC_SAMA7
+	ldr	pmc, .pmc_base
+
+	/* There are 4 MCKs we need to handle: MCK1..4 */
+	mov	tmp1, #1
+e_loop:	cmp	tmp1, #5
+	beq	e_done
+
+	/* Write MCK ID to retrieve the settings. */
+	str	tmp1, [pmc, #AT91_PMC_MCR_V2]
+	ldr	tmp2, [pmc, #AT91_PMC_MCR_V2]
+
+e_save_mck1:
+	cmp	tmp1, #1
+	bne	e_save_mck2
+	str	tmp2, .saved_mck1
+	b	e_ps
+
+e_save_mck2:
+	cmp	tmp1, #2
+	bne	e_save_mck3
+	str	tmp2, .saved_mck2
+	b	e_ps
+
+e_save_mck3:
+	cmp	tmp1, #3
+	bne	e_save_mck4
+	str	tmp2, .saved_mck3
+	b	e_ps
+
+e_save_mck4:
+	str	tmp2, .saved_mck4
+
+e_ps:
+	/* Use CSS=MAINCK and DIV=1. */
+	bic	tmp2, tmp2, #AT91_PMC_MCR_V2_CSS
+	bic	tmp2, tmp2, #AT91_PMC_MCR_V2_DIV
+	orr	tmp2, tmp2, #AT91_PMC_MCR_V2_CSS_MAINCK
+	orr	tmp2, tmp2, #AT91_PMC_MCR_V2_DIV1
+	str	tmp2, [pmc, #AT91_PMC_MCR_V2]
+
+	wait_mckrdy tmp1
+
+	add	tmp1, tmp1, #1
+	b	e_loop
+
+e_done:
+#endif
+.endm
+
+/**
+ * at91_mckx_ps_restore: restore MCK1..4 settings
+ *
+ * Side effects: overwrites tmp1, tmp2
+ */
+.macro at91_mckx_ps_restore
+#ifdef CONFIG_SOC_SAMA7
+	ldr	pmc, .pmc_base
+
+	/* There are 4 MCKs we need to handle: MCK1..4 */
+	mov	tmp1, #1
+r_loop:	cmp	tmp1, #5
+	beq	r_done
+
+r_save_mck1:
+	cmp	tmp1, #1
+	bne	r_save_mck2
+	ldr	tmp2, .saved_mck1
+	b	r_ps
+
+r_save_mck2:
+	cmp	tmp1, #2
+	bne	r_save_mck3
+	ldr	tmp2, .saved_mck2
+	b	r_ps
+
+r_save_mck3:
+	cmp	tmp1, #3
+	bne	r_save_mck4
+	ldr	tmp2, .saved_mck3
+	b	r_ps
+
+r_save_mck4:
+	ldr	tmp2, .saved_mck4
+
+r_ps:
+	/* Write MCK ID to retrieve the settings. */
+	str	tmp1, [pmc, #AT91_PMC_MCR_V2]
+	ldr	tmp3, [pmc, #AT91_PMC_MCR_V2]
+
+	/* We need to restore CSS and DIV. */
+	bic	tmp3, tmp3, #AT91_PMC_MCR_V2_CSS
+	bic	tmp3, tmp3, #AT91_PMC_MCR_V2_DIV
+	orr	tmp3, tmp3, tmp2
+	bic	tmp3, tmp3, #AT91_PMC_MCR_V2_ID_MSK
+	orr	tmp3, tmp3, tmp1
+	orr	tmp3, tmp3, #AT91_PMC_MCR_V2_CMD
+	str	tmp2, [pmc, #AT91_PMC_MCR_V2]
+
+	wait_mckrdy tmp1
+
+	add	tmp1, tmp1, #1
+	b	r_loop
+r_done:
+#endif
+.endm
+
 .macro at91_ulp_mode
+	at91_mckx_ps_enable
+
 	ldr	pmc, .pmc_base
 	ldr	tmp2, .mckr_offset
 	ldr	tmp3, .pm_mode
@@ -817,6 +932,7 @@ ulp_exit:
 	mov	tmp3, #0
 	wait_mckrdy tmp3
 
+	at91_mckx_ps_restore
 .endm
 
 .macro at91_backup_mode
@@ -946,6 +1062,16 @@ ENDPROC(at91_pm_suspend_in_sram)
 	.word 0
 .saved_osc_status:
 	.word 0
+#ifdef CONFIG_SOC_SAMA7
+.saved_mck1:
+	.word 0
+.saved_mck2:
+	.word 0
+.saved_mck3:
+	.word 0
+.saved_mck4:
+	.word 0
+#endif
 
 ENTRY(at91_pm_suspend_in_sram_sz)
 	.word .-at91_pm_suspend_in_sram
-- 
2.25.1


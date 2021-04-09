Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3572F359D02
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhDILRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:17:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:56755 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhDILRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617967009; x=1649503009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j2fGle16xNk/sUbS9KVc5rUQMDu4zNUWHMSGwOxir+Q=;
  b=D/p5EX2482BG5xw3Yb2ezdVUC+hsKbTuSptSILRA3tPaN00tnFx37/lb
   6SHolTg2QzgEWG8zsi3gpTc+dz+VDQH3DcBv8PunePw1r4V+9sRe5xayG
   p39RcG5wOrMHzuL5+ze/uszLBckFMolMTN1N1PXKW73J+S+fv5BtUBQCi
   0PIiL69PJWegCokPKB8PbCfBepNp+CSduoGYgETEgKLYL3aVigUmV4SUw
   bqv8BldFXC6qoeHf583htXvlGU3ggCZ17Es+cq+5CryWQJpXdgut5mJVL
   Owb2Kbky9DS7KFF6DMWW335WGvHi9U5dXMhlKdQqhJoMLnng++v4rnbPw
   Q==;
IronPort-SDR: +NWvB+L+ZSWY2KpyFIA0CqvIozuk/TfmONjXMvzNZARhHFIh+xsxRn1Sp1l9wKgCd6kgUyDjGG
 gyA/xHxNKWte4GGNPsuRtasxmaZD/3gF5itpknS8/U1o+D36qgsaVZlwuALlfeSRk/kRmru4U9
 ldYx+/TztF3RdjX5a+65dJyMjYg73+eQvKkIR9NnKNantUP0BKa47GQ4yoxvjbrJZCsvbluQX6
 stB4eFnujpEOQjAmGUoYXaIy/GQsnHjGk9XgPhYHKCn0X1jy+JRqizNNkQGo5ZgIYsgax2qR30
 5qk=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="110248376"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:16:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:16:49 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:16:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 13/24] ARM: at91: pm: add support for MCK1..4 save/restore for ulp modes
Date:   Fri, 9 Apr 2021 14:13:34 +0300
Message-ID: <20210409111345.294472-14-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
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


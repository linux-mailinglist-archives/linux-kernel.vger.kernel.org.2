Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764483607A9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhDOKwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:52:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:54871 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbhDOKwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483899; x=1650019899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j2fGle16xNk/sUbS9KVc5rUQMDu4zNUWHMSGwOxir+Q=;
  b=NyyRpdbY8r3L4SGD/sdeE6817L33eYIx9KbGPxB7hgC3QXmVeRsxjxba
   glEiqtcjFewixsOet+Yo0fm4OM1S7+JN8dkkGXkHjauPgLjYiA4nBZzP2
   J3D2O/WVNjDrv7PvuQcam8MrR49FydbHjF80AAiMGrDTFoIxScmZpRdX1
   gqhXmM46s126qrnetGNDBrwjVWRvU8Rdn1Mc+T4R9RVIpKzr/f80vqPco
   Fk8JfTY9bR6VG51Xfi1ScWRUL/A3jZv0uHkakiBYnuYGNTIzR6EFZJsO8
   +vHjNAIn0eY5Dh7vXL5c5T9+Ndu2/v1NedMy3b3LDFHpii5cgxvWgKYXl
   g==;
IronPort-SDR: J3NfwtK6K1M4aor5guPoxlgtODF9sGPRNFgRxb6hllCb70c6NVhqkoyXebnZcvbVqAmHkH/x8i
 xvU/0xEPDNHk4/Pgp6IU9TnUZrQ0PJT8UsJ9ASVBZs/p6OWctB+JIjcXCVc9HMuoyVPz4EtkVm
 qgeODdVs0kyX3/B4EMGoSdRPn1lgXGzR5KwTwiz+qzMDT+7uZKue950xX1Y3gQLeQChSAqr/bU
 qDJSs5R8FlGYHjmkB5aXKkiLfsOLvmqAjn4vXgh0NhG6k0g+Hvuzf88WN0VUsSdYV80Sf1xY3r
 mIY=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="113688363"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:51:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:51:38 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:51:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 13/24] ARM: at91: pm: add support for MCK1..4 save/restore for ulp modes
Date:   Thu, 15 Apr 2021 13:49:59 +0300
Message-ID: <20210415105010.569620-14-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
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


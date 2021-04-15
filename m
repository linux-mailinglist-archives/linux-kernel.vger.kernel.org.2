Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECEE36079A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhDOKvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:51:42 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:54803 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhDOKvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483869; x=1650019869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fnc4ASYJ12M3XrHDxxTQRUw3OroYEpCDglmUhVWaVeM=;
  b=cm8euHD40xlR9jM5OH7ZLkSqT+AYami1jDlAf+Z88zg9QkimoDKMp3M0
   lWV0ZOZcjsqCv06KplYzGUXZ3X491c5Lx/fV629akMLv6Jrga8ksk+7la
   fPndK4ssmCk0/1biinMkJimSQGn2LeuU5UwJoG9b0yuHEabyAk40DFhW6
   GtwJ6BLB1MJ3PnT29CDap+55rxNXCYl68N1dvvDy8IxLrLdlhZaghCMaX
   7bzuSVQqGv6YlgJR1TTPZ5HJsYDzzNboDUuUOkKaguHjNO/RB4fYbn/3x
   Gi45gKZAjHdqbM5FIO7jEAm5mCVcUFf+7lVS9VKGh7QfxPNwmHRayb0kJ
   g==;
IronPort-SDR: xrfU67RXhFPNZQmHUEupb2j8QzDBSKCVl7Atzz5Qu4QOYX7P+iRVLDnCn3SeNxg45jw1C0+9ij
 +KIiF0yOTJsYaj2iMnbwsbV4bid2M8+e91t/QC7yg04UPhfAP8Q2Fh5xtMiYNLPXv1kYRXDHJO
 CSSR63Axk9osrqGZ7SSTPnhWOPYkRsuFrrRAPX0VSbe8gZ3HjF0uq+Ya9xbCbOoVhuQicaSumA
 1aQTRQSjCMKIicsW1vMd7X62RBNHpskugFLHmaeyxMMTkS48JtD97uNxvpiuCm6Jgn+zCA684J
 jOE=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="113688201"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:51:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:51:07 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:51:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 07/24] ARM: at91: pm: avoid push and pop on stack while memory is in self-refersh
Date:   Thu, 15 Apr 2021 13:49:53 +0300
Message-ID: <20210415105010.569620-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the previous AT91 RAM controller and self-refresh procedure this
had no side effects. However, for SAMA7G5 the self-refresh procedure
doesn't allow this anymore as the RAM controller ports are closed
before switching it to self-refresh. This commits prepares the code
for the following ones adding self-refresh and PM support for SAMA7G5.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 397 +++++++++++++++++---------------
 1 file changed, 205 insertions(+), 192 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 3d20c9880fee..960ad29cce51 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -75,98 +75,147 @@ tmp3	.req	r6
 
 	.arm
 
-/*
- * void at91_suspend_sram_fn(struct at91_pm_data*)
- * @input param:
- * 	@r0: base address of struct at91_pm_data
+/**
+ * Enable self-refresh
+ *
+ * register usage:
+ * 	@r1: memory type
+ *	@r2: base address of the sram controller
+ *	@r3: temporary
  */
-/* at91_pm_suspend_in_sram must be 8-byte aligned per the requirements of fncpy() */
-	.align 3
-ENTRY(at91_pm_suspend_in_sram)
-	/* Save registers on stack */
-	stmfd	sp!, {r4 - r12, lr}
+.macro at91_sramc_self_refresh_ena
+	ldr	r1, .memtype
+	ldr	r2, .sramc_base
 
-	/* Drain write buffer */
-	mov	tmp1, #0
-	mcr	p15, 0, tmp1, c7, c10, 4
+	cmp	r1, #AT91_MEMCTRL_MC
+	bne	sr_ena_ddrc_sf
 
-	ldr	tmp1, [r0, #PM_DATA_PMC]
-	str	tmp1, .pmc_base
-	ldr	tmp1, [r0, #PM_DATA_RAMC0]
-	str	tmp1, .sramc_base
-	ldr	tmp1, [r0, #PM_DATA_RAMC1]
-	str	tmp1, .sramc1_base
-	ldr	tmp1, [r0, #PM_DATA_MEMCTRL]
-	str	tmp1, .memtype
-	ldr	tmp1, [r0, #PM_DATA_MODE]
-	str	tmp1, .pm_mode
-	ldr	tmp1, [r0, #PM_DATA_PMC_MCKR_OFFSET]
-	str	tmp1, .mckr_offset
-	ldr	tmp1, [r0, #PM_DATA_PMC_VERSION]
-	str	tmp1, .pmc_version
-	/* Both ldrne below are here to preload their address in the TLB */
-	ldr	tmp1, [r0, #PM_DATA_SHDWC]
-	str	tmp1, .shdwc
-	cmp	tmp1, #0
-	ldrne	tmp2, [tmp1, #0]
-	ldr	tmp1, [r0, #PM_DATA_SFRBU]
-	str	tmp1, .sfrbu
-	cmp	tmp1, #0
-	ldrne	tmp2, [tmp1, #0x10]
+	/* Active SDRAM self-refresh mode */
+	mov	r3, #1
+	str	r3, [r2, #AT91_MC_SDRAMC_SRR]
+	b	sr_ena_exit
 
-	/* Active the self-refresh mode */
-	mov	r0, #SRAMC_SELF_FRESH_ACTIVE
-	bl	at91_sramc_self_refresh
+sr_ena_ddrc_sf:
+	cmp	r1, #AT91_MEMCTRL_DDRSDR
+	bne	sr_ena_sdramc_sf
 
-	ldr	r0, .pm_mode
-	cmp	r0, #AT91_PM_STANDBY
-	beq	standby
-	cmp	r0, #AT91_PM_BACKUP
-	beq	backup_mode
+	/*
+	 * DDR Memory controller
+	 */
 
-	bl	at91_ulp_mode
-	b	exit_suspend
+	/* LPDDR1 --> force DDR2 mode during self-refresh */
+	ldr	r3, [r2, #AT91_DDRSDRC_MDR]
+	str	r3, .saved_sam9_mdr
+	bic	r3, r3, #~AT91_DDRSDRC_MD
+	cmp	r3, #AT91_DDRSDRC_MD_LOW_POWER_DDR
+	ldreq	r3, [r2, #AT91_DDRSDRC_MDR]
+	biceq	r3, r3, #AT91_DDRSDRC_MD
+	orreq	r3, r3, #AT91_DDRSDRC_MD_DDR2
+	streq	r3, [r2, #AT91_DDRSDRC_MDR]
 
-standby:
-	/* Wait for interrupt */
-	ldr	pmc, .pmc_base
-	at91_cpu_idle
-	b	exit_suspend
+	/* Active DDRC self-refresh mode */
+	ldr	r3, [r2, #AT91_DDRSDRC_LPR]
+	str	r3, .saved_sam9_lpr
+	bic	r3, r3, #AT91_DDRSDRC_LPCB
+	orr	r3, r3, #AT91_DDRSDRC_LPCB_SELF_REFRESH
+	str	r3, [r2, #AT91_DDRSDRC_LPR]
 
-backup_mode:
-	bl	at91_backup_mode
-	b	exit_suspend
+	/* If using the 2nd ddr controller */
+	ldr	r2, .sramc1_base
+	cmp	r2, #0
+	beq	sr_ena_no_2nd_ddrc
 
-exit_suspend:
-	/* Exit the self-refresh mode */
-	mov	r0, #SRAMC_SELF_FRESH_EXIT
-	bl	at91_sramc_self_refresh
+	ldr	r3, [r2, #AT91_DDRSDRC_MDR]
+	str	r3, .saved_sam9_mdr1
+	bic	r3, r3, #~AT91_DDRSDRC_MD
+	cmp	r3, #AT91_DDRSDRC_MD_LOW_POWER_DDR
+	ldreq	r3, [r2, #AT91_DDRSDRC_MDR]
+	biceq	r3, r3, #AT91_DDRSDRC_MD
+	orreq	r3, r3, #AT91_DDRSDRC_MD_DDR2
+	streq	r3, [r2, #AT91_DDRSDRC_MDR]
 
-	/* Restore registers, and return */
-	ldmfd	sp!, {r4 - r12, pc}
-ENDPROC(at91_pm_suspend_in_sram)
+	/* Active DDRC self-refresh mode */
+	ldr	r3, [r2, #AT91_DDRSDRC_LPR]
+	str	r3, .saved_sam9_lpr1
+	bic	r3, r3, #AT91_DDRSDRC_LPCB
+	orr	r3, r3, #AT91_DDRSDRC_LPCB_SELF_REFRESH
+	str	r3, [r2, #AT91_DDRSDRC_LPR]
 
-ENTRY(at91_backup_mode)
-	/* Switch the master clock source to slow clock. */
-	ldr	pmc, .pmc_base
-	ldr	tmp2, .mckr_offset
-	ldr	tmp1, [pmc, tmp2]
-	bic	tmp1, tmp1, #AT91_PMC_CSS
-	str	tmp1, [pmc, tmp2]
+sr_ena_no_2nd_ddrc:
+	b	sr_ena_exit
 
-	wait_mckrdy
+	/*
+	 * SDRAMC Memory controller
+	 */
+sr_ena_sdramc_sf:
+	/* Active SDRAMC self-refresh mode */
+	ldr	r3, [r2, #AT91_SDRAMC_LPR]
+	str	r3, .saved_sam9_lpr
+	bic	r3, r3, #AT91_SDRAMC_LPCB
+	orr	r3, r3, #AT91_SDRAMC_LPCB_SELF_REFRESH
+	str	r3, [r2, #AT91_SDRAMC_LPR]
 
-	/*BUMEN*/
-	ldr	r0, .sfrbu
-	mov	tmp1, #0x1
-	str	tmp1, [r0, #0x10]
+	ldr	r3, .saved_sam9_lpr
+	str	r3, [r2, #AT91_SDRAMC_LPR]
 
-	/* Shutdown */
-	ldr	r0, .shdwc
-	mov	tmp1, #0xA5000000
-	add	tmp1, tmp1, #0x1
-	str	tmp1, [r0, #0]
-ENDPROC(at91_backup_mode)
+sr_ena_exit:
+.endm
+
+/**
+ * Disable self-refresh
+ *
+ * register usage:
+ * 	@r1: memory type
+ *	@r2: base address of the sram controller
+ *	@r3: temporary
+ */
+.macro at91_sramc_self_refresh_dis
+	ldr	r1, .memtype
+	ldr	r2, .sramc_base
+
+	cmp	r1, #AT91_MEMCTRL_MC
+	bne	sr_dis_ddrc_exit_sf
+
+	/*
+	 * at91rm9200 Memory controller
+	 */
+
+	 /*
+	  * For exiting the self-refresh mode, do nothing,
+	  * automatically exit the self-refresh mode.
+	  */
+	b	sr_dis_exit
+
+sr_dis_ddrc_exit_sf:
+	cmp	r1, #AT91_MEMCTRL_DDRSDR
+	bne	sdramc_exit_sf
+
+	/* DDR Memory controller */
+
+	/* Restore MDR in case of LPDDR1 */
+	ldr	r3, .saved_sam9_mdr
+	str	r3, [r2, #AT91_DDRSDRC_MDR]
+	/* Restore LPR on AT91 with DDRAM */
+	ldr	r3, .saved_sam9_lpr
+	str	r3, [r2, #AT91_DDRSDRC_LPR]
+
+	/* If using the 2nd ddr controller */
+	ldr	r2, .sramc1_base
+	cmp	r2, #0
+	ldrne	r3, .saved_sam9_mdr1
+	strne	r3, [r2, #AT91_DDRSDRC_MDR]
+	ldrne	r3, .saved_sam9_lpr1
+	strne	r3, [r2, #AT91_DDRSDRC_LPR]
+
+	b	sr_dis_exit
+
+sdramc_exit_sf:
+	/* SDRAMC Memory controller */
+	ldr	r3, .saved_sam9_lpr
+	str	r3, [r2, #AT91_SDRAMC_LPR]
+
+sr_dis_exit:
+.endm
 
 .macro at91_pm_ulp0_mode
 	ldr	pmc, .pmc_base
@@ -503,7 +552,7 @@ ENDPROC(at91_backup_mode)
 2:
 .endm
 
-ENTRY(at91_ulp_mode)
+.macro at91_ulp_mode
 	ldr	pmc, .pmc_base
 	ldr	tmp2, .mckr_offset
 	ldr	tmp3, .pm_mode
@@ -552,133 +601,97 @@ ulp_exit:
 
 	wait_mckrdy
 
-	mov	pc, lr
-ENDPROC(at91_ulp_mode)
-
-/*
- * void at91_sramc_self_refresh(unsigned int is_active)
- *
- * @input param:
- *	@r0: 1 - active self-refresh mode
- *	     0 - exit self-refresh mode
- * register usage:
- * 	@r1: memory type
- *	@r2: base address of the sram controller
- */
-
-ENTRY(at91_sramc_self_refresh)
-	ldr	r1, .memtype
-	ldr	r2, .sramc_base
-
-	cmp	r1, #AT91_MEMCTRL_MC
-	bne	ddrc_sf
-
-	/*
-	 * at91rm9200 Memory controller
-	 */
-
-	 /*
-	  * For exiting the self-refresh mode, do nothing,
-	  * automatically exit the self-refresh mode.
-	  */
-	tst	r0, #SRAMC_SELF_FRESH_ACTIVE
-	beq	exit_sramc_sf
-
-	/* Active SDRAM self-refresh mode */
-	mov	r3, #1
-	str	r3, [r2, #AT91_MC_SDRAMC_SRR]
-	b	exit_sramc_sf
-
-ddrc_sf:
-	cmp	r1, #AT91_MEMCTRL_DDRSDR
-	bne	sdramc_sf
+.endm
 
-	/*
-	 * DDR Memory controller
-	 */
-	tst	r0, #SRAMC_SELF_FRESH_ACTIVE
-	beq	ddrc_exit_sf
+.macro at91_backup_mode
+	/* Switch the master clock source to slow clock. */
+	ldr	pmc, .pmc_base
+	ldr	tmp2, .mckr_offset
+	ldr	tmp1, [pmc, tmp2]
+	bic	tmp1, tmp1, #AT91_PMC_CSS
+	str	tmp1, [pmc, tmp2]
 
-	/* LPDDR1 --> force DDR2 mode during self-refresh */
-	ldr	r3, [r2, #AT91_DDRSDRC_MDR]
-	str	r3, .saved_sam9_mdr
-	bic	r3, r3, #~AT91_DDRSDRC_MD
-	cmp	r3, #AT91_DDRSDRC_MD_LOW_POWER_DDR
-	ldreq	r3, [r2, #AT91_DDRSDRC_MDR]
-	biceq	r3, r3, #AT91_DDRSDRC_MD
-	orreq	r3, r3, #AT91_DDRSDRC_MD_DDR2
-	streq	r3, [r2, #AT91_DDRSDRC_MDR]
+	wait_mckrdy
 
-	/* Active DDRC self-refresh mode */
-	ldr	r3, [r2, #AT91_DDRSDRC_LPR]
-	str	r3, .saved_sam9_lpr
-	bic	r3, r3, #AT91_DDRSDRC_LPCB
-	orr	r3, r3, #AT91_DDRSDRC_LPCB_SELF_REFRESH
-	str	r3, [r2, #AT91_DDRSDRC_LPR]
+	/*BUMEN*/
+	ldr	r0, .sfrbu
+	mov	tmp1, #0x1
+	str	tmp1, [r0, #0x10]
 
-	/* If using the 2nd ddr controller */
-	ldr	r2, .sramc1_base
-	cmp	r2, #0
-	beq	no_2nd_ddrc
+	/* Shutdown */
+	ldr	r0, .shdwc
+	mov	tmp1, #0xA5000000
+	add	tmp1, tmp1, #0x1
+	str	tmp1, [r0, #0]
+.endm
 
-	ldr	r3, [r2, #AT91_DDRSDRC_MDR]
-	str	r3, .saved_sam9_mdr1
-	bic	r3, r3, #~AT91_DDRSDRC_MD
-	cmp	r3, #AT91_DDRSDRC_MD_LOW_POWER_DDR
-	ldreq	r3, [r2, #AT91_DDRSDRC_MDR]
-	biceq	r3, r3, #AT91_DDRSDRC_MD
-	orreq	r3, r3, #AT91_DDRSDRC_MD_DDR2
-	streq	r3, [r2, #AT91_DDRSDRC_MDR]
+/*
+ * void at91_suspend_sram_fn(struct at91_pm_data*)
+ * @input param:
+ * 	@r0: base address of struct at91_pm_data
+ */
+/* at91_pm_suspend_in_sram must be 8-byte aligned per the requirements of fncpy() */
+	.align 3
+ENTRY(at91_pm_suspend_in_sram)
+	/* Save registers on stack */
+	stmfd	sp!, {r4 - r12, lr}
 
-	/* Active DDRC self-refresh mode */
-	ldr	r3, [r2, #AT91_DDRSDRC_LPR]
-	str	r3, .saved_sam9_lpr1
-	bic	r3, r3, #AT91_DDRSDRC_LPCB
-	orr	r3, r3, #AT91_DDRSDRC_LPCB_SELF_REFRESH
-	str	r3, [r2, #AT91_DDRSDRC_LPR]
+	/* Drain write buffer */
+	mov	tmp1, #0
+	mcr	p15, 0, tmp1, c7, c10, 4
 
-no_2nd_ddrc:
-	b	exit_sramc_sf
+	ldr	tmp1, [r0, #PM_DATA_PMC]
+	str	tmp1, .pmc_base
+	ldr	tmp1, [r0, #PM_DATA_RAMC0]
+	str	tmp1, .sramc_base
+	ldr	tmp1, [r0, #PM_DATA_RAMC1]
+	str	tmp1, .sramc1_base
+	ldr	tmp1, [r0, #PM_DATA_MEMCTRL]
+	str	tmp1, .memtype
+	ldr	tmp1, [r0, #PM_DATA_MODE]
+	str	tmp1, .pm_mode
+	ldr	tmp1, [r0, #PM_DATA_PMC_MCKR_OFFSET]
+	str	tmp1, .mckr_offset
+	ldr	tmp1, [r0, #PM_DATA_PMC_VERSION]
+	str	tmp1, .pmc_version
+	/* Both ldrne below are here to preload their address in the TLB */
+	ldr	tmp1, [r0, #PM_DATA_SHDWC]
+	str	tmp1, .shdwc
+	cmp	tmp1, #0
+	ldrne	tmp2, [tmp1, #0]
+	ldr	tmp1, [r0, #PM_DATA_SFRBU]
+	str	tmp1, .sfrbu
+	cmp	tmp1, #0
+	ldrne	tmp2, [tmp1, #0x10]
 
-ddrc_exit_sf:
-	/* Restore MDR in case of LPDDR1 */
-	ldr	r3, .saved_sam9_mdr
-	str	r3, [r2, #AT91_DDRSDRC_MDR]
-	/* Restore LPR on AT91 with DDRAM */
-	ldr	r3, .saved_sam9_lpr
-	str	r3, [r2, #AT91_DDRSDRC_LPR]
+	/* Active the self-refresh mode */
+	at91_sramc_self_refresh_ena
 
-	/* If using the 2nd ddr controller */
-	ldr	r2, .sramc1_base
-	cmp	r2, #0
-	ldrne	r3, .saved_sam9_mdr1
-	strne	r3, [r2, #AT91_DDRSDRC_MDR]
-	ldrne	r3, .saved_sam9_lpr1
-	strne	r3, [r2, #AT91_DDRSDRC_LPR]
+	ldr	r0, .pm_mode
+	cmp	r0, #AT91_PM_STANDBY
+	beq	standby
+	cmp	r0, #AT91_PM_BACKUP
+	beq	backup_mode
 
-	b	exit_sramc_sf
+	at91_ulp_mode
+	b	exit_suspend
 
-	/*
-	 * SDRAMC Memory controller
-	 */
-sdramc_sf:
-	tst	r0, #SRAMC_SELF_FRESH_ACTIVE
-	beq	sdramc_exit_sf
+standby:
+	/* Wait for interrupt */
+	ldr	pmc, .pmc_base
+	at91_cpu_idle
+	b	exit_suspend
 
-	/* Active SDRAMC self-refresh mode */
-	ldr	r3, [r2, #AT91_SDRAMC_LPR]
-	str	r3, .saved_sam9_lpr
-	bic	r3, r3, #AT91_SDRAMC_LPCB
-	orr	r3, r3, #AT91_SDRAMC_LPCB_SELF_REFRESH
-	str	r3, [r2, #AT91_SDRAMC_LPR]
+backup_mode:
+	at91_backup_mode
 
-sdramc_exit_sf:
-	ldr	r3, .saved_sam9_lpr
-	str	r3, [r2, #AT91_SDRAMC_LPR]
+exit_suspend:
+	/* Exit the self-refresh mode */
+	at91_sramc_self_refresh_dis
 
-exit_sramc_sf:
-	mov	pc, lr
-ENDPROC(at91_sramc_self_refresh)
+	/* Restore registers, and return */
+	ldmfd	sp!, {r4 - r12, pc}
+ENDPROC(at91_pm_suspend_in_sram)
 
 .pmc_base:
 	.word 0
-- 
2.25.1


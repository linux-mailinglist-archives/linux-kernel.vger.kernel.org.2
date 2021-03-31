Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F934FEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhCaLAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:00:24 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43931 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbhCaK7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188384; x=1648724384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SwingqruFsTILHdNsRp4kbqGCt+RbaMioerNsU0GdOE=;
  b=DhXX3zJmjxNOLKQlRzDwUsdWNcoyPkvi72Y/aK41dyKzWSMpqF4EfRa3
   TASqz26MgfP0tCfUnhdywIqbNaWsQYoeIRuk0MS01R3353ezypogJ/O9q
   nnSIoJ7QoIo5+qPcHwu9o+VTzvdRlGdbV9oz8s6tZ6j+kkXiV4mKkYUsr
   rqDE4BI51jqyeW8sGaZ/zW5OfPAydXaxsTO4rq2OuYUBMzyC8LdaS8pn5
   NVWx0fWWBiXIRvkFW5pyPdShNSrmpR7l/lFQyTLNRv/h+n5BbdEdteIll
   Qran/DehW8nf1EdC90+yC82LTNTiS27VX2yQ6L143iKV6ogOfmFIE42Xo
   w==;
IronPort-SDR: rCBlnyKKLDO3LGLLTfXJy3y5h0xupp0+YFB3KYgugxe6Sl7CS21tr84oDHFk91ZlpV7ouF69as
 EAmFvAbzRtNxS8V+sMYQhERJ/nNTVpNbLHthDkd8YVGbHfHQloSZ4j6o1uif+TMASbVKLdgWt2
 Z9nP8LKQbINCz7VxSmBC2hyB4EdttHs6DPsvvRjtmKYTc5LFrYhedZxOQqTIALkF8388xPgNI/
 fGUkHZEP9ZIxAdcbo3sk+/66hvpucLL4s8PXJ6WwAQHDdBHhrSrrFF/j7cJImcdkhZUH0r8PfU
 3oo=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="121233950"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:43 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:41 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 12/24] ARM: at91: pm: add self-refresh support for sama7g5
Date:   Wed, 31 Mar 2021 13:58:56 +0300
Message-ID: <20210331105908.23027-13-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add self-refresh support for SAMA7G5.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.h              |   2 +
 arch/arm/mach-at91/pm_data-offsets.c |   2 +
 arch/arm/mach-at91/pm_suspend.S      | 199 +++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)

diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index bfb260be371e..666474088d55 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -12,6 +12,7 @@
 #include <linux/mfd/syscon/atmel-mc.h>
 #include <soc/at91/at91sam9_ddrsdr.h>
 #include <soc/at91/at91sam9_sdramc.h>
+#include <soc/at91/sama7-ddr.h>
 
 #define AT91_MEMCTRL_MC		0
 #define AT91_MEMCTRL_SDRAMC	1
@@ -27,6 +28,7 @@
 struct at91_pm_data {
 	void __iomem *pmc;
 	void __iomem *ramc[2];
+	void __iomem *ramc_phy;
 	unsigned long uhp_udp_mask;
 	unsigned int memctrl;
 	unsigned int mode;
diff --git a/arch/arm/mach-at91/pm_data-offsets.c b/arch/arm/mach-at91/pm_data-offsets.c
index 82089ff258c0..40bd4e8fe40a 100644
--- a/arch/arm/mach-at91/pm_data-offsets.c
+++ b/arch/arm/mach-at91/pm_data-offsets.c
@@ -8,6 +8,8 @@ int main(void)
 	DEFINE(PM_DATA_PMC,		offsetof(struct at91_pm_data, pmc));
 	DEFINE(PM_DATA_RAMC0,		offsetof(struct at91_pm_data, ramc[0]));
 	DEFINE(PM_DATA_RAMC1,		offsetof(struct at91_pm_data, ramc[1]));
+	DEFINE(PM_DATA_RAMC_PHY,	offsetof(struct at91_pm_data,
+						 ramc_phy));
 	DEFINE(PM_DATA_MEMCTRL,	offsetof(struct at91_pm_data, memctrl));
 	DEFINE(PM_DATA_MODE,		offsetof(struct at91_pm_data, mode));
 	DEFINE(PM_DATA_SHDWC,		offsetof(struct at91_pm_data, shdwc));
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 7669b32d5257..84418120ba67 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -87,6 +87,200 @@ tmp3	.req	r6
 
 	.arm
 
+#ifdef CONFIG_SOC_SAMA7
+/**
+ * Enable self-refresh
+ *
+ * Side effects: overwrites r2, r3, tmp1, tmp2, tmp3, r7
+ */
+.macro at91_sramc_self_refresh_ena
+	ldr	r2, .sramc_base
+	ldr	r3, .sramc_phy_base
+	ldr	r7, .pm_mode
+
+	dsb
+
+	/* Disable all AXI ports. */
+	ldr	tmp1, [r2, #UDDRC_PCTRL_0]
+	bic	tmp1, tmp1, #0x1
+	str	tmp1, [r2, #UDDRC_PCTRL_0]
+
+	ldr	tmp1, [r2, #UDDRC_PCTRL_1]
+	bic	tmp1, tmp1, #0x1
+	str	tmp1, [r2, #UDDRC_PCTRL_1]
+
+	ldr	tmp1, [r2, #UDDRC_PCTRL_2]
+	bic	tmp1, tmp1, #0x1
+	str	tmp1, [r2, #UDDRC_PCTRL_2]
+
+	ldr	tmp1, [r2, #UDDRC_PCTRL_3]
+	bic	tmp1, tmp1, #0x1
+	str	tmp1, [r2, #UDDRC_PCTRL_3]
+
+	ldr	tmp1, [r2, #UDDRC_PCTRL_4]
+	bic	tmp1, tmp1, #0x1
+	str	tmp1, [r2, #UDDRC_PCTRL_4]
+
+sr_ena_1:
+	/* Wait for all ports to disable. */
+	ldr	tmp1, [r2, #UDDRC_PSTAT]
+	ldr	tmp2, =UDDRC_PSTAT_ALL_PORTS
+	tst	tmp1, tmp2
+	bne	sr_ena_1
+
+	/* Switch to self-refresh. */
+	ldr	tmp1, [r2, #UDDRC_PWRCTL]
+	orr	tmp1, tmp1, #UDDRC_PWRCTRL_SELFREF_SW
+	str	tmp1, [r2, #UDDRC_PWRCTL]
+
+sr_ena_2:
+	/* Wait for self-refresh enter. */
+	ldr	tmp1, [r2, #UDDRC_STAT]
+	bic	tmp1, tmp1, #~UDDRC_STAT_SELFREF_TYPE_MSK
+	cmp	tmp1, #UDDRC_STAT_SELFREF_TYPE_SW
+	bne	sr_ena_2
+
+	/* Put DDR PHY's DLL in bypass mode for non-backup modes. */
+	cmp	r7, #AT91_PM_BACKUP
+	beq	sr_ena_3
+	ldr	tmp1, [r3, #DDR3PHY_PIR]
+	orr	tmp1, tmp1, #DDR3PHY_PIR_DLLBYP
+	str	tmp1, [r3, #DDR3PHY_PIR]
+
+sr_ena_3:
+	/* Power down DDR PHY data receivers. */
+	ldr	tmp1, [r3, #DDR3PHY_DXCCR]
+	orr	tmp1, tmp1, #DDR3PHY_DXCCR_DXPDR
+	str	tmp1, [r3, #DDR3PHY_DXCCR]
+
+	/* Power down ADDR/CMD IO. */
+	ldr	tmp1, [r3, #DDR3PHY_ACIOCR]
+	orr	tmp1, tmp1, #DDR3PHY_ACIORC_ACPDD
+	orr	tmp1, tmp1, #DDR3PHY_ACIOCR_CKPDD_CK0
+	orr	tmp1, tmp1, #DDR3PHY_ACIOCR_CSPDD_CS0
+	str	tmp1, [r3, #DDR3PHY_ACIOCR]
+
+	/* Power down ODT. */
+	ldr	tmp1, [r3, #DDR3PHY_DSGCR]
+	orr	tmp1, tmp1, #DDR3PHY_DSGCR_ODTPDD_ODT0
+	str	tmp1, [r3, #DDR3PHY_DSGCR]
+.endm
+
+/**
+ * Disable self-refresh
+ *
+ * Side effects: overwrites r2, r3, tmp1, tmp2, tmp3
+ */
+.macro at91_sramc_self_refresh_dis
+	ldr	r2, .sramc_base
+	ldr	r3, .sramc_phy_base
+
+	/* Power up DDR PHY data receivers. */
+	ldr	tmp1, [r3, #DDR3PHY_DXCCR]
+	bic	tmp1, tmp1, #DDR3PHY_DXCCR_DXPDR
+	str	tmp1, [r3, #DDR3PHY_DXCCR]
+
+	/* Power up the output of CK and CS pins. */
+	ldr	tmp1, [r3, #DDR3PHY_ACIOCR]
+	bic	tmp1, tmp1, #DDR3PHY_ACIORC_ACPDD
+	bic	tmp1, tmp1, #DDR3PHY_ACIOCR_CKPDD_CK0
+	bic	tmp1, tmp1, #DDR3PHY_ACIOCR_CSPDD_CS0
+	str	tmp1, [r3, #DDR3PHY_ACIOCR]
+
+	/* Power up ODT. */
+	ldr	tmp1, [r3, #DDR3PHY_DSGCR]
+	bic	tmp1, tmp1, #DDR3PHY_DSGCR_ODTPDD_ODT0
+	str	tmp1, [r3, #DDR3PHY_DSGCR]
+
+	/* Take DDR PHY's DLL out of bypass mode. */
+	ldr	tmp1, [r3, #DDR3PHY_PIR]
+	bic	tmp1, tmp1, #DDR3PHY_PIR_DLLBYP
+	str	tmp1, [r3, #DDR3PHY_PIR]
+
+	/* Enable quasi-dynamic programming. */
+	mov	tmp1, #0
+	str	tmp1, [r2, #UDDRC_SWCTRL]
+
+	/* De-assert SDRAM initialization. */
+	ldr	tmp1, [r2, #UDDRC_DFIMISC]
+	bic	tmp1, tmp1, #UDDRC_DFIMISC_DFI_INIT_COMPLETE_EN
+	str	tmp1, [r2, #UDDRC_DFIMISC]
+
+	/* Quasi-dynamic programming done. */
+	mov	tmp1, #UDDRC_SWCTRL_SW_DONE
+	str	tmp1, [r2, #UDDRC_SWCTRL]
+
+sr_dis_1:
+	ldr	tmp1, [r2, #UDDRC_SWSTAT]
+	tst	tmp1, #UDDRC_SWSTAT_SW_DONE_ACK
+	beq	sr_dis_1
+
+	/* DLL soft-reset + DLL lock wait + ITM reset */
+	mov	tmp1, #(DDR3PHY_PIR_INIT | DDR3PHY_PIR_DLLSRST | \
+			DDR3PHY_PIR_DLLLOCK | DDR3PHY_PIR_ITMSRST)
+	str	tmp1, [r3, #DDR3PHY_PIR]
+
+sr_dis_4:
+	/* Wait for it. */
+	ldr	tmp1, [r3, #DDR3PHY_PGSR]
+	tst	tmp1, #DDR3PHY_PGSR_IDONE
+	beq	sr_dis_4
+
+	/* Enable quasi-dynamic programming. */
+	mov	tmp1, #0
+	str	tmp1, [r2, #UDDRC_SWCTRL]
+
+	/* Assert PHY init complete enable signal. */
+	ldr	tmp1, [r2, #UDDRC_DFIMISC]
+	orr	tmp1, tmp1, #UDDRC_DFIMISC_DFI_INIT_COMPLETE_EN
+	str	tmp1, [r2, #UDDRC_DFIMISC]
+
+	/* Programming is done. Set sw_done. */
+	mov	tmp1, #UDDRC_SWCTRL_SW_DONE
+	str	tmp1, [r2, #UDDRC_SWCTRL]
+
+sr_dis_5:
+	/* Wait for it. */
+	ldr	tmp1, [r2, #UDDRC_SWSTAT]
+	tst	tmp1, #UDDRC_SWSTAT_SW_DONE_ACK
+	beq	sr_dis_5
+
+	/* Trigger self-refresh exit. */
+	ldr	tmp1, [r2, #UDDRC_PWRCTL]
+	bic	tmp1, tmp1, #UDDRC_PWRCTRL_SELFREF_SW
+	str	tmp1, [r2, #UDDRC_PWRCTL]
+
+sr_dis_6:
+	/* Wait for self-refresh exit done. */
+	ldr	tmp1, [r2, #UDDRC_STAT]
+	bic	tmp1, tmp1, #~UDDRC_STAT_OPMODE_MSK
+	cmp	tmp1, #UDDRC_STAT_OPMODE_NORMAL
+	bne	sr_dis_6
+
+	/* Enable all AXI ports. */
+	ldr	tmp1, [r2, #UDDRC_PCTRL_0]
+	orr	tmp1, tmp1, #0x1
+	str	tmp1, [r2, #UDDRC_PCTRL_0]
+
+	ldr	tmp1, [r2, #UDDRC_PCTRL_1]
+	orr	tmp1, tmp1, #0x1
+	str	tmp1, [r2, #UDDRC_PCTRL_1]
+
+	ldr	tmp1, [r2, #UDDRC_PCTRL_2]
+	orr	tmp1, tmp1, #0x1
+	str	tmp1, [r2, #UDDRC_PCTRL_2]
+
+	ldr	tmp1, [r2, #UDDRC_PCTRL_3]
+	orr	tmp1, tmp1, #0x1
+	str	tmp1, [r2, #UDDRC_PCTRL_3]
+
+	ldr	tmp1, [r2, #UDDRC_PCTRL_4]
+	orr	tmp1, tmp1, #0x1
+	str	tmp1, [r2, #UDDRC_PCTRL_4]
+
+	dsb
+.endm
+#else
 /**
  * Enable self-refresh
  *
@@ -228,6 +422,7 @@ sdramc_exit_sf:
 
 sr_dis_exit:
 .endm
+#endif
 
 .macro at91_pm_ulp0_mode
 	ldr	pmc, .pmc_base
@@ -668,6 +863,8 @@ ENTRY(at91_pm_suspend_in_sram)
 	str	tmp1, .sramc_base
 	ldr	tmp1, [r0, #PM_DATA_RAMC1]
 	str	tmp1, .sramc1_base
+	ldr	tmp1, [r0, #PM_DATA_RAMC_PHY]
+	str	tmp1, .sramc_phy_base
 	ldr	tmp1, [r0, #PM_DATA_MEMCTRL]
 	str	tmp1, .memtype
 	ldr	tmp1, [r0, #PM_DATA_MODE]
@@ -721,6 +918,8 @@ ENDPROC(at91_pm_suspend_in_sram)
 	.word 0
 .sramc1_base:
 	.word 0
+.sramc_phy_base:
+	.word 0
 .shdwc:
 	.word 0
 .sfrbu:
-- 
2.25.1


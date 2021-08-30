Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D9F3FB39F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhH3KKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:10:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:47444 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbhH3KKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630318177; x=1661854177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SoTCnikdgf21XcZdMwzYaqI+NZ+PtkhKdXux8qvsieo=;
  b=toso2Eh5duTfs0KUx/FXkLngd0LvMXPd0367Hs+lGfakfkzHNMiDz9jT
   ge0Hp/qm9aecAmYYo6vtlkkIY2IUKKGaf28yWUTIyy2UIijDHk834fyaZ
   SzixES9g35cc1hwDicV+kCH+EEdW3xCIr8uVtxIMcv/jUhkhlB11dMdUo
   ev/DDV+xjIVTOflBePsZ1STtQBN46j9sc5gQtcBhQnvvb7XPtQ5+GySjP
   JNIYmukyq6q5klwKWcQBObkPfKUbhwnoL/3Yj76GngBpOL586HUYx5A4D
   tqlV6zW19ZketNGtSAcefq87FHjFKj+xXR4wz1d32BUYTU7KtqA3bN4kF
   Q==;
IronPort-SDR: 4T4vwwYIncsecFxlp5h/c8QbNX4IxLSceq5/odL52lcreFdly7Vjax5UO79sXnoqjOakbH4QC+
 RmEIZqpwFBqlYw3A1YB8jfOKYSQPcXI7QjlHrw7vHa8zUbSKnJar5HD+f+BSiXtM0/dm8v5bDt
 C1OBPwlPCinNJO+iyr9226wmFxjCiJ19xElp+znInps3mVhy4fmQsno7BSC4leMoZvQy5y2+CY
 ltzam7hoKa5+r4qY9N4nvJUDnTffzFAlFyN5bpHBY5DdRpQIqIzBUwsgrr1GM8OS1z+sxyjT6g
 miDDPT+XhnRnF7OwfT3XgXlX
X-IronPort-AV: E=Sophos;i="5.84,363,1620716400"; 
   d="scan'208";a="127552924"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2021 03:09:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 30 Aug 2021 03:09:35 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 30 Aug 2021 03:09:34 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: at91: pm: switch backup area to vbat in backup mode
Date:   Mon, 30 Aug 2021 13:09:27 +0300
Message-ID: <20210830100927.22711-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Backup area is now switched to VDDIN33 at boot (with the help of
bootloader). When switching to backup mode we need to switch backup area
to VBAT as all the other power sources are cut off. The resuming from
backup mode is done with the help of bootloader, so there is no need to
do something particular in Linux to restore backup area power source.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi Nicolas,

This applies clean on top of patch with title
"ARM: at91: pm: do not panic if ram controllers are not enabled"

Thank you,
Claudiu Beznea

 arch/arm/mach-at91/pm.c | 52 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index d92afca64b49..8711d6824c1f 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -47,12 +47,26 @@ struct at91_pm_bu {
 	unsigned long ddr_phy_calibration[BACKUP_DDR_PHY_CALIBRATION];
 };
 
+/*
+ * struct at91_pm_sfrbu_offsets: registers mapping for SFRBU
+ * @pswbu: power switch BU control registers
+ */
+struct at91_pm_sfrbu_regs {
+	struct {
+		u32 key;
+		u32 ctrl;
+		u32 state;
+		u32 softsw;
+	} pswbu;
+};
+
 /**
  * struct at91_soc_pm - AT91 SoC power management data structure
  * @config_shdwc_ws: wakeup sources configuration function for SHDWC
  * @config_pmc_ws: wakeup srouces configuration function for PMC
  * @ws_ids: wakup sources of_device_id array
  * @data: PM data to be used on last phase of suspend
+ * @sfrbu_regs: SFRBU registers mapping
  * @bu: backup unit mapped data (for backup mode)
  * @memcs: memory chip select
  */
@@ -62,6 +76,7 @@ struct at91_soc_pm {
 	const struct of_device_id *ws_ids;
 	struct at91_pm_bu *bu;
 	struct at91_pm_data data;
+	struct at91_pm_sfrbu_regs sfrbu_regs;
 	void *memcs;
 };
 
@@ -356,9 +371,36 @@ static int at91_suspend_finish(unsigned long val)
 	return 0;
 }
 
+static void at91_pm_switch_ba_to_vbat(void)
+{
+	unsigned int offset = offsetof(struct at91_pm_sfrbu_regs, pswbu);
+	unsigned int val;
+
+	/* Just for safety. */
+	if (!soc_pm.data.sfrbu)
+		return;
+
+	val = readl(soc_pm.data.sfrbu + offset);
+
+	/* Already on VBAT. */
+	if (!(val & soc_pm.sfrbu_regs.pswbu.state))
+		return;
+
+	val &= ~soc_pm.sfrbu_regs.pswbu.softsw;
+	val |= soc_pm.sfrbu_regs.pswbu.key | soc_pm.sfrbu_regs.pswbu.ctrl;
+	writel(val, soc_pm.data.sfrbu + offset);
+
+	/* Wait for update. */
+	val = readl(soc_pm.data.sfrbu + offset);
+	while (val & soc_pm.sfrbu_regs.pswbu.state)
+		val = readl(soc_pm.data.sfrbu + offset);
+}
+
 static void at91_pm_suspend(suspend_state_t state)
 {
 	if (soc_pm.data.mode == AT91_PM_BACKUP) {
+		at91_pm_switch_ba_to_vbat();
+
 		cpu_suspend(0, at91_suspend_finish);
 
 		/* The SRAM is lost between suspend cycles */
@@ -1155,6 +1197,11 @@ void __init sama5d2_pm_init(void)
 	soc_pm.ws_ids = sama5d2_ws_ids;
 	soc_pm.config_shdwc_ws = at91_sama5d2_config_shdwc_ws;
 	soc_pm.config_pmc_ws = at91_sama5d2_config_pmc_ws;
+
+	soc_pm.sfrbu_regs.pswbu.key = (0x4BD20C << 8);
+	soc_pm.sfrbu_regs.pswbu.ctrl = BIT(0);
+	soc_pm.sfrbu_regs.pswbu.softsw = BIT(1);
+	soc_pm.sfrbu_regs.pswbu.state = BIT(3);
 }
 
 void __init sama7_pm_init(void)
@@ -1185,6 +1232,11 @@ void __init sama7_pm_init(void)
 
 	soc_pm.ws_ids = sama7g5_ws_ids;
 	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
+
+	soc_pm.sfrbu_regs.pswbu.key = (0x4BD20C << 8);
+	soc_pm.sfrbu_regs.pswbu.ctrl = BIT(0);
+	soc_pm.sfrbu_regs.pswbu.softsw = BIT(1);
+	soc_pm.sfrbu_regs.pswbu.state = BIT(2);
 }
 
 static int __init at91_pm_modes_select(char *str)
-- 
2.25.1


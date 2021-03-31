Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7A834FF08
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbhCaLBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:01:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40149 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbhCaLA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188429; x=1648724429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X9lDETj/GSJ03Xn4vNApYK1OklpZj6sHPlsSW7AI/RA=;
  b=fnmZW4NI0Gt2kX9HrkWnr+aC8+uup350eSx4qXz0xUNAKk75IIjdPtus
   DO87aFNp2OD/KRNeBQPgsk6pDpYB8lRJbmyma3bESb93UMAnIkvZ1KG6R
   FvnjSrkxIpTlBsgMvLKloKDHYHPQS9n+XbAxvw5Ld61sMNtnywoAF+WzV
   KMXiMG30uIdWGwIBl10I/E19++MN58ixq/d/ytMdN+/0shZhHb6ZZDyzN
   50JBgHLUv0P6veMR2m/pBvwOk3XJY1zpQWdQmBBrdAgX44mDqLtOinhcl
   f210/ZEBcdrWMoQPxhjB1vEn6wEPuIxtLPsrxtqp5FTw9N0PmQZ0kDsf7
   g==;
IronPort-SDR: tfZyjsXULctxn75Rl5BVGgdiA867zNs1kJPHw19piezvjA/hijnadtjIqgct0pPQBaiK565DG6
 5q9OtqlR8qVtQ38Dq6HiQU5lCh/GlAC3FzMMEH5oXnCaWjDLkko4KLTHJD6yJLVzGAGBJm23zL
 wkRewM6oewESpRhygFiby3CTsFkXe/Ye/fxM1LzXnFjqG1RN3K7yP6N+QFzBw1Qga6Q608K8SC
 FLGzIavAgHmPG/evwgZBdAu/SWKS6yuBSj05+nxkaICfOK/CcbaQuXNXKR6TA2jQZGOk+xZ/Yh
 eAw=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="115333365"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 04:00:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 04:00:01 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:59 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 19/24] ARM: at91: pm: save ddr phy calibration data to securam
Date:   Wed, 31 Mar 2021 13:59:03 +0300
Message-ID: <20210331105908.23027-20-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resuming from backup mode is done with the help of bootloader.
The bootloader reconfigure the DDR controller and DDR PHY controller.
To speed-up the resuming process save the PHY calibration data into
SECURAM before suspending (securam is powered on backup mode).
This data will be later used by bootloader in DDR PHY reconfiguration
process. Also, in the process or recalibration the first 8 words of
the memory may get corrupted. To solve this, these 8 words are saved
in the securam and restored by bootloader in the process of PHY
configuration.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 60 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 4dec7216a80e..91b4014d2e10 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of.h>
+#include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <linux/parser.h>
 #include <linux/suspend.h>
@@ -27,18 +28,23 @@
 #include "generic.h"
 #include "pm.h"
 
+#define BACKUP_DDR_PHY_CALIBRATION	(9)
+
 /**
  * struct at91_pm_bu - AT91 power management backup unit data structure
  * @suspended: true if suspended to backup mode
  * @reserved: reserved
  * @canary: canary data for memory checking after exit from backup mode
  * @resume: resume API
+ * @ddr_phy_calibration: DDR PHY calibration data: ZQ0CR0, first 8 words
+ * of the memory
  */
 struct at91_pm_bu {
 	int suspended;
 	unsigned long reserved;
 	phys_addr_t canary;
 	phys_addr_t resume;
+	unsigned long ddr_phy_calibration[BACKUP_DDR_PHY_CALIBRATION];
 };
 
 /**
@@ -48,6 +54,7 @@ struct at91_pm_bu {
  * @ws_ids: wakup sources of_device_id array
  * @data: PM data to be used on last phase of suspend
  * @bu: backup unit mapped data (for backup mode)
+ * @memcs: memory chip select
  */
 struct at91_soc_pm {
 	int (*config_shdwc_ws)(void __iomem *shdwc, u32 *mode, u32 *polarity);
@@ -55,6 +62,7 @@ struct at91_soc_pm {
 	const struct of_device_id *ws_ids;
 	struct at91_pm_bu *bu;
 	struct at91_pm_data data;
+	void *memcs;
 };
 
 /**
@@ -316,6 +324,19 @@ extern u32 at91_pm_suspend_in_sram_sz;
 
 static int at91_suspend_finish(unsigned long val)
 {
+	int i;
+
+	if (soc_pm.data.mode == AT91_PM_BACKUP && soc_pm.data.ramc_phy) {
+		/*
+		 * The 1st 8 words of memory might get corrupted in the process
+		 * of DDR PHY recalibration; it is saved here in securam and it
+		 * will be restored later, after recalibration, by bootloader
+		 */
+		for (i = 1; i < BACKUP_DDR_PHY_CALIBRATION; i++)
+			soc_pm.bu->ddr_phy_calibration[i] =
+				*((unsigned int *)soc_pm.memcs + (i - 1));
+	}
+
 	flush_cache_all();
 	outer_disable();
 
@@ -673,12 +694,40 @@ static bool __init at91_is_pm_mode_active(int pm_mode)
 		soc_pm.data.suspend_mode == pm_mode);
 }
 
+static int __init at91_pm_backup_scan_memcs(unsigned long node,
+					    const char *uname, int depth,
+					    void *data)
+{
+	const char *type;
+	const __be32 *reg;
+	int *located = data;
+	int size;
+
+	/* Memory node already located. */
+	if (*located)
+		return 0;
+
+	type = of_get_flat_dt_prop(node, "device_type", NULL);
+
+	/* We are scanning "memory" nodes only. */
+	if (!type || strcmp(type, "memory"))
+		return 0;
+
+	reg = of_get_flat_dt_prop(node, "reg", &size);
+	if (reg) {
+		soc_pm.memcs = __va((phys_addr_t)be32_to_cpu(*reg));
+		*located = 1;
+	}
+
+	return 0;
+}
+
 static int __init at91_pm_backup_init(void)
 {
 	struct gen_pool *sram_pool;
 	struct device_node *np;
 	struct platform_device *pdev;
-	int ret = -ENODEV;
+	int ret = -ENODEV, located = 0;
 
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
 		return -EPERM;
@@ -713,6 +762,15 @@ static int __init at91_pm_backup_init(void)
 	soc_pm.bu->suspended = 0;
 	soc_pm.bu->canary = __pa_symbol(&canary);
 	soc_pm.bu->resume = __pa_symbol(cpu_resume);
+	if (soc_pm.data.ramc_phy) {
+		of_scan_flat_dt(at91_pm_backup_scan_memcs, &located);
+		if (!located)
+			goto securam_fail;
+
+		/* DDR3PHY_ZQ0SR0 */
+		soc_pm.bu->ddr_phy_calibration[0] = readl(soc_pm.data.ramc_phy +
+							  0x188);
+	}
 
 	return 0;
 
-- 
2.25.1


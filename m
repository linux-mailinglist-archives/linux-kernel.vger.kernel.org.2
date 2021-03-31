Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A8034FEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhCaK76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:59:58 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43894 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbhCaK7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188362; x=1648724362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cHhcRE9999WTkqGlGEpWgWnBMHmK4LuT5bxkyB8koIw=;
  b=2cIAQEggTRWRCLcpryJrU444DEb8gLaYIQKOdDpCiVP7NKpBUi570POf
   osKpbrjxquAQf7a11cUTXWo+qRBo8nC5MNLrii7oLgfLtt24sYxCQF8hI
   kKb78vb9iLOnsyitwW1BXBtRBrhLsL45JTmEn65qjzxBndcM3Svc1tjiy
   8giwwcw7kaLAGhMVidlOWFJOozJwnDvldzT22Awz03ZxHlnJgbpkqg5hC
   EB8XY9Wk1T5vPtHDpdEKoXfIcLPPJmkbujrSU8w8OhnVkVC0WIe7/SIJe
   I80yVq3P9B0pCxC4BqkF89W4Uburr75ntgnNxDEVBoRRp6q8xpaIx/jFk
   g==;
IronPort-SDR: lEcLdZGLSD7mrHA0gCJgtFRS6kmQ0w9wVhgrSuTwA1QqNaSkLsqKccNG2YvvB/DRWCFHL7p3ps
 SAyLCFVj+mjJnMakQzpGi/1CRqJZgPaPHz5jDE3R41HXZFTpY1aynMqMLLJk8chzbegLAHgqdp
 3FI/UPephjNETGbdNvB9ipcUu45X3Napb34VNfJV82DvZd3akIZHJb5d1o/QBBU0RTWkUp0u2P
 Wjdm3UnZbzGDeEjIV1BRX3qz34BDlhtH0J3PfgUoaNbkXlZT+NKcPckaGAom+Qr33Pq2s4EsoX
 +RE=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="121233912"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:22 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:20 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 04/24] ARM: at91: pm: check for different controllers in at91_pm_modes_init()
Date:   Wed, 31 Mar 2021 13:58:48 +0300
Message-ID: <20210331105908.23027-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at91_pm_modes_init() checks for proper nodes in device tree and maps
them accordingly. Up to SAMA7G5 all AT91 SoCs had the same mapping
b/w power saving modes and different controllers needed in the
final/first steps of suspend/resume. SAMA7G5 is not aligned with the
old SoCs thus the code is adapted for this. This patch prepares
the field for next commits.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 143 +++++++++++++++++++++++++---------------
 1 file changed, 91 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 3029351ec78e..5a6ce1d88971 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -57,6 +57,18 @@ struct at91_soc_pm {
 	struct at91_pm_data data;
 };
 
+/**
+ * enum at91_pm_iomaps:	IOs that needs to be mapped for different PM modes
+ * @AT91_PM_IOMAP_SHDWC:	SHDWC controller
+ * @AT91_PM_IOMAP_SFRBU:	SFRBU controller
+ */
+enum at91_pm_iomaps {
+	AT91_PM_IOMAP_SHDWC,
+	AT91_PM_IOMAP_SFRBU,
+};
+
+#define AT91_PM_IOMAP(name)	BIT(AT91_PM_IOMAP_##name)
+
 static struct at91_soc_pm soc_pm = {
 	.data = {
 		.standby_mode = AT91_PM_STANDBY,
@@ -656,24 +668,15 @@ static int __init at91_pm_backup_init(void)
 	if (!at91_is_pm_mode_active(AT91_PM_BACKUP))
 		return 0;
 
-	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-sfrbu");
-	if (!np) {
-		pr_warn("%s: failed to find sfrbu!\n", __func__);
-		return ret;
-	}
-
-	soc_pm.data.sfrbu = of_iomap(np, 0);
-	of_node_put(np);
-
 	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
 	if (!np)
-		goto securam_fail_no_ref_dev;
+		return ret;
 
 	pdev = of_find_device_by_node(np);
 	of_node_put(np);
 	if (!pdev) {
 		pr_warn("%s: failed to find securam device!\n", __func__);
-		goto securam_fail_no_ref_dev;
+		return ret;
 	}
 
 	sram_pool = gen_pool_get(&pdev->dev, NULL);
@@ -697,64 +700,92 @@ static int __init at91_pm_backup_init(void)
 
 securam_fail:
 	put_device(&pdev->dev);
-securam_fail_no_ref_dev:
-	iounmap(soc_pm.data.sfrbu);
-	soc_pm.data.sfrbu = NULL;
 	return ret;
 }
 
-static void __init at91_pm_use_default_mode(int pm_mode)
-{
-	if (pm_mode != AT91_PM_ULP1 && pm_mode != AT91_PM_BACKUP)
-		return;
-
-	if (soc_pm.data.standby_mode == pm_mode)
-		soc_pm.data.standby_mode = AT91_PM_ULP0;
-	if (soc_pm.data.suspend_mode == pm_mode)
-		soc_pm.data.suspend_mode = AT91_PM_ULP0;
-}
-
 static const struct of_device_id atmel_shdwc_ids[] = {
 	{ .compatible = "atmel,sama5d2-shdwc" },
 	{ .compatible = "microchip,sam9x60-shdwc" },
 	{ /* sentinel. */ }
 };
 
-static void __init at91_pm_modes_init(void)
+static void __init at91_pm_modes_init(const u32 *maps, int len)
 {
 	struct device_node *np;
-	int ret;
+	int ret, mode;
 
-	if (!at91_is_pm_mode_active(AT91_PM_BACKUP) &&
-	    !at91_is_pm_mode_active(AT91_PM_ULP1))
-		return;
+	ret = at91_pm_backup_init();
+	if (ret) {
+		if (soc_pm.data.standby_mode == AT91_PM_BACKUP)
+			soc_pm.data.standby_mode = AT91_PM_ULP0;
+		if (soc_pm.data.suspend_mode == AT91_PM_BACKUP)
+			soc_pm.data.suspend_mode = AT91_PM_ULP0;
+	}
 
-	np = of_find_matching_node(NULL, atmel_shdwc_ids);
-	if (!np) {
-		pr_warn("%s: failed to find shdwc!\n", __func__);
-		goto ulp1_default;
+	if (maps[soc_pm.data.standby_mode] & AT91_PM_IOMAP(SHDWC) ||
+	    maps[soc_pm.data.suspend_mode] & AT91_PM_IOMAP(SHDWC)) {
+		np = of_find_matching_node(NULL, atmel_shdwc_ids);
+		if (!np) {
+			pr_warn("%s: failed to find shdwc!\n", __func__);
+
+			/* Use ULP0 if it doesn't needs SHDWC.*/
+			if (!(maps[AT91_PM_ULP0] & AT91_PM_IOMAP(SHDWC)))
+				mode = AT91_PM_ULP0;
+			else
+				mode = AT91_PM_STANDBY;
+
+			if (maps[soc_pm.data.standby_mode] & AT91_PM_IOMAP(SHDWC))
+				soc_pm.data.standby_mode = mode;
+			if (maps[soc_pm.data.suspend_mode] & AT91_PM_IOMAP(SHDWC))
+				soc_pm.data.suspend_mode = mode;
+		} else {
+			soc_pm.data.shdwc = of_iomap(np, 0);
+			of_node_put(np);
+		}
 	}
 
-	soc_pm.data.shdwc = of_iomap(np, 0);
-	of_node_put(np);
+	if (maps[soc_pm.data.standby_mode] & AT91_PM_IOMAP(SFRBU) ||
+	    maps[soc_pm.data.suspend_mode] & AT91_PM_IOMAP(SFRBU)) {
+		np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-sfrbu");
+		if (!np) {
+			pr_warn("%s: failed to find sfrbu!\n", __func__);
+
+			/*
+			 * Use ULP0 if it doesn't need SHDWC or if SHDWC
+			 * was already located.
+			 */
+			if (!(maps[AT91_PM_ULP0] & AT91_PM_IOMAP(SHDWC)) ||
+			    soc_pm.data.shdwc)
+				mode = AT91_PM_ULP0;
+			else
+				mode = AT91_PM_STANDBY;
+
+			if (maps[soc_pm.data.standby_mode] & AT91_PM_IOMAP(SFRBU))
+				soc_pm.data.standby_mode = mode;
+			if (maps[soc_pm.data.suspend_mode] & AT91_PM_IOMAP(SFRBU))
+				soc_pm.data.suspend_mode = mode;
+		} else {
+			soc_pm.data.sfrbu = of_iomap(np, 0);
+			of_node_put(np);
+		}
+	}
 
-	ret = at91_pm_backup_init();
-	if (ret) {
-		if (!at91_is_pm_mode_active(AT91_PM_ULP1))
-			goto unmap;
-		else
-			goto backup_default;
+	/* Unmap all unnecessary. */
+	if (soc_pm.data.shdwc &&
+	    !(maps[soc_pm.data.standby_mode] & AT91_PM_IOMAP(SHDWC) ||
+	      maps[soc_pm.data.suspend_mode] & AT91_PM_IOMAP(SHDWC))) {
+		iounmap(soc_pm.data.shdwc);
+		soc_pm.data.shdwc = NULL;
 	}
 
-	return;
+	if (soc_pm.data.sfrbu &&
+	    !(maps[soc_pm.data.standby_mode] & AT91_PM_IOMAP(SFRBU) ||
+	      maps[soc_pm.data.suspend_mode] & AT91_PM_IOMAP(SFRBU))) {
+		iounmap(soc_pm.data.sfrbu);
+		soc_pm.data.sfrbu = NULL;
+	}
 
-unmap:
-	iounmap(soc_pm.data.shdwc);
-	soc_pm.data.shdwc = NULL;
-ulp1_default:
-	at91_pm_use_default_mode(AT91_PM_ULP1);
-backup_default:
-	at91_pm_use_default_mode(AT91_PM_BACKUP);
+	return;
 }
 
 struct pmc_info {
@@ -917,12 +948,15 @@ void __init sam9x60_pm_init(void)
 	static const int modes[] __initconst = {
 		AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP0_FAST, AT91_PM_ULP1,
 	};
+	static const int iomaps[] __initconst = {
+		[AT91_PM_ULP1]		= AT91_PM_IOMAP(SHDWC),
+	};
 
 	if (!IS_ENABLED(CONFIG_SOC_SAM9X60))
 		return;
 
 	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
-	at91_pm_modes_init();
+	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
 	at91_dt_ramc();
 	at91_pm_init(NULL);
 
@@ -967,12 +1001,17 @@ void __init sama5d2_pm_init(void)
 		AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP0_FAST, AT91_PM_ULP1,
 		AT91_PM_BACKUP,
 	};
+	static const u32 iomaps[] __initconst = {
+		[AT91_PM_ULP1]		= AT91_PM_IOMAP(SHDWC),
+		[AT91_PM_BACKUP]	= AT91_PM_IOMAP(SHDWC) |
+					  AT91_PM_IOMAP(SFRBU),
+	};
 
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
 		return;
 
 	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
-	at91_pm_modes_init();
+	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
 	at91_dt_ramc();
 	at91_pm_init(NULL);
 
-- 
2.25.1


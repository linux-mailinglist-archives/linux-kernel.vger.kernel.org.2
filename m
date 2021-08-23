Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7183F4B92
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbhHWNUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:20:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:58043 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbhHWNUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629724765; x=1661260765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E66TFJy0rECmgE6xFV3purSQzLT5GCjg0zjjpcs/aOk=;
  b=MHNWudxZULGqpAl1RPgybRVNuN95ea/0yZ6hViI93xUTypDrWIvTuvx0
   yTOYAI6RQmnJGg6SrVEgaSsyXJt4wHXvaj2XM8kgyGWr5K5P8kc9RQ8IC
   2EEODcIpM7ZInzJ2lf561aCVDD5fdQH+tyNLA31V5rLKdwlr3C+P2+p6O
   gikl2K0w/v2/VzTNnphY4XaMtIij72KKvackoHNVR2J6qYG6WpGoo6M9t
   7d9pfsSs8uWSqsJpS6ueYkFOCr9egqx6kludM8NX4tWwp5GxuWieFJvpd
   EY1HSvf7o8hbmCDiBqUqoO6rYM1AgR/dl6E63mkKpi4qIjiGg1T8rkCmN
   w==;
IronPort-SDR: 1mkgHJ5+7q5CVjvLLNV9j7AESo0tBW0Vos0iZbmJZjJZEByN01d8eWCFxnOQ7KjKqovfWdzQLc
 wAZ1vKYB2SPjuJ0URCiVZHZ8FOqUuMbr4vTsdMTbhl0kD1lRpOFhnIkAE3ayPN9JE9jnkf350x
 6fJbkyUG+kvblh2/e31aD/v6eqIB3jkxZ3C09lQzhzIPouLBp6/TyZV98mG43jreWaulkbRWaW
 DUXnNcT1b1yilYA7mFdIwz13tRvPR6Is/HcOnmjNVDn/JH4uiQ9HVdReK7TL72KTKzCNwWiopw
 IerMNOwqYCrqjp+MNPQbVWj7
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="141194698"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2021 06:19:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 Aug 2021 06:19:24 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 Aug 2021 06:19:20 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 1/4] ARM: at91: pm: do not panic if ram controllers are not enabled
Date:   Mon, 23 Aug 2021 16:19:12 +0300
Message-ID: <20210823131915.23857-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210823131915.23857-1-claudiu.beznea@microchip.com>
References: <20210823131915.23857-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case PM is enabled but there is no RAM controller information
in DT the code will panic. Avoid such scenarios by not initializing
platform specific PM code in case RAM controller is not provided
via DT.

Reported-by: Eugen Hristev <eugen.hristev@microchip.com>
Fixes: 827de1f123ba0 ("ARM: at91: remove at91_dt_initialize and machine init_early()")
Fixes: 892e1f4a3ae58 ("ARM: at91: pm: add sama7g5 ddr phy controller")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 78 ++++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index d6cfe7c4bb00..d92afca64b49 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -589,18 +589,22 @@ static const struct of_device_id ramc_phy_ids[] __initconst = {
 	{ /* Sentinel. */ },
 };
 
-static __init void at91_dt_ramc(bool phy_mandatory)
+static __init int at91_dt_ramc(bool phy_mandatory)
 {
 	struct device_node *np;
 	const struct of_device_id *of_id;
 	int idx = 0;
 	void *standby = NULL;
 	const struct ramc_info *ramc;
+	int ret;
 
 	for_each_matching_node_and_match(np, ramc_ids, &of_id) {
 		soc_pm.data.ramc[idx] = of_iomap(np, 0);
-		if (!soc_pm.data.ramc[idx])
-			panic(pr_fmt("unable to map ramc[%d] cpu registers\n"), idx);
+		if (!soc_pm.data.ramc[idx]) {
+			pr_err("unable to map ramc[%d] cpu registers\n", idx);
+			ret = -ENOMEM;
+			goto unmap_ramc;
+		}
 
 		ramc = of_id->data;
 		if (ramc) {
@@ -612,25 +616,42 @@ static __init void at91_dt_ramc(bool phy_mandatory)
 		idx++;
 	}
 
-	if (!idx)
-		panic(pr_fmt("unable to find compatible ram controller node in dtb\n"));
+	if (!idx) {
+		pr_err("unable to find compatible ram controller node in dtb\n");
+		ret = -ENODEV;
+		goto unmap_ramc;
+	}
 
 	/* Lookup for DDR PHY node, if any. */
 	for_each_matching_node_and_match(np, ramc_phy_ids, &of_id) {
 		soc_pm.data.ramc_phy = of_iomap(np, 0);
-		if (!soc_pm.data.ramc_phy)
-			panic(pr_fmt("unable to map ramc phy cpu registers\n"));
+		if (!soc_pm.data.ramc_phy) {
+			pr_err("unable to map ramc phy cpu registers\n");
+			ret = -ENOMEM;
+			goto unmap_ramc;
+		}
 	}
 
-	if (phy_mandatory && !soc_pm.data.ramc_phy)
-		panic(pr_fmt("DDR PHY is mandatory!\n"));
+	if (phy_mandatory && !soc_pm.data.ramc_phy) {
+		pr_err("DDR PHY is mandatory!\n");
+		ret = -ENODEV;
+		goto unmap_ramc;
+	}
 
 	if (!standby) {
 		pr_warn("ramc no standby function available\n");
-		return;
+		return 0;
 	}
 
 	at91_cpuidle_device.dev.platform_data = standby;
+
+	return 0;
+
+unmap_ramc:
+	while (idx)
+		iounmap(soc_pm.data.ramc[--idx]);
+
+	return ret;
 }
 
 static void at91rm9200_idle(void)
@@ -1017,6 +1038,8 @@ static void __init at91_pm_init(void (*pm_idle)(void))
 
 void __init at91rm9200_pm_init(void)
 {
+	int ret;
+
 	if (!IS_ENABLED(CONFIG_SOC_AT91RM9200))
 		return;
 
@@ -1028,7 +1051,9 @@ void __init at91rm9200_pm_init(void)
 	soc_pm.data.standby_mode = AT91_PM_STANDBY;
 	soc_pm.data.suspend_mode = AT91_PM_ULP0;
 
-	at91_dt_ramc(false);
+	ret = at91_dt_ramc(false);
+	if (ret)
+		return;
 
 	/*
 	 * AT91RM9200 SDRAM low-power mode cannot be used with self-refresh.
@@ -1046,13 +1071,17 @@ void __init sam9x60_pm_init(void)
 	static const int iomaps[] __initconst = {
 		[AT91_PM_ULP1]		= AT91_PM_IOMAP(SHDWC),
 	};
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_SOC_SAM9X60))
 		return;
 
 	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
 	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
-	at91_dt_ramc(false);
+	ret = at91_dt_ramc(false);
+	if (ret)
+		return;
+
 	at91_pm_init(NULL);
 
 	soc_pm.ws_ids = sam9x60_ws_ids;
@@ -1061,6 +1090,8 @@ void __init sam9x60_pm_init(void)
 
 void __init at91sam9_pm_init(void)
 {
+	int ret;
+
 	if (!IS_ENABLED(CONFIG_SOC_AT91SAM9))
 		return;
 
@@ -1072,7 +1103,10 @@ void __init at91sam9_pm_init(void)
 	soc_pm.data.standby_mode = AT91_PM_STANDBY;
 	soc_pm.data.suspend_mode = AT91_PM_ULP0;
 
-	at91_dt_ramc(false);
+	ret = at91_dt_ramc(false);
+	if (ret)
+		return;
+
 	at91_pm_init(at91sam9_idle);
 }
 
@@ -1081,12 +1115,16 @@ void __init sama5_pm_init(void)
 	static const int modes[] __initconst = {
 		AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP0_FAST,
 	};
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5))
 		return;
 
 	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
-	at91_dt_ramc(false);
+	ret = at91_dt_ramc(false);
+	if (ret)
+		return;
+
 	at91_pm_init(NULL);
 }
 
@@ -1101,13 +1139,17 @@ void __init sama5d2_pm_init(void)
 		[AT91_PM_BACKUP]	= AT91_PM_IOMAP(SHDWC) |
 					  AT91_PM_IOMAP(SFRBU),
 	};
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
 		return;
 
 	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
 	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
-	at91_dt_ramc(false);
+	ret = at91_dt_ramc(false);
+	if (ret)
+		return;
+
 	at91_pm_init(NULL);
 
 	soc_pm.ws_ids = sama5d2_ws_ids;
@@ -1127,13 +1169,17 @@ void __init sama7_pm_init(void)
 		[AT91_PM_BACKUP]	= AT91_PM_IOMAP(SFRBU) |
 					  AT91_PM_IOMAP(SHDWC),
 	};
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_SOC_SAMA7))
 		return;
 
 	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
 
-	at91_dt_ramc(true);
+	ret = at91_dt_ramc(true);
+	if (ret)
+		return;
+
 	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
 	at91_pm_init(NULL);
 
-- 
2.25.1


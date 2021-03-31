Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC99534FF06
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhCaLBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:01:15 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40139 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbhCaLA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188426; x=1648724426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9V9RqdI0EwgAjOnpM2Y5HNidcaMJtUhqTwXWdJSC784=;
  b=rTYyWSjhOpIDiPP1mt2WJO9hhZRcumHrGjrjJ/OymTU4dk2vvZVTI162
   H88Twipkvk+5o8qp3dzIV6Kft/wGhQ6pIlqARjP+qgcQTUkSliSvXILsc
   yhDDVfmAHaJufbg7W/3wdKX8bwKeIEkPZkG1Djtdef48njX2q7Li6Ks8q
   Ht3oouW1XArmQddgfcFsucwKCGiOARxzrWZGyMfHBxv2/6QLcNBkprhPZ
   nMROjLr83v0WPV3ceveD6nPSPzJ8KwVW6iYuc4ZRMdWOLJNBn7C/tcK5C
   09kdGwI9Gg1rg79sJKxxbmLfgx03QrTjdcR0zWt1jUsFWh9A7I4fx0NrD
   A==;
IronPort-SDR: 0mdK9Cnphe+wUbkkNhNt+eHd5eSTwrivx8LeI6xw3rgR/ckVwXROqtUIMFHQXxCFf0ABwZ/YM4
 w7Ix7E7diGW6ghwab2uSKPwPcNPSuQz+stecNUR90Q3g5vNslllI65Bfl4FJC/ZI+JGlO3UVpt
 0gDK5NR0NQfHJxgg25tMYm3YOP0An4/IWuDoHvgzQZo+XbGeH6FYraekYk+B/dwBCPms7aEfu2
 VQJj4qxBqJ4j9BnHsX0xkptJaJOZvyHV3v6LHeIIs6ezfr0K6bF6qyaHriBmeTca9BdUdbHgb1
 r0k=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="115333393"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 04:00:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 04:00:11 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 04:00:09 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 23/24] ARM: at91: pm: add pm support for SAMA7G5
Date:   Wed, 31 Mar 2021 13:59:07 +0300
Message-ID: <20210331105908.23027-24-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SAMA7G5 power management modes: standby, ulp0, ulp1, backup.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/generic.h |  2 ++
 arch/arm/mach-at91/pm.c      | 37 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/sama7.c   |  1 +
 3 files changed, 40 insertions(+)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 0a4cdcb4985b..0c3960a8b3eb 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -14,12 +14,14 @@ extern void __init at91sam9_pm_init(void);
 extern void __init sam9x60_pm_init(void);
 extern void __init sama5_pm_init(void);
 extern void __init sama5d2_pm_init(void);
+extern void __init sama7_pm_init(void);
 #else
 static inline void __init at91rm9200_pm_init(void) { }
 static inline void __init at91sam9_pm_init(void) { }
 static inline void __init sam9x60_pm_init(void) { }
 static inline void __init sama5_pm_init(void) { }
 static inline void __init sama5d2_pm_init(void) { }
+static inline void __init sama7_pm_init(void) { }
 #endif
 
 #endif /* _AT91_GENERIC_H */
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index f4e66a7c7d18..24d5fd06d487 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -152,6 +152,17 @@ static const struct of_device_id sam9x60_ws_ids[] = {
 	{ /* sentinel */ }
 };
 
+static const struct of_device_id sama7g5_ws_ids[] = {
+	{ .compatible = "atmel,at91sam9x5-rtc",		.data = &ws_info[1] },
+	{ .compatible = "microchip,sama7g5-ohci",	.data = &ws_info[2] },
+	{ .compatible = "usb-ohci",			.data = &ws_info[2] },
+	{ .compatible = "atmel,at91sam9g45-ehci",	.data = &ws_info[2] },
+	{ .compatible = "usb-ehci",			.data = &ws_info[2] },
+	{ .compatible = "microchip,sama7g5-sdhci",	.data = &ws_info[3] },
+	{ .compatible = "atmel,at91sam9260-rtt",	.data = &ws_info[4] },
+	{ /* sentinel */ }
+};
+
 static int at91_pm_config_ws(unsigned int pm_mode, bool set)
 {
 	const struct wakeup_source_info *wsi;
@@ -1103,6 +1114,32 @@ void __init sama5d2_pm_init(void)
 	soc_pm.config_pmc_ws = at91_sama5d2_config_pmc_ws;
 }
 
+void __init sama7_pm_init(void)
+{
+	static const int modes[] __initconst = {
+		AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP1, AT91_PM_BACKUP,
+	};
+	static const u32 iomaps[] __initconst = {
+		[AT91_PM_ULP0]		= AT91_PM_IOMAP(SFRBU),
+		[AT91_PM_ULP1]		= AT91_PM_IOMAP(SFRBU) |
+					  AT91_PM_IOMAP(SHDWC),
+		[AT91_PM_BACKUP]	= AT91_PM_IOMAP(SFRBU) |
+					  AT91_PM_IOMAP(SHDWC),
+	};
+
+	if (!IS_ENABLED(CONFIG_SOC_SAMA7))
+		return;
+
+	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
+
+	at91_dt_ramc(true);
+	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
+	at91_pm_init(NULL);
+
+	soc_pm.ws_ids = sama7g5_ws_ids;
+	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
+}
+
 static int __init at91_pm_modes_select(char *str)
 {
 	char *s;
diff --git a/arch/arm/mach-at91/sama7.c b/arch/arm/mach-at91/sama7.c
index e04cadb569ad..bcabe4d82080 100644
--- a/arch/arm/mach-at91/sama7.c
+++ b/arch/arm/mach-at91/sama7.c
@@ -17,6 +17,7 @@
 static void __init sama7_common_init(void)
 {
 	of_platform_default_populate(NULL, NULL, NULL);
+	sama7_pm_init();
 }
 
 static void __init sama7_dt_device_init(void)
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3524B3607C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhDOKxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:53:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:26199 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbhDOKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483948; x=1650019948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mjPAJxK4oRCQ9n7U+VwdtIWQ0PrPFIAAliQ56Jru4fI=;
  b=vLw5GOOxnGm0/QarolLnBxDoJ5O+kvTmcsLxa2oOk6Zxufgv+a7Lg3lB
   nqVt+0pkCl0o31XS8+fIFjd1LSDuLrEBvY2SlvhpX3l6Rh1Iy9rT/ISrd
   gXG32mfsPi/QIzCFeqU9ip4Vrgk6QdzklAn5wi62GyUQGn4GWSTDZxptZ
   g+B37+Eu/cSvR6jbvN38XedMfJF3trsppMjdGQs78WMZN/pMMNyNd2AOj
   BiCXBDNbeqkToQOLmQrjFx5eFsQy8Al8gjBtnsOXKUo7RUBjTQXu0dDa6
   aIIvh71XXNInZfpIieNshomnj3fqSaREZ7Z3eJcFpR6HR6kv75Q1eDaM4
   w==;
IronPort-SDR: pvbS6L75UhXRDDO2zthSLPO900WQCwjPlW8UJef3qkDfAxzFD0Q6uXqwqvHQbbkOFi4lRi9CbE
 Ne16tCW1Eip8yYRtsbJfMW0XiuWNyFxqMe84g8xESrjMorxZiTo5cSEpyqdji2NMkwq/vMhAUn
 Cf47l/mHDLvWQwSyMPWLuyX44Pzuth3WlY9dMYNrUwYaJWH+tJ1f7qK7qrLqwAErxEPZ3d91uB
 VrbEUcmpWh1GHtYev4buaUQ5wTcS1ol8a0m6pJQogB1xVlkg3FjvTepmuvrWAcGlKTS6xBx7uC
 sD4=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="123168998"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:52:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:52:28 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:52:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 23/24] ARM: at91: pm: add pm support for SAMA7G5
Date:   Thu, 15 Apr 2021 13:50:09 +0300
Message-ID: <20210415105010.569620-24-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
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
index 19d7bcbc97f1..bd43733ede18 100644
--- a/arch/arm/mach-at91/sama7.c
+++ b/arch/arm/mach-at91/sama7.c
@@ -17,6 +17,7 @@
 static void __init sama7_dt_device_init(void)
 {
 	of_platform_default_populate(NULL, NULL, NULL);
+	sama7_pm_init();
 }
 
 static const char *const sama7_dt_board_compat[] __initconst = {
-- 
2.25.1


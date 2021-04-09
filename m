Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC0F359D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhDILSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:18:01 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:56843 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbhDILRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617967062; x=1649503062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gH+P3u9QqmYU3zqS64hGGjXJzweivpLPH2/q118Kpho=;
  b=jojwyy+5ErOgghUJvCPRaSQD+WlmybC5qoGnIo5FiOUVmpxq3H9fGdYM
   kjGZqVPY8fNnridK1dIiLr5E/e845oKoysQBUT6DYLFLSZT8+lrqdzKgS
   CyrQglO2B6BQ/PdAFWx+9k4u+KdnCIu4+Y1yJNhn63FGsxAT7hKR/qCyB
   FQrB285omSOXYtZ5OKielOEJ9byuFP+knBvfgHI8ld25Ki3qvelqPoPNm
   AQLXSzWjZTuPH4VhKeO3onhY9V8J6NxeImF20lztGjcbUVbuwTHawNagF
   L0g0g/C2XM12CwsmeadePq/HZIwuPm/Zsu/u7oIn/AZIzA7UDeLc3wZKK
   w==;
IronPort-SDR: Om+59q3lcxmFOImEpM4pL2V3P5WyT8g5kg6zxS0zcCOGcaTx1VuoNwnUc1CREA78t8SiM58HvR
 aZyIYPKOPwwOmAVx4Yh1HTjPGg1EU+PE62v3kFloPmnDK7xg6arXTKanW7Me0zbDgCBUlLUnH+
 nkIY5ItNwK3RvTdfGEUP8UPgOuFUcao6tjRK8aTzxMrpAzshdtX182BRzteTfYMNBstAlIB7Ey
 34v9a9DPol3NLY/rZfBy0D8bBXlJh11UUeDBdnGJImdHRqP44X54TcreWWIDiZCPLWoQ42nGqW
 YWw=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="110248452"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:17:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:17:42 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:17:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 18/24] ARM: at91: pm: add sama7g5 ddr phy controller
Date:   Fri, 9 Apr 2021 14:13:39 +0300
Message-ID: <20210409111345.294472-19-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA7G5 self-refresh procedure accesses also the DDR PHY registers.
Adapt the code so that the at91_dt_ramc() to look also for DDR PHYs,
in case it is mandatory.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 5dc942a2012d..4dec7216a80e 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -552,7 +552,12 @@ static const struct of_device_id ramc_ids[] __initconst = {
 	{ /*sentinel*/ }
 };
 
-static __init void at91_dt_ramc(void)
+static const struct of_device_id ramc_phy_ids[] __initconst = {
+	{ .compatible = "microchip,sama7g5-ddr3phy", },
+	{ /* Sentinel. */ },
+};
+
+static __init void at91_dt_ramc(bool phy_mandatory)
 {
 	struct device_node *np;
 	const struct of_device_id *of_id;
@@ -578,6 +583,16 @@ static __init void at91_dt_ramc(void)
 	if (!idx)
 		panic(pr_fmt("unable to find compatible ram controller node in dtb\n"));
 
+	/* Lookup for DDR PHY node, if any. */
+	for_each_matching_node_and_match(np, ramc_phy_ids, &of_id) {
+		soc_pm.data.ramc_phy = of_iomap(np, 0);
+		if (!soc_pm.data.ramc_phy)
+			panic(pr_fmt("unable to map ramc phy cpu registers\n"));
+	}
+
+	if (phy_mandatory && !soc_pm.data.ramc_phy)
+		panic(pr_fmt("DDR PHY is mandatory!\n"));
+
 	if (!standby) {
 		pr_warn("ramc no standby function available\n");
 		return;
@@ -936,7 +951,7 @@ void __init at91rm9200_pm_init(void)
 	soc_pm.data.standby_mode = AT91_PM_STANDBY;
 	soc_pm.data.suspend_mode = AT91_PM_ULP0;
 
-	at91_dt_ramc();
+	at91_dt_ramc(false);
 
 	/*
 	 * AT91RM9200 SDRAM low-power mode cannot be used with self-refresh.
@@ -960,7 +975,7 @@ void __init sam9x60_pm_init(void)
 
 	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
 	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
-	at91_dt_ramc();
+	at91_dt_ramc(false);
 	at91_pm_init(NULL);
 
 	soc_pm.ws_ids = sam9x60_ws_ids;
@@ -980,7 +995,7 @@ void __init at91sam9_pm_init(void)
 	soc_pm.data.standby_mode = AT91_PM_STANDBY;
 	soc_pm.data.suspend_mode = AT91_PM_ULP0;
 
-	at91_dt_ramc();
+	at91_dt_ramc(false);
 	at91_pm_init(at91sam9_idle);
 }
 
@@ -994,7 +1009,7 @@ void __init sama5_pm_init(void)
 		return;
 
 	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
-	at91_dt_ramc();
+	at91_dt_ramc(false);
 	at91_pm_init(NULL);
 }
 
@@ -1015,7 +1030,7 @@ void __init sama5d2_pm_init(void)
 
 	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
 	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
-	at91_dt_ramc();
+	at91_dt_ramc(false);
 	at91_pm_init(NULL);
 
 	soc_pm.ws_ids = sama5d2_ws_ids;
-- 
2.25.1


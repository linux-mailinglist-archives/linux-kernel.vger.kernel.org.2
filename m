Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86E734FEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhCaLBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:01:03 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43949 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbhCaLAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188399; x=1648724399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gH+P3u9QqmYU3zqS64hGGjXJzweivpLPH2/q118Kpho=;
  b=c11cFrBa+o7DS98V7tLxhf9IA1kR1CAPvG3UPfdgjmT/1PZ4I8yUGRa6
   fza4X4ihe5SelJ3qOckY1Vh+zE6dS+hmjfWO5rlNum7pKQxwNO88kvmh5
   Zet3hT2cJSo0TAmV5z5SlQSXaRdOti9FFWGwup3j0hcqqiUTMth7WrtQ1
   sioR01Zl9KOG972yHuBSvZJi0CfNqrT5B+/c5/pdidGW+DaNTiXL9dmPX
   UZ3Xii5eJqnZ3GpZQzEt2ERMBwQ5672IhNVhSq8+eXXu67o9fAwfbiaiS
   SqKNdQYq8S3CvjhF1QFoU+PdaKoO4fnOsPWu+byzY46bueL71uQWKd9BO
   A==;
IronPort-SDR: w4DOE/imI+3L/TVfwFwDlDwr7HpwL4VLiE1lNh/2lL4WT9ATtY3Dl2PSRdGg/5onq7LutbAzy6
 b1nS0T0NhD8c3h+tIU4YSR9Bq7lFHklGMvuLPKxh1nGwOhnFU/onzujRSEs0x4Czvgmpy0HH7P
 NKq6zmnKSfesJbaBRBXbB50KPghVCM5FTTq7p61cKKYukTy4h1X+V0pXKX6AFuCSFNJGGgZIG2
 1L/KO+OF7ZUl2gRSEgHQjZE4sAsobIW7bHjMeMBodggJFV+1t2f2b4s4/Vfq7F6Np5yWaLfTxR
 gpo=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="121233976"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:58 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:56 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 18/24] ARM: at91: pm: add sama7g5 ddr phy controller
Date:   Wed, 31 Mar 2021 13:59:02 +0300
Message-ID: <20210331105908.23027-19-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
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


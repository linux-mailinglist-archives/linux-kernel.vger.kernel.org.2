Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0A8428BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhJKL3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:29:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:61300 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbhJKL3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633951657; x=1665487657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5VG5paF1egv5urRpyHo/ZP0+9vjC7lINSoHMjLiU1WQ=;
  b=SpCtS/jr9Bn802iAz3bXeQ0uOU29Z5+an9dxbxipcqlkdFQ1fgyKDJgn
   Xl8yX9bSYQax/ibYVk4wccK3T/3dAxBDWHlBUrPT5kIghgAY2vG1rxSQC
   h3BS1aNefLCQfxThuNT0l6pkhzAQ9WZ4cvR75f9l5RTo9n9fX2LzHacyV
   pkqE7GKAqrCbCQ7T8NPD/ijlOSkyomSX4cqPpDH4L/dDawd/a7bdLPo47
   ralkQuis9yuY267vd/VX7yufNO+cohDLVgsQjK+b6ULhqjT4V7g9CB5Tm
   epXNctrGkd6YlGXMFnSiHQavpKq2PhohdGsOuI0+Jh5kjqPjRtu/rROLC
   Q==;
IronPort-SDR: pI+5HxfY4N8rvlbJ1ctQ4eo9EpvLd8dQnMBW4RR3MsK2tiQavdE/ERDCK49LjLC7pp6BPEWFN3
 sKhiuKpoPxQtwoRzGqVIZl2topMmR1DXtIT6moxt1aHMhetYs0OmRc6nKIJSeKruH+olhBBBpV
 xVhcfK+GKGzv4aTb0XDqryZHqOX+FaI4O+tLBvkdkvVU24LcRE/9pS2mCfsz54RYzZxO+IoCpH
 ZI7sWAGe80sW0silaAavYDMouEoh0dDA3mZBgkw57C1km1POwuZT6PVhCc8WacFopJ/SSAhiYN
 olSvDU/riuBt52UEpa/ifkxH
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="139244665"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 04:27:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 04:27:35 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Oct 2021 04:27:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 02/15] clk: at91: pmc: execute suspend/resume only for backup mode
Date:   Mon, 11 Oct 2021 14:27:06 +0300
Message-ID: <20211011112719.3951784-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before going to backup mode architecture specific PM code sets the first
word in securam (file arch/arm/mach-at91/pm.c, function at91_pm_begin()).
Thus take this into account when suspending/resuming clocks. This will
avoid executing unnecessary instructions when suspending to non backup
modes.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/pmc.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index b2806946a77a..517973062719 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -8,6 +8,7 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -110,13 +111,35 @@ struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
 }
 
 #ifdef CONFIG_PM
+
+/* Address in SECURAM that say if we suspend to backup mode. */
+static void __iomem *at91_pmc_backup_suspend;
+
 static int at91_pmc_suspend(void)
 {
+	unsigned int backup;
+
+	if (!at91_pmc_backup_suspend)
+		return 0;
+
+	backup = readl_relaxed(at91_pmc_backup_suspend);
+	if (!backup)
+		return 0;
+
 	return clk_save_context();
 }
 
 static void at91_pmc_resume(void)
 {
+	unsigned int backup;
+
+	if (!at91_pmc_backup_suspend)
+		return;
+
+	backup = readl_relaxed(at91_pmc_backup_suspend);
+	if (!backup)
+		return;
+
 	clk_restore_context();
 }
 
@@ -144,6 +167,22 @@ static int __init pmc_register_ops(void)
 	}
 	of_node_put(np);
 
+	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
+	if (!np)
+		return -ENODEV;
+
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+	of_node_put(np);
+
+	at91_pmc_backup_suspend = of_iomap(np, 0);
+	if (!at91_pmc_backup_suspend) {
+		pr_warn("%s(): unable to map securam\n", __func__);
+		return -ENOMEM;
+	}
+
 	register_syscore_ops(&pmc_syscore_ops);
 
 	return 0;
-- 
2.25.1


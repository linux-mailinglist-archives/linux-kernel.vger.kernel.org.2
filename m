Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83DE40F71F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243529AbhIQMIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:08:16 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25398 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241146AbhIQMIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880411; x=1663416411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2RWqN9QB2QVB/b7ge5LAdzUZ1SFAzssOZe07e839kf4=;
  b=vdqVAXxnOAmmixffxJQXXfbcCZkUXEVOh5NbWUEo5PMG9c/LJT5jNnfq
   OQK/5/pGDJKMFHUzqELuKBoX8oF2rto53ACA8ENGgwuPzvju6XS4BKDl/
   e208wDCxBByP5u63xJiDuZtgsR5Xw62UQ6wn/RsAM4LE39TcWvTaItO5M
   PWqQkmK2M7/F4VIeSpGNGrIZVZ9WLQpXDIi+3bwDayEcjwW/ao8i8GNCt
   gQtJWoDV55w1CuOEBk7z8QRrfX9B6d9FM2cZQKykGu8fv054VyPrw4HPQ
   QgGkPFZ26RdDYFiGgV737hCxVWQNNW1dqx4u03h8zIbePKkE3aGnbGDFt
   w==;
IronPort-SDR: q+jhQewa8qJAxgiDhFw9cFzTPH24rX41Mp5Z8DWVCt0uY6KzcqrXUgjz3Rw5dre9G1gtz0dhi9
 pyOkss/Pq67TOfzvuU3YvEtyWfZp6aSg+XDU8utzSOp5BCP1bu+RkfYksxIZiNaaKbqQLn8S2u
 dH6KGvIrldDt4U3NlESsnrMRYfdyDGQUcTHWKfly1CLZMXZbywiwVO/zqGxrRvLQI9qycC+ycJ
 y5wzThmTbQPszamGbmBR+pI2oXvZCxm0G7Qn+KcC2ES9iF5UYG5mgOs6q/l7jMNh8pXzTeRZng
 QX8JKkEGNxVQsWhidBpKbki9
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="129673906"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:06:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:06:50 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:06:48 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 02/17] clk: at91: pmc: execute suspend/resume only for backup mode
Date:   Fri, 17 Sep 2021 15:06:27 +0300
Message-ID: <20210917120642.8993-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210917120642.8993-1-claudiu.beznea@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
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
modes. Also this commit changed the postcore_initcall() with
subsys_initcall() to be able to execute of_find_compatible_node() since
this was not available at the moment of postcore_initcall(). This should
not alter the tcb_clksrc since the changes are related to clocks
suspend/resume procedure that will be executed at the user space request,
thus long ago after subsys_initcall().

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/pmc.c | 49 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index b2806946a77a..58e9c088cb22 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -8,6 +8,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -110,13 +112,35 @@ struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
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
+	backup = *(unsigned int *)at91_pmc_backup_suspend;
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
+	backup = *(unsigned int *)at91_pmc_backup_suspend;
+	if (!backup)
+		return;
+
 	clk_restore_context();
 }
 
@@ -132,6 +156,7 @@ static const struct of_device_id sama5d2_pmc_dt_ids[] = {
 
 static int __init pmc_register_ops(void)
 {
+	struct platform_device *pdev;
 	struct device_node *np;
 
 	np = of_find_matching_node(NULL, sama5d2_pmc_dt_ids);
@@ -144,10 +169,30 @@ static int __init pmc_register_ops(void)
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
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return -ENODEV;
+
+	at91_pmc_backup_suspend = of_iomap(np, 0);
+	if (!at91_pmc_backup_suspend) {
+		pr_warn("%s(): unable to map securam\n", __func__);
+		return -ENOMEM;
+	}
+
 	register_syscore_ops(&pmc_syscore_ops);
 
 	return 0;
 }
-/* This has to happen before arch_initcall because of the tcb_clksrc driver */
-postcore_initcall(pmc_register_ops);
+
+subsys_initcall(pmc_register_ops);
 #endif
-- 
2.25.1


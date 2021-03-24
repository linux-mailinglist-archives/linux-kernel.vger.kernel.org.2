Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D5A3474F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhCXJo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:44:59 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:2528 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhCXJo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1616579066; x=1648115066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EL+7YZiuBOEuw3rdP+GGFj0w1dSQCtzlJBMqg/Kiiro=;
  b=OayBMEyKdZZ3P1eI7YJuUtXNNFvpHUrwiE4u1+aP1PIVc/dyEpziRFjE
   ZMy5aRNgq0VobBwn+nAgzbEXxIE8lNwreTLAkuFYHJCjFzX5IpwBUCown
   AnFZIdzduTrItvIRtEzNboD4D2qRD5b+0ZdtYYKa79mY4rT1F56bY0toq
   OQ2qUNXvVRGXMiatn7NIokIpZo9wl1jDar417AnLup83Ayxeb03ksqy5H
   shZABO9aF2erRn1p/lMC4tBBgrR0IDiOPzT66z1m3GHOBR1xGhumtZ1/I
   U53qrKYu9B5IikmJ4tOnmDaRz7+opj87G1RQhqvwowV5pkdda0AOJ5O9f
   Q==;
IronPort-SDR: MLiPjfzeiL9oGBqIT0jCTt08RrcsBAOejhIc5oKB67mv0gCo0qKXO0Y2DfIa27q7Zw1pKMxdrA
 KkiwjQwXymLDeYfZwHYvHhxYi3TbllW1QzTtidQIomc5/LxZtiu4TCsG3O9YjWf0xhjalVon3L
 mGGAohs2hw9U8yhkDHoOIi9PQQV7bk45AdL2/6KPkEmFJDvyLCHapNy0+XRN6HnVRDdOMgg9jA
 tbm4cj5j7ZNXkNQiFMHoFgwd0TfPR5aSJ5vZjNNsZanBMhj0BkqFih+0exn673u3yuOBZ4AcPv
 E/0=
X-IronPort-AV: E=Sophos;i="5.81,274,1610434800"; 
   d="scan'208";a="48679574"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2021 02:44:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 02:44:25 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 24 Mar 2021 02:44:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RESEND PATCH 2/5] clk: at91: pmc: execute suspend/resume only for backup mode
Date:   Wed, 24 Mar 2021 11:43:50 +0200
Message-ID: <20210324094353.1710114-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210324094353.1710114-1-claudiu.beznea@microchip.com>
References: <20210324094353.1710114-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before going to backup mode architecture specific PM code sets the first
word in securam (and it will be cleared in a subsequent commit for the rest
of power saving modes). Thus take this into account when
suspending/resuming clocks. This will avoid executing unnecessary
instructions when suspending to non backup modes. Since the clear of the
1st word in securam will be done in a subsequent commit the current commit
will not broke the current behavior since up to this moment the
suspend/resume were executed for all AT91 PM modes. The difference now
is that the suspend/resume for clocks will be executed for the rest of
AT91 PM modes just after the 1st enter/exit to/from backup mode.
Also this commit changed the postcore_initcall() with subsys_initcall()
to be able to execute of_find_compatible_node() since this was not
available at the moment of postcore_initcall(). This should not alter
the tcb_clksrc since the changes are related to clocks suspend/resume
procedure that will be executed at the user space request, thus long
ago after postcore_initcall().

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/pmc.c | 48 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 77b57c9f5dcb..c226d33cd899 100644
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
 
@@ -125,24 +149,30 @@ static struct syscore_ops pmc_syscore_ops = {
 	.resume = at91_pmc_resume,
 };
 
-static const struct of_device_id sama5d2_pmc_dt_ids[] = {
-	{ .compatible = "atmel,sama5d2-pmc" },
-	{ /* sentinel */ }
-};
-
 static int __init pmc_register_ops(void)
 {
+	struct platform_device *pdev;
 	struct device_node *np;
 
-	np = of_find_matching_node(NULL, sama5d2_pmc_dt_ids);
+	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
 	if (!np)
-		return 0;
+		return -ENODEV;
+
+	pdev = of_find_device_by_node(np);
 	of_node_put(np);
+	if (!pdev)
+		return -ENODEV;
+
+	at91_pmc_backup_suspend = of_iomap(np, 0);
+	if (!at91_pmc_backup_suspend) {
+		pr_warn("%s(): unable to map securam\n", __func__);
+		return -ENOMEM;
+	}
 
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


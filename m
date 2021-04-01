Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB94351CB0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhDASU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:20:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:44187 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbhDASCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617300145; x=1648836145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EL+7YZiuBOEuw3rdP+GGFj0w1dSQCtzlJBMqg/Kiiro=;
  b=udDyEwGiPPzesl4hguwiRXbgj3NRdTLU9fi/gRJ23p0YL7MbM5GJUYeu
   sFgP+WWsVoY2DXzw6+YFYftyyyn4Z9BURGVUE12JWntqjEclVTwmOAQWQ
   JBAMBtVdulad3impogjQJc0jTvgd9816JiG0QHPj9hzKgNL0ZEHgZe9P4
   HZWitJcjaXLgWtzI2hsEhiudAG095ny7oCA0PayYNTC2+vCii9hQDTULn
   rZ8NpcmAcaufwLv1ylMLCTCNyOerzuTK+mDjgdNG8eAO37r05p5CFExyo
   RmWzppHEraTgOMQH/ClLc6JpcUSZgVjfynBRe6NgXlA7a91ZUvEm5PoZs
   w==;
IronPort-SDR: hHkWY4BKPIUX8hGGjxe0M9lB/iROJacgnyGWWc6eoxil6K0Cnd6GMAAuTWBXGBOszJqdp29BKg
 YjSMQU4px+sg9xR+Ik1+F5JFEKOCoJQ0hPXJ5eQfqomg9jJz8hp3alwve1hXWCNu/yio9BhaZd
 xLX329ryODf6b/nsU0PrWa5JNihJCaaTFqmV4oeY49ZiJw3fi9gx64F5TRaEGhw6UhgUNsaYoO
 e4G/puTlNM67RxM7LYBInBmeYprWFxZlv0wfP6UzYTl9jnJeqhCfq9rCJsB3nZ2MQHz9L0qoHX
 Z7g=
X-IronPort-AV: E=Sophos;i="5.81,296,1610434800"; 
   d="scan'208";a="112137114"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2021 05:27:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 05:27:36 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 1 Apr 2021 05:27:34 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <viresh.kumar@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/6] clk: at91: pmc: execute suspend/resume only for backup mode
Date:   Thu, 1 Apr 2021 15:27:22 +0300
Message-ID: <20210401122726.28528-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210401122726.28528-1-claudiu.beznea@microchip.com>
References: <20210401122726.28528-1-claudiu.beznea@microchip.com>
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


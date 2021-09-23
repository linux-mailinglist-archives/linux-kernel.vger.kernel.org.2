Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7D3415F71
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241279AbhIWNW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:22:59 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:64381 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241290AbhIWNWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632403277; x=1663939277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PAlQz9ImFlO7qIwbUzAgmC9YSfeXGWfelq6OxBy//Dk=;
  b=DJhos12kOwh3BBz8J/d1kaK31SOacmkY4+4CV9Hr7I4jo81VO1ZTKQgs
   wVvSIb9KBoDtIu++c5sW0KddPAXDgJ2sLsUAgASsTLaLeE3Nu+Z7fcD1B
   tEKKdBs0Cd+vHZc/FZoLRDO1ELDkuUg47RFZAA1gBT2/tOojEziETXevQ
   PS07fTsnhpdoHR2tw0h8hfplrauBqrU9L36F5gphBiY5FbhI/KCtuHOhF
   Xg414nkqHjoubbyQULmwqiBJbCrLBafInRlAsap0pN9HW46frz9pJtsuj
   fbU2ItF6TWukDCvVZdSb0dR835O7R4QL1kcNGGLlYeWZlc9V8HEKwD/nd
   g==;
IronPort-SDR: rm2OP2I2Lx90qkPM0vKcdrIxUO2QnHbPF+EpCo5yI7lEcC/dq051Pq57A57vkFWsBsT/K22Jx+
 7mz13tEJJNO1zCAwSCJP7K71z0azuQexDvbMp6+FdMHQvlpDB4vPq94kmQwMMbr6jcq63Vyk+p
 89bqwz9TcLRsEd+E9H32gEy8wokeRfw42MnFYQWl+fyoIHXlr9E8KSv2GGohCn+IhDpRy0m2J/
 4ueFo5s0D+D/A5dx3qQHLlSTz7D3qi/w45jQEw6zTkhW+rL0sHJ5FwMwIU6E3/hBeCzraMISsW
 TmEZHT5a2jbli769VovjFiuI
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="145305432"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 06:21:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 06:21:16 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Sep 2021 06:21:14 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 06/17] clk: at91: pmc: add sama7g5 to the list of available pmcs
Date:   Thu, 23 Sep 2021 16:20:35 +0300
Message-ID: <20210923132046.1860549-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SAMA7G5 to the list of available PMCs such that the suspend/resume
code for clocks to be used on backup mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/pmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 58e9c088cb22..2a9636edfe9d 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -149,8 +149,9 @@ static struct syscore_ops pmc_syscore_ops = {
 	.resume = at91_pmc_resume,
 };
 
-static const struct of_device_id sama5d2_pmc_dt_ids[] = {
+static const struct of_device_id pmc_dt_ids[] = {
 	{ .compatible = "atmel,sama5d2-pmc" },
+	{ .compatible = "microchip,sama7g5-pmc", },
 	{ /* sentinel */ }
 };
 
@@ -159,7 +160,7 @@ static int __init pmc_register_ops(void)
 	struct platform_device *pdev;
 	struct device_node *np;
 
-	np = of_find_matching_node(NULL, sama5d2_pmc_dt_ids);
+	np = of_find_matching_node(NULL, pmc_dt_ids);
 	if (!np)
 		return -ENODEV;
 
-- 
2.25.1


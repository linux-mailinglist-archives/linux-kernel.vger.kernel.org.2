Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5D040F729
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243679AbhIQMIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:08:30 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:65117 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243748AbhIQMIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880423; x=1663416423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PAlQz9ImFlO7qIwbUzAgmC9YSfeXGWfelq6OxBy//Dk=;
  b=uhE3vPNngvS4rl7/6HdNxSba9woRUOFkW9lyPRX6/Slrz3YSYG/qKXjQ
   btpUNvOGtYf4p1Thf0ZBvUlg9TXo26tjjpJCRHkofVPpLGri8L4wX184J
   jhYeieH+aD6Jp721acvhYqjPDLlouhGPIoPHjc+cfL4K+cg3WffZxebqd
   IGox02fbQ9EhMM+cwB6ECZC/yeypBgI+Di0iDLWGf3o/Von2UUBGIlxYq
   xCbuFOUfO4ZHiOTVK/U5BOf0TDOXgK0A11r6bxCzVDioECwWZtPdf9VuP
   3GRxLqDLb+UU6j+MbNGODO2zaojAUEdu+2bslSfK29F+hSQQA91dYdSoM
   A==;
IronPort-SDR: OfW4gaP0yYZgnYd2lbt6AVqaR39Cx2gppz92G3HhE/Vjdgpd1cPCUTXCtJQFV4iES3nu/UVnPF
 tJNUr9wJHofktGcYKZwDYIDyqv2Dopg4L8KRNdtppZVHZ/5m4ARyryus/lQrx0PGPoURhJY1jC
 Mi3rDhheMqFiWdw+tl35/azWcy4hfb2BJz7OYO/ZieoXFUBE+voD6qWj5fnrBSjk4y1YgktC43
 e75D649p/Nqdc2xlhu5Gx0CpIZ4EFe4zbipCQY1fOXg/NPoHBsT+v8FWy3wAtyBNSaeEfFf1k6
 t3I1vFoKiZL7Nmn3EHvQnj8m
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="144535323"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:07:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:07:00 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:06:58 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 06/17] clk: at91: pmc: add sama7g5 to the list of available pmcs
Date:   Fri, 17 Sep 2021 15:06:31 +0300
Message-ID: <20210917120642.8993-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210917120642.8993-1-claudiu.beznea@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
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


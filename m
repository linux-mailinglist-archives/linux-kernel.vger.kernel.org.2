Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C0F40F721
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243578AbhIQMIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:08:18 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25398 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243487AbhIQMIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880413; x=1663416413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gm3Yx6VC8RmsDdjJLQsenFpWH675vHotkTTgQqR0D20=;
  b=KgJJPUQF9P/uzcRoId6z+zrShYt/0Wrb6hVmD+pTfE/f6137+XClc2pM
   4wZBBj5PW+7qMQeCL0cVH9qngYvsCbfZiIr8EPOTcH8K1vbBKkLTvT97r
   kKkIaSTQ2BUqPV6/8eBA8DwnR4xzM8rmc9Ykyjiyewpq36c+6n7AwGQQ4
   KiCVIGL+Y0GuK4/ZkhbioBAGFiu9SE7svWTsfAyLw4anS0ZukAzfZj0JQ
   SHwK4YF26VhsipkIUcCYu7M72ZGYx+YOCpunm41Y1x6trBtC5bYmBY360
   Po5NYdqVJRDK4RN2rxhidZBgl6p9NAOs8B8pZzjcEpSTHnfqP5S9QP0YY
   A==;
IronPort-SDR: VpIaYiI1sKpgvXh/+aFYcdQizlnOrFvx6+GW4xRNIEY/qrL4fb8fGzbJzm5XVHhYmhzzdbnExe
 4lO8qvk6E0uqG5IJkD5zFZoXyiYAvmlE3sj9Ryp9rk8HFFe1w7qvZ2uPsDoPrz1Fp6z/sv1YTZ
 qr/FGcrlPvun0X1f5xnwm57tOhlnWoRooSdzVsJPMBHTs5RE6pkcSs5+lfrKKp7jVoYY5t7Xrd
 WY8HagDy0ZkHkA3oOgFK/JAu2Y0gN93v6LspaHg6M435hS3iarGo9zIqR0yP+DLK8DWyYa6u5q
 uBkjNpd1VHrMNVEpNleHFf85
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="129673919"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:06:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:06:53 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:06:51 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 03/17] clk: at91: sama7g5: add securam's peripheral clock
Date:   Fri, 17 Sep 2021 15:06:28 +0300
Message-ID: <20210917120642.8993-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210917120642.8993-1-claudiu.beznea@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SECURAM's peripheral clock.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index cf8c079aa086..970135e19a75 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -377,6 +377,7 @@ static const struct {
 	u8 id;
 } sama7g5_periphck[] = {
 	{ .n = "pioA_clk",	.p = "mck0", .id = 11, },
+	{ .n = "securam_clk",	.p = "mck0", .id = 18, },
 	{ .n = "sfr_clk",	.p = "mck1", .id = 19, },
 	{ .n = "hsmc_clk",	.p = "mck1", .id = 21, },
 	{ .n = "xdmac0_clk",	.p = "mck1", .id = 22, },
-- 
2.25.1


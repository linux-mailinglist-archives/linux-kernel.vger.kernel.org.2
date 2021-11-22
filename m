Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7D745961B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 21:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhKVUg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 15:36:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:37946 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233434AbhKVUgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 15:36:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="234823166"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="234823166"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 12:32:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="649573938"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2021 12:32:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 70ED2B8; Mon, 22 Nov 2021 22:32:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 1/1] ARM: pxa/lubbock: Replace custom ->cs_control() by GPIO lookup table
Date:   Mon, 22 Nov 2021 22:32:47 +0200
Message-Id: <20211122203247.11665-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI PXA2xx driver supports GPIO chipselect by querying for known
GPIO connection ID. Replace custom ->cs_control() by GPIO table,
so the driver will use generic approach on this platform.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/arm/mach-pxa/lubbock.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 742d18a1f7dc..e2411971422d 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -211,16 +211,17 @@ static struct ads7846_platform_data ads_info = {
 	// .y_plate_ohms		= 500,	/* GUESS! */
 };
 
-static void ads7846_cs(u32 command)
-{
-	static const unsigned	TS_nCS = 1 << 11;
-	lubbock_set_misc_wr(TS_nCS, (command == PXA2XX_CS_ASSERT) ? 0 : TS_nCS);
-}
+static struct gpiod_lookup_table ads7846_cs_gpios = {
+	.dev_id		= "ads7846",
+	.table		= {
+		GPIO_LOOKUP("lubbock", 11, "cs", GPIO_ACTIVE_LOW),
+		{}
+	},
+};
 
 static struct pxa2xx_spi_chip ads_hw = {
 	.tx_threshold		= 1,
 	.rx_threshold		= 2,
-	.cs_control		= ads7846_cs,
 };
 
 static struct spi_board_info spi_board_info[] __initdata = { {
@@ -512,6 +513,8 @@ static void __init lubbock_init(void)
 	lubbock_flash_data[flashboot].name = "boot-rom";
 	(void) platform_add_devices(devices, ARRAY_SIZE(devices));
 
+	gpiod_add_lookup_table(&ads7846_cs_gpios);
+
 	pxa2xx_set_spi_info(1, &pxa_ssp_master_info);
 	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
 }
-- 
2.33.0


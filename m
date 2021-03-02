Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBEB32A7B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579121AbhCBQ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:28:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:29294 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1572965AbhCBOIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:08:11 -0500
IronPort-SDR: cfRJwidl7CPEOZ08x3V0pHlWoesGsJBRI2zQzIKy8/o/lVhsgic/M6CsV6wyqUPjq8fQVcYx97
 7DcSQ81wSvHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="184382560"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="184382560"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 05:56:33 -0800
IronPort-SDR: gizoIGjn/UQv/RwAvX07ipTGXRPxk/xhRbS2qPXwXqAQBNR4fYKhFx0j1iiN0Pv3+DHGpiiRMJ
 ++nam2sPwAgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="595799623"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2021 05:56:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4F7291F1; Tue,  2 Mar 2021 15:56:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 4/5] =?UTF-8?q?mfd:=20intel=5Fquark=5Fi2c=5Fgpio:=20Rep?= =?UTF-8?q?lace=20I=C2=B2C=20speeds=20with=20descriptive=20definitions?=
Date:   Tue,  2 Mar 2021 15:56:19 +0200
Message-Id: <20210302135620.89958-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I²C header provides a descriptive definitions for standard bus speeds.
Use them instead of plain numbers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_quark_i2c_gpio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 053780539175..7af22d1399e1 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -16,6 +16,7 @@
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/dmi.h>
+#include <linux/i2c.h>
 #include <linux/platform_data/gpio-dwapb.h>
 #include <linux/platform_data/i2c-designware.h>
 
@@ -54,19 +55,19 @@ static const struct dmi_system_id dmi_platform_info[] = {
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Galileo"),
 		},
-		.driver_data = (void *)100000,
+		.driver_data = (void *)I2C_MAX_STANDARD_MODE_FREQ,
 	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GalileoGen2"),
 		},
-		.driver_data = (void *)400000,
+		.driver_data = (void *)I2C_MAX_FAST_MODE_FREQ,
 	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
 		},
-		.driver_data = (void *)400000,
+		.driver_data = (void *)I2C_MAX_FAST_MODE_FREQ,
 	},
 	{}
 };
@@ -176,7 +177,7 @@ static int intel_quark_i2c_setup(struct pci_dev *pdev, struct mfd_cell *cell)
 		return -ENOMEM;
 
 	/* Normal mode by default */
-	pdata->i2c_scl_freq = 100000;
+	pdata->i2c_scl_freq = I2C_MAX_STANDARD_MODE_FREQ;
 
 	dmi_id = dmi_first_match(dmi_platform_info);
 	if (dmi_id)
-- 
2.30.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFE831C9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBPLiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:38:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:47562 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhBPLg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:36:59 -0500
IronPort-SDR: CfD9P6anjMsIcntD2s4r8U5AzJWO4AEQzNZknK493gUFgvCOwGsnUdMoUKeTEW52yKlSCZaScz
 2Jaf/FWHDeMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="180301355"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="180301355"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 03:32:52 -0800
IronPort-SDR: U/ToGnTKz/FAToqhTmTNsa7nXGWKxJwdObta39HiZqe9JM58DyGh91nC1jjBHhzMym7ibrNHeC
 yRkl8sBYhcyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="364084818"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2021 03:32:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9004935E; Tue, 16 Feb 2021 13:32:50 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>
Subject: [PATCH v1 5/7] pps: clients: gpio: Make use of device properties
Date:   Tue, 16 Feb 2021 13:31:52 +0200
Message-Id: <20210216113154.70852-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
References: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device property API allows to gather device resources from different sources,
such as ACPI. Convert the drivers to unleash the power of device property API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pps/clients/pps-gpio.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 291240dce79e..c6db3a3b257b 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -12,14 +12,14 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/pps_kernel.h>
 #include <linux/gpio/consumer.h>
 #include <linux/list.h>
-#include <linux/of_device.h>
-#include <linux/of_gpio.h>
+#include <linux/property.h>
 #include <linux/timer.h>
 #include <linux/jiffies.h>
 
@@ -102,7 +102,6 @@ static void pps_gpio_echo_timer_callback(struct timer_list *t)
 static int pps_gpio_setup(struct platform_device *pdev)
 {
 	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
-	struct device_node *np = pdev->dev.of_node;
 	int ret;
 	u32 value;
 
@@ -121,26 +120,24 @@ static int pps_gpio_setup(struct platform_device *pdev)
 				     "failed to request ECHO GPIO\n");
 
 	if (data->echo_pin) {
-		ret = of_property_read_u32(np,
-			"echo-active-ms",
-			&value);
+		ret = device_property_read_u32(&pdev->dev, "echo-active-ms", &value);
 		if (ret) {
 			dev_err(&pdev->dev,
-				"failed to get echo-active-ms from OF\n");
+				"failed to get echo-active-ms from FW\n");
 			return ret;
 		}
 		data->echo_active_ms = value;
 		/* sanity check on echo_active_ms */
 		if (!data->echo_active_ms || data->echo_active_ms > 999) {
 			dev_err(&pdev->dev,
-				"echo-active-ms: %u - bad value from OF\n",
+				"echo-active-ms: %u - bad value from FW\n",
 				data->echo_active_ms);
 			return -EINVAL;
 		}
 	}
 
-	if (of_property_read_bool(np, "assert-falling-edge"))
-		data->assert_falling_edge = true;
+	data->assert_falling_edge =
+		device_property_read_bool(&pdev->dev, "assert-falling-edge");
 	return 0;
 }
 
-- 
2.30.0


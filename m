Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657D6340649
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhCRNEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:04:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:18150 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231379AbhCRNDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:03:43 -0400
IronPort-SDR: fu+ZB6wl2KkPEYdZ7cJ3tM9Mrq7GMwN7qPRCzlvnuDnzhDutfo0hYvsk31B1ZI130Tl3Hvjskw
 sA/+Ukgs0RaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="186317455"
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="186317455"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 06:03:28 -0700
IronPort-SDR: 4fKqNGtGgY789cO1+389ytGiKZrkeV+fwYL9bY3QF14djZylajHR166AJZNCtLfpYfqJJp/2nT
 myXEmy4BTL3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="450473564"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 18 Mar 2021 06:03:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AE0D1368; Thu, 18 Mar 2021 15:03:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 5/7] pps: clients: gpio: Make use of device properties
Date:   Thu, 18 Mar 2021 15:03:19 +0200
Message-Id: <20210318130321.24227-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318130321.24227-1-andriy.shevchenko@linux.intel.com>
References: <20210318130321.24227-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device property API allows to gather device resources from different sources,
such as ACPI. Convert the drivers to unleash the power of device property API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
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
2.30.2


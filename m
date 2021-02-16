Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8600431C9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhBPLhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:37:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:35905 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhBPLfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:35:04 -0500
IronPort-SDR: bs2q6x/lkitc1AkzQ8UvGJyqBFMmcUMEGQGEy/b6se9ygTYXvPrgmamxkYmG984JSzZ9dlBib/
 wdwnzsNdTzUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="182935743"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="182935743"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 03:32:54 -0800
IronPort-SDR: 0BcPsYWPsnBlisjqmwnIilbjkGBGK9SOZX/nTJhTjQNrOOV2pxUf3kp9Wtr4vti3jFvNfME+ZE
 WxnNu7RyjwmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="377527440"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Feb 2021 03:32:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9A947220; Tue, 16 Feb 2021 13:32:50 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>
Subject: [PATCH v1 6/7] pps: clients: gpio: Use struct device pointer directly
Date:   Tue, 16 Feb 2021 13:31:53 +0200
Message-Id: <20210216113154.70852-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
References: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most parts of the code the platform device is not used.
Use struct device pointer directly to reduce code size and
increase readability.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pps/clients/pps-gpio.c | 42 +++++++++++++++-------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index c6db3a3b257b..b097da5a659a 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -99,45 +99,39 @@ static void pps_gpio_echo_timer_callback(struct timer_list *t)
 	gpiod_set_value(info->echo_pin, 0);
 }
 
-static int pps_gpio_setup(struct platform_device *pdev)
+static int pps_gpio_setup(struct device *dev)
 {
-	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
+	struct pps_gpio_device_data *data = dev_get_drvdata(dev);
 	int ret;
 	u32 value;
 
-	data->gpio_pin = devm_gpiod_get(&pdev->dev,
-		NULL,	/* request "gpios" */
-		GPIOD_IN);
+	data->gpio_pin = devm_gpiod_get(dev, NULL, GPIOD_IN);
 	if (IS_ERR(data->gpio_pin))
-		return dev_err_probe(&pdev->dev, PTR_ERR(data->gpio_pin),
+		return dev_err_probe(dev, PTR_ERR(data->gpio_pin),
 				     "failed to request PPS GPIO\n");
 
-	data->echo_pin = devm_gpiod_get_optional(&pdev->dev,
-			"echo",
-			GPIOD_OUT_LOW);
+	data->echo_pin = devm_gpiod_get_optional(dev, "echo", GPIOD_OUT_LOW);
 	if (IS_ERR(data->echo_pin))
-		return dev_err_probe(&pdev->dev, PTR_ERR(data->echo_pin),
+		return dev_err_probe(dev, PTR_ERR(data->echo_pin),
 				     "failed to request ECHO GPIO\n");
 
 	if (data->echo_pin) {
-		ret = device_property_read_u32(&pdev->dev, "echo-active-ms", &value);
+		ret = device_property_read_u32(dev, "echo-active-ms", &value);
 		if (ret) {
-			dev_err(&pdev->dev,
-				"failed to get echo-active-ms from FW\n");
+			dev_err(dev, "failed to get echo-active-ms from FW\n");
 			return ret;
 		}
 		data->echo_active_ms = value;
 		/* sanity check on echo_active_ms */
 		if (!data->echo_active_ms || data->echo_active_ms > 999) {
-			dev_err(&pdev->dev,
-				"echo-active-ms: %u - bad value from FW\n",
+			dev_err(dev, "echo-active-ms: %u - bad value from FW\n",
 				data->echo_active_ms);
 			return -EINVAL;
 		}
 	}
 
 	data->assert_falling_edge =
-		device_property_read_bool(&pdev->dev, "assert-falling-edge");
+		device_property_read_bool(dev, "assert-falling-edge");
 	return 0;
 }
 
@@ -158,24 +152,26 @@ get_irqf_trigger_flags(const struct pps_gpio_device_data *data)
 static int pps_gpio_probe(struct platform_device *pdev)
 {
 	struct pps_gpio_device_data *data;
+	struct device *dev = &pdev->dev;
 	int ret;
 	int pps_default_params;
 
 	/* allocate space for device info */
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-	platform_set_drvdata(pdev, data);
+
+	dev_set_drvdata(dev, data);
 
 	/* GPIO setup */
-	ret = pps_gpio_setup(pdev);
+	ret = pps_gpio_setup(dev);
 	if (ret)
 		return -EINVAL;
 
 	/* IRQ setup */
 	ret = gpiod_to_irq(data->gpio_pin);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to map GPIO to IRQ: %d\n", ret);
+		dev_err(dev, "failed to map GPIO to IRQ: %d\n", ret);
 		return -EINVAL;
 	}
 	data->irq = ret;
@@ -201,17 +197,17 @@ static int pps_gpio_probe(struct platform_device *pdev)
 		pps_default_params |= PPS_CAPTURECLEAR | PPS_OFFSETCLEAR;
 	data->pps = pps_register_source(&data->info, pps_default_params);
 	if (IS_ERR(data->pps)) {
-		dev_err(&pdev->dev, "failed to register IRQ %d as PPS source\n",
+		dev_err(dev, "failed to register IRQ %d as PPS source\n",
 			data->irq);
 		return PTR_ERR(data->pps);
 	}
 
 	/* register IRQ interrupt handler */
-	ret = devm_request_irq(&pdev->dev, data->irq, pps_gpio_irq_handler,
+	ret = devm_request_irq(dev, data->irq, pps_gpio_irq_handler,
 			get_irqf_trigger_flags(data), data->info.name, data);
 	if (ret) {
 		pps_unregister_source(data->pps);
-		dev_err(&pdev->dev, "failed to acquire IRQ %d\n", data->irq);
+		dev_err(dev, "failed to acquire IRQ %d\n", data->irq);
 		return -EINVAL;
 	}
 
-- 
2.30.0


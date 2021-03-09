Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D7B3323E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhCILYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:24:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:51214 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhCILYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:24:22 -0500
IronPort-SDR: efmk/ff4BK4aslMCYjfPlhFPg0GDCZSdAkOBPy3u/hRkZbw501OxhTFmnT6Npu/d+aedQ7LtRA
 4Fnio8mrZQvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="168123110"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="168123110"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 03:24:20 -0800
IronPort-SDR: lUf7+Y9RLzYmA/19wzoLeV8blIQZjOfvCvAi76N3KClxXZSWxDVGT2ffL0aduGfseEELE2eYtf
 UAcN7of1ggVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="371509124"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 09 Mar 2021 03:24:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 836CC565; Tue,  9 Mar 2021 13:24:18 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH resend v1 4/7] pps: clients: gpio: Get rid of legacy platform data
Date:   Tue,  9 Mar 2021 13:24:00 +0200
Message-Id: <20210309112403.36633-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
References: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform data is a legacy interface to supply device properties
to the driver. In this case we even don't have in-kernel users
for it. Just remove it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pps/clients/pps-gpio.c | 17 +++--------------
 include/linux/pps-gpio.h       | 19 -------------------
 2 files changed, 3 insertions(+), 33 deletions(-)
 delete mode 100644 include/linux/pps-gpio.h

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index dc9ed6fc3dae..291240dce79e 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -16,7 +16,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/pps_kernel.h>
-#include <linux/pps-gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/list.h>
 #include <linux/of_device.h>
@@ -164,7 +163,6 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	struct pps_gpio_device_data *data;
 	int ret;
 	int pps_default_params;
-	const struct pps_gpio_platform_data *pdata = pdev->dev.platform_data;
 
 	/* allocate space for device info */
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -173,18 +171,9 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 
 	/* GPIO setup */
-	if (pdata) {
-		data->gpio_pin = pdata->gpio_pin;
-		data->echo_pin = pdata->echo_pin;
-
-		data->assert_falling_edge = pdata->assert_falling_edge;
-		data->capture_clear = pdata->capture_clear;
-		data->echo_active_ms = pdata->echo_active_ms;
-	} else {
-		ret = pps_gpio_setup(pdev);
-		if (ret)
-			return -EINVAL;
-	}
+	ret = pps_gpio_setup(pdev);
+	if (ret)
+		return -EINVAL;
 
 	/* IRQ setup */
 	ret = gpiod_to_irq(data->gpio_pin);
diff --git a/include/linux/pps-gpio.h b/include/linux/pps-gpio.h
deleted file mode 100644
index 7bf49908be06..000000000000
--- a/include/linux/pps-gpio.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * pps-gpio.h -- PPS client for GPIOs
- *
- * Copyright (C) 2011 James Nuss <jamesnuss@nanometrics.ca>
- */
-
-#ifndef _PPS_GPIO_H
-#define _PPS_GPIO_H
-
-struct pps_gpio_platform_data {
-	struct gpio_desc *gpio_pin;
-	struct gpio_desc *echo_pin;
-	bool assert_falling_edge;
-	bool capture_clear;
-	unsigned int echo_active_ms;
-};
-
-#endif /* _PPS_GPIO_H */
-- 
2.30.1


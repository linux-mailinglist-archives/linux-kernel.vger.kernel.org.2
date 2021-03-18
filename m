Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AD6340644
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhCRNEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:04:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:29493 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231354AbhCRND0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:03:26 -0400
IronPort-SDR: vdkOE6Ww0iT2LGuCLIodLCo0XtHYT1IdNRiYTMdoioOaRwnVKRzYFZ2qzjPAD9pIs9HfXL0CXE
 6DP5Bmj0oqPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="274730701"
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="274730701"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 06:03:25 -0700
IronPort-SDR: c/81zatrRYlWPCsLDPBHnPiFe9xVGdaCy01Cd1v/X2Iunydr6+uNIeihDoWTaFQA32hjgWOtoT
 W+hfBzUs0ZBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="512109855"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2021 06:03:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A29C62A7; Thu, 18 Mar 2021 15:03:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 4/7] pps: clients: gpio: Get rid of legacy platform data
Date:   Thu, 18 Mar 2021 15:03:18 +0200
Message-Id: <20210318130321.24227-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318130321.24227-1-andriy.shevchenko@linux.intel.com>
References: <20210318130321.24227-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform data is a legacy interface to supply device properties
to the driver. In this case we even don't have in-kernel users
for it. Just remove it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
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
2.30.2


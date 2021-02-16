Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74F31C9E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhBPLgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:36:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:35903 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhBPLfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:35:00 -0500
IronPort-SDR: O5/35aOm3g49vi6Uk9OCuLd0WiNlnapRoCShyqR1usTOhob+AHoW1QNBtxHQTARIpZpYfIIeVx
 chCtOh3m+Cyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="182935741"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="182935741"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 03:32:52 -0800
IronPort-SDR: eqQefngKuE+j7MRjDfb3qiF2K9g+1TmBpTd73QYZU42K3HXy5MA8yj5/8NB17bInzZ/OQMVZDJ
 JjLC/Ap1+dtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="377527431"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Feb 2021 03:32:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8494635A; Tue, 16 Feb 2021 13:32:50 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>
Subject: [PATCH v1 4/7] pps: clients: gpio: Get rid of legacy platform data
Date:   Tue, 16 Feb 2021 13:31:51 +0200
Message-Id: <20210216113154.70852-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
References: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
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
2.30.0


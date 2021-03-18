Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8DC340646
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhCRNEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:04:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:20821 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCRND2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:03:28 -0400
IronPort-SDR: MLi83ODdwKkJha9ZulAZP+lwhJEPej/oXbP6po4J0U8Il4DanexgfvmHGg2q14Lggcbehda2w/
 Pc9A9byfQLUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="168957186"
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="168957186"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 06:03:25 -0700
IronPort-SDR: MVUWFJ9Hnkdm1YZOtbGAZiJcN6LqNY4o3/H98QD3ErJNFoRVf8dLx8jMoCCU8lrSo5QJWirrwC
 F6blOD0tFVKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="379742884"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 18 Mar 2021 06:03:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8C9C211C; Thu, 18 Mar 2021 15:03:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/7] pps: clients: gpio: Use dev_err_probe() to avoid log noise
Date:   Thu, 18 Mar 2021 15:03:16 +0200
Message-Id: <20210318130321.24227-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318130321.24227-1-andriy.shevchenko@linux.intel.com>
References: <20210318130321.24227-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When GPIO APIs return -EPROBE_DEFER there is no need to print the message,
especially taking into consideration that it may repeat several times.
Use dev_err_probe() to avoid log noise in such cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
---
 drivers/pps/clients/pps-gpio.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index f89c31aa66f1..78c9680e8063 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -110,19 +110,16 @@ static int pps_gpio_setup(struct platform_device *pdev)
 	data->gpio_pin = devm_gpiod_get(&pdev->dev,
 		NULL,	/* request "gpios" */
 		GPIOD_IN);
-	if (IS_ERR(data->gpio_pin)) {
-		dev_err(&pdev->dev,
-			"failed to request PPS GPIO\n");
-		return PTR_ERR(data->gpio_pin);
-	}
+	if (IS_ERR(data->gpio_pin))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->gpio_pin),
+				     "failed to request PPS GPIO\n");
 
 	data->echo_pin = devm_gpiod_get_optional(&pdev->dev,
 			"echo",
 			GPIOD_OUT_LOW);
-	if (IS_ERR(data->echo_pin)) {
-		dev_err(&pdev->dev, "failed to request ECHO GPIO\n");
-		return PTR_ERR(data->echo_pin);
-	}
+	if (IS_ERR(data->echo_pin))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->echo_pin),
+				     "failed to request ECHO GPIO\n");
 
 	if (data->echo_pin) {
 		ret = of_property_read_u32(np,
-- 
2.30.2


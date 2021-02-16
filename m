Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2352431C9E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBPLiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:38:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:9704 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhBPLhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:37:10 -0500
IronPort-SDR: hHmJ6RjeisE0RuJGJBMCQA1kzYdJt0kCNNv6Fx2FRPa5D1FJvIg+bSgvNs6wDMo/lBuowrJULB
 p8ZRZicC3+vA==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="169994422"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="169994422"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 03:32:53 -0800
IronPort-SDR: HFFJug/zogBZE9V6b9pfwVlZnqIZTKAZFij5Xiq6P/w1UsWT4l0QVusXE1bUammv8WWv+wIDEw
 BvYBbNAnb/Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="493161365"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Feb 2021 03:32:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5E9F41F1; Tue, 16 Feb 2021 13:32:50 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>
Subject: [PATCH v1 1/7] pps: clients: gpio: Bail out on error when requesting GPIO echo line
Date:   Tue, 16 Feb 2021 13:31:48 +0200
Message-Id: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When requesting optional GPIO echo line, bail out on error,
so user will know that something wrong with the existing property.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pps/clients/pps-gpio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index e0de1df2ede0..f89c31aa66f1 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -119,12 +119,12 @@ static int pps_gpio_setup(struct platform_device *pdev)
 	data->echo_pin = devm_gpiod_get_optional(&pdev->dev,
 			"echo",
 			GPIOD_OUT_LOW);
-	if (data->echo_pin) {
-		if (IS_ERR(data->echo_pin)) {
-			dev_err(&pdev->dev, "failed to request ECHO GPIO\n");
-			return PTR_ERR(data->echo_pin);
-		}
+	if (IS_ERR(data->echo_pin)) {
+		dev_err(&pdev->dev, "failed to request ECHO GPIO\n");
+		return PTR_ERR(data->echo_pin);
+	}
 
+	if (data->echo_pin) {
 		ret = of_property_read_u32(np,
 			"echo-active-ms",
 			&value);
-- 
2.30.0


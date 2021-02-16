Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4A31C9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBPLgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:36:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:47562 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230144AbhBPLeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:34:44 -0500
IronPort-SDR: OqFcnP89RylOvexYY4qCFdOWUYl46IMiYEgHpO9LGKXTWmBVowY+WlQy8PKC3GqNXAPBpmVEaM
 vNGXvRP0OxCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="180301354"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="180301354"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 03:32:52 -0800
IronPort-SDR: Q5q6IwXgrtnwEgUKr595xikf9QikU3neu6k34PkymGtLv5dsLsQnYxRaLAmnkVOFQlIvUfRWqE
 d9dAQ7J2J/sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="366422974"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Feb 2021 03:32:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 65D58169; Tue, 16 Feb 2021 13:32:50 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>
Subject: [PATCH v1 2/7] pps: clients: gpio: Use dev_err_probe() to avoid log noise
Date:   Tue, 16 Feb 2021 13:31:49 +0200
Message-Id: <20210216113154.70852-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
References: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When GPIO APIs return -EPROBE_DEFER there is no need to print the message,
especially taking into consideration that it may repeat several times.
Use dev_err_probe() to avoid log noise in such cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
2.30.0


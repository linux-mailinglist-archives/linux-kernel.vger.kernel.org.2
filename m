Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A27E31C9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhBPLhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:37:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:20158 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhBPLfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:35:01 -0500
IronPort-SDR: FsgT1/laYsCT7dKnnEk7DDkC9ugP0QKctoCfKqu5h4J8F6Gey6XnaqX1rq/WCWQqFaasm6wa1o
 Rcs/QmCJJ5dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="161998062"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="161998062"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 03:32:55 -0800
IronPort-SDR: 5k19Yr/7vlAXkntq8Lmb3za2haWaSEd0pCzg8xpwFmiBXkP2PO2XKxxadV1ldL6XDJFhM/xbv7
 2vhwIQUU6FAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="438886400"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2021 03:32:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A9892525; Tue, 16 Feb 2021 13:32:50 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>
Subject: [PATCH v1 7/7] pps: clients: gpio: Rearrange optional stuff in pps_gpio_setup()
Date:   Tue, 16 Feb 2021 13:31:54 +0200
Message-Id: <20210216113154.70852-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
References: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange optional stuff in pps_gpio_setup() so it will go after mandatory one
and with reduced indentation. This will increase readability of the sources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pps/clients/pps-gpio.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index b097da5a659a..35799e6401c9 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -110,28 +110,31 @@ static int pps_gpio_setup(struct device *dev)
 		return dev_err_probe(dev, PTR_ERR(data->gpio_pin),
 				     "failed to request PPS GPIO\n");
 
+	data->assert_falling_edge =
+		device_property_read_bool(dev, "assert-falling-edge");
+
 	data->echo_pin = devm_gpiod_get_optional(dev, "echo", GPIOD_OUT_LOW);
 	if (IS_ERR(data->echo_pin))
 		return dev_err_probe(dev, PTR_ERR(data->echo_pin),
 				     "failed to request ECHO GPIO\n");
 
-	if (data->echo_pin) {
-		ret = device_property_read_u32(dev, "echo-active-ms", &value);
-		if (ret) {
-			dev_err(dev, "failed to get echo-active-ms from FW\n");
-			return ret;
-		}
-		data->echo_active_ms = value;
-		/* sanity check on echo_active_ms */
-		if (!data->echo_active_ms || data->echo_active_ms > 999) {
-			dev_err(dev, "echo-active-ms: %u - bad value from FW\n",
-				data->echo_active_ms);
-			return -EINVAL;
-		}
+	if (!data->echo_pin)
+		return 0;
+
+	ret = device_property_read_u32(dev, "echo-active-ms", &value);
+	if (ret) {
+		dev_err(dev, "failed to get echo-active-ms from FW\n");
+		return ret;
 	}
 
-	data->assert_falling_edge =
-		device_property_read_bool(dev, "assert-falling-edge");
+	/* sanity check on echo_active_ms */
+	if (!value || value > 999) {
+		dev_err(dev, "echo-active-ms: %u - bad value from FW\n", value);
+		return -EINVAL;
+	}
+
+	data->echo_active_ms = value;
+
 	return 0;
 }
 
-- 
2.30.0


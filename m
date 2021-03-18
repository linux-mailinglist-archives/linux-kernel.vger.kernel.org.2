Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9C7340643
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhCRND7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:03:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:7917 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231349AbhCRND0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:03:26 -0400
IronPort-SDR: JUZVXXQJg7q4sk50cu9mPep45uqkqO2/4Gh2NcXw8yNnbPm1vI+sjCk0nPDkMviBtcviqO26U3
 bLe9D8QnKxPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="189045210"
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="189045210"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 06:03:25 -0700
IronPort-SDR: HdnB/9OgF10St7uco6ulPx6VYG13mwu6ErsFz52xsulmP8wUn0EiV4XEZp7CcT9KkUHKMewk16
 +kx2RW4OMnkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="406352272"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2021 06:03:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 81E96249; Thu, 18 Mar 2021 15:03:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/7] pps: clients: gpio: Bail out on error when requesting GPIO echo line
Date:   Thu, 18 Mar 2021 15:03:15 +0200
Message-Id: <20210318130321.24227-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When requesting optional GPIO echo line, bail out on error,
so user will know that something wrong with the existing property.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
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
2.30.2


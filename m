Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C183323E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCILYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:24:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:56964 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230149AbhCILYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:24:22 -0500
IronPort-SDR: tG2UU/fsEWY/b4m9Q9zJV9Eapjy/p+vMbfCPt/9PiTGnKMc5wzC4FfFz9a/PbEnkhRwcDVRsp7
 /Dw9788PT9Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="185828127"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="185828127"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 03:24:19 -0800
IronPort-SDR: fsvzNJC82dYmfB6ubVDsgfcIXlv6kVcQI7+aBt/F2KW94XA7NDEOlz/CenHUIivY6pOdsPxhRz
 w4CDI3tSK5YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="437864953"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Mar 2021 03:24:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 691851EC; Tue,  9 Mar 2021 13:24:18 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH resend v1 1/7] pps: clients: gpio: Bail out on error when requesting GPIO echo line
Date:   Tue,  9 Mar 2021 13:23:57 +0200
Message-Id: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
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
2.30.1


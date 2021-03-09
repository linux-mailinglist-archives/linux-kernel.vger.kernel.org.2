Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDE73323DF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCILYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:24:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:41542 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230140AbhCILYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:24:21 -0500
IronPort-SDR: hFTJKYm9Xkk4hSVNbvEynp7Ua8I8RdB8S1TMzbVUhQw+U/hmeDZl7Ivvn/bNLVHTJo/2otmavQ
 MM8AtFeFqa2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="207987897"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="207987897"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 03:24:19 -0800
IronPort-SDR: Qii+MoWk4dOYJ10fx/+shoz9QfhvckuFZ1K8RLfi9MCjTYCS+0QTXmCk1xvbf8s27O/NU9xiZ4
 yv6y1Ql11q0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="599289384"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 09 Mar 2021 03:24:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 72742147; Tue,  9 Mar 2021 13:24:18 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH resend v1 2/7] pps: clients: gpio: Use dev_err_probe() to avoid log noise
Date:   Tue,  9 Mar 2021 13:23:58 +0200
Message-Id: <20210309112403.36633-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
References: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
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
2.30.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135C043E2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJ1NyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:54:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:37406 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhJ1NyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635429108; x=1666965108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J1Jut8y78dJxzJuQ1c/bXW+ltdI9J1tCNObaN5FWdPo=;
  b=Sr/NnXA5eLcDxpmBvJLXUjvakBbni4X8d/w2oMit5nZ1y/hfpATvcEle
   uJlUztXu9RysbvHQ2Bd7in2IhPolYlbpeDk9mX2pjFCdIjf/imv7/99N+
   64osOnALZKgZgZI01CVSfGugvxQ0giapamrmi7WdU13pOijwGoy9Vh9MF
   KdxPDs7eKPBabr+hsN8r4r2bk/D3m6CYUEUqGHOGwdT6Uybh6DXowzFL6
   b6sBAvRvmrZAG6kJwj2nt1gICjAYcrNShJWT8WGoUxXzl3+/hA+0wtyMw
   L0S4aoJwMXiC8tKxCJkruwZttE03jxcyUWiIpyYrrSw1zavPZF9jOcC17
   w==;
IronPort-SDR: 0IwVF14ONRPm88DGTuPojN/aVufBLr94jpEqqbvso1umf9fb3NX6y7FsGAHMyaykH7CqZ+Jf0e
 0XHI0fRdD882vZse/POUHa+qc3YMOMvztCLXaCpd4S3nq/zTwBcM2vKVShmSwuC2IU3J15V4Dm
 Vce8ghgtyBWt7Ex2jOYfBfMNZqBH+AqV8r85+KFVNJo9e29AG7h62Ul2FVcXo90Ft5QR8yQak0
 0buZnUE+gq8eVUc8eiZiWBa48NHm7Ww1yatC8IS80QZlnZpMK/VQj1o9EobEeYXhd31nugZGSk
 TxWK7vlG7P809CGQvVaVSp8G
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="141410834"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Oct 2021 06:51:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 28 Oct 2021 06:51:46 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 28 Oct 2021 06:51:44 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lee.jones@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <romain.izard.pro@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/2] mfd: atmel-flexcom: remove #ifdef CONFIG_PM_SLEEP
Date:   Thu, 28 Oct 2021 16:51:37 +0300
Message-ID: <20211028135138.3481166-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211028135138.3481166-1-claudiu.beznea@microchip.com>
References: <20211028135138.3481166-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove compilation flag and use __maybe_unused and pm_ptr instead.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/mfd/atmel-flexcom.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
index d2f5c073fdf3..962f66dc8813 100644
--- a/drivers/mfd/atmel-flexcom.c
+++ b/drivers/mfd/atmel-flexcom.c
@@ -87,8 +87,7 @@ static const struct of_device_id atmel_flexcom_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
 
-#ifdef CONFIG_PM_SLEEP
-static int atmel_flexcom_resume(struct device *dev)
+static int __maybe_unused atmel_flexcom_resume(struct device *dev)
 {
 	struct atmel_flexcom *ddata = dev_get_drvdata(dev);
 	int err;
@@ -105,7 +104,6 @@ static int atmel_flexcom_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(atmel_flexcom_pm_ops, NULL,
 			 atmel_flexcom_resume);
@@ -114,7 +112,7 @@ static struct platform_driver atmel_flexcom_driver = {
 	.probe	= atmel_flexcom_probe,
 	.driver	= {
 		.name		= "atmel_flexcom",
-		.pm		= &atmel_flexcom_pm_ops,
+		.pm		= pm_ptr(&atmel_flexcom_pm_ops),
 		.of_match_table	= atmel_flexcom_of_match,
 	},
 };
-- 
2.33.0


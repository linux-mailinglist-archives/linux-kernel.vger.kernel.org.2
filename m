Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482883BBC39
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhGELfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:35:51 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:38599 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhGELfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625484793; x=1657020793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQ/1I3RXbJGu/RPnA3qU5eJ4XD3q8hxQd/nTMuI2iFo=;
  b=Ves0evqkZ7JPaRr2SV94jIHVchCYGpGAXpgreR+uNnVmYzq/ZY482x+r
   QxwfYc7/pY5wUAvezMoed9LoUYxk2phbaxZCu9rrwf4RFPLWro9eS9cRJ
   BsmKlgcbx02fLBstuB7Q1aTB2w3gNiq+KdkRZXiFvkSfLIkC4pTXfXaAv
   XnLNC7CKY4Mdw7NYjaP86fuz8/J5y5f1HaSZCFyhMNXIkX/kENZZIoxCM
   1G067FCxa7K9dSwMDD2RkFRKffoHjuP/r6DtVkLCV0310Jqy+KRDl3n79
   eWwPfJIB3kF6UcRN6GfhxWNZrh7Kn3WwrDORT8SDdIPeKSJxZk2YjWiLc
   Q==;
IronPort-SDR: l9sz6/fZ1l/CSssiWniCtLtgn152WiWwjKb55YhRUlS3ZCxFHd/upSnv9AhHxWpA9eDIhL2Rz7
 XTsP+X3lk1xg2dgJso/Qljk46YLaR4kXRlMkckQf91xTf0QheUwCGyF2eBLKi+1cM7QpNMtpcZ
 KI/8tl3qQmBaX2CQpI1PtkEhp11sCeY/Pu3Hg1/l6cIi3NgGlQKhJlxK9vOaHxPU1pwPZ2X7V9
 B88uyC7gganbxJ4v4XEu2URbNcK0Df/t3zDdGHlTt4HLuHQRH1/f2MyLBbxX5DJh5jGKnwDYyL
 bAE=
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="127689856"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2021 04:33:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 04:33:13 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 5 Jul 2021 04:33:09 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lee.jones@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <romain.izard.pro@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] mfd: atmel-flexcom: remove #ifdef CONFIG_PM_SLEEP
Date:   Mon, 5 Jul 2021 14:31:03 +0300
Message-ID: <20210705113104.579535-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210705113104.579535-1-claudiu.beznea@microchip.com>
References: <20210705113104.579535-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove compilation flag and use __maybe_unused and pm_ptr instead.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
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
2.25.1


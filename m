Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB64374812
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhEESeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:34:08 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:15041 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbhEESd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:33:59 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id A791F1AA0D55
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 20:33:01 +0200 (CEST)
Received: from s499.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 9708B2E2C5C4;
        Wed,  5 May 2021 20:33:01 +0200 (CEST)
Received: from s475.loopia.se (unknown [172.22.191.6])
        by s499.loopia.se (Postfix) with ESMTP id 9152A1CE6265;
        Wed,  5 May 2021 20:33:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s645.loopia.se ([172.22.191.6])
        by s475.loopia.se (s475.loopia.se [172.22.190.15]) (amavisd-new, port 10024)
        with LMTP id na-2hkE3FVOd; Wed,  5 May 2021 20:33:01 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 98.128.181.169
Received: from localhost.localdomain (h-98-128-181-169.NA.cust.bahnhof.se [98.128.181.169])
        (Authenticated sender: carl@hgsystem.se)
        by s645.loopia.se (Postfix) with ESMTPSA id D02B6157A054;
        Wed,  5 May 2021 20:33:00 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH 3/3] hwmon: (pmbus) Add support for additional Flex BMR converters to pmbus
Date:   Wed,  5 May 2021 20:32:48 +0200
Message-Id: <20210505183248.57082-4-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210505183248.57082-1-erik.rosen@metormote.com>
References: <20210505183248.57082-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Flex BMR310, BMR456, BMR457, BMR458, BMR480, BMR490,
BMR491 and BMR492 to the pmbus driver

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 Documentation/hwmon/pmbus.rst | 11 +++++++----
 drivers/hwmon/pmbus/Kconfig   |  7 ++++---
 drivers/hwmon/pmbus/pmbus.c   | 24 ++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/Documentation/hwmon/pmbus.rst b/Documentation/hwmon/pmbus.rst
index c44f14115413..0514c3052d4a 100644
--- a/Documentation/hwmon/pmbus.rst
+++ b/Documentation/hwmon/pmbus.rst
@@ -3,15 +3,18 @@ Kernel driver pmbus
 
 Supported chips:
 
-  * Ericsson BMR453, BMR454
+  * Flex BMR453, BMR454, BMR456, BMR457, BMR458, BMR480,
+    BMR490, BMR491, BMR310, BMR492
 
-    Prefixes: 'bmr453', 'bmr454'
+    Prefixes: 'bmr453', 'bmr454', 'bmr456', 'bmr457', 'bmr458', 'bmr480',
+    'bmr490', 'bmr491', 'bmr310', 'bmr492'
 
     Addresses scanned: -
 
-    Datasheet:
+    Datasheets:
+
+ 	https://flexpowermodules.com/products
 
- http://archive.ericsson.net/service/internet/picov/get?DocNo=28701-EN/LZT146395
 
   * ON Semiconductor ADP4000, NCP4200, NCP4208
 
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 32d2fc850621..59080d142bf7 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -19,9 +19,10 @@ config SENSORS_PMBUS
 	default y
 	help
 	  If you say yes here you get hardware monitoring support for generic
-	  PMBus devices, including but not limited to ADP4000, BMR453, BMR454,
-	  MAX20796, MDT040, NCP4200, NCP4208, PDT003, PDT006, PDT012, TPS40400,
-	  TPS544B20, TPS544B25, TPS544C20, TPS544C25, and UDT020.
+	  PMBus devices, including but not limited to ADP4000, BMR310, BMR453,
+	  BMR454, BMR456, BMR457, BMR458, BMR480, BMR490, BMR491, BMR492,
+	  MAX20796, MDT040, NCP4200, NCP4208, PDT003, PDT006, PDT012,
+	  TPS40400, TPS544B20, TPS544B25, TPS544C20, TPS544C25, and UDT020.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index a1b4260e75b2..688c4a3a87e0 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -173,13 +173,18 @@ static int pmbus_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	device_info = (struct pmbus_device_info *)i2c_match_id(pmbus_id, client)->driver_data;
-	if (device_info->flags & PMBUS_SKIP_STATUS_CHECK) {
+	if (device_info->flags & PMBUS_SKIP_STATUS_CHECK ||
+	    device_info->flags & PMBUS_READ_STATUS_AFTER_FAILED_CHECK) {
 		pdata = devm_kzalloc(dev, sizeof(struct pmbus_platform_data),
 				     GFP_KERNEL);
 		if (!pdata)
 			return -ENOMEM;
 
-		pdata->flags = PMBUS_SKIP_STATUS_CHECK;
+		pdata->flags = 0;
+		if (device_info->flags & PMBUS_SKIP_STATUS_CHECK)
+			pdata->flags |= PMBUS_SKIP_STATUS_CHECK;
+		if (device_info->flags & PMBUS_READ_STATUS_AFTER_FAILED_CHECK)
+			pdata->flags |= PMBUS_READ_STATUS_AFTER_FAILED_CHECK;
 	}
 
 	info->pages = device_info->pages;
@@ -193,22 +198,37 @@ static const struct pmbus_device_info pmbus_info_one = {
 	.pages = 1,
 	.flags = 0
 };
+
 static const struct pmbus_device_info pmbus_info_zero = {
 	.pages = 0,
 	.flags = 0
 };
+
 static const struct pmbus_device_info pmbus_info_one_skip = {
 	.pages = 1,
 	.flags = PMBUS_SKIP_STATUS_CHECK
 };
 
+static const struct pmbus_device_info pmbus_info_one_status = {
+	.pages = 1,
+	.flags = PMBUS_READ_STATUS_AFTER_FAILED_CHECK
+};
+
 /*
  * Use driver_data to set the number of pages supported by the chip.
  */
 static const struct i2c_device_id pmbus_id[] = {
 	{"adp4000", (kernel_ulong_t)&pmbus_info_one},
+	{"bmr310", (kernel_ulong_t)&pmbus_info_one_status},
 	{"bmr453", (kernel_ulong_t)&pmbus_info_one},
 	{"bmr454", (kernel_ulong_t)&pmbus_info_one},
+	{"bmr456", (kernel_ulong_t)&pmbus_info_one},
+	{"bmr457", (kernel_ulong_t)&pmbus_info_one},
+	{"bmr458", (kernel_ulong_t)&pmbus_info_one_status},
+	{"bmr480", (kernel_ulong_t)&pmbus_info_one_status},
+	{"bmr490", (kernel_ulong_t)&pmbus_info_one_status},
+	{"bmr491", (kernel_ulong_t)&pmbus_info_one_status},
+	{"bmr492", (kernel_ulong_t)&pmbus_info_one},
 	{"dps460", (kernel_ulong_t)&pmbus_info_one_skip},
 	{"dps650ab", (kernel_ulong_t)&pmbus_info_one_skip},
 	{"dps800", (kernel_ulong_t)&pmbus_info_one_skip},
-- 
2.20.1


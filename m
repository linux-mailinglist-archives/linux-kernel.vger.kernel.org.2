Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD6340FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhCRVZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:25:51 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:11628 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhCRVZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:25:21 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 526CE1A9A944
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:25:20 +0100 (CET)
Received: from s499.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 4180F2E28453;
        Thu, 18 Mar 2021 22:25:20 +0100 (CET)
Received: from s472.loopia.se (unknown [172.22.191.5])
        by s499.loopia.se (Postfix) with ESMTP id 398BF1CE6018;
        Thu, 18 Mar 2021 22:25:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s498.loopia.se ([172.22.191.5])
        by s472.loopia.se (s472.loopia.se [172.22.190.12]) (amavisd-new, port 10024)
        with LMTP id PuTfCBKNNeYS; Thu, 18 Mar 2021 22:25:18 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.131.157
Received: from localhost.localdomain (h-155-4-131-157.NA.cust.bahnhof.se [155.4.131.157])
        (Authenticated sender: carl@hgsystem.se)
        by s498.loopia.se (Postfix) with ESMTPSA id 934A2489411;
        Thu, 18 Mar 2021 22:25:18 +0100 (CET)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH 2/2] hwmon: (pmbus/tps53679) Add support for TPS53676
Date:   Thu, 18 Mar 2021 22:24:41 +0100
Message-Id: <20210318212441.69050-3-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210318212441.69050-1-erik.rosen@metormote.com>
References: <20210318212441.69050-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TI TPS53676 controller to the tps53679 pmbus driver

The driver uses the USER_DATA_03 register to figure out how many phases are
enabled and to which channel they are assigned, and sets the number of pages
and phases accordingly.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 Documentation/hwmon/tps53679.rst | 13 +++++++--
 drivers/hwmon/pmbus/Kconfig      |  4 +--
 drivers/hwmon/pmbus/tps53679.c   | 49 +++++++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/tps53679.rst b/Documentation/hwmon/tps53679.rst
index c7c589e49789..3b9561648c24 100644
--- a/Documentation/hwmon/tps53679.rst
+++ b/Documentation/hwmon/tps53679.rst
@@ -19,6 +19,14 @@ Supported chips:
 
     Datasheet: https://www.ti.com/lit/gpn/TPS53667
 
+  * Texas Instruments TPS53676
+
+    Prefix: 'tps53676'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.ti.com/lit/gpn/TPS53676
+
   * Texas Instruments TPS53679
 
     Prefix: 'tps53679'
@@ -136,7 +144,7 @@ power1_input		Measured input power.
 power[N]_label		"pout[1-2]".
 
 			- TPS53647, TPS53667: N=2
-			- TPS53679, TPS53681, TPS53588: N=2,3
+			- TPS53676, TPS53679, TPS53681, TPS53588: N=2,3
 
 power[N]_input		Measured output power.
 
@@ -156,10 +164,11 @@ curr[N]_label		"iout[1-2]" or "iout1.[0-5]".
 
 			The first digit is the output channel, the second
 			digit is the phase within the channel. Per-phase
-			telemetry supported on TPS53681 only.
+			telemetry supported on TPS53676 and TPS53681 only.
 
 			- TPS53647, TPS53667: N=2
 			- TPS53679, TPS53588: N=2,3
+			- TPS53676: N=2-8
 			- TPS53681: N=2-9
 
 curr[N]_input		Measured output current.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 32d2fc850621..35956a9227d8 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -257,10 +257,10 @@ config SENSORS_TPS40422
 	  be called tps40422.
 
 config SENSORS_TPS53679
-	tristate "TI TPS53647, TPS53667, TPS53679, TPS53681, TPS53688"
+	tristate "TI TPS53647, TPS53667, TPS53676, TPS53679, TPS53681, TPS53688"
 	help
 	  If you say yes here you get hardware monitoring support for TI
-	  TPS53647, TPS53667, TPS53679, TPS53681, and TPS53688.
+	  TPS53647, TPS53667, TPS53676, TPS53679, TPS53681, and TPS53688.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called tps53679.
diff --git a/drivers/hwmon/pmbus/tps53679.c b/drivers/hwmon/pmbus/tps53679.c
index ba838fa311c3..d8e5f71ff162 100644
--- a/drivers/hwmon/pmbus/tps53679.c
+++ b/drivers/hwmon/pmbus/tps53679.c
@@ -16,11 +16,14 @@
 #include "pmbus.h"
 
 enum chips {
-	tps53647, tps53667, tps53679, tps53681, tps53688
+	tps53647, tps53667, tps53676, tps53679, tps53681, tps53688
 };
 
 #define TPS53647_PAGE_NUM		1
 
+#define TPS53676_USER_DATA_03		0xb3
+#define TPS53676_MAX_PHASES		7
+
 #define TPS53679_PROT_VR12_5MV		0x01 /* VR12.0 mode, 5-mV DAC */
 #define TPS53679_PROT_VR12_5_10MV	0x02 /* VR12.5 mode, 10-mV DAC */
 #define TPS53679_PROT_VR13_10MV		0x04 /* VR13.0 mode, 10-mV DAC */
@@ -143,6 +146,43 @@ static int tps53681_identify(struct i2c_client *client,
 					    TPS53681_DEVICE_ID);
 }
 
+static int tps53676_identify(struct i2c_client *client,
+			     struct pmbus_driver_info *info)
+{
+	u8 buf[I2C_SMBUS_BLOCK_MAX];
+	int phases_a = 0, phases_b = 0;
+	int i, ret;
+
+	ret = i2c_smbus_read_block_data(client, PMBUS_IC_DEVICE_ID, buf);
+	if (ret < 0)
+		return ret;
+	if (strncmp("TI\x53\x67\x60", buf, 5)) {
+		dev_err(&client->dev, "Unexpected device ID: %s\n", buf);
+		return -ENODEV;
+	}
+
+	ret = i2c_smbus_read_block_data(client, TPS53676_USER_DATA_03, buf);
+	if (ret < 0)
+		return ret;
+	for (i = 0; i < 2 * TPS53676_MAX_PHASES; i += 2) {
+		if (buf[i + 1] & 0x80) {
+			if (buf[i] & 0x08)
+				phases_b++;
+			else
+				phases_a++;
+		}
+	}
+
+	info->format[PSC_VOLTAGE_OUT] = linear;
+	info->pages = 1;
+	info->phases[0] = phases_a;
+	if (phases_b > 0) {
+		info->pages = 2;
+		info->phases[1] = phases_b;
+	}
+	return 0;
+}
+
 static int tps53681_read_word_data(struct i2c_client *client, int page,
 				   int phase, int reg)
 {
@@ -183,6 +223,7 @@ static struct pmbus_driver_info tps53679_info = {
 	.pfunc[3] = PMBUS_HAVE_IOUT,
 	.pfunc[4] = PMBUS_HAVE_IOUT,
 	.pfunc[5] = PMBUS_HAVE_IOUT,
+	.pfunc[6] = PMBUS_HAVE_IOUT,
 };
 
 static int tps53679_probe(struct i2c_client *client)
@@ -206,6 +247,9 @@ static int tps53679_probe(struct i2c_client *client)
 		info->pages = TPS53647_PAGE_NUM;
 		info->identify = tps53679_identify;
 		break;
+	case tps53676:
+		info->identify = tps53676_identify;
+		break;
 	case tps53679:
 	case tps53688:
 		info->pages = TPS53679_PAGE_NUM;
@@ -227,9 +271,11 @@ static int tps53679_probe(struct i2c_client *client)
 static const struct i2c_device_id tps53679_id[] = {
 	{"tps53647", tps53647},
 	{"tps53667", tps53667},
+	{"tps53676", tps53676},
 	{"tps53679", tps53679},
 	{"tps53681", tps53681},
 	{"tps53688", tps53688},
+	{"bmr474", tps53676},
 	{}
 };
 
@@ -238,6 +284,7 @@ MODULE_DEVICE_TABLE(i2c, tps53679_id);
 static const struct of_device_id __maybe_unused tps53679_of_match[] = {
 	{.compatible = "ti,tps53647", .data = (void *)tps53647},
 	{.compatible = "ti,tps53667", .data = (void *)tps53667},
+	{.compatible = "ti,tps53676", .data = (void *)tps53676},
 	{.compatible = "ti,tps53679", .data = (void *)tps53679},
 	{.compatible = "ti,tps53681", .data = (void *)tps53681},
 	{.compatible = "ti,tps53688", .data = (void *)tps53688},
-- 
2.20.1


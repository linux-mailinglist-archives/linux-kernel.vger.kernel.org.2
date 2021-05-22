Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF3E38D56C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhEVK5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:57:14 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:28617 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhEVK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:57:04 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id CFE8F246E96A
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 12:55:35 +0200 (CEST)
Received: from s630.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id BF45D2E2B891;
        Sat, 22 May 2021 12:55:35 +0200 (CEST)
Received: from s472.loopia.se (unknown [172.22.191.5])
        by s630.loopia.se (Postfix) with ESMTP id B1A5113ADD0D;
        Sat, 22 May 2021 12:55:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s934.loopia.se ([172.22.191.6])
        by s472.loopia.se (s472.loopia.se [172.22.190.12]) (amavisd-new, port 10024)
        with LMTP id lWHXlG8C1IYY; Sat, 22 May 2021 12:55:34 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.133.180
Received: from localhost.localdomain (h-155-4-133-180.NA.cust.bahnhof.se [155.4.133.180])
        (Authenticated sender: carl@hgsystem.se)
        by s934.loopia.se (Postfix) with ESMTPSA id 631D57CE968;
        Sat, 22 May 2021 12:55:34 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v2 3/6] hwmon: (pmbus/pim4328) Add support for reading direct format coefficients
Date:   Sat, 22 May 2021 12:55:25 +0200
Message-Id: <20210522105528.87629-4-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210522105528.87629-1-erik.rosen@metormote.com>
References: <20210522105528.87629-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for reading and decoding direct format coefficients to
the PMBus core driver. If the new flag PMBUS_USE_COEFFICIENTS_CMD
is set, the driver will use the COEFFICIENTS register together with
the information in the pmbus_sensor_attr structs to initialize
relevant coefficients for the direct mode format.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 93 ++++++++++++++++++++++++++++++++
 include/linux/pmbus.h            |  8 +++
 2 files changed, 101 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 460cbfd716e4..03c169bf5633 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2177,6 +2177,38 @@ static int pmbus_find_attributes(struct i2c_client *client,
 	return ret;
 }
 
+static int pmbus_init_coefficients(struct i2c_client *client,
+				   struct pmbus_data *data, int page,
+				   enum pmbus_sensor_classes sensor_class,
+				   const struct pmbus_sensor_attr *attrs,
+				   int nattrs)
+{
+	int i, status;
+
+	for (i = 0; i < nattrs; i++) {
+		if (attrs->class == sensor_class &&
+		    (attrs->func & data->info->func[page])) {
+			status = pmbus_read_coefficients(client,
+							 (struct pmbus_driver_info *)data->info,
+							 sensor_class,
+							 attrs->reg);
+			if (status < 0) {
+				dev_err(&client->dev,
+					"Failed to read coefficients for register: %x\n",
+					attrs->reg);
+				return status;
+			}
+			return 0;
+		}
+		attrs++;
+	}
+
+	dev_err(&client->dev, "No coefficients found for register: %x\n",
+		attrs->reg);
+
+	return -ENODEV;
+}
+
 /*
  * Identify chip parameters.
  * This function is called for all chips.
@@ -2185,6 +2217,7 @@ static int pmbus_identify_common(struct i2c_client *client,
 				 struct pmbus_data *data, int page)
 {
 	int vout_mode = -1;
+	int ret;
 
 	if (pmbus_check_byte_register(client, page, PMBUS_VOUT_MODE))
 		vout_mode = _pmbus_read_byte_data(client, page,
@@ -2214,6 +2247,66 @@ static int pmbus_identify_common(struct i2c_client *client,
 		}
 	}
 
+	if (data->flags & PMBUS_USE_COEFFICIENTS_CMD) {
+		if (!i2c_check_functionality(client->adapter,
+					     I2C_FUNC_SMBUS_BLOCK_PROC_CALL))
+			return -ENODEV;
+
+		if (data->info->format[PSC_VOLTAGE_IN] == direct) {
+			ret = pmbus_init_coefficients(client, data, page,
+						      PSC_VOLTAGE_IN,
+						      voltage_attributes,
+						      ARRAY_SIZE(voltage_attributes));
+			if (ret)
+				return ret;
+		}
+
+		if (data->info->format[PSC_VOLTAGE_OUT] == direct) {
+			ret = pmbus_init_coefficients(client, data, page,
+						      PSC_VOLTAGE_OUT,
+						      voltage_attributes,
+						      ARRAY_SIZE(voltage_attributes));
+			if (ret)
+				return ret;
+		}
+
+		if (data->info->format[PSC_CURRENT_IN] == direct) {
+			ret = pmbus_init_coefficients(client, data, page,
+						      PSC_CURRENT_IN,
+						      current_attributes,
+						      ARRAY_SIZE(current_attributes));
+			if (ret)
+				return ret;
+		}
+
+		if (data->info->format[PSC_CURRENT_OUT] == direct) {
+			ret = pmbus_init_coefficients(client, data, page,
+						      PSC_CURRENT_OUT,
+						      current_attributes,
+						      ARRAY_SIZE(current_attributes));
+			if (ret)
+				return ret;
+		}
+
+		if (data->info->format[PSC_POWER] == direct) {
+			ret = pmbus_init_coefficients(client, data, page,
+						      PSC_POWER,
+						      power_attributes,
+						      ARRAY_SIZE(power_attributes));
+			if (ret)
+				return ret;
+		}
+
+		if (data->info->format[PSC_TEMPERATURE] == direct) {
+			ret = pmbus_init_coefficients(client, data, page,
+						      PSC_TEMPERATURE,
+						      temp_attributes,
+						      ARRAY_SIZE(temp_attributes));
+			if (ret)
+				return ret;
+		}
+	}
+
 	pmbus_clear_fault_page(client, page);
 	return 0;
 }
diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
index f720470b1bab..7fdc282dab5a 100644
--- a/include/linux/pmbus.h
+++ b/include/linux/pmbus.h
@@ -52,6 +52,14 @@
  */
 #define PMBUS_NO_WRITE_PROTECT			BIT(4)
 
+/*
+ * PMBUS_USE_COEFFICIENTS_CMD
+ *
+ * When this flag is set the PMBus core driver will use the COEFFICIENTS
+ * register to initialize the coefficients for the direct mode format.
+ */
+#define PMBUS_USE_COEFFICIENTS_CMD		BIT(5)
+
 struct pmbus_platform_data {
 	u32 flags;		/* Device specific flags */
 
-- 
2.20.1


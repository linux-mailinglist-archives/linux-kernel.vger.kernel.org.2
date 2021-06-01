Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4D397851
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhFAQpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:45:47 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:14738 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbhFAQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:45:45 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 2F3C62E69A69
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 18:44:02 +0200 (CEST)
Received: from s934.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id 1E45B2E2C690;
        Tue,  1 Jun 2021 18:44:02 +0200 (CEST)
Received: from s473.loopia.se (unknown [172.22.191.5])
        by s934.loopia.se (Postfix) with ESMTP id 19FD47CE962;
        Tue,  1 Jun 2021 18:44:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s645.loopia.se ([172.22.191.6])
        by s473.loopia.se (s473.loopia.se [172.22.190.13]) (amavisd-new, port 10024)
        with LMTP id 9fOk1f17zmG5; Tue,  1 Jun 2021 18:44:01 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 178.28.230.104
Received: from localhost.localdomain (c-b21ce668-74736162.cust.telenor.se [178.28.230.104])
        (Authenticated sender: carl@hgsystem.se)
        by s645.loopia.se (Postfix) with ESMTPSA id 79E021579F99;
        Tue,  1 Jun 2021 18:44:00 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Nilsson <daniel.nilsson@flex.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v4 2/5] hwmon: (pmbus/pim4328) Add support for reading direct mode coefficients
Date:   Tue,  1 Jun 2021 18:43:17 +0200
Message-Id: <20210601164320.2907-3-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210601164320.2907-1-erik.rosen@metormote.com>
References: <20210601164320.2907-1-erik.rosen@metormote.com>
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
 drivers/hwmon/pmbus/pmbus_core.c | 116 +++++++++++++++++++++++++++++++
 include/linux/pmbus.h            |   8 +++
 2 files changed, 124 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index cb885efc4fba..cd80cb574267 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2139,6 +2139,111 @@ static int pmbus_find_attributes(struct i2c_client *client,
 	return ret;
 }
 
+/*
+ * The pmbus_class_attr_map structure maps one sensor class to
+ * it's corresponding sensor attributes array.
+ */
+struct pmbus_class_attr_map {
+	enum pmbus_sensor_classes class;
+	int nattr;
+	const struct pmbus_sensor_attr *attr;
+};
+
+static const struct pmbus_class_attr_map class_attr_map[] = {
+	{
+		.class = PSC_VOLTAGE_IN,
+		.attr = voltage_attributes,
+		.nattr = ARRAY_SIZE(voltage_attributes),
+	}, {
+		.class = PSC_VOLTAGE_OUT,
+		.attr = voltage_attributes,
+		.nattr = ARRAY_SIZE(voltage_attributes),
+	}, {
+		.class = PSC_CURRENT_IN,
+		.attr = current_attributes,
+		.nattr = ARRAY_SIZE(current_attributes),
+	}, {
+		.class = PSC_CURRENT_OUT,
+		.attr = current_attributes,
+		.nattr = ARRAY_SIZE(current_attributes),
+	}, {
+		.class = PSC_POWER,
+		.attr = power_attributes,
+		.nattr = ARRAY_SIZE(power_attributes),
+	}, {
+		.class = PSC_TEMPERATURE,
+		.attr = temp_attributes,
+		.nattr = ARRAY_SIZE(temp_attributes),
+	}
+};
+
+/*
+ * Read the coefficients for direct mode.
+ */
+static int pmbus_read_coefficients(struct i2c_client *client,
+				   struct pmbus_driver_info *info,
+				   const struct pmbus_sensor_attr *attr)
+{
+	int rv;
+	union i2c_smbus_data data;
+	enum pmbus_sensor_classes class = attr->class;
+	s8 R;
+	s16 m, b;
+
+	data.block[0] = 2;
+	data.block[1] = attr->reg;
+	data.block[2] = 0x01;
+
+	rv = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			    I2C_SMBUS_WRITE, PMBUS_COEFFICIENTS,
+			    I2C_SMBUS_BLOCK_PROC_CALL, &data);
+
+	if (rv < 0)
+		return rv;
+
+	if (data.block[0] != 5)
+		return -EIO;
+
+	m = data.block[1] | (data.block[2] << 8);
+	b = data.block[3] | (data.block[4] << 8);
+	R = data.block[5];
+	info->m[class] = m;
+	info->b[class] = b;
+	info->R[class] = R;
+
+	return rv;
+}
+
+static int pmbus_init_coefficients(struct i2c_client *client,
+				   struct pmbus_driver_info *info)
+{
+	int i, n, ret;
+	const struct pmbus_class_attr_map *map;
+	const struct pmbus_sensor_attr *attr;
+
+	for (i = 0; i < ARRAY_SIZE(class_attr_map); i++) {
+		map = &class_attr_map[i];
+		if (info->format[map->class] != direct)
+			continue;
+		for (n = 0; n < map->nattr; n++) {
+			attr = &map->attr[n];
+			if (map->class != attr->class)
+				continue;
+			ret = pmbus_read_coefficients(client, info, attr);
+			if (ret >= 0)
+				break;
+		}
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"No coefficients found for sensor class %d\n",
+				map->class);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Identify chip parameters.
  * This function is called for all chips.
@@ -2258,6 +2363,17 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 			return ret;
 		}
 	}
+
+	if (data->flags & PMBUS_USE_COEFFICIENTS_CMD) {
+		if (!i2c_check_functionality(client->adapter,
+					     I2C_FUNC_SMBUS_BLOCK_PROC_CALL))
+			return -ENODEV;
+
+		ret = pmbus_init_coefficients(client, info);
+		if (ret < 0)
+			return ret;
+	}
+
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


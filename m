Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABED638EC8D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhEXPRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 11:17:25 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:36287 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhEXPGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 11:06:33 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id C187A2E6C2B6
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:02:55 +0200 (CEST)
Received: from s899.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id B0F372E2B914;
        Mon, 24 May 2021 17:02:55 +0200 (CEST)
Received: from s475.loopia.se (unknown [172.22.191.6])
        by s899.loopia.se (Postfix) with ESMTP id AE5352C8B9C8;
        Mon, 24 May 2021 17:02:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s934.loopia.se ([172.22.191.5])
        by s475.loopia.se (s475.loopia.se [172.22.190.15]) (amavisd-new, port 10024)
        with UTF8LMTP id 2m_0VNQb4Fz4; Mon, 24 May 2021 17:02:55 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.133.180
Received: from localhost.localdomain (h-155-4-133-180.NA.cust.bahnhof.se [155.4.133.180])
        (Authenticated sender: carl@hgsystem.se)
        by s934.loopia.se (Postfix) with ESMTPSA id 05F2A7CE98B;
        Mon, 24 May 2021 17:02:54 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v3 3/6] hwmon: (pmbus/pim4328) Add support for reading direct format coefficients
Date:   Mon, 24 May 2021 17:02:43 +0200
Message-Id: <20210524150246.90546-4-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210524150246.90546-1-erik.rosen@metormote.com>
References: <20210524150246.90546-1-erik.rosen@metormote.com>
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
 drivers/hwmon/pmbus/pmbus_core.c | 82 ++++++++++++++++++++++++++++++++
 include/linux/pmbus.h            |  8 ++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 460cbfd716e4..32e29f6dee38 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2177,6 +2177,77 @@ static int pmbus_find_attributes(struct i2c_client *client,
 	return ret;
 }
 
+/*
+ * The pmbus_class_attr_map structure maps one sensor class to
+ * it's corresponding sensor attributes array.
+ */
+struct pmbus_class_attr_map {
+	enum pmbus_sensor_classes class;
+	u8 nattr;
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
+static int pmbus_init_coefficients(struct i2c_client *client,
+				   struct pmbus_data *data)
+{
+	int i, n;
+	int ret = 0;
+	const struct pmbus_class_attr_map *map;
+	const struct pmbus_sensor_attr *attr;
+
+	for (i = 0; i < ARRAY_SIZE(class_attr_map); i++) {
+		map = &class_attr_map[i];
+		if (data->info->format[map->class] != direct)
+			continue;
+		for (n = 0; n < map->nattr; n++) {
+			attr = &map->attr[n];
+			if (map->class != attr->class)
+				continue;
+			ret = pmbus_read_coefficients(client,
+						      (struct pmbus_driver_info *)data->info,
+						      attr->class,
+						      attr->reg);
+			if (ret >= 0)
+				break;
+		}
+		if (ret < 0) {
+			dev_err(&client->dev, "No coefficients found for sensor class %d\n",
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
@@ -2296,6 +2367,17 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 			return ret;
 		}
 	}
+
+	if (data->flags & PMBUS_USE_COEFFICIENTS_CMD) {
+		if (!i2c_check_functionality(client->adapter,
+					     I2C_FUNC_SMBUS_BLOCK_PROC_CALL))
+			return -ENODEV;
+
+		ret = pmbus_init_coefficients(client, data);
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F04236E350
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 04:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhD2Cgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 22:36:51 -0400
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:36777 "EHLO
        gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229814AbhD2Cgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 22:36:49 -0400
X-Greylist: delayed 891 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Apr 2021 22:36:49 EDT
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id B2534F7BD35C8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 20:21:11 -0600 (MDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id bwIflnIEFuVqnbwIgltsU5; Wed, 28 Apr 2021 20:21:11 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=MPsDJOVl c=1 sm=1 tr=0 ts=608a1817
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=3YhXtTcJ-WEA:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=vU9dKmh3AAAA:8
 a=NcCfH-bgAAAA:8 a=oRuukivaymlIrXuBOnYA:9 a=rsP06fVo5MYu2ilr0aT5:22
 a=nZLUJm6UEJn402BoZzOq:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HAlAICjVAeD4WWlt4yNf8G/oodCmNwmDE6zYdVqUoSc=; b=CXX7kdk5V1k7pwmQQT4/Z2HO/r
        eCTGs0UsA4I1rUZUO7Uv0/1Bmu05jetUUyBXi7atA/bkkgL5rdeNSF2AR6BqKapFaNu7AroaHVOrj
        3SVb99X90hTyqrE25jOXGTxH9O5jb2bkjeog5VFyY2824S+VLhI4FkkLfPoLLoK6DnCeDUc/VBlDK
        a4Gg+LVyyZbNCJMmokRn/hYq1BhefiVza7O5TWAYgC3gByVvuId4MVhGdZiWORDVmmikkua4PUqWJ
        tzgs4uKByEiKCXOkYsm0E5CPwelLbR3LRpGifbWMWTDvHxo8bs/aC3+t6Ya2i6sfcSUmo3CSs0q09
        2X7tmWDw==;
Received: from [59.92.99.32] (port=50720 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <navin@linumiz.com>)
        id 1lbwIe-003hcK-Bu; Thu, 29 Apr 2021 02:21:08 +0000
From:   Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     navin@linumiz.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: Add sht4x Temperature and Humidity Sensor Driver
Date:   Thu, 29 Apr 2021 07:50:56 +0530
Message-Id: <20210429022058.106757-1-navin@linumiz.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 59.92.99.32
X-Source-L: No
X-Exim-ID: 1lbwIe-003hcK-Bu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [59.92.99.32]:50720
X-Source-Auth: linumcmc
X-Email-Count: 2
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a hwmon driver for the SHT4x Temperature and
Humidity sensor.

Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>
---
 Documentation/hwmon/index.rst |   1 +
 Documentation/hwmon/sht4x.rst |  45 +++++
 drivers/hwmon/Kconfig         |  13 +-
 drivers/hwmon/Makefile        |   1 +
 drivers/hwmon/sht4x.c         | 312 ++++++++++++++++++++++++++++++++++
 5 files changed, 371 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/hwmon/sht4x.rst
 create mode 100644 drivers/hwmon/sht4x.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 8d5a2df1ecb6..2a20c6616e21 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -160,6 +160,7 @@ Hardware Monitoring Kernel Drivers
    sht15
    sht21
    sht3x
+   sht4x
    shtc1
    sis5595
    sl28cpld
diff --git a/Documentation/hwmon/sht4x.rst b/Documentation/hwmon/sht4x.rst
new file mode 100644
index 000000000000..3b37abcd4a46
--- /dev/null
+++ b/Documentation/hwmon/sht4x.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver sht4x
+===================
+
+Supported Chips:
+
+  * Sensirion SHT4X
+
+    Prefix: 'sht4x'
+
+    Addresses scanned: None
+
+    Datasheet:
+
+      English: https://www.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/2_Humidity_Sensors/Datasheets/Sensirion_Humidity_Sensors_SHT4x_Datasheet.pdf
+
+Author: Navin Sankar Velliangiri <navin@linumiz.com>
+
+
+Description
+-----------
+
+This driver implements support for the Sensirion SHT4x chip, a humidity
+and temperature sensor. Temperature is measured in degree celsius, relative
+humidity is expressed as a percentage. In sysfs interface, all values are
+scaled by 1000, i.e. the value for 31.5 degrees celsius is 31500.
+
+Usage Notes
+-----------
+
+The device communicates with the I2C protocol. Sensors can have the I2C
+address 0x44. See Documentation/i2c/instantiating-devices.rst for methods
+to instantiate the device.
+
+Sysfs entries
+-------------
+
+=============== ============================================
+temp1_input     Measured temperature in millidegrees Celcius
+humidity1_input Measured humidity in %H
+update_interval The minimum interval for polling the sensor,
+                in milliseconds. Writable. Must be at least
+                2000.
+============== =============================================
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 54f04e61fb83..ad10469d7b13 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1583,6 +1583,17 @@ config SENSORS_SHT3x
 	  This driver can also be built as a module. If so, the module
 	  will be called sht3x.
 
+config SENSORS_SHT4x
+	tristate "Sensiron humidity and temperature sensors. SHT4x and compat."
+	depends on I2C
+	select CRC8
+	help
+	  If you say yes here you get support for thr Sensiron SHT40, SHT41 and
+	  SHT45 humidity and temperature sensors.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called sht4x.
+
 config SENSORS_SHTC1
 	tristate "Sensiron humidity and temperature sensors. SHTC1 and compat."
 	depends on I2C
@@ -1798,7 +1809,7 @@ config SENSORS_ADS7871
 
 config SENSORS_AMC6821
 	tristate "Texas Instruments AMC6821"
-	depends on I2C 
+	depends on I2C
 	help
 	  If you say yes here you get support for the Texas Instruments
 	  AMC6821 hardware monitoring chips.
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index fe38e8a5c979..62cee3e03c7f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -170,6 +170,7 @@ obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
 obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
 obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
 obj-$(CONFIG_SENSORS_SHT3x)	+= sht3x.o
+obj-$(CONFIG_SENSORS_SHT4x)	+= sht4x.o
 obj-$(CONFIG_SENSORS_SHTC1)	+= shtc1.o
 obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
 obj-$(CONFIG_SENSORS_SMM665)	+= smm665.o
diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
new file mode 100644
index 000000000000..439ccdabb30c
--- /dev/null
+++ b/drivers/hwmon/sht4x.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) Linumiz 2021
+ *
+ * sht4x.c - Linux hwmon driver for SHT4x Temperature and Humidity sensor
+ *
+ * Author: Navin Sankar Velliangiri <navin@linumiz.com>
+ */
+
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/ktime.h>
+
+/*
+ * Poll intervals (in milliseconds)
+ */
+#define SHT4X_DEFAULT_MIN_POLL_INTERVAL	2000
+#define SHT4X_MIN_POLL_INTERVAL		2000
+
+/*
+ * I2C command delays (in microseconds)
+ */
+#define SHT4X_MEAS_DELAY	1000
+#define SHT4X_DELAY_EXTRA	10000
+
+/*
+ * Command Bytes
+ */
+#define SHT4X_CMD_MEASURE_HPM	0b11111101
+#define SHT4X_CMD_RESET		0b10010100
+
+#define SHT4X_CMD_LEN		1
+#define SHT4X_CRC8_LEN		1
+#define SHT4X_WORD_LEN		2
+#define SHT4X_RESPONSE_LENGTH	6
+#define SHT4X_CRC8_POLYNOMIAL	0x31
+#define SHT4X_CRC8_INIT		0xff
+#define SHT4X_MIN_TEMPERATURE	-45000
+#define SHT4X_MAX_TEMPERATURE	125000
+#define SHT4X_MIN_HUMIDITY	0
+#define SHT4X_MAX_HUMIDITY	100000
+
+DECLARE_CRC8_TABLE(sht4x_crc8_table);
+
+/**
+ * struct sht4x_data - All the data required to operate an SHT4X chip
+ * @client: the i2c client associated with the SHT4X
+ * @lock: a mutex that is used to prevent parallel access to the i2c client
+ * @min_poll_interval: the minimum poll interval
+ * @previous_poll_time: the previous time that the SHT4X was polled
+ * @temperature: the latest temperature value received from the SHT4X
+ * @humidity: the latest humidity value received from the SHT4X
+ */
+struct sht4x_data {
+	struct i2c_client *client;
+	/*
+	 * Prevent simultaneous access to the i2c client
+	 */
+	struct mutex lock;
+	ktime_t min_poll_interval;
+	ktime_t previous_poll_time;
+	s32 temperature;
+	s32 humidity;
+};
+
+/**
+ * sht4x_polltime_expired() - check if the minimum poll interval has expired
+ * @data: the data containing the time to compare
+ * Return: 1 if the minimum poll interval has expired, 0 if not
+ */
+static bool sht4x_polltime_expired(struct sht4x_data *data)
+{
+	ktime_t current_time = ktime_get_boottime();
+	ktime_t difference = ktime_sub(current_time, data->previous_poll_time);
+
+	return ktime_after(difference, data->min_poll_interval);
+}
+
+/**
+ * sht4x_read_values() - read and parse the raw data from the SHT4X
+ * @sht4x_data: the struct sht4x_data to use for the lock
+ * Return: 0 if succesfull, 1 if not
+ */
+static int sht4x_read_values(struct sht4x_data *data)
+{
+	int ret;
+	u16 t_ticks, rh_ticks;
+	struct i2c_client *client = data->client;
+	u8 crc, raw_data[SHT4X_RESPONSE_LENGTH],
+	cmd[] = {SHT4X_CMD_MEASURE_HPM};
+
+	mutex_lock(&data->lock);
+	if (sht4x_polltime_expired(data)) {
+		ret = i2c_master_send(client, cmd, SHT4X_CMD_LEN);
+		if (ret < 0) {
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+
+		usleep_range(SHT4X_MEAS_DELAY,
+			     SHT4X_MEAS_DELAY + SHT4X_DELAY_EXTRA);
+
+		ret = i2c_master_recv(client, raw_data, SHT4X_RESPONSE_LENGTH);
+		if (ret != SHT4X_RESPONSE_LENGTH) {
+			mutex_unlock(&data->lock);
+			if (ret >= 0)
+				return -ENODATA;
+			else
+				return ret;
+		}
+
+		t_ticks = raw_data[0] << 8 | raw_data[1];
+		rh_ticks = raw_data[3] << 8 | raw_data[4];
+
+		crc = crc8(sht4x_crc8_table, &raw_data[0], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
+		if (crc != raw_data[2]) {
+			mutex_unlock(&data->lock);
+			dev_err(&client->dev, "data integrity check failed\n");
+			return -EIO;
+		}
+
+		crc = crc8(sht4x_crc8_table, &raw_data[3], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
+		if (crc != raw_data[5]) {
+			mutex_unlock(&data->lock);
+			dev_err(&client->dev, "data integrity check failed\n");
+			return -EIO;
+		}
+
+		data->temperature = ((21875 * (int32_t)t_ticks) >> 13) - 45000;
+		data->humidity = ((15625 * (int32_t)rh_ticks) >> 13) - 6000;
+		data->previous_poll_time = ktime_get_boottime();
+	}
+
+	mutex_unlock(&data->lock);
+	return 0;
+}
+
+static ssize_t sht4x_interval_write(struct sht4x_data *data,
+				    long val)
+{
+	data->min_poll_interval = ms_to_ktime(clamp_val(val, 2000, LONG_MAX));
+	return 0;
+}
+
+/**
+ * sht4x_interval_read() - read the minimum poll interval
+ *			   in milliseconds
+ */
+static size_t sht4x_interval_read(struct sht4x_data *data,
+				  long *val)
+{
+	*val = ktime_to_ms(data->min_poll_interval);
+	return 0;
+}
+
+/**
+ * sht4x_temperature1_read() - read the temperature in millidegrees
+ */
+static int sht4x_temperature1_read(struct sht4x_data *data, long *val)
+{
+	int ret;
+
+	ret = sht4x_read_values(data);
+	if (ret < 0)
+		return ret;
+
+	*val = data->temperature;
+	return 0;
+}
+
+/**
+ * sht4x_humidity1_read() - read a relative humidity in millipercent
+ */
+static int sht4x_humidity1_read(struct sht4x_data *data, long *val)
+{
+	int ret;
+
+	ret = sht4x_read_values(data);
+	if (ret < 0)
+		return ret;
+
+	*val = data->humidity;
+	return 0;
+}
+
+static umode_t sht4x_hwmon_visible(const void *data,
+				   enum hwmon_sensor_types type,
+				   u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_temp:
+	case hwmon_humidity:
+		return 0444;
+	case hwmon_chip:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+static int sht4x_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, long *val)
+{
+	struct sht4x_data *data = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_temp:
+		return sht4x_temperature1_read(data, val);
+	case hwmon_humidity:
+		return sht4x_humidity1_read(data, val);
+	case hwmon_chip:
+		return sht4x_interval_read(data, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int sht4x_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+			     u32 attr, int channel, long val)
+{
+	struct sht4x_data *data = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_chip:
+		return sht4x_interval_write(data, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_channel_info *sht4x_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	HWMON_CHANNEL_INFO(humidity, HWMON_H_INPUT),
+	NULL,
+};
+
+static const struct hwmon_ops sht4x_hwmon_ops = {
+	.is_visible = sht4x_hwmon_visible,
+	.read = sht4x_hwmon_read,
+	.write = sht4x_hwmon_write,
+};
+
+static const struct hwmon_chip_info sht4x_chip_info = {
+	.ops = &sht4x_hwmon_ops,
+	.info = sht4x_info,
+};
+
+static int sht4x_probe(struct i2c_client *client,
+		       const struct i2c_device_id *sht4x_id)
+{
+	struct device *device = &client->dev;
+	struct device *hwmon_dev;
+	struct sht4x_data *data;
+	u8 cmd[] = {SHT4X_CMD_RESET};
+	int ret;
+
+	/*
+	 * we require full i2c support since the sht4x uses multi-byte read and
+	 * writes as well as multi-byte commands which are not supported by
+	 * the smbus protocol
+	 */
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	data = devm_kzalloc(device, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->min_poll_interval = ms_to_ktime(SHT4X_DEFAULT_MIN_POLL_INTERVAL);
+	data->client = client;
+
+	mutex_init(&data->lock);
+
+	crc8_populate_msb(sht4x_crc8_table, SHT4X_CRC8_POLYNOMIAL);
+
+	ret = i2c_master_send(client, cmd, SHT4X_CMD_LEN);
+	if (ret != SHT4X_CMD_LEN)
+		return -EIO;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(device,
+							 client->name,
+							 data,
+							 &sht4x_chip_info,
+							 NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct i2c_device_id sht4x_id[] = {
+	{ "sht4x", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, sht4x_id);
+
+static struct i2c_driver sht4x_driver = {
+	.driver = {
+		.name = "sht4x",
+	},
+	.probe		= sht4x_probe,
+	.id_table	= sht4x_id,
+};
+
+module_i2c_driver(sht4x_driver);
+
+MODULE_AUTHOR("Navin Sankar Velliangiri <navin@linumiz.com>");
+MODULE_DESCRIPTION("Sensirion SHT4x humidity and temperature sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
2.31.1


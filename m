Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3CD33DBA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbhCPR4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:56:46 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38752 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhCPRzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:55:55 -0400
Received: by mail-ed1-f52.google.com with SMTP id h13so22607595eds.5;
        Tue, 16 Mar 2021 10:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwY0jENGZ8w9LCap3uvWftM+Im9MAgWDuvj+CVzZHJY=;
        b=BC13zEOpOWfsUiKynpwCr7feK73cpFNWPgJ6Ou3550yzo9HF0dHoQDh0CBrDLTFVFn
         2zrMGC0xCD3LnAcg8KhM7wDTIn29LjFad+1eBrXajzjBt+sjlOIp8ldT2JfqhT3AgBLh
         bWXQkIKPv+STK5QhHafqwnlXsOmIPYn2JXLTJwy4SNemygPmRsvUSmp1bcTDwNX1+oqi
         y7eesl9zvhnMxVCfy8CHab5z2AZw/+F1j5ez/rzRrvWc+fbb6KDWgwbWfmsBHHiz1MLG
         hLSbHzfLby1AFRiqQGA9yTq73wH/68vQ3/boDC8sDd6io+wlr7jQIV7dGETts4gtM+bL
         9tug==
X-Gm-Message-State: AOAM530GzXAK0oVPu4yW5qC9gYSN4YwcY92/d5XvQivOwsLelZOoTqLR
        6iC5Jd24znjbg+eFD/4Kg2w=
X-Google-Smtp-Source: ABdhPJzlXQaIHxU4eVzKOQYzPOIYeCyc+rmX+fJKstmslZsqNj2K/ry+wuq6D4qmOP2cPIvGkcaCHw==
X-Received: by 2002:a05:6402:704:: with SMTP id w4mr39026341edx.175.1615917353528;
        Tue, 16 Mar 2021 10:55:53 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id b6sm9630201ejb.8.2021.03.16.10.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 10:55:53 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] hwmon: (max31790) Rework to use regmap
Date:   Tue, 16 Mar 2021 18:54:58 +0100
Message-Id: <20210316175503.1003051-1-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting the driver to use regmap makes it more generic. It also makes
it a lot easier to debug through debugfs.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 drivers/hwmon/Kconfig    |   1 +
 drivers/hwmon/max31790.c | 318 ++++++++++++++++++++-------------------
 2 files changed, 163 insertions(+), 156 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 54f04e61fb83..c2ec57672c4e 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1092,6 +1092,7 @@ config SENSORS_MAX6697
 config SENSORS_MAX31790
 	tristate "Maxim MAX31790 sensor chip"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for 6-Channel PWM-Output
 	  Fan RPM Controller.
diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 86e6c71db685..4e5add567890 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 /* MAX31790 registers */
@@ -46,92 +47,49 @@
 
 #define NR_CHANNEL			6
 
+#define MAX31790_REG_USER_BYTE_67	0x67
+
+#define BULK_TO_U16(msb, lsb)		(((msb) << 8) + (lsb))
+#define U16_MSB(num)			(((num) & 0xFF00) >> 8)
+#define U16_LSB(num)			((num) & 0x00FF)
+
+static const struct regmap_range max31790_ro_range = {
+	.range_min = MAX31790_REG_TACH_COUNT(0),
+	.range_max = MAX31790_REG_PWMOUT(0) - 1,
+};
+
+static const struct regmap_access_table max31790_wr_table = {
+	.no_ranges = &max31790_ro_range,
+	.n_no_ranges = 1,
+};
+
+static const struct regmap_range max31790_volatile_ranges[] = {
+	regmap_reg_range(MAX31790_REG_TACH_COUNT(0), MAX31790_REG_TACH_COUNT(12)),
+	regmap_reg_range(MAX31790_REG_FAN_FAULT_STATUS2, MAX31790_REG_FAN_FAULT_STATUS1),
+};
+
+static const struct regmap_access_table max31790_volatile_table = {
+	.no_ranges = max31790_volatile_ranges,
+	.n_no_ranges = 2,
+	.n_yes_ranges = 0
+};
+
+static const struct regmap_config max31790_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.reg_stride = 1,
+	.max_register = MAX31790_REG_USER_BYTE_67,
+	.wr_table = &max31790_wr_table,
+	.volatile_table = &max31790_volatile_table
+};
+
 /*
  * Client data (each client gets its own)
  */
 struct max31790_data {
-	struct i2c_client *client;
-	struct mutex update_lock;
-	bool valid; /* zero until following fields are valid */
-	unsigned long last_updated; /* in jiffies */
-
-	/* register values */
-	u8 fan_config[NR_CHANNEL];
-	u8 fan_dynamics[NR_CHANNEL];
-	u16 fault_status;
-	u16 tach[NR_CHANNEL * 2];
-	u16 pwm[NR_CHANNEL];
-	u16 target_count[NR_CHANNEL];
+	struct regmap *regmap;
 };
 
-static struct max31790_data *max31790_update_device(struct device *dev)
-{
-	struct max31790_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-	struct max31790_data *ret = data;
-	int i;
-	int rv;
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		rv = i2c_smbus_read_byte_data(client,
-				MAX31790_REG_FAN_FAULT_STATUS1);
-		if (rv < 0)
-			goto abort;
-		data->fault_status = rv & 0x3F;
-
-		rv = i2c_smbus_read_byte_data(client,
-				MAX31790_REG_FAN_FAULT_STATUS2);
-		if (rv < 0)
-			goto abort;
-		data->fault_status |= (rv & 0x3F) << 6;
-
-		for (i = 0; i < NR_CHANNEL; i++) {
-			rv = i2c_smbus_read_word_swapped(client,
-					MAX31790_REG_TACH_COUNT(i));
-			if (rv < 0)
-				goto abort;
-			data->tach[i] = rv;
-
-			if (data->fan_config[i]
-			    & MAX31790_FAN_CFG_TACH_INPUT) {
-				rv = i2c_smbus_read_word_swapped(client,
-					MAX31790_REG_TACH_COUNT(NR_CHANNEL
-								+ i));
-				if (rv < 0)
-					goto abort;
-				data->tach[NR_CHANNEL + i] = rv;
-			} else {
-				rv = i2c_smbus_read_word_swapped(client,
-						MAX31790_REG_PWMOUT(i));
-				if (rv < 0)
-					goto abort;
-				data->pwm[i] = rv;
-
-				rv = i2c_smbus_read_word_swapped(client,
-						MAX31790_REG_TARGET_COUNT(i));
-				if (rv < 0)
-					goto abort;
-				data->target_count[i] = rv;
-			}
-		}
-
-		data->last_updated = jiffies;
-		data->valid = true;
-	}
-	goto done;
-
-abort:
-	data->valid = false;
-	ret = ERR_PTR(rv);
-
-done:
-	mutex_unlock(&data->update_lock);
-
-	return ret;
-}
-
 static const u8 tach_period[8] = { 1, 2, 4, 8, 16, 32, 32, 32 };
 
 static u8 get_tach_period(u8 fan_dynamics)
@@ -159,28 +117,89 @@ static u8 bits_for_tach_period(int rpm)
 	return bits;
 }
 
+static int read_reg_byte(struct regmap *regmap, u8 reg)
+{
+	int rv;
+	int val;
+
+	rv = regmap_read(regmap, reg, &val);
+
+	if (rv < 0)
+		return rv;
+
+	return val;
+}
+
+static int read_reg_word(struct regmap *regmap, u8 reg)
+{
+	int rv;
+	u8 val_bulk[2];
+
+	rv = regmap_bulk_read(regmap, reg, val_bulk, 2);
+	if (rv < 0)
+		return rv;
+
+	return BULK_TO_U16(val_bulk[0], val_bulk[1]);
+}
+
+static int write_reg_word(struct regmap *regmap, u8 reg, u16 val)
+{
+	u8 bulk_val[2];
+
+	bulk_val[0] = U16_MSB(val);
+	bulk_val[1] = U16_LSB(val);
+
+	return regmap_bulk_write(regmap, reg, bulk_val, 2);
+}
+
 static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 			     long *val)
 {
-	struct max31790_data *data = max31790_update_device(dev);
-	int sr, rpm;
+	struct max31790_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	int rpm, dynamics, tach, fault;
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
 	switch (attr) {
 	case hwmon_fan_input:
-		sr = get_tach_period(data->fan_dynamics[channel]);
-		rpm = RPM_FROM_REG(data->tach[channel], sr);
+		dynamics = read_reg_byte(regmap, MAX31790_REG_FAN_DYNAMICS(channel));
+		if (dynamics < 0)
+			return dynamics;
+
+		tach = read_reg_word(regmap, MAX31790_REG_TACH_COUNT(channel));
+		if (tach < 0)
+			return tach;
+
+		rpm = RPM_FROM_REG(tach, get_tach_period(dynamics));
 		*val = rpm;
 		return 0;
 	case hwmon_fan_target:
-		sr = get_tach_period(data->fan_dynamics[channel]);
-		rpm = RPM_FROM_REG(data->target_count[channel], sr);
+		dynamics = read_reg_byte(regmap, MAX31790_REG_FAN_DYNAMICS(channel));
+		if (dynamics < 0)
+			return dynamics;
+
+		tach = read_reg_word(regmap, MAX31790_REG_TARGET_COUNT(channel));
+		if (tach < 0)
+			return tach;
+
+		rpm = RPM_FROM_REG(tach, get_tach_period(dynamics));
 		*val = rpm;
 		return 0;
 	case hwmon_fan_fault:
-		*val = !!(data->fault_status & (1 << channel));
+		if (channel > 6)
+			fault = read_reg_byte(regmap, MAX31790_REG_FAN_FAULT_STATUS2);
+		else
+			fault = read_reg_byte(regmap, MAX31790_REG_FAN_FAULT_STATUS1);
+
+		if (fault < 0)
+			return fault;
+
+		if (channel > 6)
+			*val = !!(fault & (1 << (channel - 6)));
+		else
+			*val = !!(fault & (1 << channel));
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -191,52 +210,58 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 			      long val)
 {
 	struct max31790_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
+	struct regmap *regmap = data->regmap;
 	int target_count;
 	int err = 0;
 	u8 bits;
 	int sr;
-
-	mutex_lock(&data->update_lock);
+	int fan_dynamics;
 
 	switch (attr) {
 	case hwmon_fan_target:
 		val = clamp_val(val, FAN_RPM_MIN, FAN_RPM_MAX);
 		bits = bits_for_tach_period(val);
-		data->fan_dynamics[channel] =
-			((data->fan_dynamics[channel] &
+		fan_dynamics = read_reg_byte(regmap, MAX31790_REG_FAN_DYNAMICS(channel));
+
+		if (fan_dynamics < 0)
+			return fan_dynamics;
+
+		fan_dynamics =
+			((fan_dynamics &
 			  ~MAX31790_FAN_DYN_SR_MASK) |
 			 (bits << MAX31790_FAN_DYN_SR_SHIFT));
-		err = i2c_smbus_write_byte_data(client,
-					MAX31790_REG_FAN_DYNAMICS(channel),
-					data->fan_dynamics[channel]);
+		err = regmap_write(regmap,
+				   MAX31790_REG_FAN_DYNAMICS(channel),
+				   fan_dynamics);
 		if (err < 0)
 			break;
 
-		sr = get_tach_period(data->fan_dynamics[channel]);
+		sr = get_tach_period(fan_dynamics);
 		target_count = RPM_TO_REG(val, sr);
 		target_count = clamp_val(target_count, 0x1, 0x7FF);
 
-		data->target_count[channel] = target_count << 5;
+		target_count = target_count << 5;
 
-		err = i2c_smbus_write_word_swapped(client,
-					MAX31790_REG_TARGET_COUNT(channel),
-					data->target_count[channel]);
+		err = write_reg_word(regmap,
+				     MAX31790_REG_TARGET_COUNT(channel),
+				     target_count);
 		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
 	}
 
-	mutex_unlock(&data->update_lock);
-
 	return err;
 }
 
 static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
 {
 	const struct max31790_data *data = _data;
-	u8 fan_config = data->fan_config[channel % NR_CHANNEL];
+	struct regmap *regmap = data->regmap;
+	u8 fan_config = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel % NR_CHANNEL));
+
+	if (fan_config < 0)
+		return 0;
 
 	switch (attr) {
 	case hwmon_fan_input:
@@ -258,22 +283,29 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
 static int max31790_read_pwm(struct device *dev, u32 attr, int channel,
 			     long *val)
 {
-	struct max31790_data *data = max31790_update_device(dev);
-	u8 fan_config;
+	struct max31790_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	int read;
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	fan_config = data->fan_config[channel];
-
 	switch (attr) {
 	case hwmon_pwm_input:
-		*val = data->pwm[channel] >> 8;
+		read = read_reg_word(regmap, MAX31790_REG_PWMOUT(channel));
+		if (read < 0)
+			return read;
+
+		*val = read >> 8;
 		return 0;
 	case hwmon_pwm_enable:
-		if (fan_config & MAX31790_FAN_CFG_RPM_MODE)
+		read = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel));
+		if (read < 0)
+			return read;
+
+		if (read & MAX31790_FAN_CFG_RPM_MODE)
 			*val = 2;
-		else if (fan_config & MAX31790_FAN_CFG_TACH_INPUT_EN)
+		else if (read & MAX31790_FAN_CFG_TACH_INPUT_EN)
 			*val = 1;
 		else
 			*val = 0;
@@ -287,25 +319,24 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
 			      long val)
 {
 	struct max31790_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
+	struct regmap *regmap = data->regmap;
 	u8 fan_config;
 	int err = 0;
 
-	mutex_lock(&data->update_lock);
-
 	switch (attr) {
 	case hwmon_pwm_input:
 		if (val < 0 || val > 255) {
 			err = -EINVAL;
 			break;
 		}
-		data->pwm[channel] = val << 8;
-		err = i2c_smbus_write_word_swapped(client,
-						   MAX31790_REG_PWMOUT(channel),
-						   data->pwm[channel]);
+		err = write_reg_word(regmap, MAX31790_REG_PWMOUT(channel), val << 8);
 		break;
 	case hwmon_pwm_enable:
-		fan_config = data->fan_config[channel];
+		fan_config = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel % NR_CHANNEL));
+
+		if (fan_config < 0)
+			return fan_config;
+
 		if (val == 0) {
 			fan_config &= ~(MAX31790_FAN_CFG_TACH_INPUT_EN |
 					MAX31790_FAN_CFG_RPM_MODE);
@@ -320,25 +351,26 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
 			err = -EINVAL;
 			break;
 		}
-		data->fan_config[channel] = fan_config;
-		err = i2c_smbus_write_byte_data(client,
-					MAX31790_REG_FAN_CONFIG(channel),
-					fan_config);
+		err = regmap_write(regmap,
+				   MAX31790_REG_FAN_CONFIG(channel),
+				   fan_config);
 		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
 	}
 
-	mutex_unlock(&data->update_lock);
-
 	return err;
 }
 
 static umode_t max31790_pwm_is_visible(const void *_data, u32 attr, int channel)
 {
 	const struct max31790_data *data = _data;
-	u8 fan_config = data->fan_config[channel];
+	struct regmap *regmap = data->regmap;
+	u8 fan_config = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel % NR_CHANNEL));
+
+	if (fan_config < 0)
+		return 0;
 
 	switch (attr) {
 	case hwmon_pwm_input:
@@ -426,35 +458,12 @@ static const struct hwmon_chip_info max31790_chip_info = {
 	.info = max31790_info,
 };
 
-static int max31790_init_client(struct i2c_client *client,
-				struct max31790_data *data)
-{
-	int i, rv;
-
-	for (i = 0; i < NR_CHANNEL; i++) {
-		rv = i2c_smbus_read_byte_data(client,
-				MAX31790_REG_FAN_CONFIG(i));
-		if (rv < 0)
-			return rv;
-		data->fan_config[i] = rv;
-
-		rv = i2c_smbus_read_byte_data(client,
-				MAX31790_REG_FAN_DYNAMICS(i));
-		if (rv < 0)
-			return rv;
-		data->fan_dynamics[i] = rv;
-	}
-
-	return 0;
-}
-
 static int max31790_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	struct device *dev = &client->dev;
 	struct max31790_data *data;
 	struct device *hwmon_dev;
-	int err;
 
 	if (!i2c_check_functionality(adapter,
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
@@ -464,15 +473,12 @@ static int max31790_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	data->client = client;
-	mutex_init(&data->update_lock);
+	data->regmap = devm_regmap_init_i2c(client, &max31790_regmap_config);
 
-	/*
-	 * Initialize the max31790 chip
-	 */
-	err = max31790_init_client(client, data);
-	if (err)
-		return err;
+	if (IS_ERR(data->regmap)) {
+		dev_err(dev, "failed to allocate register map\n");
+		return PTR_ERR(data->regmap);
+	}
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 data,
-- 
2.30.2


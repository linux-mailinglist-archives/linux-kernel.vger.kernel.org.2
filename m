Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D8232D15C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbhCDLAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:00:52 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:36369 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbhCDLAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:00:41 -0500
Received: by mail-wm1-f43.google.com with SMTP id k66so9222736wmf.1;
        Thu, 04 Mar 2021 03:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RANBnD46ojmlSMccdilRdjvDcaZ6u/VFb9a869Iq5XU=;
        b=k/KvLQlzVFSSdzxEXi7HR8pHR1NFyjTyoj1PQztsHJzjFkyarqMGc7lqkIb6yzjYt3
         akO7VeysmsYANNaru9AhiAZa2bNKcPy2R5Dei/FhBUGQL109Xd8RO/pr3yrCMA6PVtOG
         3ejX09LHtTqF2B68BI7UZiMOxJvhvmMYGEI59mlXlbS/BzOGUuNT1BWmUKUy9pJtUiwc
         gzAaAlc03DuTiS5RUYEpr/75+OUj5tT1QerPRUAeNWBosQC/p5/Mgdlse4Gt25EqASXt
         RnlpiDWwPNUOEV5C51C0youuoQbGgrr5bRNUDIMzNr0qwMe3eXkMHCfFKsD5Ig/LWKX8
         Kg3A==
X-Gm-Message-State: AOAM531+b+YLChCQLnHwpqugzoOXTQv57Q5GBvP63j/hphtK23V0jK4A
        u9lZitv4lErsWtkFKRYPxVY=
X-Google-Smtp-Source: ABdhPJy9psosJAJzPkFtViYYM9+1QFnG3jbrArOHYWSu0xYl6j08YYMahfmJOMk7q24BUS7maJ9bSA==
X-Received: by 2002:a1c:ddc6:: with SMTP id u189mr3361967wmg.171.1614855600261;
        Thu, 04 Mar 2021 03:00:00 -0800 (PST)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id d85sm9420246wmd.15.2021.03.04.02.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 02:59:59 -0800 (PST)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] hwmon: (max31790) Rework to use regmap
Date:   Thu,  4 Mar 2021 11:58:24 +0100
Message-Id: <20210304105830.507176-1-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.30.1
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
 drivers/hwmon/max31790.c | 148 +++++++++++++++++++++++++++------------
 2 files changed, 105 insertions(+), 44 deletions(-)

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
index 86e6c71db685..ca413985b5f9 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 /* MAX31790 registers */
@@ -46,11 +47,35 @@
 
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
+static const struct regmap_config max31790_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.reg_stride = 1,
+	.max_register = MAX31790_REG_USER_BYTE_67,
+	.wr_table = &max31790_wr_table,
+};
+
 /*
  * Client data (each client gets its own)
  */
 struct max31790_data {
-	struct i2c_client *client;
+	struct regmap *regmap;
 	struct mutex update_lock;
 	bool valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -67,53 +92,72 @@ struct max31790_data {
 static struct max31790_data *max31790_update_device(struct device *dev)
 {
 	struct max31790_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
+	struct regmap *regmap = data->regmap;
 	struct max31790_data *ret = data;
 	int i;
 	int rv;
+	int val;
+	u8 val_bulk[2];
 
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		rv = i2c_smbus_read_byte_data(client,
-				MAX31790_REG_FAN_FAULT_STATUS1);
+		rv = regmap_read(regmap,
+				 MAX31790_REG_FAN_FAULT_STATUS1,
+				 &val);
 		if (rv < 0)
 			goto abort;
-		data->fault_status = rv & 0x3F;
+		data->fault_status = val & 0x3F;
 
-		rv = i2c_smbus_read_byte_data(client,
-				MAX31790_REG_FAN_FAULT_STATUS2);
+		rv = regmap_read(regmap,
+				 MAX31790_REG_FAN_FAULT_STATUS2,
+				 &val);
 		if (rv < 0)
 			goto abort;
-		data->fault_status |= (rv & 0x3F) << 6;
+		data->fault_status |= (val & 0x3F) << 6;
 
 		for (i = 0; i < NR_CHANNEL; i++) {
-			rv = i2c_smbus_read_word_swapped(client,
-					MAX31790_REG_TACH_COUNT(i));
+			rv = regmap_bulk_read(regmap,
+					      MAX31790_REG_TACH_COUNT(i),
+					      val_bulk,
+					      2);
 			if (rv < 0)
 				goto abort;
-			data->tach[i] = rv;
+			data->tach[i] = BULK_TO_U16(val_bulk[0],
+						    val_bulk[1]);
 
 			if (data->fan_config[i]
 			    & MAX31790_FAN_CFG_TACH_INPUT) {
-				rv = i2c_smbus_read_word_swapped(client,
-					MAX31790_REG_TACH_COUNT(NR_CHANNEL
-								+ i));
+				rv = regmap_bulk_read(regmap,
+						      MAX31790_REG_TACH_COUNT(NR_CHANNEL
+									      + i),
+					      val_bulk,
+					      2);
 				if (rv < 0)
 					goto abort;
-				data->tach[NR_CHANNEL + i] = rv;
+
+				data->tach[NR_CHANNEL + i] =
+					BULK_TO_U16(val_bulk[0],
+						    val_bulk[1]);
 			} else {
-				rv = i2c_smbus_read_word_swapped(client,
-						MAX31790_REG_PWMOUT(i));
+				rv = regmap_bulk_read(regmap,
+						      MAX31790_REG_PWMOUT(i),
+						      val_bulk,
+						      2);
 				if (rv < 0)
 					goto abort;
-				data->pwm[i] = rv;
+				data->pwm[i] = BULK_TO_U16(val_bulk[0],
+							   val_bulk[1]);
 
-				rv = i2c_smbus_read_word_swapped(client,
-						MAX31790_REG_TARGET_COUNT(i));
+				rv = regmap_bulk_read(regmap,
+						      MAX31790_REG_TARGET_COUNT(i),
+						      val_bulk,
+						      2);
 				if (rv < 0)
 					goto abort;
-				data->target_count[i] = rv;
+				data->target_count[i] =
+					BULK_TO_U16(val_bulk[0],
+						    val_bulk[1]);
 			}
 		}
 
@@ -191,11 +235,12 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 			      long val)
 {
 	struct max31790_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
+	struct regmap *regmap = data->regmap;
 	int target_count;
 	int err = 0;
 	u8 bits;
 	int sr;
+	u8 bulk_val[2];
 
 	mutex_lock(&data->update_lock);
 
@@ -207,9 +252,9 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 			((data->fan_dynamics[channel] &
 			  ~MAX31790_FAN_DYN_SR_MASK) |
 			 (bits << MAX31790_FAN_DYN_SR_SHIFT));
-		err = i2c_smbus_write_byte_data(client,
-					MAX31790_REG_FAN_DYNAMICS(channel),
-					data->fan_dynamics[channel]);
+		err = regmap_write(regmap,
+				   MAX31790_REG_FAN_DYNAMICS(channel),
+				   data->fan_dynamics[channel]);
 		if (err < 0)
 			break;
 
@@ -218,10 +263,13 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 		target_count = clamp_val(target_count, 0x1, 0x7FF);
 
 		data->target_count[channel] = target_count << 5;
+		bulk_val[0] = U16_MSB(data->target_count[channel]);
+		bulk_val[1] = U16_LSB(data->target_count[channel]);
 
-		err = i2c_smbus_write_word_swapped(client,
+		err = regmap_bulk_write(regmap,
 					MAX31790_REG_TARGET_COUNT(channel),
-					data->target_count[channel]);
+					bulk_val,
+					2);
 		break;
 	default:
 		err = -EOPNOTSUPP;
@@ -287,9 +335,10 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
 			      long val)
 {
 	struct max31790_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
+	struct regmap *regmap = data->regmap;
 	u8 fan_config;
 	int err = 0;
+	u8 bulk_val[2];
 
 	mutex_lock(&data->update_lock);
 
@@ -300,9 +349,12 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
 			break;
 		}
 		data->pwm[channel] = val << 8;
-		err = i2c_smbus_write_word_swapped(client,
-						   MAX31790_REG_PWMOUT(channel),
-						   data->pwm[channel]);
+		bulk_val[0] = U16_MSB(data->pwm[channel]);
+		bulk_val[1] = U16_LSB(data->pwm[channel]);
+		err = regmap_bulk_write(regmap,
+					MAX31790_REG_PWMOUT(channel),
+					bulk_val,
+					2);
 		break;
 	case hwmon_pwm_enable:
 		fan_config = data->fan_config[channel];
@@ -321,9 +373,9 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
 			break;
 		}
 		data->fan_config[channel] = fan_config;
-		err = i2c_smbus_write_byte_data(client,
-					MAX31790_REG_FAN_CONFIG(channel),
-					fan_config);
+		err = regmap_write(regmap,
+				   MAX31790_REG_FAN_CONFIG(channel),
+				   fan_config);
 		break;
 	default:
 		err = -EOPNOTSUPP;
@@ -426,23 +478,25 @@ static const struct hwmon_chip_info max31790_chip_info = {
 	.info = max31790_info,
 };
 
-static int max31790_init_client(struct i2c_client *client,
+static int max31790_init_client(struct regmap *regmap,
 				struct max31790_data *data)
 {
-	int i, rv;
+	int i, rv, val;
 
 	for (i = 0; i < NR_CHANNEL; i++) {
-		rv = i2c_smbus_read_byte_data(client,
-				MAX31790_REG_FAN_CONFIG(i));
+		rv = regmap_read(regmap,
+				 MAX31790_REG_FAN_CONFIG(i),
+				 &val);
 		if (rv < 0)
 			return rv;
-		data->fan_config[i] = rv;
+		data->fan_config[i] = val;
 
-		rv = i2c_smbus_read_byte_data(client,
-				MAX31790_REG_FAN_DYNAMICS(i));
+		rv = regmap_read(regmap,
+				 MAX31790_REG_FAN_DYNAMICS(i),
+				 &val);
 		if (rv < 0)
 			return rv;
-		data->fan_dynamics[i] = rv;
+		data->fan_dynamics[i] = val;
 	}
 
 	return 0;
@@ -464,13 +518,19 @@ static int max31790_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	data->client = client;
 	mutex_init(&data->update_lock);
 
+	data->regmap = devm_regmap_init_i2c(client, &max31790_regmap_config);
+
+	if (IS_ERR(data->regmap)) {
+		dev_err(dev, "failed to allocate register map\n");
+		return PTR_ERR(data->regmap);
+	}
+
 	/*
 	 * Initialize the max31790 chip
 	 */
-	err = max31790_init_client(client, data);
+	err = max31790_init_client(data->regmap, data);
 	if (err)
 		return err;
 
-- 
2.30.1


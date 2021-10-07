Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080BD42537C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhJGMzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhJGMzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:55:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE0C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 05:53:08 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mYStU-0003eE-SQ; Thu, 07 Oct 2021 14:53:04 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mYStT-0000on-Ry; Thu, 07 Oct 2021 14:53:03 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        David Jander <david@protonic.nl>
Subject: [PATCH v1] hwmon: (tmp103) Convert tmp103 to use new hwmon registration API
Date:   Thu,  7 Oct 2021 14:53:01 +0200
Message-Id: <20211007125301.3030-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_hwmon_device_register_with_info() which will make thermal framework
work.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/hwmon/tmp103.c | 105 +++++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 31 deletions(-)

diff --git a/drivers/hwmon/tmp103.c b/drivers/hwmon/tmp103.c
index a7e202cc8323..5cab4436aa77 100644
--- a/drivers/hwmon/tmp103.c
+++ b/drivers/hwmon/tmp103.c
@@ -51,51 +51,92 @@ static inline u8 tmp103_mc_to_reg(int val)
 	return DIV_ROUND_CLOSEST(val, 1000);
 }
 
-static ssize_t tmp103_temp_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static int tmp103_read(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long *temp)
 {
-	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
 	struct regmap *regmap = dev_get_drvdata(dev);
 	unsigned int regval;
-	int ret;
+	int err, reg;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		reg = TMP103_TEMP_REG;
+		break;
+	case hwmon_temp_min:
+		reg = TMP103_TLOW_REG;
+		break;
+	case hwmon_temp_max:
+		reg = TMP103_THIGH_REG;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
 
-	ret = regmap_read(regmap, sda->index, &regval);
-	if (ret < 0)
-		return ret;
+	err = regmap_read(regmap, reg, &regval);
+	if (err < 0)
+		return err;
+
+	*temp = tmp103_reg_to_mc(regval);
 
-	return sprintf(buf, "%d\n", tmp103_reg_to_mc(regval));
+	return 0;
 }
 
-static ssize_t tmp103_temp_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t count)
+static int tmp103_write(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long temp)
 {
-	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
 	struct regmap *regmap = dev_get_drvdata(dev);
-	long val;
-	int ret;
-
-	if (kstrtol(buf, 10, &val) < 0)
-		return -EINVAL;
+	int reg;
+
+	switch (attr) {
+	case hwmon_temp_min:
+		reg = TMP103_TLOW_REG;
+		break;
+	case hwmon_temp_max:
+		reg = TMP103_THIGH_REG;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
 
-	val = clamp_val(val, -55000, 127000);
-	ret = regmap_write(regmap, sda->index, tmp103_mc_to_reg(val));
-	return ret ? ret : count;
+	temp = clamp_val(temp, -55000, 127000);
+	return regmap_write(regmap, reg, tmp103_mc_to_reg(temp));
 }
 
-static SENSOR_DEVICE_ATTR_RO(temp1_input, tmp103_temp, TMP103_TEMP_REG);
+static umode_t tmp103_is_visible(const void *data, enum hwmon_sensor_types type,
+				 u32 attr, int channel)
+{
+	if (type != hwmon_temp)
+		return 0;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		return 0444;
+	case hwmon_temp_min:
+	case hwmon_temp_max:
+		return 0644;
+	default:
+		return 0;
+	}
+}
 
-static SENSOR_DEVICE_ATTR_RW(temp1_min, tmp103_temp, TMP103_TLOW_REG);
+static const struct hwmon_channel_info *tmp103_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN),
+	NULL
+};
 
-static SENSOR_DEVICE_ATTR_RW(temp1_max, tmp103_temp, TMP103_THIGH_REG);
+static const struct hwmon_ops tmp103_hwmon_ops = {
+	.is_visible = tmp103_is_visible,
+	.read = tmp103_read,
+	.write = tmp103_write,
+};
 
-static struct attribute *tmp103_attrs[] = {
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_min.dev_attr.attr,
-	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	NULL
+static const struct hwmon_chip_info tmp103_chip_info = {
+	.ops = &tmp103_hwmon_ops,
+	.info = tmp103_info,
 };
-ATTRIBUTE_GROUPS(tmp103);
 
 static bool tmp103_regmap_is_volatile(struct device *dev, unsigned int reg)
 {
@@ -130,8 +171,10 @@ static int tmp103_probe(struct i2c_client *client)
 	}
 
 	i2c_set_clientdata(client, regmap);
-	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
-						      regmap, tmp103_groups);
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+							 regmap,
+							 &tmp103_chip_info,
+							 NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-- 
2.30.2


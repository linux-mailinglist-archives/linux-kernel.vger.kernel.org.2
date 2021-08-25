Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAF83F7094
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbhHYHnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbhHYHnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:43:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A20FC061757;
        Wed, 25 Aug 2021 00:42:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id q17so13693297edv.2;
        Wed, 25 Aug 2021 00:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tor+uQR8SHg+BzPiemjSMDBPRTBlnQe2rntkRDD09Ok=;
        b=B2g+EyixnXPqwEgac1flrn+O7RxTP53uEyg2xmkh9KXum6e0IN77wnK6p+tJocNjPM
         xCIzrHeb7MTJW281BcdYS9hfNlJ1Ewb6WWKaqmPDVTThrtalLi9sHPpGssR45mm7X27q
         FpVDEj/NbO+td6voJTA4CpiyWDhwvHOLAx/gz2hP4XiXpEEUuqXwKc3vsPYU/eiKZR6L
         Ib6HueBeOBEecVXJ8iTBQyuyCwTBTV6jybiOcE1whsUyA8DeYFXtfhA33Wr7CKYrynwA
         mr268wWvG9Frjoci/MvEqreU/uJROt3R9KoMXFsxMNVohd4ulzxoH4aRDW2ot+ftQHzK
         cEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tor+uQR8SHg+BzPiemjSMDBPRTBlnQe2rntkRDD09Ok=;
        b=fU2MF6IXDq4p5p/iuuuDm0fmiajirlt4BAkZ1I9vldJkxxktybqaHDHaWUFEIFVvCp
         gGHUY82wbrKBDJxR9GuijJ9k5v5qQ70ATIKOojEf/7ywy1KM07V6clV8BAJ/UPEpa5WO
         f3qzZcz9uiICICdFgb1JrJ2OPekIobjbWTd01OP9ZQcRSGbrv/3AKPahKjqfhVJfcagw
         SAPlC4VcyCih3IRTYwo1hSDXswQJw91dh9K2XDkEVL/jyo4CbABuPyf5q0zSlp5tKzFT
         dda7GxuPkTT9GNoiKqDH2eNF5emAauLef5iv1gy+CmhAtZPeWKVN1kO75JoQnXeQNKX3
         lKVA==
X-Gm-Message-State: AOAM530USkHpfhweSnUF1tkUV87qLRveCdWtcBK3HiwM02Np5lHfy+HQ
        d4OyTzuA1yuPauB7ggmxGq4=
X-Google-Smtp-Source: ABdhPJyvUn4gssr+yG6M5n8QZdCmnEuLXnrA7+p1jQ2+mEj5ucx0z+NO/TA/aVaiRB5yvcjHOwvHxw==
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr44958017edu.71.1629877341628;
        Wed, 25 Aug 2021 00:42:21 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id d19sm10348945ejj.122.2021.08.25.00.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 00:42:21 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <demonsingur@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: adt7410: fix hwmon sysfs attrs not being created
Date:   Wed, 25 Aug 2021 10:42:27 +0300
Message-Id: <20210825074228.199070-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824210458.GA3418169@roeck-us.net>
References: <20210824210458.GA3418169@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs attrs for adt7410 are supposed to be created under
the hwmon device, but are being created under the i2c
device.
Switch to hwmon_device_register_with_groups to create
the relevant attrs in the correct directory, and
to also fix the deprecation warning created by
hwmon_device_register.

To achieve this, the following changes are also made.

 * pass client name from adt7410 driver to common
   driver and use it to register hwmon device
 * remove attribute_group declaration and use the
   ATTRIBUTE_GROUPS macro to align with other
   usages of hwmon_device_register_with_groups
 * remove name attribute since it is not needed anymore
   after moving away from hwmon_device_register
 * store bus device into private data and use it to call
   the i2c/spi ops both in hwmon sysfs attr contexts and
   outside of them

Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
---
 drivers/hwmon/adt7410.c |  2 +-
 drivers/hwmon/adt7x10.c | 56 ++++++++---------------------------------
 2 files changed, 12 insertions(+), 46 deletions(-)

diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index 80f8a4673315..a5901ecbb347 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -46,7 +46,7 @@ static int adt7410_i2c_probe(struct i2c_client *client,
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
 
-	return adt7x10_probe(&client->dev, NULL, client->irq, &adt7410_i2c_ops);
+	return adt7x10_probe(&client->dev, client->name, client->irq, &adt7410_i2c_ops);
 }
 
 static int adt7410_i2c_remove(struct i2c_client *client)
diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 3f03b4cf5858..5093911472e8 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -54,8 +54,8 @@
 /* Each client has this additional data */
 struct adt7x10_data {
 	const struct adt7x10_ops *ops;
-	const char		*name;
 	struct device		*hwmon_dev;
+	struct device		*bus_dev;
 	struct mutex		update_lock;
 	u8			config;
 	u8			oldconfig;
@@ -72,25 +72,25 @@ struct adt7x10_data {
 static int adt7x10_read_byte(struct device *dev, u8 reg)
 {
 	struct adt7x10_data *d = dev_get_drvdata(dev);
-	return d->ops->read_byte(dev, reg);
+	return d->ops->read_byte(d->bus_dev, reg);
 }
 
 static int adt7x10_write_byte(struct device *dev, u8 reg, u8 data)
 {
 	struct adt7x10_data *d = dev_get_drvdata(dev);
-	return d->ops->write_byte(dev, reg, data);
+	return d->ops->write_byte(d->bus_dev, reg, data);
 }
 
 static int adt7x10_read_word(struct device *dev, u8 reg)
 {
 	struct adt7x10_data *d = dev_get_drvdata(dev);
-	return d->ops->read_word(dev, reg);
+	return d->ops->read_word(d->bus_dev, reg);
 }
 
 static int adt7x10_write_word(struct device *dev, u8 reg, u16 data)
 {
 	struct adt7x10_data *d = dev_get_drvdata(dev);
-	return d->ops->write_word(dev, reg, data);
+	return d->ops->write_word(d->bus_dev, reg, data);
 }
 
 static const u8 ADT7X10_REG_TEMP[4] = {
@@ -315,14 +315,6 @@ static ssize_t adt7x10_alarm_show(struct device *dev,
 	return sprintf(buf, "%d\n", !!(ret & attr->index));
 }
 
-static ssize_t name_show(struct device *dev, struct device_attribute *da,
-			 char *buf)
-{
-	struct adt7x10_data *data = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%s\n", data->name);
-}
-
 static SENSOR_DEVICE_ATTR_RO(temp1_input, adt7x10_temp, 0);
 static SENSOR_DEVICE_ATTR_RW(temp1_max, adt7x10_temp, 1);
 static SENSOR_DEVICE_ATTR_RW(temp1_min, adt7x10_temp, 2);
@@ -336,9 +328,8 @@ static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, adt7x10_alarm,
 			     ADT7X10_STAT_T_HIGH);
 static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, adt7x10_alarm,
 			     ADT7X10_STAT_T_CRIT);
-static DEVICE_ATTR_RO(name);
 
-static struct attribute *adt7x10_attributes[] = {
+static struct attribute *adt7x10_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
@@ -352,9 +343,7 @@ static struct attribute *adt7x10_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group adt7x10_group = {
-	.attrs = adt7x10_attributes,
-};
+ATTRIBUTE_GROUPS(adt7x10);
 
 int adt7x10_probe(struct device *dev, const char *name, int irq,
 		  const struct adt7x10_ops *ops)
@@ -367,7 +356,7 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 		return -ENOMEM;
 
 	data->ops = ops;
-	data->name = name;
+	data->bus_dev = dev;
 
 	dev_set_drvdata(dev, data);
 	mutex_init(&data->update_lock);
@@ -399,26 +388,11 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 	if (ret)
 		goto exit_restore;
 
-	/* Register sysfs hooks */
-	ret = sysfs_create_group(&dev->kobj, &adt7x10_group);
-	if (ret)
-		goto exit_restore;
-
-	/*
-	 * The I2C device will already have it's own 'name' attribute, but for
-	 * the SPI device we need to register it. name will only be non NULL if
-	 * the device doesn't register the 'name' attribute on its own.
-	 */
-	if (name) {
-		ret = device_create_file(dev, &dev_attr_name);
-		if (ret)
-			goto exit_remove;
-	}
-
-	data->hwmon_dev = hwmon_device_register(dev);
+	data->hwmon_dev = hwmon_device_register_with_groups(dev, name, data,
+							    adt7x10_groups);
 	if (IS_ERR(data->hwmon_dev)) {
 		ret = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_name;
+		goto exit_restore;
 	}
 
 	if (irq > 0) {
@@ -433,11 +407,6 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 
 exit_hwmon_device_unregister:
 	hwmon_device_unregister(data->hwmon_dev);
-exit_remove_name:
-	if (name)
-		device_remove_file(dev, &dev_attr_name);
-exit_remove:
-	sysfs_remove_group(&dev->kobj, &adt7x10_group);
 exit_restore:
 	adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
 	return ret;
@@ -452,9 +421,6 @@ int adt7x10_remove(struct device *dev, int irq)
 		free_irq(irq, dev);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	if (data->name)
-		device_remove_file(dev, &dev_attr_name);
-	sysfs_remove_group(&dev->kobj, &adt7x10_group);
 	if (data->oldconfig != data->config)
 		adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
 	return 0;
-- 
2.33.0


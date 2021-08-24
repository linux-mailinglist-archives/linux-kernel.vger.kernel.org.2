Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1DF3F5DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbhHXM0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbhHXM0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:26:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A08C061757;
        Tue, 24 Aug 2021 05:25:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lc21so11584328ejc.7;
        Tue, 24 Aug 2021 05:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zCYMYRBr45gblgjUphfKBiOGe2xORl6NmvfN93CKe4Q=;
        b=D4quDLvoSVQjbeEJqj+xDKyZl1e8E4OVu+SohqkFIKOe3EqWUUrB10cDHgT5TblDcn
         ZTn9sJ4U3fFxhYMUm2kofVqK5E6H5gYj+1xRm1X+I3ZyZqQ33rGd7S5BJNKEwlQ1TCK1
         5s78FgJGAKNFETbIYRXRWVuJa7xnMs9EtscWkiPo1h4ZPx4hxrN3wjW3tIqcV7/Dt/My
         mKOy4e6u6Bu53T1fmuThhlOHEXO6MeulAEpSTr2Gy8elMjvUVbWVw+nVZLcK99N+t9x7
         izGH9Af8aXRJ0GyeWYoGQg6cJO+xnIBqtZqz+4AloFgD+ZenddHFV6AlPfLRNQszrJkx
         Yvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zCYMYRBr45gblgjUphfKBiOGe2xORl6NmvfN93CKe4Q=;
        b=teRoz66oVigWyNRafKlzlWJZXHnVO9bTf7wqr8pWVAs0JyEIP9Kk51RFaPuDVFBrF8
         usf0eM5/lHlgbAu9hSzaW0z7nxBHxVHEY+sCJTj3LSAFx88+kJrUxzym12qRn/E7CNTa
         GPVbJJl5lcoD9FsZ7L+PmFtbBiOYVF7FF496t5YJ1/vRLUYlEmPEfUIFLZ237qNZkIPi
         dhYA8ZNeLReaCIzM+RL2B3KH1vr2r58NfjvVobc+skKNSzCEHpNZuRIZOnJxJEAalo4k
         1kyRrG8FSbKnmqAH4ZmwK04RkcwgcQPd2mC8bJDs6KOKuVA/M0ieSl7BPguxEb/esJW4
         wX+A==
X-Gm-Message-State: AOAM531JEtflVETz773Xv3dtwFJHjUGE+SfKIlaF1/ttWdJUl+VtTBkF
        3GtPrLzI7HKGZaER+T/ugYZQk+5r2udCsCzc
X-Google-Smtp-Source: ABdhPJxBtXrkk+pGaaeUmy4ukCB1FBYqLjahIeM42Cyt5UK9TY62+ki9+2e0ywedV6L8ZLtxrsfDDA==
X-Received: by 2002:a17:906:b745:: with SMTP id fx5mr19444376ejb.515.1629807929658;
        Tue, 24 Aug 2021 05:25:29 -0700 (PDT)
Received: from localhost.localdomain ([185.53.196.6])
        by smtp.gmail.com with ESMTPSA id o6sm4606811eje.6.2021.08.24.05.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 05:25:29 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <demonsingur@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: adt7410: fix hwmon sysfs attrs not being created
Date:   Tue, 24 Aug 2021 15:25:11 +0300
Message-Id: <20210824122511.185514-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 * store bus device into private data to use both in
   hwmon_dev contexts and outside of them
 * pass client name from adt7410 driver to common
   driver and use it register hwmon device
 * switch from hwmon_device_register to
   hwmon_device_register_with_groups to remove the
   deprecation warning

Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
---
 drivers/hwmon/adt7410.c |  2 +-
 drivers/hwmon/adt7x10.c | 56 ++++++++---------------------------------
 2 files changed, 12 insertions(+), 46 deletions(-)

diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index 9d80895d0266..5c816760fd78 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -45,7 +45,7 @@ static int adt7410_i2c_probe(struct i2c_client *client)
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


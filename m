Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EDA3B29D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhFXIH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhFXIHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:07:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FE5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:05:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gn32so8143494ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=97Lb3vGMIjKXqd/UtI7VBtf2c74YiMaSq0XnAt5KpaE=;
        b=bL/1IMGnIaFaBMD4p6YgIIScJ5++Psz7wzCNg3iFNlr3zcAQbsgNib2eXdXTDnC7SL
         WpgHL9hUR3rBbtLw0SjKk4DEvgNdg/6XOzV2VCZ2hQmMyhj8VNGDUr6hhLlQ0zIe4QEK
         Aj/9q86Irg+Hbm2869gETRNyNQZRD0nXpWkQtAmwdEj2roO0/YP+raCyTOiKuFZy7dJk
         mhvBxgi66I6YM5HvuhgVn2kb7Ww+lEu/HzLDdW4yQrUEYjxVHqsAhQCRHpaGH0qY88tc
         sYRzLI6lCz48oWqZEHSF0g8iQIsDCHkSNXThkss/XoSxqWH9Rv/l3IklYjl8E1CRLEau
         SsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=97Lb3vGMIjKXqd/UtI7VBtf2c74YiMaSq0XnAt5KpaE=;
        b=YX9tNOCZePgiMm3zVKRb6/iGxu8eMGm9WOg1RQoebBM8qciRg3ODKWpfUQkuPkVipW
         ss6xr7ESpxd8h4ZA8czbRPH37EBR346hFHhYCVQAY0JRvHbH4x8zSWhWk7C8A0R2u65Y
         vANuwkLBnhks2/FxrzSvFn8HDzdS404Y/ZPlo3agQP8dKBA03++7UHR6bKSp1eYJ4Nzz
         dD5WrhQH0re1fNtisL6fZbwSRAvBO8muQAtMpWbwaBRHfz1d9j2UKRFH21jzqp8ibrLG
         NNBAkUmvSXh2FPCdDGS1Qnl22HSJH7XuHbWDLuFegIlH4G2NZxqD+LXKAcXWPRvDwW8D
         hdfA==
X-Gm-Message-State: AOAM530/SFsqrXjmehKnkp8gpPszZXG0w/rOZ9MqKCYB1u8ZYtHAi+xS
        ncBeN3bscikVM+nHvNUWvWK4lQ==
X-Google-Smtp-Source: ABdhPJy/CiXHr2K8yoHjsGx6Pfpl32sd2xb4XwkG3Ex6eminxcBH/8HJOgMmH2aTWOXE4V3su42okA==
X-Received: by 2002:a17:907:1b22:: with SMTP id mp34mr4079709ejc.408.1624521904372;
        Thu, 24 Jun 2021 01:05:04 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id j19sm1390060edw.43.2021.06.24.01.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 01:05:03 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: accel: adxl345: convert probe to device-managed functions
Date:   Thu, 24 Jun 2021 11:04:40 +0300
Message-Id: <20210624080441.8710-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver has two parts, one for i2c and one for spi, since the chip can
operate with both wire protocols.

The core file has a common adxl345_core_remove() function which puts the
chip into a powerdown state. This can be implemented with a
devm_add_action_or_reset() hook.

Doing that means we can register the IIO device with
devm_iio_device_register() and get rid of the adxl345_core_remove()
function.

The dev_set_drvdata() call can be removed as there is no other user of this
private data anymore.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/adxl345.h      |  1 -
 drivers/iio/accel/adxl345_core.c | 29 +++++++++--------------------
 drivers/iio/accel/adxl345_i2c.c  |  6 ------
 drivers/iio/accel/adxl345_spi.c  |  6 ------
 4 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 384497776b67..af0fdd02c4f2 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -15,6 +15,5 @@ enum adxl345_device_type {
 
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		       enum adxl345_device_type type, const char *name);
-int adxl345_core_remove(struct device *dev);
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 312866530065..4b275051ef61 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -208,6 +208,11 @@ static const struct iio_info adxl345_info = {
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
 };
 
+static void adxl345_powerdown(void *regmap)
+{
+	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
+}
+
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		       enum adxl345_device_type type, const char *name)
 {
@@ -233,7 +238,6 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
 	data->type = type;
 	/* Enable full-resolution mode */
@@ -260,29 +264,14 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(dev, "iio_device_register failed: %d\n", ret);
-		regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
-			     ADXL345_POWER_CTL_STANDBY);
-	}
+	ret = devm_add_action_or_reset(dev, adxl345_powerdown, data->regmap);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_GPL(adxl345_core_probe);
 
-int adxl345_core_remove(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adxl345_data *data = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	return regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
-			    ADXL345_POWER_CTL_STANDBY);
-}
-EXPORT_SYMBOL_GPL(adxl345_core_remove);
-
 MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
 MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer core driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 1561364ae296..a431cba216e6 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -38,11 +38,6 @@ static int adxl345_i2c_probe(struct i2c_client *client,
 				  id->name);
 }
 
-static int adxl345_i2c_remove(struct i2c_client *client)
-{
-	return adxl345_core_remove(&client->dev);
-}
-
 static const struct i2c_device_id adxl345_i2c_id[] = {
 	{ "adxl345", ADXL345 },
 	{ "adxl375", ADXL375 },
@@ -65,7 +60,6 @@ static struct i2c_driver adxl345_i2c_driver = {
 		.of_match_table = adxl345_of_match,
 	},
 	.probe		= adxl345_i2c_probe,
-	.remove		= adxl345_i2c_remove,
 	.id_table	= adxl345_i2c_id,
 };
 
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index da4591c7ef23..ea559ac2e87d 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -42,11 +42,6 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	return adxl345_core_probe(&spi->dev, regmap, id->driver_data, id->name);
 }
 
-static int adxl345_spi_remove(struct spi_device *spi)
-{
-	return adxl345_core_remove(&spi->dev);
-}
-
 static const struct spi_device_id adxl345_spi_id[] = {
 	{ "adxl345", ADXL345 },
 	{ "adxl375", ADXL375 },
@@ -69,7 +64,6 @@ static struct spi_driver adxl345_spi_driver = {
 		.of_match_table = adxl345_of_match,
 	},
 	.probe		= adxl345_spi_probe,
-	.remove		= adxl345_spi_remove,
 	.id_table	= adxl345_spi_id,
 };
 
-- 
2.31.1


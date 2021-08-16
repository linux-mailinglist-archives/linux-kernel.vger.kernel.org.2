Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFD83ED048
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhHPIat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbhHPIap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:30:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215C6C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 01:30:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b15so30226033ejg.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 01:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3wqgTJ3DyEm8eCey8yz1HhDOFV+KDsaDhsotdZbVLiw=;
        b=DBiUsPVgSbMyQ0kI/uSzvnUg6o/3EhVXMEea6301659vUasEtawsqkrbkt2rWISrTs
         sziVowCEbepelXALxxC2JMvsUkhvhXG79saDKfedxHBP0AZr2KXSGGtbN90k5mJr4qzi
         SgDKxbLJmtCHak+z0qJHiXSlaZ+PQMUT1+pvui1Grr7j6C8HA87y72qLzPS2TsP4hDek
         i00ro98fUL+CwakIniLEPI8TUzHpaNqkj/wldYRppjUyauOguWeDdZefmta7oXLAsf1z
         nTK0C7SjKlzlWh3/J7pRMMAOGC8UEWbZnYZw1v3Dy3eLhz8pdneHJCtKP1HvMzun13kL
         Y1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3wqgTJ3DyEm8eCey8yz1HhDOFV+KDsaDhsotdZbVLiw=;
        b=RSfVYsRKw5NOe637Afcm9A0Rx5fceWA+ldYChjg2N3UAN11ZKkDcZRXsRiF2ByOjD1
         Rb9b+lyu+WxXLgmiWJJ2zSi2zT1+Tapx2zLbso03QCXTqDvQHbPA54Ns5Huicw2621AG
         63lw8rSD9a9Z3thj2vroOpWaPsi2ndtuoXJOvyNRHkrbHR+tXBgLowlSRv4Sa3B8r4bJ
         2kdz4Es7MJDRAdYhsvGAmRPYSXWnKOdTP9lCFaVtuRpT0crXz5TY8aEzAzsEbxPw+JZD
         mndvy47MFTE+FPD2l3+SX6fha48DWjL6npBEX/J3ROKeGYGxn6RHiTSEYysEP/HkEEyj
         vDKg==
X-Gm-Message-State: AOAM5323o1Y9f07TEMOdYCcZyGSIwcq8PWW6Ltc6e9tUT6nJ1gBk8UBt
        V7EO1EJ5naEXzvt6k5Zm2n8SYiKErmE5mb1g
X-Google-Smtp-Source: ABdhPJzPsPccVuODW+wy37D3iSpm2kVTCj8ycxO/MWk2/ppnWfWxczHmCK+NZve/BMLit65c3OyQjA==
X-Received: by 2002:a17:907:785a:: with SMTP id lb26mr15108661ejc.77.1629102612570;
        Mon, 16 Aug 2021 01:30:12 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id q30sm4516878edi.84.2021.08.16.01.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 01:30:12 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 3/5] iio: st_sensors: remove st_sensors_power_disable() function
Date:   Mon, 16 Aug 2021 11:28:34 +0300
Message-Id: <20210816082836.67511-4-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816082836.67511-1-aardelean@deviqon.com>
References: <20210816082836.67511-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change converts the st_sensors_power_enable() function to use
devm_add_action_or_reset() handlers to register regulator_disable hooks for
when the drivers get unloaded.

The parent device of the IIO device object is used. This is based on the
assumption that all other devm_ calls in the ST sensors use this reference.

This makes the st_sensors_power_disable() un-needed.
Removing this also changes unload order a bit, as all ST drivers would call
st_sensors_power_disable() first and iio_device_unregister() after that.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/st_accel_i2c.c              | 13 +------
 drivers/iio/accel/st_accel_spi.c              | 13 +------
 .../iio/common/st_sensors/st_sensors_core.c   | 34 ++++++++-----------
 drivers/iio/gyro/st_gyro_i2c.c                | 13 +------
 drivers/iio/gyro/st_gyro_spi.c                | 13 +------
 drivers/iio/magnetometer/st_magn_i2c.c        | 13 +------
 drivers/iio/magnetometer/st_magn_spi.c        | 13 +------
 drivers/iio/pressure/st_pressure_i2c.c        | 13 +------
 drivers/iio/pressure/st_pressure_spi.c        | 13 +------
 include/linux/iio/common/st_sensors.h         |  2 --
 10 files changed, 23 insertions(+), 117 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index cba57459e90a..b377575efc41 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -177,16 +177,7 @@ static int st_accel_i2c_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = st_accel_common_probe(indio_dev);
-	if (ret < 0)
-		goto st_accel_power_off;
-
-	return 0;
-
-st_accel_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return ret;
+	return st_accel_common_probe(indio_dev);
 }
 
 static int st_accel_i2c_remove(struct i2c_client *client)
@@ -195,8 +186,6 @@ static int st_accel_i2c_remove(struct i2c_client *client)
 
 	st_accel_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 5167fae1ee8e..4ca87e73bdb3 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -127,16 +127,7 @@ static int st_accel_spi_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	err = st_accel_common_probe(indio_dev);
-	if (err < 0)
-		goto st_accel_power_off;
-
-	return 0;
-
-st_accel_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_accel_common_probe(indio_dev);
 }
 
 static int st_accel_spi_remove(struct spi_device *spi)
@@ -145,8 +136,6 @@ static int st_accel_spi_remove(struct spi_device *spi)
 
 	st_accel_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 0bbb090b108c..a5a140de9a23 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -215,13 +215,19 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
 }
 EXPORT_SYMBOL(st_sensors_set_axis_enable);
 
+static void st_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 int st_sensors_power_enable(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *pdata = iio_priv(indio_dev);
+	struct device *parent = indio_dev->dev.parent;
 	int err;
 
 	/* Regulators not mandatory, but if requested we should enable them. */
-	pdata->vdd = devm_regulator_get(indio_dev->dev.parent, "vdd");
+	pdata->vdd = devm_regulator_get(parent, "vdd");
 	if (IS_ERR(pdata->vdd)) {
 		dev_err(&indio_dev->dev, "unable to get Vdd supply\n");
 		return PTR_ERR(pdata->vdd);
@@ -233,36 +239,26 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 		return err;
 	}
 
-	pdata->vdd_io = devm_regulator_get(indio_dev->dev.parent, "vddio");
+	err = devm_add_action_or_reset(parent, st_reg_disable, pdata->vdd);
+	if (err)
+		return err;
+
+	pdata->vdd_io = devm_regulator_get(parent, "vddio");
 	if (IS_ERR(pdata->vdd_io)) {
 		dev_err(&indio_dev->dev, "unable to get Vdd_IO supply\n");
-		err = PTR_ERR(pdata->vdd_io);
-		goto st_sensors_disable_vdd;
+		return PTR_ERR(pdata->vdd_io);
 	}
 	err = regulator_enable(pdata->vdd_io);
 	if (err != 0) {
 		dev_warn(&indio_dev->dev,
 			 "Failed to enable specified Vdd_IO supply\n");
-		goto st_sensors_disable_vdd;
+		return err;
 	}
 
-	return 0;
-
-st_sensors_disable_vdd:
-	regulator_disable(pdata->vdd);
-	return err;
+	return devm_add_action_or_reset(parent, st_reg_disable, pdata->vdd_io);
 }
 EXPORT_SYMBOL(st_sensors_power_enable);
 
-void st_sensors_power_disable(struct iio_dev *indio_dev)
-{
-	struct st_sensor_data *pdata = iio_priv(indio_dev);
-
-	regulator_disable(pdata->vdd);
-	regulator_disable(pdata->vdd_io);
-}
-EXPORT_SYMBOL(st_sensors_power_disable);
-
 static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
 {
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index a8164fe48b85..0bd80dfd389f 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -90,16 +90,7 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	err = st_gyro_common_probe(indio_dev);
-	if (err < 0)
-		goto st_gyro_power_off;
-
-	return 0;
-
-st_gyro_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_gyro_common_probe(indio_dev);
 }
 
 static int st_gyro_i2c_remove(struct i2c_client *client)
@@ -108,8 +99,6 @@ static int st_gyro_i2c_remove(struct i2c_client *client)
 
 	st_gyro_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 9d8916871b4b..f74b09fa5cde 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -94,16 +94,7 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	err = st_gyro_common_probe(indio_dev);
-	if (err < 0)
-		goto st_gyro_power_off;
-
-	return 0;
-
-st_gyro_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_gyro_common_probe(indio_dev);
 }
 
 static int st_gyro_spi_remove(struct spi_device *spi)
@@ -112,8 +103,6 @@ static int st_gyro_spi_remove(struct spi_device *spi)
 
 	st_gyro_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index fa78f0a3b53e..0a5117dffcf4 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -86,16 +86,7 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	err = st_magn_common_probe(indio_dev);
-	if (err < 0)
-		goto st_magn_power_off;
-
-	return 0;
-
-st_magn_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_magn_common_probe(indio_dev);
 }
 
 static int st_magn_i2c_remove(struct i2c_client *client)
@@ -104,8 +95,6 @@ static int st_magn_i2c_remove(struct i2c_client *client)
 
 	st_magn_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index ff43cbf61b05..1f3bf02b24e0 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -80,16 +80,7 @@ static int st_magn_spi_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	err = st_magn_common_probe(indio_dev);
-	if (err < 0)
-		goto st_magn_power_off;
-
-	return 0;
-
-st_magn_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_magn_common_probe(indio_dev);
 }
 
 static int st_magn_spi_remove(struct spi_device *spi)
@@ -98,8 +89,6 @@ static int st_magn_spi_remove(struct spi_device *spi)
 
 	st_magn_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 6215de677017..afeeab485c0d 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -103,16 +103,7 @@ static int st_press_i2c_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ret = st_press_common_probe(indio_dev);
-	if (ret < 0)
-		goto st_press_power_off;
-
-	return 0;
-
-st_press_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return ret;
+	return st_press_common_probe(indio_dev);
 }
 
 static int st_press_i2c_remove(struct i2c_client *client)
@@ -121,8 +112,6 @@ static int st_press_i2c_remove(struct i2c_client *client)
 
 	st_press_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 5001aae8f00b..834ad6d40a70 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -86,16 +86,7 @@ static int st_press_spi_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	err = st_press_common_probe(indio_dev);
-	if (err < 0)
-		goto st_press_power_off;
-
-	return 0;
-
-st_press_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_press_common_probe(indio_dev);
 }
 
 static int st_press_spi_remove(struct spi_device *spi)
@@ -104,8 +95,6 @@ static int st_press_spi_remove(struct spi_device *spi)
 
 	st_press_common_remove(indio_dev);
 
-	st_sensors_power_disable(indio_dev);
-
 	return 0;
 }
 
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index e74b55244f35..fc90c202d15e 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -293,8 +293,6 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable);
 
 int st_sensors_power_enable(struct iio_dev *indio_dev);
 
-void st_sensors_power_disable(struct iio_dev *indio_dev);
-
 int st_sensors_debugfs_reg_access(struct iio_dev *indio_dev,
 				  unsigned reg, unsigned writeval,
 				  unsigned *readval);
-- 
2.31.1


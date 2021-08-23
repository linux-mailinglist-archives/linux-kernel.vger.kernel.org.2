Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5B3F49A0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhHWLXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbhHWLXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:23:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE55C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:22:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n27so4290584eja.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQ8sclaJNC37h3HE8p7+oGVbPPYA8yvwWkRrtNbc0C4=;
        b=rOvb8GpQlDdcbs0BOQICC9TpElh+L4nn2sD9u/qmAhhGHVMskpKaE/uiLvM5zBEoGF
         Prp9gIkyUKR4FgugCmv5OusPYort9ogKflptJfqdYicVI8EIPNASDvO5bTX6z0Cwq6TS
         YoPUo+MmQO3KjPg+kPTHogZgavvSfrhTJQL6RR0+p/uyRlEBo7cv43vvLkNuR+/2ZmL8
         x+8EDAtZDO/cpB1I+EADpfNTXA/56abrISvpaMhtt9wxmd3icEpxxA6Ft3JJMEMgXMSU
         uHBGaclcvmfHeuVPii8/7PYiJrJ+kLFMkQaggY5wKVzS0RjL1HwHDSQ9o60sUoLyf5RD
         D46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQ8sclaJNC37h3HE8p7+oGVbPPYA8yvwWkRrtNbc0C4=;
        b=ks8rjCXJ5kDdKmZu1/Too6CZMBS+oCcDm0+DUcCD/ROV0SGpJCnThpUEvMq+mPjP67
         6ESIivKgNdhpiR6cC6F57JfjRAQbo3KUfD5Bq8rd376pj9m254/J4GXqKCrWU3oPwpw0
         tU3UiDW40w5yjkoMH6+fYrJVpfDbB56o/b7FGP2a5SraC9eVGcaJGsROOKJk+jBUTP2b
         /rr3wRGRIBIIwxBR3DVjgoUMF+wP9MWr583oduCoK999gengFKHrWvcRSyOgHTvdn2C9
         uQxJ0M9MVlR4v5YL0hDZUWMVfwtXUk58HfsySVL1sQ1aXgwYuMN6eyp2f1rJo5oulTZo
         jCWw==
X-Gm-Message-State: AOAM532t5Lv8uP33GDmwRu5XR1fV5wmmVU6JLzdDHZm57OW/5O5mnhRk
        m7RzMmDqEMwGIBsuH0MDUwWFrg==
X-Google-Smtp-Source: ABdhPJynexHclE9BcETTjZ9caW2nskQ0jaYESxLt0Z/Z0BlffRO8NMAmiLBhUnrMnUeiiVzj99tLnA==
X-Received: by 2002:a17:906:aada:: with SMTP id kt26mr35526938ejb.199.1629717755097;
        Mon, 23 Aug 2021 04:22:35 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id d22sm7382212ejj.47.2021.08.23.04.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:22:34 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org, andy.shevchenko@gmail.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 1/5] iio: st_sensors: disable regulators after device unregistration
Date:   Mon, 23 Aug 2021 14:22:00 +0300
Message-Id: <20210823112204.243255-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210823112204.243255-1-aardelean@deviqon.com>
References: <20210823112204.243255-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until commit ea7e586bdd331 ("iio: st_sensors: move regulator retrieveal
to core") only the ST pressure driver seems to have had any regulator
disable. After that commit, the regulator handling was moved into the
common st_sensors logic.

In all instances of this regulator handling, the regulators were disabled
before unregistering the IIO device.
This can cause issues where the device would be powered down and still be
available to userspace, allowing it to send invalid/garbage data.

This change moves the st_sensors_power_disable() after the common probe
functions. These common probe functions also handle unregistering the IIO
device.

Fixes: 774487611c949 ("iio: pressure-core: st: Provide support for the Vdd power supply")
Fixes: ea7e586bdd331 ("iio: st_sensors: move regulator retrieveal to core")
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Denis CIOCCA <denis.ciocca@st.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/st_accel_i2c.c       | 4 ++--
 drivers/iio/accel/st_accel_spi.c       | 4 ++--
 drivers/iio/gyro/st_gyro_i2c.c         | 4 ++--
 drivers/iio/gyro/st_gyro_spi.c         | 4 ++--
 drivers/iio/magnetometer/st_magn_i2c.c | 4 ++--
 drivers/iio/magnetometer/st_magn_spi.c | 4 ++--
 drivers/iio/pressure/st_pressure_i2c.c | 4 ++--
 drivers/iio/pressure/st_pressure_spi.c | 4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index f711756e41e3..cba57459e90a 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -193,10 +193,10 @@ static int st_accel_i2c_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_accel_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index bb45d9ff95b8..5167fae1ee8e 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -143,10 +143,10 @@ static int st_accel_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_accel_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 3ef86e16ee65..a8164fe48b85 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -106,10 +106,10 @@ static int st_gyro_i2c_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_gyro_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 41d835493347..9d8916871b4b 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -110,10 +110,10 @@ static int st_gyro_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_gyro_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 2dfe4ee99591..fa78f0a3b53e 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -102,10 +102,10 @@ static int st_magn_i2c_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_magn_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index fba978796395..ff43cbf61b05 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -96,10 +96,10 @@ static int st_magn_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_magn_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 52fa98f24478..6215de677017 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -119,10 +119,10 @@ static int st_press_i2c_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_press_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index ee393df54cee..5001aae8f00b 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -102,10 +102,10 @@ static int st_press_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_press_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
-- 
2.31.1


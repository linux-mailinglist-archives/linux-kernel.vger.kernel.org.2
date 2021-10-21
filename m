Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B922E436764
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhJUQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhJUQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:17:10 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E8BC061764;
        Thu, 21 Oct 2021 09:14:53 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id n15-20020a4ad12f000000b002b6e3e5fd5dso291649oor.1;
        Thu, 21 Oct 2021 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DIh//B5cX1tKK5aGoOXZngVHy7BzhIgL1SIq8cnhHfY=;
        b=o37UJBQDncXEBd5vrXBj0UWO6ciPDAi55NQalChRiuYPhsjZCn3mXvT1/OX1CFhQv2
         msXajTRYAB/qK8JjzNopTH6rTCi+lWRpe+KJaw0+6+CDpJepZhV/klp8lcS4YOQLIsf3
         SoMm4jmhQYEcc2ZShrtC6uETjWaBIVybWiqiYzSuw/VTIoEmRc1i4wDqkU9+40tz+F0V
         vRlGHBe6sLOp04+xLUJ1cZacNkLcXG2wIzShJYoyUua23SZtN9qDuJzS5UetqGdeVwUL
         VMX8OsLrFlRZwFL8cZOLiLIT+fmKe9sI3vpHNAAvnUvL4LiWGsBsxOKGJ/4rYxqJoKFc
         GR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DIh//B5cX1tKK5aGoOXZngVHy7BzhIgL1SIq8cnhHfY=;
        b=GNiRmpN3jtmq7X70VDUWcgk8yaGUqrkONGw3rhIjxOQMGms1IJEQboUKZu+8nv2oBy
         y5ZLe2KdUnXGBbV5RrZAVh1sy0DLqOSPqMkSWsNDczCj4qLCSCTDdVAb1kU9hkhUSZjX
         d1a282FT30J/HK9iaqAM2iFnBjLsIYS5x07PgIYx2cSfMoeOtDsB5HsqSsSxra6tqcth
         6e9Ilp/x/AmcoHmd/IGDjFLbj0Q5HofrC6eoBfvlWfhB4M0KLN4N3UhbN5T4+TXfmIg+
         7a5KRsqoYAj0GcS7vipNgW8ahax8k9c6ocZblpU0Ssi++RTPY+v6Rz6F93yi/yLnk2V7
         hmfQ==
X-Gm-Message-State: AOAM533MpzZCBdoTzJ/6pFa1Ss2Yiq9oy3OMKcuz34syWiWMzN9O5mhB
        4iwtGCSqvt4wkKFqicV8DkcRqS03K1I=
X-Google-Smtp-Source: ABdhPJwiJfToecHrUR/4VzYhdwb2JS4vKPmBtooc9KwB892AJwrl16almOzMukN+moe4HLFv5vO/Tw==
X-Received: by 2002:a4a:de10:: with SMTP id y16mr5184275oot.4.1634832892837;
        Thu, 21 Oct 2021 09:14:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x28sm1217625ote.24.2021.10.21.09.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:14:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        "David T . Wilson" <david.wilson@nasa.gov>
Subject: [PATCH v2 3/3] hwmon: (tmp401) Drop support for TMP461
Date:   Thu, 21 Oct 2021 09:14:44 -0700
Message-Id: <20211021161444.3145112-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211021161444.3145112-1-linux@roeck-us.net>
References: <20211021161444.3145112-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TMP461 is almost identical to TMP451, which is already supported by the
lm90 driver. At the same time, unlike other sensors from the TMP401
compatible series, it only supports 8-bit temperature read operations,
it supports negative temperatures when configured for its default
temperature range, and it supports a temperature offset register.
Supporting this chip in the tmp401 driver adds unnecessary complexity.
Remove its support from this driver and support the chip with the lm90
driver instead.

Fixes: 24333ac26d01 ("hwmon: (tmp401) use smb word operations instead of 2 smb byte operations")
Reported-by: David T. Wilson <david.wilson@nasa.gov>
Cc: David T. Wilson <david.wilson@nasa.gov>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Explain additional limitations of tmp401 driver which are affecting
    TMP461

 Documentation/hwmon/tmp401.rst | 15 +--------------
 drivers/hwmon/Kconfig          |  2 +-
 drivers/hwmon/tmp401.c         | 25 ++-----------------------
 3 files changed, 4 insertions(+), 38 deletions(-)

diff --git a/Documentation/hwmon/tmp401.rst b/Documentation/hwmon/tmp401.rst
index 14bf1fbf4493..3aacf3d3bdf3 100644
--- a/Documentation/hwmon/tmp401.rst
+++ b/Documentation/hwmon/tmp401.rst
@@ -43,12 +43,6 @@ Supported chips:
 
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp435.html
 
-  * Texas Instruments TMP461
-
-    Prefix: 'tmp461'
-
-    Datasheet: https://www.ti.com/product/tmp461
-
 
 
 Authors:
@@ -60,7 +54,7 @@ Description
 -----------
 
 This driver implements support for Texas Instruments TMP401, TMP411,
-TMP431, TMP432, TMP435, and TMP461 chips. These chips implement one or two
+TMP431, TMP432, and TMP435 chips. These chips implement one or two
 remote and one local temperature sensors. Temperature is measured in degrees
 Celsius. Resolution of the remote sensor is 0.0625 degree. Local
 sensor resolution can be set to 0.5, 0.25, 0.125 or 0.0625 degree (not
@@ -84,10 +78,3 @@ some additional features.
 
 TMP432 is compatible with TMP401 and TMP431. It supports two external
 temperature sensors.
-
-TMP461 is compatible with TMP401. It supports offset correction
-that is applied to the remote sensor.
-
-* Sensor offset values are temperature values
-
-  Exported via sysfs attribute tempX_offset
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ccdaeafed0bb..feff41444f05 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1930,7 +1930,7 @@ config SENSORS_TMP401
 	depends on I2C
 	help
 	  If you say yes here you get support for Texas Instruments TMP401,
-	  TMP411, TMP431, TMP432, TMP435, and TMP461 temperature sensor chips.
+	  TMP411, TMP431, TMP432, and TMP435 temperature sensor chips.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called tmp401.
diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index 9dc210b55e69..cd72755ec8f7 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -34,7 +34,7 @@
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c, 0x4d,
 	0x4e, 0x4f, I2C_CLIENT_END };
 
-enum chips { tmp401, tmp411, tmp431, tmp432, tmp435, tmp461 };
+enum chips { tmp401, tmp411, tmp431, tmp432, tmp435 };
 
 /*
  * The TMP401 registers, note some registers have different addresses for
@@ -56,7 +56,6 @@ static const u8 TMP401_TEMP_MSB_READ[7][2] = {
 	{ 0x20, 0x19 },	/* therm (crit) limit */
 	{ 0x30, 0x34 },	/* lowest */
 	{ 0x32, 0x36 },	/* highest */
-	{ 0, 0x11 },	/* offset */
 };
 
 static const u8 TMP401_TEMP_MSB_WRITE[7][2] = {
@@ -66,7 +65,6 @@ static const u8 TMP401_TEMP_MSB_WRITE[7][2] = {
 	{ 0x20, 0x19 },	/* therm (crit) limit */
 	{ 0x30, 0x34 },	/* lowest */
 	{ 0x32, 0x36 },	/* highest */
-	{ 0, 0x11 },	/* offset */
 };
 
 static const u8 TMP432_TEMP_MSB_READ[4][3] = {
@@ -123,7 +121,6 @@ static const struct i2c_device_id tmp401_id[] = {
 	{ "tmp431", tmp431 },
 	{ "tmp432", tmp432 },
 	{ "tmp435", tmp435 },
-	{ "tmp461", tmp461 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp401_id);
@@ -570,21 +567,6 @@ static const struct attribute_group tmp432_group = {
 	.attrs = tmp432_attributes,
 };
 
-/*
- * Additional features of the TMP461 chip.
- * The TMP461 temperature offset for the remote channel.
- */
-static SENSOR_DEVICE_ATTR_2_RW(temp2_offset, temp, 6, 1);
-
-static struct attribute *tmp461_attributes[] = {
-	&sensor_dev_attr_temp2_offset.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group tmp461_group = {
-	.attrs = tmp461_attributes,
-};
-
 /*
  * Begin non sysfs callback code (aka Real code)
  */
@@ -686,7 +668,7 @@ static int tmp401_detect(struct i2c_client *client,
 static int tmp401_probe(struct i2c_client *client)
 {
 	static const char * const names[] = {
-		"TMP401", "TMP411", "TMP431", "TMP432", "TMP435", "TMP461"
+		"TMP401", "TMP411", "TMP431", "TMP432", "TMP435"
 	};
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
@@ -717,9 +699,6 @@ static int tmp401_probe(struct i2c_client *client)
 	if (data->kind == tmp432)
 		data->groups[groups++] = &tmp432_group;
 
-	if (data->kind == tmp461)
-		data->groups[groups++] = &tmp461_group;
-
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data, data->groups);
 	if (IS_ERR(hwmon_dev))
-- 
2.33.0


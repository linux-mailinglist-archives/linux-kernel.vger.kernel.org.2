Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5414C355B24
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 20:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhDFSRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 14:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbhDFSR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 14:17:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6410C06174A;
        Tue,  6 Apr 2021 11:17:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c6so16107646lji.8;
        Tue, 06 Apr 2021 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Elryf7DTE+ajkGNPBUbUw47tX7XLWuBfXwEe8faEp7U=;
        b=Q2RasqmQ1i4xIt+hQS30C4HKpDTKePb7Bxl8A4COmI+SoXf80VnURIcvvUAelmqQEL
         ZPflrRd6kBaY1mQ3if2eAn/m57v2i7AKQ8vBLteLU/QJUy/qDcLTYa6twu0+PwVKuq2M
         7/zIjLLTK0kXOcmL3XL8dEQVFqZziNqfLRMxgw859sDOaAhFf2PQ+RxUsjpp/3jnjPYN
         LDk5VU7dTWgClECgKN/APRf6/ZdFXVFwkzHtx29mSTE1gnh7Y9wMWI44weFVqNgTLYzn
         ukLz3nYugNYjVt8Q1RQle8VKhUOtFRseBk6bTtGz/o4jfgTjateAuYdPoX8wiiTIk/FO
         oUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Elryf7DTE+ajkGNPBUbUw47tX7XLWuBfXwEe8faEp7U=;
        b=IuoRDTt3ZcCAazft87XteQCmycJKJqf9FfHqJsrJtq+UiBLU6KK/8KZMMbJ2weQEx0
         ZRgUyrxpTbp+/SBR70eqrYw1ETdNyl38sJSuUqXDxr0zI4ppSTHUGC5hpMyrbchcScmN
         pKjN2z55PyCuqMGlyxrGnnHBiByiI3aLEK25ohHriWsYMH5oDYuPFRPzns1/Ez/byH/7
         pW0b5wppIObV6gZE6EokRBAg4vzJAe91UssibYc4qNyEcA4SQXlTOWMP30Emy9xJbw32
         uOd72j2iHld8SI3VaTB3nmwskateC0xExyROfOWC4gSO9CSHD6lLMGLox8HaSDPDPrR+
         dpPA==
X-Gm-Message-State: AOAM533pZ0dGYWvOuRgRDrKdNLs5acB/JezQwWN53Gbgx84Z539aLhCM
        aqUx9rOurt8GJHnCB5M3PgA=
X-Google-Smtp-Source: ABdhPJyXd7fgvuahaKbIkVMnxmoLStMkzAqaj4ghb2qvNay7OAte+L5Mn7kEb4fvgQZ+aHtxQMMVOg==
X-Received: by 2002:a2e:140b:: with SMTP id u11mr20118577ljd.125.1617733038338;
        Tue, 06 Apr 2021 11:17:18 -0700 (PDT)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-46-242-10-29.ip.moscow.rt.ru. [46.242.10.29])
        by smtp.gmail.com with ESMTPSA id b28sm2227397lfo.219.2021.04.06.11.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:17:17 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     kunyi@google.com, Konstantin Aladyshev <aladyshev22@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (sbtsi) Don't read sensor more than once if it doesn't respond
Date:   Tue,  6 Apr 2021 21:16:24 +0300
Message-Id: <20210406181624.713-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ed438518-66ad-6e08-2a1b-597ac3f2ae8d@roeck-us.net>
References: <ed438518-66ad-6e08-2a1b-597ac3f2ae8d@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBTSI sensors don't work when the CPU is off.
In this case every 'i2c_smbus_read_byte_data' function would fail
by a timeout.
Currently temp1_max/temp1_min file reads can cause two such timeouts
for every read.
Restructure code so there will be no more than one timeout for every
read operation.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
Changes in v2:
  - Fix typo in a commit message
  - Don't swap temp_int/temp_dec checks at the end of the 'sbtsi_read' function

 drivers/hwmon/sbtsi_temp.c | 55 +++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
index e35357c48b8e..4ae48635bb31 100644
--- a/drivers/hwmon/sbtsi_temp.c
+++ b/drivers/hwmon/sbtsi_temp.c
@@ -74,48 +74,47 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
 		      u32 attr, int channel, long *val)
 {
 	struct sbtsi_data *data = dev_get_drvdata(dev);
+	u8 temp_int_reg, temp_dec_reg;
 	s32 temp_int, temp_dec;
 	int err;
 
 	switch (attr) {
 	case hwmon_temp_input:
-		/*
-		 * ReadOrder bit specifies the reading order of integer and
-		 * decimal part of CPU temp for atomic reads. If bit == 0,
-		 * reading integer part triggers latching of the decimal part,
-		 * so integer part should be read first. If bit == 1, read
-		 * order should be reversed.
-		 */
-		err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
-		if (err < 0)
-			return err;
-
-		mutex_lock(&data->lock);
-		if (err & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT)) {
-			temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_DEC);
-			temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_INT);
-		} else {
-			temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_INT);
-			temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_DEC);
-		}
-		mutex_unlock(&data->lock);
+		temp_int_reg = SBTSI_REG_TEMP_INT;
+		temp_dec_reg = SBTSI_REG_TEMP_DEC;
 		break;
 	case hwmon_temp_max:
-		mutex_lock(&data->lock);
-		temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_HIGH_INT);
-		temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_HIGH_DEC);
-		mutex_unlock(&data->lock);
+		temp_int_reg = SBTSI_REG_TEMP_HIGH_INT;
+		temp_dec_reg = SBTSI_REG_TEMP_HIGH_DEC;
 		break;
 	case hwmon_temp_min:
-		mutex_lock(&data->lock);
-		temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_LOW_INT);
-		temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_LOW_DEC);
-		mutex_unlock(&data->lock);
+		temp_int_reg = SBTSI_REG_TEMP_LOW_INT;
+		temp_dec_reg = SBTSI_REG_TEMP_LOW_DEC;
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	/*
+	 * ReadOrder bit specifies the reading order of integer and
+	 * decimal part of CPU temp for atomic reads. If bit == 0,
+	 * reading integer part triggers latching of the decimal part,
+	 * so integer part should be read first. If bit == 1, read
+	 * order should be reversed.
+	 */
+	err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
+	if (err < 0)
+		return err;
+
+	mutex_lock(&data->lock);
+	if (err & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT)) {
+		temp_dec = i2c_smbus_read_byte_data(data->client, temp_dec_reg);
+		temp_int = i2c_smbus_read_byte_data(data->client, temp_int_reg);
+	} else {
+		temp_int = i2c_smbus_read_byte_data(data->client, temp_int_reg);
+		temp_dec = i2c_smbus_read_byte_data(data->client, temp_dec_reg);
+	}
+	mutex_unlock(&data->lock);
 
 	if (temp_int < 0)
 		return temp_int;
-- 
2.25.1


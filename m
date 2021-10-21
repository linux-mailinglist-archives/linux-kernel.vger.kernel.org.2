Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31667436760
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhJUQRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUQRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:17:05 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3EAC061764;
        Thu, 21 Oct 2021 09:14:48 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id n63so1484015oif.7;
        Thu, 21 Oct 2021 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WnpfHyH93J5Loag6VXxmRt8ePnyLozQcAJY/KLTa4lA=;
        b=Tp3Qo1a/Hi08VKavO9uxHeliub1Iugu8/ZaSg4FJ/77Z3ZwojloPrUbVki/QEaqyoI
         2PTmhIQcgXjF8KRrYCURBsmFQULA2SZtaYQ1XlB02js89jlTHyrUZe2J0nI+ddweaWSK
         9RxX1yT7ZCmWb4G/H8u+kiIQCz0m+q/y9ensrJzJFQ91vknJEytfe7vtlhp7CrMcgiiV
         k2+RwT3SGI42nUWxO3V/ic3mi5sgVjJ9GttejtWhvCkaVXB2M56baTAuW7jOr/4pyXeK
         44FXUlniLijvwBZt6EPCSxUf4OxRWfm3UlqtG/yGtgWD31pqWfBHiob3V/LddTcPipGx
         SIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=WnpfHyH93J5Loag6VXxmRt8ePnyLozQcAJY/KLTa4lA=;
        b=rizcRH7rBgZ0IddvMHo59nznT7bzkp80eozvC+diIFQGq4fUxmMpcR3dPL2BRSgswb
         drwjmUxHWpTsYEN+2YNJMJsiEZRd1YozjFk//gX90Jnha46NS2hJOdrvwq/f1KrOdG6D
         YgV1rUfcuJmBcb7vOmdUr6qqOVUwryplcEG3kR5GYyedkxt1nKWm0aqu8BK8bapITHVN
         NAqtqhVIg5ChfoOuMVqe76SWEET8jzqVe12Xg1cARJWEkylvBycEigTyK+wMb6fTdURU
         M418YpKqtUItZRB4xXCsS/u2oWrzP2lImAh3bw8BBdCuXtnFkqC1PmaOxAH4oc2MNU8h
         NapQ==
X-Gm-Message-State: AOAM53046W+6W0Kfh2siI7pc912itUKhP3hoVADUaFWNQ/MUmpMvGDw7
        TWbGoim3bV+BFEX2pFUIi6o=
X-Google-Smtp-Source: ABdhPJyHhWgMHKdAJqTRrtd50AmQRsgDUCW+a1v13OdHKAZ2iE3XRWT9QFD0+TAnFS3eLOE971nL2Q==
X-Received: by 2002:a05:6808:bc5:: with SMTP id o5mr4975111oik.129.1634832888228;
        Thu, 21 Oct 2021 09:14:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e59sm1177192ote.14.2021.10.21.09.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:14:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        "David T . Wilson" <david.wilson@nasa.gov>
Subject: [PATCH v2 1/3] hwmon: (lm90) Introduce flag indicating extended temperature support
Date:   Thu, 21 Oct 2021 09:14:42 -0700
Message-Id: <20211021161444.3145112-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A flag indicating extended temperature support makes it easier
to add support for additional chips with this functionality.

Cc: David T. Wilson <david.wilson@nasa.gov>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch

 drivers/hwmon/lm90.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 567b7c521f38..1a1d7bfcb30b 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -182,7 +182,8 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
 #define LM90_HAVE_EMERGENCY_ALARM (1 << 5)/* emergency alarm		*/
 #define LM90_HAVE_TEMP3		(1 << 6) /* 3rd temperature sensor	*/
 #define LM90_HAVE_BROKEN_ALERT	(1 << 7) /* Broken alert		*/
-#define LM90_PAUSE_FOR_CONFIG	(1 << 8) /* Pause conversion for config	*/
+#define LM90_HAVE_EXTENDED_TEMP	(1 << 8) /* extended temperature support*/
+#define LM90_PAUSE_FOR_CONFIG	(1 << 9) /* Pause conversion for config	*/
 
 /* LM90 status */
 #define LM90_STATUS_LTHRM	(1 << 0) /* local THERM limit tripped */
@@ -350,7 +351,7 @@ static const struct lm90_params lm90_params[] = {
 	},
 	[adt7461] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_BROKEN_ALERT,
+		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
@@ -422,7 +423,7 @@ static const struct lm90_params lm90_params[] = {
 	},
 	[tmp451] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
-		  | LM90_HAVE_BROKEN_ALERT,
+		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
 		.reg_local_ext = TMP451_REG_R_LOCAL_TEMPL,
@@ -998,7 +999,7 @@ static int lm90_get_temp11(struct lm90_data *data, int index)
 	s16 temp11 = data->temp11[index];
 	int temp;
 
-	if (data->kind == adt7461 || data->kind == tmp451)
+	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
 		temp = temp_from_u16_adt7461(data, temp11);
 	else if (data->kind == max6646)
 		temp = temp_from_u16(temp11);
@@ -1035,7 +1036,7 @@ static int lm90_set_temp11(struct lm90_data *data, int index, long val)
 		val -= 16000;
 	}
 
-	if (data->kind == adt7461 || data->kind == tmp451)
+	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
 		data->temp11[index] = temp_to_u16_adt7461(data, val);
 	else if (data->kind == max6646)
 		data->temp11[index] = temp_to_u8(val) << 8;
@@ -1062,7 +1063,7 @@ static int lm90_get_temp8(struct lm90_data *data, int index)
 	s8 temp8 = data->temp8[index];
 	int temp;
 
-	if (data->kind == adt7461 || data->kind == tmp451)
+	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
 		temp = temp_from_u8_adt7461(data, temp8);
 	else if (data->kind == max6646)
 		temp = temp_from_u8(temp8);
@@ -1098,7 +1099,7 @@ static int lm90_set_temp8(struct lm90_data *data, int index, long val)
 		val -= 16000;
 	}
 
-	if (data->kind == adt7461 || data->kind == tmp451)
+	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
 		data->temp8[index] = temp_to_u8_adt7461(data, val);
 	else if (data->kind == max6646)
 		data->temp8[index] = temp_to_u8(val);
@@ -1116,7 +1117,7 @@ static int lm90_get_temphyst(struct lm90_data *data, int index)
 {
 	int temp;
 
-	if (data->kind == adt7461 || data->kind == tmp451)
+	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
 		temp = temp_from_u8_adt7461(data, data->temp8[index]);
 	else if (data->kind == max6646)
 		temp = temp_from_u8(data->temp8[index]);
@@ -1136,7 +1137,7 @@ static int lm90_set_temphyst(struct lm90_data *data, long val)
 	int temp;
 	int err;
 
-	if (data->kind == adt7461 || data->kind == tmp451)
+	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
 		temp = temp_from_u8_adt7461(data, data->temp8[LOCAL_CRIT]);
 	else if (data->kind == max6646)
 		temp = temp_from_u8(data->temp8[LOCAL_CRIT]);
@@ -1685,7 +1686,7 @@ static int lm90_init_client(struct i2c_client *client, struct lm90_data *data)
 	lm90_set_convrate(client, data, 500); /* 500ms; 2Hz conversion rate */
 
 	/* Check Temperature Range Select */
-	if (data->kind == adt7461 || data->kind == tmp451) {
+	if (data->flags & LM90_HAVE_EXTENDED_TEMP) {
 		if (config & 0x04)
 			data->flags |= LM90_FLAG_ADT7461_EXT;
 	}
-- 
2.33.0


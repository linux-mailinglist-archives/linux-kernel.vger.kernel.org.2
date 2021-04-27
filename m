Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C7F36C1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 11:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhD0Jin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 05:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhD0Jim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 05:38:42 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D83C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 02:37:59 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q10so41939542pgj.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 02:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ySz9EGPIWcNR6VfOuBDwIZj3KzCMKoy3Eg2bpBKSCFs=;
        b=KSGOQt2BBxqrba5pWgjcu5T9PACN1ph9VV9Ot1zJcG48mn4v8aVUGstrCId/8yFQiT
         g0Y4RcteqoBbpxIVu5h3U+9ReFBrOdRkpFew/gCyU+1lfZ2UiJa/UxlrDLg0axO75S4D
         iCdJng6W4mISA9fkMo5CYOlgvQBjJGRE2rjo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ySz9EGPIWcNR6VfOuBDwIZj3KzCMKoy3Eg2bpBKSCFs=;
        b=I504fQzgY7gZynwwIGUNSWLLvi2g6GFV8br40/I6h+1jhWtjd7k7fkA6kPFUY+mrL1
         vSpBs9KrVfmdPfisotbflTJg6DV9kyJGqCyLGyWDyveELS0AtFgUEqVGOfrY6i6q5hab
         c2k7aUN7BskRCB/l+DoPPDrSrEjoGDjQw8f3AEqUCqAtFNDTLR+sr5KQ9sPZmHCBBna5
         et7suu5K6yWgwAFtyBzbivgKUnEVqiwMDQK5cFPhQzzNd1krvLf2EEYJ+AZCBnGPOzD9
         RZDgYX4K2zpOwy43gqb/6thrz1LGEoELWcuQivKo+3yxivSLDH4v4yRQXV2Y2qhzNSw1
         HSYw==
X-Gm-Message-State: AOAM532acH2uTJsTQoVkW0Eup/Mk4dx6scXDEGOcR90HOzbJaaqsB5uF
        miFWg4MT8Y6+50TVpkgg10j2cR/J3jnq4oGJ
X-Google-Smtp-Source: ABdhPJwi8yxAsWUpTwa5zsAuYIl4CwYDWGzArolifx9IwPmCQH1UXiGkYofBwOc7U/dUmkzLGIdy5Q==
X-Received: by 2002:a63:ad42:: with SMTP id y2mr21043295pgo.187.1619516278774;
        Tue, 27 Apr 2021 02:37:58 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:e57d:264c:f339:a6a7])
        by smtp.gmail.com with ESMTPSA id c125sm2142070pfa.74.2021.04.27.02.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 02:37:58 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-pm@vger.kernel.org
Cc:     hsinyi@chromium.org, Ikjoon Jang <ikjn@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: sbs-battery: do not use global variables
Date:   Tue, 27 Apr 2021 17:37:54 +0800
Message-Id: <20210427093754.3000087-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently sbs-battery driver declares three string buffers as global
variables for manufacturer, model_name, and chemistry. This patch
moves them into struct sbs_info.

Additionally, for 'chemistry' string property, suppress dev_warn() into
dev_warn_once() for some ChromeOS devices exposing chemistry property
as a non-standard string.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

---

 drivers/power/supply/sbs-battery.c | 118 ++++++++++++++++-------------
 1 file changed, 66 insertions(+), 52 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 4bf92831cb06..f51ff1d7b12f 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -188,6 +188,14 @@ static const enum power_supply_property sbs_properties[] = {
 /* Supports special manufacturer commands from TI BQ20Z65 and BQ20Z75 IC. */
 #define SBS_FLAGS_TI_BQ20ZX5		BIT(0)
 
+const enum power_supply_property string_properties[] = {
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+};
+
+#define NR_STRING_BUFFERS	ARRAY_SIZE(string_properties)
+
 struct sbs_info {
 	struct i2c_client		*client;
 	struct power_supply		*power_supply;
@@ -201,11 +209,21 @@ struct sbs_info {
 	struct delayed_work		work;
 	struct mutex			mode_lock;
 	u32				flags;
+	char				strings[NR_STRING_BUFFERS][I2C_SMBUS_BLOCK_MAX + 1];
 };
 
-static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
-static char manufacturer[I2C_SMBUS_BLOCK_MAX + 1];
-static char chemistry[I2C_SMBUS_BLOCK_MAX + 1];
+static char *sbs_get_string_buf(struct sbs_info *chip,
+				enum power_supply_property psp)
+{
+	int i = 0;
+
+	for (i = 0; i < NR_STRING_BUFFERS; i++)
+		if (string_properties[i] == psp)
+			return chip->strings[i];
+
+	return ERR_PTR(-EINVAL);
+}
+
 static bool force_load;
 
 static int sbs_read_word_data(struct i2c_client *client, u8 address);
@@ -639,17 +657,43 @@ static int sbs_get_battery_property(struct i2c_client *client,
 	return 0;
 }
 
-static int sbs_get_battery_string_property(struct i2c_client *client,
-	int reg_offset, enum power_supply_property psp, char *val)
+static int sbs_get_property_index(struct i2c_client *client,
+	enum power_supply_property psp)
 {
-	s32 ret;
+	int count;
+
+	for (count = 0; count < ARRAY_SIZE(sbs_data); count++)
+		if (psp == sbs_data[count].psp)
+			return count;
+
+	dev_warn(&client->dev,
+		"%s: Invalid Property - %d\n", __func__, psp);
+
+	return -EINVAL;
+}
 
-	ret = sbs_read_string_data(client, sbs_data[reg_offset].addr, val);
+static const char *sbs_get_battery_string_property(struct sbs_info *chip,
+			enum power_supply_property psp)
+{
+	int ret;
+	char *buf;
+	u8 addr;
 
+	ret = sbs_get_property_index(chip->client, psp);
 	if (ret < 0)
-		return ret;
+		return ERR_PTR(ret);
 
-	return 0;
+	addr = sbs_data[ret].addr;
+
+	buf = sbs_get_string_buf(chip, psp);
+	if (IS_ERR(buf))
+		return buf;
+
+	ret = sbs_read_string_data(chip->client, addr, buf);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	return buf;
 }
 
 static void  sbs_unit_adjustment(struct i2c_client *client,
@@ -772,34 +816,14 @@ static int sbs_get_battery_serial_number(struct i2c_client *client,
 	return 0;
 }
 
-static int sbs_get_property_index(struct i2c_client *client,
-	enum power_supply_property psp)
-{
-	int count;
-	for (count = 0; count < ARRAY_SIZE(sbs_data); count++)
-		if (psp == sbs_data[count].psp)
-			return count;
-
-	dev_warn(&client->dev,
-		"%s: Invalid Property - %d\n", __func__, psp);
-
-	return -EINVAL;
-}
-
-static int sbs_get_chemistry(struct i2c_client *client,
+static int sbs_get_chemistry(struct sbs_info *chip,
 		union power_supply_propval *val)
 {
-	enum power_supply_property psp = POWER_SUPPLY_PROP_TECHNOLOGY;
-	int ret;
+	const char *chemistry = sbs_get_battery_string_property(chip,
+					POWER_SUPPLY_PROP_TECHNOLOGY);
 
-	ret = sbs_get_property_index(client, psp);
-	if (ret < 0)
-		return ret;
-
-	ret = sbs_get_battery_string_property(client, ret, psp,
-					      chemistry);
-	if (ret < 0)
-		return ret;
+	if (IS_ERR(chemistry))
+		return PTR_ERR(chemistry);
 
 	if (!strncasecmp(chemistry, "LION", 4))
 		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
@@ -813,7 +837,7 @@ static int sbs_get_chemistry(struct i2c_client *client,
 		val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 
 	if (val->intval == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
-		dev_warn(&client->dev, "Unknown chemistry: %s\n", chemistry);
+		dev_warn_once(&chip->client->dev, "Unknown chemistry: %s\n", chemistry);
 
 	return 0;
 }
@@ -857,6 +881,7 @@ static int sbs_get_property(struct power_supply *psy,
 	int ret = 0;
 	struct sbs_info *chip = power_supply_get_drvdata(psy);
 	struct i2c_client *client = chip->client;
+	const char *str;
 
 	if (chip->gpio_detect) {
 		ret = gpiod_get_value_cansleep(chip->gpio_detect);
@@ -882,7 +907,7 @@ static int sbs_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		ret = sbs_get_chemistry(client, val);
+		ret = sbs_get_chemistry(chip, val);
 		if (ret < 0)
 			break;
 
@@ -934,23 +959,12 @@ static int sbs_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_MODEL_NAME:
-		ret = sbs_get_property_index(client, psp);
-		if (ret < 0)
-			break;
-
-		ret = sbs_get_battery_string_property(client, ret, psp,
-						      model_name);
-		val->strval = model_name;
-		break;
-
 	case POWER_SUPPLY_PROP_MANUFACTURER:
-		ret = sbs_get_property_index(client, psp);
-		if (ret < 0)
-			break;
-
-		ret = sbs_get_battery_string_property(client, ret, psp,
-						      manufacturer);
-		val->strval = manufacturer;
+		str = sbs_get_battery_string_property(chip, psp);
+		if (IS_ERR(str))
+			ret = PTR_ERR(str);
+		else
+			val->strval = str;
 		break;
 
 	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
-- 
2.31.1.498.g6c1eba8ee3d-goog


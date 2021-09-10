Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8778C406CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 15:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhIJNJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 09:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhIJNJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 09:09:15 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237F5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 06:08:04 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id f14-20020a056214076e00b003773e95910bso11343762qvz.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VlEvmbNQwy3WmS2EQy0HYXvO2GX3J+VeN2uTtXQzNEw=;
        b=aEty1M6v3onP/TzNYUjjg8fLjsuTPY1KpFNe+CUE9lAe3xc5TMCSj0e/mFsNJnnJzS
         +VV5cr15Bf962XUkzeYcKNZkwBKvEzSv1T2BQzy34NAc19DXx3J3BoLZX+D+fGbf5nVf
         Mq68wY7eXNSg3/QSjkHmdXEhqwBmR3vgwqz+wBXrf40NSdcpqMXuk4mI5rKejWmwWtr2
         GqOhYdyHHcPWG2IknAZx5b2LXQxV+5TUnL4sLt3lsmvGXl3Ciigtg5joQxCGcm80zMCI
         m9/SfnxTayY80iSAXk1QpoGg4Xwl4UC2UexFuOtZiOQloPva6BWOwFRcXNa7DRboYnnB
         UgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VlEvmbNQwy3WmS2EQy0HYXvO2GX3J+VeN2uTtXQzNEw=;
        b=0jC6d3MUkftBxWWvaBvXHsf47/b+BTNI10WwBE1sbOtnwgxIJTS+Ap4QWqGW4eCN23
         EkRv/oXnhiH2ht6a7yIRQPat4i/fA7ssJ6UfY9kcUrpvTudqs9cdCuw1JwMSSveg6ir1
         2IQaZvhH3SOV0hKGJCJE1Ac4gy/j1Wsb5go2yriuTRa3MWQzdyTAJS8jVA3Cz7HPsUe8
         okfqI5khg6uML14VmgosH2bAi/W8N0G2853zeT6CJ3zCiv15hEZRegeommFgXQ5hpmre
         A2XzzJfqAYoQuz6dT5XYwOKqCfBtca2/ylwr7WHW0cAcbzv+dANVHw8nMb4tm2JbUXPR
         hLhA==
X-Gm-Message-State: AOAM531x8T7bji/+HUjWf4AohEjNzfj0mJ9uBGOE9Bu1D6seS1V2FR1g
        hfVRDIWrDjQsYK6x/QezVqM9CPk=
X-Google-Smtp-Source: ABdhPJyPD1ADed2h+UH2uHbGSNgQPP9rRBimuBwL5GIjA4u65O9GzOBu380ZblAyXQlDe5mqIMjFA78=
X-Received: from osk.cam.corp.google.com ([2620:0:1004:1a:42c6:8506:76cb:83dc])
 (user=osk job=sendgmr) by 2002:a05:6214:1a05:: with SMTP id
 fh5mr8382352qvb.45.1631279283253; Fri, 10 Sep 2021 06:08:03 -0700 (PDT)
Date:   Fri, 10 Sep 2021 09:07:55 -0400
Message-Id: <20210910130755.2027995-1-osk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] hwmon: (nct7802) Make RTD modes configurable.
From:   Oskar Senft <osk@google.com>
To:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Oskar Senft <osk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change allows the RTD modes to be configurable via device tree
bindings. When the setting is not present via device tree, the driver
still defaults to the previous behavior where the RTD modes are left
alone.

Signed-off-by: Oskar Senft <osk@google.com>
---
 drivers/hwmon/nct7802.c | 94 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 604af2f6103a..6a6ab529bdd3 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -51,6 +51,24 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] = {
 #define REG_CHIP_ID		0xfe
 #define REG_VERSION_ID		0xff
 
+/*
+ * Sensor modes according to 7.2.32 Mode Selection Register
+ */
+#define RTD_MODE_CLOSED		0x0
+#define RTD_MODE_CURRENT	0x1
+#define RTD_MODE_THERMISTOR	0x2
+#define RTD_MODE_VOLTAGE	0x3
+#define RTD_MODE_UNDEFINED	0xf
+
+#define MODE_BITS_MASK		0x3
+
+/*
+ * Bit offsets for sensors modes in REG_MODE
+ */
+#define MODE_OFFSET_RTD1	0
+#define MODE_OFFSET_RTD2	2
+#define MODE_OFFSET_RTD3	4
+
 /*
  * Data structures and manipulation thereof
  */
@@ -1038,7 +1056,9 @@ static const struct regmap_config nct7802_regmap_config = {
 	.volatile_reg = nct7802_regmap_is_volatile,
 };
 
-static int nct7802_init_chip(struct nct7802_data *data)
+static int nct7802_init_chip(struct nct7802_data *data,
+	unsigned char rtd1_mode, unsigned char rtd2_mode,
+	unsigned char rtd3_mode)
 {
 	int err;
 
@@ -1052,15 +1072,57 @@ static int nct7802_init_chip(struct nct7802_data *data)
 	if (err)
 		return err;
 
+	/* Configure sensor modes */
+	if ((rtd1_mode & MODE_BITS_MASK) == rtd1_mode) {
+		err = regmap_update_bits(data->regmap, REG_MODE,
+			MODE_BITS_MASK << MODE_OFFSET_RTD1,
+			rtd1_mode << MODE_OFFSET_RTD1);
+		if (err)
+			return err;
+	}
+	if ((rtd2_mode & MODE_BITS_MASK) == rtd2_mode) {
+		err = regmap_update_bits(data->regmap, REG_MODE,
+			MODE_BITS_MASK << MODE_OFFSET_RTD2,
+			rtd2_mode << MODE_OFFSET_RTD2);
+		if (err)
+			return err;
+	}
+	if ((rtd3_mode & MODE_BITS_MASK) == rtd3_mode) {
+		err = regmap_update_bits(data->regmap, REG_MODE,
+			MODE_BITS_MASK << MODE_OFFSET_RTD3,
+			rtd3_mode << MODE_OFFSET_RTD3);
+		if (err)
+			return err;
+	}
+
 	/* Enable Vcore and VCC voltage monitoring */
 	return regmap_update_bits(data->regmap, REG_VMON_ENABLE, 0x03, 0x03);
 }
 
+static unsigned char rtd_mode_from_string(const char *value)
+{
+	if (!strcmp(value, "closed"))
+		return RTD_MODE_CLOSED;
+	if (!strcmp(value, "current"))
+		return RTD_MODE_CURRENT;
+	if (!strcmp(value, "thermistor"))
+		return RTD_MODE_THERMISTOR;
+	if (!strcmp(value, "voltage"))
+		return RTD_MODE_VOLTAGE;
+
+	return RTD_MODE_UNDEFINED;
+}
+
 static int nct7802_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct nct7802_data *data;
 	struct device *hwmon_dev;
+	int rtd_mode_count;
+	unsigned char rtd1_mode = RTD_MODE_UNDEFINED;
+	unsigned char rtd2_mode = RTD_MODE_UNDEFINED;
+	unsigned char rtd3_mode = RTD_MODE_UNDEFINED;
+	const char *prop_value;
 	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -1074,7 +1136,25 @@ static int nct7802_probe(struct i2c_client *client)
 	mutex_init(&data->access_lock);
 	mutex_init(&data->in_alarm_lock);
 
-	ret = nct7802_init_chip(data);
+	if (dev->of_node) {
+		rtd_mode_count = of_property_count_strings(dev->of_node,
+			"nuvoton,rtd-modes");
+
+		if (rtd_mode_count > 0)
+			if (!of_property_read_string_index(dev->of_node,
+				"nuvoton,rtd-modes", 0, &prop_value))
+				rtd1_mode = rtd_mode_from_string(prop_value);
+		if (rtd_mode_count > 1)
+			if (!of_property_read_string_index(dev->of_node,
+				"nuvoton,rtd-modes", 1, &prop_value))
+				rtd2_mode = rtd_mode_from_string(prop_value);
+		if (rtd_mode_count > 2)
+			if (!of_property_read_string_index(dev->of_node,
+				"nuvoton,rtd-modes", 2, &prop_value))
+				rtd3_mode = rtd_mode_from_string(prop_value);
+	}
+
+	ret = nct7802_init_chip(data, rtd1_mode, rtd2_mode, rtd3_mode);
 	if (ret < 0)
 		return ret;
 
@@ -1094,10 +1174,20 @@ static const struct i2c_device_id nct7802_idtable[] = {
 };
 MODULE_DEVICE_TABLE(i2c, nct7802_idtable);
 
+static const struct of_device_id __maybe_unused nct7802_of_match[] = {
+	{
+		.compatible = "nuvoton,nct7802",
+		.data = 0
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, nct7802_of_match);
+
 static struct i2c_driver nct7802_driver = {
 	.class = I2C_CLASS_HWMON,
 	.driver = {
 		.name = DRVNAME,
+		.of_match_table = of_match_ptr(nct7802_of_match),
 	},
 	.detect = nct7802_detect,
 	.probe_new = nct7802_probe,
-- 
2.33.0.309.g3052b89438-goog


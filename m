Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547A9427E96
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 05:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJJDdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 23:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhJJDdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 23:33:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A77C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 20:31:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so18377468ybk.16
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 20:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GTFBSlmBEa7odVv9MwgpMymtH3E72sgHzXsh/md0g9k=;
        b=fztNZ+tuHSBVQ+F0Re1E3H950emA6aSsoX/k5Nk4JiMboTGOHsOTsyk///xHjIN7nY
         cQpk1oIoSpkXE6TGeKBYR+JHkRmdPoS2KYx9ukc12niGB2SMSe0pPY4tEBdUNlNDusM0
         kbTDnsrroXqk9u7JriuGQB8cs2C/mv8QY81TbOXmAotdkb1UzVYipyHSG6795yopD5dL
         CxiGtsrvCFRHscNB7/DgpzUV35ciNo10uKI4sVljvK4x/K633y55kYgC37mYzgvrESVY
         KZqRKIA3p3oHnqBpF9G7McCdNxgqdenUdPeab7r0dGkuz9l0SqgB5onesqCxdf2tQz1d
         31Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GTFBSlmBEa7odVv9MwgpMymtH3E72sgHzXsh/md0g9k=;
        b=joanP3cKeTlaByZMK/E1DpTj6Wy4ZwMumuJFbity39ZvVMqwX3J7fzRpdTBTwWz6td
         HTd8KO3drMD1Y8vSC1c9ZbGiPiZ1KFEKQvV3p/7ikCtDNQ6T0fLntIS022xDQU0UZyrN
         6fZaLFJz0/aVY9QPoFwx9SyB690Qlsj5Mro0oZvOGtu8DPJQR4VoCmqs/nWaOnjx+8cL
         94hzclTv9qF7RMzNtlvj86hw02auna0rc5iUBJAwi9R8JvpeTBol8s0y6jemuE0xS0bq
         nmgRzwO8TGgvAawkxmkxEg36SKMzVnqDrB4DW8xMLqz+UkZdTJmh5VgoHu4s78qQBMls
         4NjA==
X-Gm-Message-State: AOAM532t6GrPgTfy9ADNizZ+hODxFXec4vc85j+trmHF0mgd4ze4jZ7p
        9glAThK96hpK1EYOSRMYXyojPqM=
X-Google-Smtp-Source: ABdhPJxfJfZbJWJMRGv30fvKYBtkmUp+/KyFDdRza+LRta/JvYZSuIIYGTVjBoVoCtl1wGhcD7wagF4=
X-Received: from osk.cam.corp.google.com ([2620:0:1004:1a:cf37:dd81:3340:f4a7])
 (user=osk job=sendgmr) by 2002:a25:5646:: with SMTP id k67mr13586251ybb.127.1633836679955;
 Sat, 09 Oct 2021 20:31:19 -0700 (PDT)
Date:   Sat,  9 Oct 2021 23:31:12 -0400
In-Reply-To: <20211010033112.3621816-1-osk@google.com>
Message-Id: <20211010033112.3621816-2-osk@google.com>
Mime-Version: 1.0
References: <20211010033112.3621816-1-osk@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v6 2/2] hwmon: (nct7802) Make temperature/voltage sensors configurable
From:   Oskar Senft <osk@google.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Oskar Senft <osk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change allows LTD and RTD inputs to be configured via
device tree bindings. If the DT bindings are not present or
invalid, the input configuration is not modified and left at
HW defaults.

Signed-off-by: Oskar Senft <osk@google.com>
---
Changes from PATCH v5:
- Removed unused "found_channel_config" variable.
- Initialize mode_mask and mode_val to defaults.
---
 drivers/hwmon/nct7802.c | 129 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 604af2f6103a..d56f78327619 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -51,6 +51,23 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] = {
 #define REG_CHIP_ID		0xfe
 #define REG_VERSION_ID		0xff
 
+/*
+ * Resistance temperature detector (RTD) modes according to 7.2.32 Mode
+ * Selection Register
+ */
+#define RTD_MODE_CURRENT	0x1
+#define RTD_MODE_THERMISTOR	0x2
+#define RTD_MODE_VOLTAGE	0x3
+
+#define MODE_RTD_MASK		0x3
+#define MODE_LTD_EN		0x40
+
+/*
+ * Bit offset for sensors modes in REG_MODE.
+ * Valid for index 0..2, indicating RTD1..3.
+ */
+#define MODE_BIT_OFFSET_RTD(index) ((index) * 2)
+
 /*
  * Data structures and manipulation thereof
  */
@@ -1038,7 +1055,112 @@ static const struct regmap_config nct7802_regmap_config = {
 	.volatile_reg = nct7802_regmap_is_volatile,
 };
 
-static int nct7802_init_chip(struct nct7802_data *data)
+static int nct7802_get_channel_config(struct device *dev,
+				      struct device_node *node, u8 *mode_mask,
+				      u8 *mode_val)
+{
+	u32 reg;
+	const char *type_str, *md_str;
+	u8 md;
+
+	if (!node->name || of_node_cmp(node->name, "channel"))
+		return 0;
+
+	if (of_property_read_u32(node, "reg", &reg)) {
+		dev_err(dev, "Could not read reg value for '%s'\n",
+			node->full_name);
+		return -EINVAL;
+	}
+
+	if (reg > 3) {
+		dev_err(dev, "Invalid reg (%u) in '%s'\n", reg,
+			node->full_name);
+		return -EINVAL;
+	}
+
+	if (reg == 0) {
+		if (!of_device_is_available(node))
+			*mode_val &= ~MODE_LTD_EN;
+		else
+			*mode_val |= MODE_LTD_EN;
+		*mode_mask |= MODE_LTD_EN;
+		return 0;
+	}
+
+	/* At this point we have reg >= 1 && reg <= 3 */
+
+	if (!of_device_is_available(node)) {
+		*mode_val &= ~(MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1));
+		*mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
+		return 0;
+	}
+
+	if (of_property_read_string(node, "sensor-type", &type_str)) {
+		dev_err(dev, "No type for '%s'\n", node->full_name);
+		return -EINVAL;
+	}
+
+	if (!strcmp(type_str, "voltage")) {
+		*mode_val |= (RTD_MODE_VOLTAGE & MODE_RTD_MASK)
+			     << MODE_BIT_OFFSET_RTD(reg - 1);
+		*mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
+		return 0;
+	}
+
+	if (strcmp(type_str, "temperature")) {
+		dev_err(dev, "Invalid type '%s' for '%s'\n", type_str,
+			node->full_name);
+		return -EINVAL;
+	}
+
+	if (reg == 3) {
+		/* RTD3 only supports thermistor mode */
+		md = RTD_MODE_THERMISTOR;
+	} else {
+		if (of_property_read_string(node, "temperature-mode",
+					    &md_str)) {
+			dev_err(dev, "No mode for '%s'\n", node->full_name);
+			return -EINVAL;
+		}
+
+		if (!strcmp(md_str, "thermal-diode"))
+			md = RTD_MODE_CURRENT;
+		else if (!strcmp(md_str, "thermistor"))
+			md = RTD_MODE_THERMISTOR;
+		else {
+			dev_err(dev, "Invalid mode '%s' for '%s'\n", md_str,
+				node->full_name);
+			return -EINVAL;
+		}
+	}
+
+	*mode_val |= (md & MODE_RTD_MASK) << MODE_BIT_OFFSET_RTD(reg - 1);
+	*mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
+
+	return 0;
+}
+
+static int nct7802_configure_channels(struct device *dev,
+				      struct nct7802_data *data)
+{
+	/* Enable local temperature sensor by default */
+	u8 mode_mask = MODE_LTD_EN, mode_val = MODE_LTD_EN;
+	struct device_node *node;
+	int err;
+
+	if (dev->of_node) {
+		for_each_child_of_node(dev->of_node, node) {
+			err = nct7802_get_channel_config(dev, node, &mode_mask,
+							 &mode_val);
+			if (err)
+				return err;
+		}
+	}
+
+	return regmap_update_bits(data->regmap, REG_MODE, mode_mask, mode_val);
+}
+
+static int nct7802_init_chip(struct device *dev, struct nct7802_data *data)
 {
 	int err;
 
@@ -1047,8 +1169,7 @@ static int nct7802_init_chip(struct nct7802_data *data)
 	if (err)
 		return err;
 
-	/* Enable local temperature sensor */
-	err = regmap_update_bits(data->regmap, REG_MODE, 0x40, 0x40);
+	err = nct7802_configure_channels(dev, data);
 	if (err)
 		return err;
 
@@ -1074,7 +1195,7 @@ static int nct7802_probe(struct i2c_client *client)
 	mutex_init(&data->access_lock);
 	mutex_init(&data->in_alarm_lock);
 
-	ret = nct7802_init_chip(data);
+	ret = nct7802_init_chip(dev, data);
 	if (ret < 0)
 		return ret;
 
-- 
2.33.0.882.g93a45727a2-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803A94276C8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 04:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244118AbhJIDBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 23:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244041AbhJIDBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 23:01:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB5AC061762
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 19:59:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z130-20020a256588000000b005b6b4594129so15189365ybb.15
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 19:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MuY5EcfJUpO26mkR5YwnAB+nrV65iR50asRjerTqYeA=;
        b=fFDcv0UhAN0UxjmKT63092Bim9C2vkDRif/TAxYiS1BpWoRuLChjZZo/2jSDn0uIzW
         qoWivJu/K1hCAF3Tw9/xeF+O40lRLAFW6FNb6MOAioW11LKoxG0Z+fwEfuT/3cHtWw/T
         6mrmQ9eeVPOSQ+oPSWWYokpTLcB3ToZimcXnIXwq2IqFlXTE0PYhnN93HAyyjjDS3/sN
         96P6eFdilf78JhSuxdM0nt6JBacl7oqWz4djMQzupvIsVjIbrBDWSO6946Tp23mBvqKL
         GIGcCcWTeRQHUGzH6srAEmfY/H0zopOPiefH6CB0xe5N+3nR0sEa8NmBZgJBSw0panrb
         +maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MuY5EcfJUpO26mkR5YwnAB+nrV65iR50asRjerTqYeA=;
        b=mHloLoxhKLFrGonw7tkNuFeYJbskEcwHa7oDSIn7JqHKgtKQBLJVzJ63SsHixq2Aal
         PL8zscqae6A8qtK9iYtkDvf4TcJl0FS0KccTxLISIR0yN9NW0WEH348Ygj6hL0/LU9MH
         H2/Yc2kGOmHPNGf/7uY35PKWiTOtYEsohqEV/jLMp8H6+zoiOL0k//1sTHewJbejLDEa
         iynXRiBMB3koY4aUh7eLlHaD4lu6CYNExz99Nyj0QpO1wxTP5+FYuiIGNQ7kv7Xq7Q2n
         FlXrcUa5s8cldPk+faqtqFptlHgjdJzog3Pw8BGzHQd7yvz+gN2YJKiH0FvJCZLYfdBx
         WiNQ==
X-Gm-Message-State: AOAM531F1Pc9nWzANKq2KdpyMPA6USeE3BTNUqlE+kOL1one8VRhJmpK
        Z7QUzPGCkYxJh1UUoaEq9STI6vQ=
X-Google-Smtp-Source: ABdhPJx97zawVJod7HuVi5dTuo7JdWJ5GD177xLMfbki3rqoO8oISy7GwABXlMYukGACDijEAJy4CRM=
X-Received: from osk.cam.corp.google.com ([2620:0:1004:1a:acb9:8fa6:8db4:ee39])
 (user=osk job=sendgmr) by 2002:a25:4241:: with SMTP id p62mr7412807yba.325.1633748346973;
 Fri, 08 Oct 2021 19:59:06 -0700 (PDT)
Date:   Fri,  8 Oct 2021 22:58:58 -0400
In-Reply-To: <20211009025858.3326725-1-osk@google.com>
Message-Id: <20211009025858.3326725-2-osk@google.com>
Mime-Version: 1.0
References: <20211009025858.3326725-1-osk@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v4 2/2] hwmon: (nct7802) Make temperature sensors configurable.
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
device tree bindings. If the DT bindings are not present,
the input configuration is not modified and left at HW
defaults.

Signed-off-by: Oskar Senft <osk@google.com>
---
 drivers/hwmon/nct7802.c | 158 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 144 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 604af2f6103a..5a7e38e8a188 100644
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
@@ -74,7 +91,9 @@ static ssize_t temp_type_show(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%u\n", (mode >> (2 * sattr->index) & 3) + 2);
+	return sprintf(buf, "%u\n",
+			((mode >> MODE_BIT_OFFSET_RTD(sattr->index)) &
+				MODE_RTD_MASK) + 2);
 }
 
 static ssize_t temp_type_store(struct device *dev,
@@ -94,7 +113,8 @@ static ssize_t temp_type_store(struct device *dev,
 	if (type < 3 || type > 4)
 		return -EINVAL;
 	err = regmap_update_bits(data->regmap, REG_MODE,
-			3 << 2 * sattr->index, (type - 2) << 2 * sattr->index);
+			MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(sattr->index),
+			(type - 2) << MODE_BIT_OFFSET_RTD(sattr->index));
 	return err ? : count;
 }
 
@@ -682,24 +702,24 @@ static umode_t nct7802_temp_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct nct7802_data *data = dev_get_drvdata(dev);
 	unsigned int reg;
+	unsigned int rtd_mode;
 	int err;
 
 	err = regmap_read(data->regmap, REG_MODE, &reg);
 	if (err < 0)
 		return 0;
 
-	if (index < 10 &&
-	    (reg & 03) != 0x01 && (reg & 0x03) != 0x02)		/* RD1 */
+	rtd_mode = (reg >> MODE_BIT_OFFSET_RTD(index / 10)) & MODE_RTD_MASK;
+	if (index >= 0 && index < 20 &&				/* RD1, RD 2*/
+	    rtd_mode != 0x01 && rtd_mode != 0x02)
 		return 0;
 
-	if (index >= 10 && index < 20 &&
-	    (reg & 0x0c) != 0x04 && (reg & 0x0c) != 0x08)	/* RD2 */
-		return 0;
-	if (index >= 20 && index < 30 && (reg & 0x30) != 0x20)	/* RD3 */
+	if (index >= 20 && index < 30 && rtd_mode != 0x02)	/* RD3 */
 		return 0;
 
-	if (index >= 30 && index < 38)				/* local */
-		return attr->mode;
+	if (index >= 30 && index < 38 &&			/* local */
+	    (reg & MODE_LTD_EN) != MODE_LTD_EN)
+		return 0;
 
 	err = regmap_read(data->regmap, REG_PECI_ENABLE, &reg);
 	if (err < 0)
@@ -1038,7 +1058,118 @@ static const struct regmap_config nct7802_regmap_config = {
 	.volatile_reg = nct7802_regmap_is_volatile,
 };
 
-static int nct7802_init_chip(struct nct7802_data *data)
+static bool nct7802_get_input_config(struct device *dev,
+	struct device_node *input, u8 *mode_mask, u8 *mode_val)
+{
+	u32 reg;
+	const char *type_str, *md_str;
+	u8 md;
+
+	if (!input->name || of_node_cmp(input->name, "input"))
+		return false;
+
+	if (of_property_read_u32(input, "reg", &reg)) {
+		dev_err(dev, "Could not read reg value for '%s'\n",
+			input->full_name);
+		return false;
+	}
+
+	if (reg > 3) {
+		dev_err(dev,
+			"Invalid reg (%u) in '%s'\n", reg, input->full_name);
+		return false;
+	}
+
+	if (reg == 0) {
+		if (!of_device_is_available(input))
+			*mode_val &= ~MODE_LTD_EN;
+		else
+			*mode_val |= MODE_LTD_EN;
+		*mode_mask |= MODE_LTD_EN;
+		return true;
+	}
+
+	if (reg >= 1 && reg <= 3 && !of_device_is_available(input)) {
+		*mode_val &= ~(MODE_RTD_MASK
+			<< MODE_BIT_OFFSET_RTD(reg-1));
+		*mode_mask |= MODE_RTD_MASK
+			<< MODE_BIT_OFFSET_RTD(reg-1);
+		return true;
+	}
+
+	if (of_property_read_string(input, "sensor-type", &type_str)) {
+		dev_err(dev, "No type for '%s'\n", input->full_name);
+		return false;
+	}
+
+	if (!strcmp(type_str, "voltage")) {
+		*mode_val |= (RTD_MODE_VOLTAGE & MODE_RTD_MASK)
+			<< MODE_BIT_OFFSET_RTD(reg-1);
+		*mode_mask |= MODE_RTD_MASK
+			<< MODE_BIT_OFFSET_RTD(reg-1);
+		return true;
+	}
+
+	if (strcmp(type_str, "temperature")) {
+		dev_err(dev, "Invalid type '%s' for '%s'\n", type_str,
+			input->full_name);
+		return false;
+	}
+
+	if (reg == 3) {
+		/* RTD3 only supports thermistor mode */
+		md = RTD_MODE_THERMISTOR;
+	} else {
+		if (of_property_read_string(input, "temperature-mode",
+								&md_str)) {
+			dev_err(dev, "No mode for '%s'\n", input->full_name);
+			return false;
+		}
+
+		if (!strcmp(md_str, "thermal-diode"))
+			md = RTD_MODE_CURRENT;
+		else if (!strcmp(md_str, "thermistor"))
+			md = RTD_MODE_THERMISTOR;
+		else {
+			dev_err(dev, "Invalid mode '%s' for '%s'\n", md_str,
+				input->full_name);
+			return false;
+		}
+	}
+
+	*mode_val |= (md & MODE_RTD_MASK)
+		<< MODE_BIT_OFFSET_RTD(reg-1);
+	*mode_mask |= MODE_RTD_MASK
+		<< MODE_BIT_OFFSET_RTD(reg-1);
+
+	return true;
+}
+
+static int nct7802_configure_inputs(struct device *dev,
+	struct nct7802_data *data)
+{
+	bool found_input_config = false;
+	u8 mode_mask = 0, mode_val = 0;
+	struct device_node *input;
+
+	if (dev->of_node) {
+		for_each_child_of_node(dev->of_node, input) {
+			if (nct7802_get_input_config(dev, input, &mode_mask,
+					&mode_val))
+				found_input_config = true;
+		}
+	}
+
+	if (!found_input_config) {
+		/* Enable local temperature sensor by default */
+		mode_val |= MODE_LTD_EN;
+		mode_mask |= MODE_LTD_EN;
+	}
+
+	return regmap_update_bits(data->regmap, REG_MODE, mode_mask, mode_val);
+}
+
+static int nct7802_init_chip(struct device *dev, struct nct7802_data *data)
 {
 	int err;
 
@@ -1047,8 +1178,7 @@ static int nct7802_init_chip(struct nct7802_data *data)
 	if (err)
 		return err;
 
-	/* Enable local temperature sensor */
-	err = regmap_update_bits(data->regmap, REG_MODE, 0x40, 0x40);
+	err = nct7802_configure_inputs(dev, data);
 	if (err)
 		return err;
 
@@ -1074,7 +1204,7 @@ static int nct7802_probe(struct i2c_client *client)
 	mutex_init(&data->access_lock);
 	mutex_init(&data->in_alarm_lock);
 
-	ret = nct7802_init_chip(data);
+	ret = nct7802_init_chip(dev, data);
 	if (ret < 0)
 		return ret;
 
-- 
2.33.0.882.g93a45727a2-goog


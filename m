Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF91427CDD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhJISzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 14:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhJISzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 14:55:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BEDC061764
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 11:53:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j193-20020a2523ca000000b005b789d71d9aso17166033ybj.21
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 11:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uXK4s0x5l6f3p7uiREPFtHGfBMw9RXdTSan5p/kAGQg=;
        b=JFrwD4Eubrlz94yWeT7kjLkFXO4W9PzJQ56sWaW99CViOVIeLz5yKQq/c3/Yvhnatc
         lpsJ5j2Vyi+CsZHqh+CG9YH0J+lf33sbZ5bNJ7opZMUHtUFab9Ok1BclOmTHlprYSFc3
         V7peFxfQP1toHe62MD1fxsVgUa9wE6fo3lCo36tPhG1jXc0FqWsGs3qg2cNivhFYEAu7
         XX+x6XA2SxkyZg4zFkGYZZGXFrTgCsbk5GQRVg+DtJOisXn3e9WecrjDkWh5qYOMXvGz
         0gt/hs9z6qweCse/a3k5Xhw3tnuYoHwF+pYtzS2fgHyLW+zfrmZu+gOI2qdERr5+OVt5
         VpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uXK4s0x5l6f3p7uiREPFtHGfBMw9RXdTSan5p/kAGQg=;
        b=iKrDPH7Y6RJsl48g1zDRCBYkmdjHsb63+Mp5E47ZDJ/Or5hi+D6sHaLXcP0pbU84Za
         ZFFyx5OPAxCPCot/EA7DdWdWM5ZwCwFUU7Bnw+tvR+WvX4u95l/1tioIcgbxxh8/czO6
         +FDkiTURpSM0pA89eXNgSHxdpikSe6s6JM3738MygVGeW1YK/q033x5Ay8mXmgTtGL8q
         aHiKjpElVkHTgJIdbwD7GZ+M1Wr1EJtMkOZfeTbWc/WAr3RWYybFO4orhgWeb9ZyQoXE
         8fqlWIqoGFII1yhrsyf5pWtoLrqUunhgS7ycX3fAV7Y8xAvzMDH+KaLK/w98qg/8+zxr
         Odsw==
X-Gm-Message-State: AOAM532pMExySiLR+yLkY/g4ClKmOLoRzs5ppLhBuXlMQPKm5OUjkOTc
        Fx2U5t+l+UFBmYF+ISF/NcpIwcE=
X-Google-Smtp-Source: ABdhPJwr37XefjTzdvM99GJxKu7vK3jPY9upRnirPDhMDuux52awMuqYwgwvgIvFr5NJ6MbEuHBvJ28=
X-Received: from osk.cam.corp.google.com ([2620:0:1004:1a:cf37:dd81:3340:f4a7])
 (user=osk job=sendgmr) by 2002:a25:1ac6:: with SMTP id a189mr11346643yba.149.1633805584570;
 Sat, 09 Oct 2021 11:53:04 -0700 (PDT)
Date:   Sat,  9 Oct 2021 14:52:57 -0400
In-Reply-To: <20211009185257.2230013-1-osk@google.com>
Message-Id: <20211009185257.2230013-2-osk@google.com>
Mime-Version: 1.0
References: <20211009185257.2230013-1-osk@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v5 2/2] hwmon: (nct7802) Make temperature/voltage sensors configurable
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
 drivers/hwmon/nct7802.c | 133 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 604af2f6103a..e28f8eaf9f0f 100644
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
@@ -1038,7 +1055,116 @@ static const struct regmap_config nct7802_regmap_config = {
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
+	bool found_channel_config = false;
+	u8 mode_mask = 0, mode_val = 0;
+	struct device_node *node;
+	int err;
+
+	/* Enable local temperature sensor by default */
+	mode_val |= MODE_LTD_EN;
+	mode_mask |= MODE_LTD_EN;
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
 
@@ -1047,8 +1173,7 @@ static int nct7802_init_chip(struct nct7802_data *data)
 	if (err)
 		return err;
 
-	/* Enable local temperature sensor */
-	err = regmap_update_bits(data->regmap, REG_MODE, 0x40, 0x40);
+	err = nct7802_configure_channels(dev, data);
 	if (err)
 		return err;
 
@@ -1074,7 +1199,7 @@ static int nct7802_probe(struct i2c_client *client)
 	mutex_init(&data->access_lock);
 	mutex_init(&data->in_alarm_lock);
 
-	ret = nct7802_init_chip(data);
+	ret = nct7802_init_chip(dev, data);
 	if (ret < 0)
 		return ret;
 
-- 
2.33.0.882.g93a45727a2-goog


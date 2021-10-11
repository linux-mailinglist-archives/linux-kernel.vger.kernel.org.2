Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D043428492
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 03:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhJKBYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 21:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbhJKBYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 21:24:18 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58411C061762
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 18:22:19 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id n1-20020a05622a11c100b002a749aace38so12333648qtk.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 18:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Yb8GYkswY7I891A2MWNkFVDI8lUni2ET66GNmTlCyZg=;
        b=tGs90MJg+KzTz+OAKa2A3GW1SgEMcGjwrFZ2rUxn8BlXgWaxFmT+6IWdH0XS7ke3M+
         qtVVh+qPFpDtsfTUREIu4+X6UnybVQNoxE/qOb+DT4EtXuyb3J5HbSQovD5sk1UhQVfj
         0DOQMvnK+r7Qrw5F2okkTtY8Rg9q+a3twsi6FMUzzfxGNtF3WQu7kGxkTCfaQTXau0Xo
         VPY7EDXZ0BuOItvmwKlu9bKikcwUnJZ4xdY+1bttOhP6P88hi5llxABsu+w9IJG+bGP4
         KCCgRskTbCF2Ga1AUc961GL3YBTx3qVhEw+G5pnAnVnyfCnZb5gsCWyyUgLP8hYRDidn
         zD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yb8GYkswY7I891A2MWNkFVDI8lUni2ET66GNmTlCyZg=;
        b=n/DEDQ6ud6wNqNQSocVqWH8sx8Tiq+82ss8t0H33vnRsSrH2jpLklgwXixBiYMWLDB
         4t8UEyd1A5IA0SLqaqqUnp99xNKJBwUVbUSyFuSYBdES9QL+ZrqKsBKVjlOrBfrPqbb1
         xLUQWBtNbofD1y7WdC3eAvxA7J+vbhTBp3kvvhl84okdwr9ocW77IKRCZTdkI75bgOcb
         4Wdo5riV4x/3vOb8chUJu0hvMKJlwtW/1OMG4tnmQZcAAwtEEhg9wIckJttw8qyAOoWu
         aQA3PYyq9uxUSULIoKVfizx4Xfkiyb0LdJNfAANox8VSfYjCfRNujaIIJ5WJxm6ltFxM
         0Dgw==
X-Gm-Message-State: AOAM530mTRAJOGeMwiCAFF5jfztH+wr7PoJSVELylozttskFdsghrYk7
        Zzi6AEBMSboxIuWf4pzLlBSocFA=
X-Google-Smtp-Source: ABdhPJwSaDpVFeeB4QrYjK1+Fb4m8VoKyNmrtMqdlxAcB5A1bjFq7EPUAq5QaAPrqrEUOmLj04TpQcE=
X-Received: from osk.cam.corp.google.com ([2620:0:1004:1a:8461:b843:7404:1394])
 (user=osk job=sendgmr) by 2002:ac8:5ac6:: with SMTP id d6mr8821338qtd.241.1633915338495;
 Sun, 10 Oct 2021 18:22:18 -0700 (PDT)
Date:   Sun, 10 Oct 2021 21:22:12 -0400
In-Reply-To: <20211011012212.91357-1-osk@google.com>
Message-Id: <20211011012212.91357-2-osk@google.com>
Mime-Version: 1.0
References: <20211011012212.91357-1-osk@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v7 2/2] hwmon: (nct7802) Make temperature/voltage sensors configurable
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
Changes from PATCH v6:
- None (resubmitted due to changes in nuvoton,nct7802.yaml).

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


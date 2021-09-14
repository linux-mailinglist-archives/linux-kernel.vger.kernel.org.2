Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78F140BC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 01:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbhINXaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 19:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbhINXaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:30:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC7CC061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:28:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso836367pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GFqL8ydnkQeUXNmZmKiGsIW/guXO6MU9r6iNeByf/c8=;
        b=UvV62QwhwcOVEYcKk2ub0GGU4K+39Gvj/dE6S4h6/UNNHsgIIfpjX/W3n4/n7j/GRU
         CF/SbkmjbW++POpbO4eO5sE36mYTfp1lsbCM7CgC8ZN+X5Czo5gvXNyz2DI39KxG9ijj
         W+H1mQBPGPovaWs/DnaQTEdHsZ2G3pCbmMnyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFqL8ydnkQeUXNmZmKiGsIW/guXO6MU9r6iNeByf/c8=;
        b=r0DLEKHQvPevRiLZ4m2+z7Mqe9B1NVD0MWLuFunlrdUWnODGNVE2Qf9UGqeLyIQXjV
         qYbqk8jFcogcz/7WGRA1CfRc8ndj5bDu/MK5/epnbPWy0LHebKbNqWkE11l2238h4LL1
         15tCJh8fnvOuHU1rKVGJLZ9pe/+hmJp2GjeZK9ANeQuF/5Gb4IniCYbAPvAhJKw3OWD0
         0nsUa6ReQ6WtevIbHnvdQ7+tanSlh8JiZ/bnO2HAIHHFqyoHBWP5qVDewB8XShvauUxF
         yQOMvFJiTDPAmZLcKEG0q4ITEVr20LioRIOPcUY6ZMuCUcKFzJx/9jlSRYFaIlR6oyYv
         6PAA==
X-Gm-Message-State: AOAM532OJmXzbH1mcOHoSiOGkjX6QH3hUJyj5sh4o3eehbDUFNW4zi2u
        XJngBvNBtQjSH4sJpUdOLps2oDoZOgdA6A==
X-Google-Smtp-Source: ABdhPJzfqpiT2WCz/VbUnQH34kyUDIaeP/ZRQKU9vyXzPoYFL8VfjM0ORwlkbki7grcoxpiO7uiZxA==
X-Received: by 2002:a17:90b:4c05:: with SMTP id na5mr3739129pjb.49.1631662137870;
        Tue, 14 Sep 2021 16:28:57 -0700 (PDT)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:6213:6a82:3731:1220])
        by smtp.gmail.com with ESMTPSA id x64sm11395360pfd.194.2021.09.14.16.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 16:28:57 -0700 (PDT)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, swboyd@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 2/3] drm/bridge: parade-ps8640: Use regmap APIs
Date:   Tue, 14 Sep 2021 16:28:44 -0700
Message-Id: <20210914162825.v3.2.Ib06997ddd73e2ac29e185f039d85cfa8e760d641@changeid>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
In-Reply-To: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the direct i2c access (i2c_smbus_* functions) with regmap APIs,
which will simplify the future update on ps8640 driver.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

Changes in v3:
- Fix the nits from v2 review

Changes in v2:
- Add separate reg map config per page

 drivers/gpu/drm/bridge/parade-ps8640.c | 94 +++++++++++++++++++-------
 1 file changed, 68 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index e340af381e05..8d3e7a147170 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -9,6 +9,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
 #include <drm/drm_bridge.h>
@@ -31,6 +32,11 @@
 
 #define NUM_MIPI_LANES		4
 
+#define COMMON_PS8640_REGMAP_CONFIG \
+	.reg_bits = 8, \
+	.val_bits = 8, \
+	.cache_type = REGCACHE_NONE
+
 /*
  * PS8640 uses multiple addresses:
  * page[0]: for DP control
@@ -64,12 +70,48 @@ struct ps8640 {
 	struct drm_bridge *panel_bridge;
 	struct mipi_dsi_device *dsi;
 	struct i2c_client *page[MAX_DEVS];
+	struct regmap	*regmap[MAX_DEVS];
 	struct regulator_bulk_data supplies[2];
 	struct gpio_desc *gpio_reset;
 	struct gpio_desc *gpio_powerdown;
 	bool powered;
 };
 
+static const struct regmap_config ps8640_regmap_config[] = {
+	[PAGE0_DP_CNTL] = {
+		COMMON_PS8640_REGMAP_CONFIG,
+		.max_register = 0xbf,
+	},
+	[PAGE1_VDO_BDG] = {
+		COMMON_PS8640_REGMAP_CONFIG,
+		.max_register = 0xff,
+	},
+	[PAGE2_TOP_CNTL] = {
+		COMMON_PS8640_REGMAP_CONFIG,
+		.max_register = 0xff,
+	},
+	[PAGE3_DSI_CNTL1] = {
+		COMMON_PS8640_REGMAP_CONFIG,
+		.max_register = 0xff,
+	},
+	[PAGE4_MIPI_PHY] = {
+		COMMON_PS8640_REGMAP_CONFIG,
+		.max_register = 0xff,
+	},
+	[PAGE5_VPLL] = {
+		COMMON_PS8640_REGMAP_CONFIG,
+		.max_register = 0x7f,
+	},
+	[PAGE6_DSI_CNTL2] = {
+		COMMON_PS8640_REGMAP_CONFIG,
+		.max_register = 0xff,
+	},
+	[PAGE7_SPI_CNTL] = {
+		COMMON_PS8640_REGMAP_CONFIG,
+		.max_register = 0xff,
+	},
+};
+
 static inline struct ps8640 *bridge_to_ps8640(struct drm_bridge *e)
 {
 	return container_of(e, struct ps8640, bridge);
@@ -78,13 +120,13 @@ static inline struct ps8640 *bridge_to_ps8640(struct drm_bridge *e)
 static int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge,
 				     const enum ps8640_vdo_control ctrl)
 {
-	struct i2c_client *client = ps_bridge->page[PAGE3_DSI_CNTL1];
+	struct regmap *map = ps_bridge->regmap[PAGE3_DSI_CNTL1];
 	u8 vdo_ctrl_buf[] = { VDO_CTL_ADD, ctrl };
 	int ret;
 
-	ret = i2c_smbus_write_i2c_block_data(client, PAGE3_SET_ADD,
-					     sizeof(vdo_ctrl_buf),
-					     vdo_ctrl_buf);
+	ret = regmap_bulk_write(map, PAGE3_SET_ADD,
+				vdo_ctrl_buf, sizeof(vdo_ctrl_buf));
+
 	if (ret < 0) {
 		DRM_ERROR("failed to %sable VDO: %d\n",
 			  ctrl == ENABLE ? "en" : "dis", ret);
@@ -96,8 +138,7 @@ static int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge,
 
 static void ps8640_bridge_poweron(struct ps8640 *ps_bridge)
 {
-	struct i2c_client *client = ps_bridge->page[PAGE2_TOP_CNTL];
-	unsigned long timeout;
+	struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
 	int ret, status;
 
 	if (ps_bridge->powered)
@@ -121,18 +162,12 @@ static void ps8640_bridge_poweron(struct ps8640 *ps_bridge)
 	 */
 	msleep(200);
 
-	timeout = jiffies + msecs_to_jiffies(200) + 1;
-
-	while (time_is_after_jiffies(timeout)) {
-		status = i2c_smbus_read_byte_data(client, PAGE2_GPIO_H);
-		if (status < 0) {
-			DRM_ERROR("failed read PAGE2_GPIO_H: %d\n", status);
-			goto err_regulators_disable;
-		}
-		if ((status & PS_GPIO9) == PS_GPIO9)
-			break;
+	ret = regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
+			status & PS_GPIO9, 20 * 1000, 200 * 1000);
 
-		msleep(20);
+	if (ret < 0) {
+		DRM_ERROR("failed read PAGE2_GPIO_H: %d\n", ret);
+		goto err_regulators_disable;
 	}
 
 	msleep(50);
@@ -144,22 +179,15 @@ static void ps8640_bridge_poweron(struct ps8640 *ps_bridge)
 	 * disabled by the manufacturer. Once disabled, all MCS commands are
 	 * ignored by the display interface.
 	 */
-	status = i2c_smbus_read_byte_data(client, PAGE2_MCS_EN);
-	if (status < 0) {
-		DRM_ERROR("failed read PAGE2_MCS_EN: %d\n", status);
-		goto err_regulators_disable;
-	}
 
-	ret = i2c_smbus_write_byte_data(client, PAGE2_MCS_EN,
-					status & ~MCS_EN);
+	ret = regmap_update_bits(map, PAGE2_MCS_EN, MCS_EN, 0);
 	if (ret < 0) {
 		DRM_ERROR("failed write PAGE2_MCS_EN: %d\n", ret);
 		goto err_regulators_disable;
 	}
 
 	/* Switch access edp panel's edid through i2c */
-	ret = i2c_smbus_write_byte_data(client, PAGE2_I2C_BYPASS,
-					I2C_BYPASS_EN);
+	ret = regmap_write(map, PAGE2_I2C_BYPASS, I2C_BYPASS_EN);
 	if (ret < 0) {
 		DRM_ERROR("failed write PAGE2_I2C_BYPASS: %d\n", ret);
 		goto err_regulators_disable;
@@ -368,6 +396,12 @@ static int ps8640_probe(struct i2c_client *client)
 
 	ps_bridge->page[PAGE0_DP_CNTL] = client;
 
+	ps_bridge->regmap[PAGE0_DP_CNTL] = devm_regmap_init_i2c(client, ps8640_regmap_config);
+	if (IS_ERR(ps_bridge->regmap[PAGE0_DP_CNTL])) {
+		return dev_err_probe(dev, PTR_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]),
+				     "Error initting page 0 regmap\n");
+	}
+
 	for (i = 1; i < ARRAY_SIZE(ps_bridge->page); i++) {
 		ps_bridge->page[i] = devm_i2c_new_dummy_device(&client->dev,
 							     client->adapter,
@@ -377,6 +411,14 @@ static int ps8640_probe(struct i2c_client *client)
 				"Error initting i2c dummy dev, address %02x\n",
 				client->addr + i);
 		}
+
+		ps_bridge->regmap[i] = devm_regmap_init_i2c(ps_bridge->page[i],
+						ps8640_regmap_config + i);
+		if (IS_ERR(ps_bridge->regmap[i])) {
+			return dev_err_probe(dev,
+				PTR_ERR(ps_bridge->regmap[i]),
+				"Error initting page %d regmap\n", i);
+		}
 	}
 
 	i2c_set_clientdata(client, ps_bridge);
-- 
2.33.0.309.g3052b89438-goog


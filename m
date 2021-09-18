Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9A74107CB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 19:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhIRRWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 13:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbhIRRWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 13:22:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1C5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 10:21:27 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t1so12988418pgv.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8rj7V11x5Q/j4PMu2OowpxaU3HgfkUM9t7pdTGnEwJA=;
        b=BhfzGCvwGlqDEPmJ0sfOo/ggU/xY9ycc7N2CJAhqRcIWKYfB0onwq4Nw3RRSwumiQv
         YxMpDO/JQuxOB6yNIEhYl0hJLmSQjwb3caxTWWJ+bquuZz+bLpkXWZ91YxbGAD26PypV
         /BkEpF0aQOPX5HKH2UThWIKRbvjzBEzuzkkzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8rj7V11x5Q/j4PMu2OowpxaU3HgfkUM9t7pdTGnEwJA=;
        b=7LmmqBWjIs1I5gkW0gol9TAFslAcvPKEBlCzvrLQjTFMvyQ/8kMtLER6EzIH5HIZGP
         wWhkKLV4+X/oijytqZnbb9d/gx1+ET3150Th2eEAwrlPEoNrauyn2aa2rKnNukU13GIV
         eOngwLu2UincOdo2JZBzJeAp9wcleqGTFbZYToSnR++OkyfsTIwvPkvqmNvO+5qEwLnE
         exeX0Q8ZXMf25K8XTtNOT3Bt+/11KvN2aUzXcsZmzHua7MwFl3UhNRhJGcxTjDrHT08e
         hdBZTUSIZb25oJYfHdDTZEGK0vuE1B7UT4fmcciCXBuObsq495gHCCY+D4HR9R5ABBXt
         6aIA==
X-Gm-Message-State: AOAM533JyvbXZaOqIG3dWfOvkQlafCtSKx+hoD549nB6+r8Cpc7amdf5
        tfv0CtUjpYhDzzzgiD6U+VznVegqbySqyg==
X-Google-Smtp-Source: ABdhPJwxFELPEIn5WgrfXdnA1wibLoeO6AiBm0fcCLi9NBN1UW3GYgxe4qrI/7Go8/+yHcpY7b11ug==
X-Received: by 2002:aa7:9dc6:0:b0:440:b629:6e57 with SMTP id g6-20020aa79dc6000000b00440b6296e57mr14939603pfq.69.1631985685203;
        Sat, 18 Sep 2021 10:21:25 -0700 (PDT)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:c4eb:5fb6:44fe:7952])
        by smtp.gmail.com with ESMTPSA id a10sm9455204pfn.48.2021.09.18.10.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 10:21:24 -0700 (PDT)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     swboyd@chromium.org, dianders@chromium.org,
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
Subject: [PATCH v5 1/2] drm/bridge: parade-ps8640: Use regmap APIs
Date:   Sat, 18 Sep 2021 10:21:16 -0700
Message-Id: <20210918102058.v5.1.I2351df94f18d5d8debc22d4d100f36fac560409a@changeid>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
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

(no changes since v4)

Changes in v4:
- Remove excessive error logging from the probe function

Changes in v3:
- Fix the nits from v2 review

Changes in v2:
- Add separate reg map config per page

 drivers/gpu/drm/bridge/parade-ps8640.c | 94 ++++++++++++++++++--------
 1 file changed, 64 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 685e9c38b2db..18328e75bf90 100644
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
@@ -362,15 +390,21 @@ static int ps8640_probe(struct i2c_client *client)
 
 	ps_bridge->page[PAGE0_DP_CNTL] = client;
 
+	ps_bridge->regmap[PAGE0_DP_CNTL] = devm_regmap_init_i2c(client, ps8640_regmap_config);
+	if (IS_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]))
+		return PTR_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]);
+
 	for (i = 1; i < ARRAY_SIZE(ps_bridge->page); i++) {
 		ps_bridge->page[i] = devm_i2c_new_dummy_device(&client->dev,
 							     client->adapter,
 							     client->addr + i);
-		if (IS_ERR(ps_bridge->page[i])) {
-			dev_err(dev, "failed i2c dummy device, address %02x\n",
-				client->addr + i);
+		if (IS_ERR(ps_bridge->page[i]))
 			return PTR_ERR(ps_bridge->page[i]);
-		}
+
+		ps_bridge->regmap[i] = devm_regmap_init_i2c(ps_bridge->page[i],
+						ps8640_regmap_config + i);
+		if (IS_ERR(ps_bridge->regmap[i]))
+			return PTR_ERR(ps_bridge->regmap[i]);
 	}
 
 	i2c_set_clientdata(client, ps_bridge);
-- 
2.33.0.464.g1972c5931b-goog


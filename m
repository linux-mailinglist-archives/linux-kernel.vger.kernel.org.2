Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7EA343E04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCVKeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhCVKdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:33:51 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A37C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:33:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w11so6315221ply.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gu4WEFDGSB9CAQfbCPK1lkoz2eEh/Okvod2x4mdPu+g=;
        b=jYbt7eJsw66jK3EIn6FgtNG2MLTjN0C2ZoaV+mD57j2ast5OMPftZ5ZseW8uAHHt2S
         a4C6MA8JJq15RyKxrx6y3gN3cfmHrynAWiSxijv4/pOyUA0AVNio5TOW8rxkP86LcQEd
         MBPxepGd1UuYTfOw7V3NWS8EKu86LbxMnvKy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gu4WEFDGSB9CAQfbCPK1lkoz2eEh/Okvod2x4mdPu+g=;
        b=BJoTwNXLyhZDhAqmNWnTj2mjBztI3Li0qaeIq1p1vbGfGOfcyt3+1Rt2cxqKJH4HtV
         xRDo5B9qX7u84VzpZJA2EKbKQ6PBOnKf2rDQjX/hi/oKv0lZ2rbiGrVVw33VNloFGluz
         aX8JBsPEmK0tIx2rulIoWYvRKAQzIPDJLoa7x6fNelTuxw66YQ/n6AY3e4e6En/axgyz
         GhQud0sSBYLtb7Ozx9gz3kL3vmsKz6t1dkvRCtbEIVTTSrW530jWypdIcfP7E6nx8wKv
         S/3uUzxCxOfuNkm7CSvABrK3EFeqyFIurTaMmndHayQPE88JzhF9U43mqEG7d5eCw0yf
         as+g==
X-Gm-Message-State: AOAM53271RwLYgCkB5SWONIpYtO/HYCBopcKfAH+Sl8UxOmoJC/FAjXv
        9kwBHscIPa5aSP4WYNVObcgGGQ==
X-Google-Smtp-Source: ABdhPJwE+UfBKbnOkio3bMHFYd0xplyK6GWvNiYhosGjPb2s8zUKN84cE/x7OQM/o9lf/hrJ42LVrg==
X-Received: by 2002:a17:902:8c8d:b029:e5:e1fc:a587 with SMTP id t13-20020a1709028c8db02900e5e1fca587mr26582772plo.12.1616409230894;
        Mon, 22 Mar 2021 03:33:50 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a884:15c1:9a30:414f:d84b])
        by smtp.gmail.com with ESMTPSA id o13sm12812422pgv.40.2021.03.22.03.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:33:50 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 2/2] drm: bridge: Add Chipone ICN6211 MIPI-DSI to RGB bridge
Date:   Mon, 22 Mar 2021 16:03:27 +0530
Message-Id: <20210322103328.66442-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322103328.66442-1-jagan@amarulasolutions.com>
References: <20210322103328.66442-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICN6211 is MIPI-DSI to RGB Converter bridge from Chipone.

It has a flexible configuration of MIPI DSI signal input and
produce RGB565, RGB666, RGB888 output format.

Add bridge driver for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
Changes for v5:
- rebase drm-misc-next
- collect Robert review tags
Changes for v4:
- added regulators
- replace reset with EN
- fixed warnings pointed by Robert
Changes for v3:
- updated the driver to inline with new drm bridge style

 MAINTAINERS                              |   1 +
 drivers/gpu/drm/bridge/Kconfig           |  13 +
 drivers/gpu/drm/bridge/Makefile          |   1 +
 drivers/gpu/drm/bridge/chipone-icn6211.c | 293 +++++++++++++++++++++++
 4 files changed, 308 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/chipone-icn6211.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b9d11101d060..b92a35c80eae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5572,6 +5572,7 @@ DRM DRIVER FOR CHIPONE ICN6211 MIPI-DSI to RGB CONVERTER BRIDGE
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
+F:	drivers/gpu/drm/bridge/chipone-icn6211.c
 
 DRM DRIVER FOR FARADAY TVE200 TV ENCODER
 M:	Linus Walleij <linus.walleij@linaro.org>
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index e4110d6ca7b3..330ee70ed746 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -27,6 +27,19 @@ config DRM_CDNS_DSI
 	  Support Cadence DPI to DSI bridge. This is an internal
 	  bridge and is meant to be directly embedded in a SoC.
 
+config DRM_CHIPONE_ICN6211
+	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
+	depends on OF
+	select DRM_MIPI_DSI
+	select DRM_PANEL_BRIDGE
+	help
+	  ICN6211 is MIPI-DSI/RGB Converter bridge from chipone.
+
+	  It has a flexible configuration of MIPI DSI signal input
+	  and produce RGB565, RGB666, RGB888 output format.
+
+	  If in doubt, say "N".
+
 config DRM_CHRONTEL_CH7033
 	tristate "Chrontel CH7033 Video Encoder"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 86e7acc76f8d..3eb84b638988 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
+obj-$(CONFIG_DRM_CHIPONE_ICN6211) += chipone-icn6211.o
 obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
 obj-$(CONFIG_DRM_DISPLAY_CONNECTOR) += display-connector.o
 obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
new file mode 100644
index 000000000000..a6151db95586
--- /dev/null
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Amarula Solutions(India)
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+#include <drm/drm_of.h>
+#include <drm/drm_print.h>
+#include <drm/drm_mipi_dsi.h>
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#define HACTIVE_LI		0x20
+#define VACTIVE_LI		0x21
+#define VACTIVE_HACTIVE_HI	0x22
+#define HFP_LI			0x23
+#define HSYNC_LI		0x24
+#define HBP_LI			0x25
+#define HFP_HSW_HBP_HI		0x26
+#define VFP			0x27
+#define VSYNC			0x28
+#define VBP			0x29
+
+struct chipone {
+	struct device *dev;
+	struct drm_bridge bridge;
+	struct drm_bridge *panel_bridge;
+	struct gpio_desc *enable_gpio;
+	struct regulator *vdd1;
+	struct regulator *vdd2;
+	struct regulator *vdd3;
+};
+
+static inline struct chipone *bridge_to_chipone(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct chipone, bridge);
+}
+
+static struct drm_display_mode *bridge_to_mode(struct drm_bridge *bridge)
+{
+	return &bridge->encoder->crtc->state->adjusted_mode;
+}
+
+static inline int chipone_dsi_write(struct chipone *icn,  const void *seq,
+				    size_t len)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(icn->dev);
+
+	return mipi_dsi_generic_write(dsi, seq, len);
+}
+
+#define ICN6211_DSI(icn, seq...)				\
+	{							\
+		const u8 d[] = { seq };				\
+		chipone_dsi_write(icn, d, ARRAY_SIZE(d));	\
+	}
+
+static void chipone_enable(struct drm_bridge *bridge)
+{
+	struct chipone *icn = bridge_to_chipone(bridge);
+	struct drm_display_mode *mode = bridge_to_mode(bridge);
+
+	ICN6211_DSI(icn, 0x7a, 0xc1);
+
+	ICN6211_DSI(icn, HACTIVE_LI, mode->hdisplay & 0xff);
+
+	ICN6211_DSI(icn, VACTIVE_LI, mode->vdisplay & 0xff);
+
+	/**
+	 * lsb nibble: 2nd nibble of hdisplay
+	 * msb nibble: 2nd nibble of vdisplay
+	 */
+	ICN6211_DSI(icn, VACTIVE_HACTIVE_HI,
+		    ((mode->hdisplay >> 8) & 0xf) |
+		    (((mode->vdisplay >> 8) & 0xf) << 4));
+
+	ICN6211_DSI(icn, HFP_LI, mode->hsync_start - mode->hdisplay);
+
+	ICN6211_DSI(icn, HSYNC_LI, mode->hsync_end - mode->hsync_start);
+
+	ICN6211_DSI(icn, HBP_LI, mode->htotal - mode->hsync_end);
+
+	ICN6211_DSI(icn, HFP_HSW_HBP_HI, 0x00);
+
+	ICN6211_DSI(icn, VFP, mode->vsync_start - mode->vdisplay);
+
+	ICN6211_DSI(icn, VSYNC, mode->vsync_end - mode->vsync_start);
+
+	ICN6211_DSI(icn, VBP, mode->vtotal - mode->vsync_end);
+
+	/* dsi specific sequence */
+	ICN6211_DSI(icn, MIPI_DCS_SET_TEAR_OFF, 0x80);
+	ICN6211_DSI(icn, MIPI_DCS_SET_ADDRESS_MODE, 0x28);
+	ICN6211_DSI(icn, 0xb5, 0xa0);
+	ICN6211_DSI(icn, 0x5c, 0xff);
+	ICN6211_DSI(icn, MIPI_DCS_SET_COLUMN_ADDRESS, 0x01);
+	ICN6211_DSI(icn, MIPI_DCS_GET_POWER_SAVE, 0x92);
+	ICN6211_DSI(icn, 0x6b, 0x71);
+	ICN6211_DSI(icn, 0x69, 0x2b);
+	ICN6211_DSI(icn, MIPI_DCS_ENTER_SLEEP_MODE, 0x40);
+	ICN6211_DSI(icn, MIPI_DCS_EXIT_SLEEP_MODE, 0x98);
+
+	/* icn6211 specific sequence */
+	ICN6211_DSI(icn, 0xb6, 0x20);
+	ICN6211_DSI(icn, 0x51, 0x20);
+	ICN6211_DSI(icn, 0x09, 0x10);
+
+	usleep_range(10000, 11000);
+}
+
+static void chipone_pre_enable(struct drm_bridge *bridge)
+{
+	struct chipone *icn = bridge_to_chipone(bridge);
+	int ret;
+
+	if (icn->vdd1) {
+		ret = regulator_enable(icn->vdd1);
+		if (ret)
+			DRM_DEV_ERROR(icn->dev,
+				      "failed to enable VDD1 regulator: %d\n", ret);
+	}
+
+	if (icn->vdd2) {
+		ret = regulator_enable(icn->vdd2);
+		if (ret)
+			DRM_DEV_ERROR(icn->dev,
+				      "failed to enable VDD2 regulator: %d\n", ret);
+	}
+
+	if (icn->vdd3) {
+		ret = regulator_enable(icn->vdd3);
+		if (ret)
+			DRM_DEV_ERROR(icn->dev,
+				      "failed to enable VDD3 regulator: %d\n", ret);
+	}
+
+	gpiod_set_value(icn->enable_gpio, 1);
+
+	usleep_range(10000, 11000);
+}
+
+static void chipone_post_disable(struct drm_bridge *bridge)
+{
+	struct chipone *icn = bridge_to_chipone(bridge);
+
+	if (icn->vdd1)
+		regulator_disable(icn->vdd1);
+
+	if (icn->vdd2)
+		regulator_disable(icn->vdd2);
+
+	if (icn->vdd3)
+		regulator_disable(icn->vdd3);
+
+	gpiod_set_value(icn->enable_gpio, 0);
+}
+
+static int chipone_attach(struct drm_bridge *bridge, enum drm_bridge_attach_flags flags)
+{
+	struct chipone *icn = bridge_to_chipone(bridge);
+
+	return drm_bridge_attach(bridge->encoder, icn->panel_bridge, bridge, flags);
+}
+
+static const struct drm_bridge_funcs chipone_bridge_funcs = {
+	.attach = chipone_attach,
+	.post_disable = chipone_post_disable,
+	.pre_enable = chipone_pre_enable,
+	.enable = chipone_enable,
+};
+
+static int chipone_parse_dt(struct chipone *icn)
+{
+	struct device *dev = icn->dev;
+	struct drm_panel *panel;
+	int ret;
+
+	icn->vdd1 = devm_regulator_get_optional(dev, "vdd1");
+	if (IS_ERR(icn->vdd1)) {
+		ret = PTR_ERR(icn->vdd1);
+		if (ret == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		icn->vdd1 = NULL;
+		DRM_DEV_DEBUG(dev, "failed to get VDD1 regulator: %d\n", ret);
+	}
+
+	icn->vdd2 = devm_regulator_get_optional(dev, "vdd2");
+	if (IS_ERR(icn->vdd2)) {
+		ret = PTR_ERR(icn->vdd2);
+		if (ret == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		icn->vdd2 = NULL;
+		DRM_DEV_DEBUG(dev, "failed to get VDD2 regulator: %d\n", ret);
+	}
+
+	icn->vdd3 = devm_regulator_get_optional(dev, "vdd3");
+	if (IS_ERR(icn->vdd3)) {
+		ret = PTR_ERR(icn->vdd3);
+		if (ret == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		icn->vdd3 = NULL;
+		DRM_DEV_DEBUG(dev, "failed to get VDD3 regulator: %d\n", ret);
+	}
+
+	icn->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(icn->enable_gpio)) {
+		DRM_DEV_ERROR(dev, "failed to get enable GPIO\n");
+		return PTR_ERR(icn->enable_gpio);
+	}
+
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel, NULL);
+	if (ret)
+		return ret;
+
+	icn->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+	if (IS_ERR(icn->panel_bridge))
+		return PTR_ERR(icn->panel_bridge);
+
+	return 0;
+}
+
+static int chipone_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct chipone *icn;
+	int ret;
+
+	icn = devm_kzalloc(dev, sizeof(struct chipone), GFP_KERNEL);
+	if (!icn)
+		return -ENOMEM;
+
+	mipi_dsi_set_drvdata(dsi, icn);
+	icn->dev = dev;
+
+	ret = chipone_parse_dt(icn);
+	if (ret)
+		return ret;
+
+	icn->bridge.funcs = &chipone_bridge_funcs;
+	icn->bridge.type = DRM_MODE_CONNECTOR_DPI;
+	icn->bridge.of_node = dev->of_node;
+
+	drm_bridge_add(&icn->bridge);
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		drm_bridge_remove(&icn->bridge);
+		dev_err(dev, "failed to attach dsi\n");
+	}
+
+	return ret;
+}
+
+static int chipone_remove(struct mipi_dsi_device *dsi)
+{
+	struct chipone *icn = mipi_dsi_get_drvdata(dsi);
+
+	mipi_dsi_detach(dsi);
+	drm_bridge_remove(&icn->bridge);
+
+	return 0;
+}
+
+static const struct of_device_id chipone_of_match[] = {
+	{ .compatible = "chipone,icn6211", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, chipone_of_match);
+
+static struct mipi_dsi_driver chipone_driver = {
+	.probe = chipone_probe,
+	.remove = chipone_remove,
+	.driver = {
+		.name = "chipone-icn6211",
+		.owner = THIS_MODULE,
+		.of_match_table = chipone_of_match,
+	},
+};
+module_mipi_dsi_driver(chipone_driver);
+
+MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
+MODULE_DESCRIPTION("Chipone ICN6211 MIPI-DSI to RGB Converter Bridge");
+MODULE_LICENSE("GPL");
-- 
2.25.1


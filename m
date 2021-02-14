Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEBA31B1B5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 18:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhBNRyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 12:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhBNRyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 12:54:24 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB56AC061788
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 09:53:44 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id k13so2799193pfh.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 09:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MNj6o7RtmTcqCaf1dh/S3Z73kTB3kvzGPRyE3Y/HMtg=;
        b=fg/jXMmwngxsIWcQzg1hiDeVMN8PL6AakNw+3+/xIQieuco1Xco4kDy6aaF70fSrG2
         JCx10pglNUQL77Bc3zGCp9qqbfYo+FsdygTInxsHEo/Z6NSfobT6YqjbT6KWIiZkaifm
         JO/rGuySHSjcOZdAkI5gzNQSMTjT3K41AeIN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MNj6o7RtmTcqCaf1dh/S3Z73kTB3kvzGPRyE3Y/HMtg=;
        b=Epjmp5jtRMyWdql/fl6nWetVvt0hBXkAeqq5KThtEdb69HUINtD8O+gcxqiqlXHsiF
         AmdOtNwawgKS1fp5fIcM3uZ/PlflddTSLzKL8hFMK3+WlG/AAYHdRXNh75Skt6lrMIkV
         wxYLwe3r32wgfUiyz93Td2cB1KiydNM4OnWTnMB4dR+oD1RZintbgW+JyWw75ZCsL/iP
         7FunqBccLNjaw3tSsS8bI9B8t84QJlcenijSBqLQLuKjZA5/nSKggbPvujvsimKSIrj3
         5aRn2oo0cfaQSIFhjZUqT1C91ax+zadBKlRvLJngmhQm+Rc9sp7FLRf8p3fi13U+VyEL
         3wBQ==
X-Gm-Message-State: AOAM530DgEWet25PL+aM1+9snwHSFqoTCiamwHr4LO9eUlgJPhBvHgBx
        SjUkdakIaWH9eDJXNMQD7UjLxg==
X-Google-Smtp-Source: ABdhPJzsD44xxYkWxPSIXtK590P+rYTRtkZwjfq5GMBJZByPxa/cb1jTM4m0IbhlCuOvP+XHcxQJHA==
X-Received: by 2002:aa7:8d0d:0:b029:1d7:3c52:e1f6 with SMTP id j13-20020aa78d0d0000b02901d73c52e1f6mr12272527pfe.39.1613325223568;
        Sun, 14 Feb 2021 09:53:43 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([45.249.78.214])
        by smtp.gmail.com with ESMTPSA id h17sm15094443pfr.200.2021.02.14.09.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 09:53:43 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 2/2] drm: bridge: Add Chipone ICN6211 MIPI-DSI to RGB bridge
Date:   Sun, 14 Feb 2021 23:22:11 +0530
Message-Id: <20210214175211.105107-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210214175211.105107-1-jagan@amarulasolutions.com>
References: <20210214175211.105107-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICN6211 is MIPI-DSI to RGB Convertor bridge from Chipone.

It has a flexible configuration of MIPI DSI signal input and
produce RGB565, RGB666, RGB888 output format.

Add bridge driver for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- updated the driver to inline with new drm bridge style

 MAINTAINERS                              |   6 +
 drivers/gpu/drm/bridge/Kconfig           |  11 ++
 drivers/gpu/drm/bridge/Makefile          |   1 +
 drivers/gpu/drm/bridge/chipone-icn6211.c | 222 +++++++++++++++++++++++
 4 files changed, 240 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/chipone-icn6211.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d241b832aae..4f1084aae50d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5529,6 +5529,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml
 F:	drivers/gpu/drm/panel/panel-boe-himax8279d.c
 
+DRM DRIVER FOR CHIPONE ICN6211 MIPI-DSI to RGB CONVERTOR BRIDGE
+M:	Jagan Teki <jagan@amarulasolutions.com>
+S:	Maintained
+F:	drivers/gpu/drm/bridge/chipone-icn6211.c
+F:	Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
+
 DRM DRIVER FOR FARADAY TVE200 TV ENCODER
 M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index e4110d6ca7b3..49d1565b7f25 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -27,6 +27,17 @@ config DRM_CDNS_DSI
 	  Support Cadence DPI to DSI bridge. This is an internal
 	  bridge and is meant to be directly embedded in a SoC.
 
+config DRM_CHIPONE_ICN6211
+	tristate "Chipone ICN6211 MIPI-DSI/RGB Convertor bridge"
+	depends on OF
+	select DRM_MIPI_DSI
+	select DRM_PANEL_BRIDGE
+	help
+	  ICN6211 is MIPI-DSI/RGB Convertor bridge from chipone.
+
+	  It has a flexible configuration of MIPI DSI signal input
+	  and produce RGB565, RGB666, RGB888 output format.
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
index 000000000000..3f478f21a4a5
--- /dev/null
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -0,0 +1,222 @@
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
+
+#include <video/mipi_display.h>
+
+struct chipone {
+	struct device *dev;
+	struct drm_bridge bridge;
+	struct drm_bridge *panel_bridge;
+	struct gpio_desc *reset_gpio;
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
+static void chipone_post_disable(struct drm_bridge *bridge)
+{
+	struct chipone *icn = bridge_to_chipone(bridge);
+
+	gpiod_set_value(icn->reset_gpio, 0);
+
+	msleep(50);
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
+#define CHIPONE_DSI(icn, seq...)				\
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
+	CHIPONE_DSI(icn, 0x7A, 0xC1);
+
+	/* lower 8 bits of hdisplay */
+	CHIPONE_DSI(icn, 0x20, mode->hdisplay & 0xff);
+
+	/* lower 8 bits of vdisplay */
+	CHIPONE_DSI(icn, 0x21, mode->vdisplay & 0xff);
+
+	/**
+	 * lsb nibble: 2nd nibble of hdisplay
+	 * msb nibble: 2nd nibble of vdisplay
+	 */
+	CHIPONE_DSI(icn, 0x22, (((mode->hdisplay >> 8) & 0xf) |
+		    (((mode->vdisplay >> 8) & 0xf) << 4)));
+
+	/* HFP */
+	CHIPONE_DSI(icn, 0x23, mode->hsync_start - mode->hdisplay);
+
+	/* HSYNC */
+	CHIPONE_DSI(icn, 0x24, mode->hsync_end - mode->hsync_start);
+
+	/* HBP */
+	CHIPONE_DSI(icn, 0x25, mode->htotal - mode->hsync_end);
+
+	CHIPONE_DSI(icn, 0x26, 0x00);
+
+	/* VFP */
+	CHIPONE_DSI(icn, 0x27, mode->vsync_start - mode->vdisplay);
+
+	/* VSYNC */
+	CHIPONE_DSI(icn, 0x28, mode->vsync_end - mode->vsync_start);
+
+	/* VBP */
+	CHIPONE_DSI(icn, 0x29, mode->vtotal - mode->vsync_end);
+
+	/* dsi specific sequence */
+	CHIPONE_DSI(icn, MIPI_DCS_SET_TEAR_OFF, 0x80);
+	CHIPONE_DSI(icn, MIPI_DCS_SET_ADDRESS_MODE, 0x28);
+	CHIPONE_DSI(icn, 0xB5, 0xA0);
+	CHIPONE_DSI(icn, 0x5C, 0xFF);
+	CHIPONE_DSI(icn, MIPI_DCS_SET_COLUMN_ADDRESS, 0x01);
+	CHIPONE_DSI(icn, MIPI_DCS_GET_POWER_SAVE, 0x92);
+	CHIPONE_DSI(icn, 0x6B, 0x71);
+	CHIPONE_DSI(icn, 0x69, 0x2B);
+	CHIPONE_DSI(icn, MIPI_DCS_ENTER_SLEEP_MODE, 0x40);
+	CHIPONE_DSI(icn, MIPI_DCS_EXIT_SLEEP_MODE, 0x98);
+
+	/* icn6211 specific sequence */
+	CHIPONE_DSI(icn, 0xB6, 0x20);
+	CHIPONE_DSI(icn, 0x51, 0x20);
+	CHIPONE_DSI(icn, 0x09, 0x10);
+
+	msleep(120);
+}
+
+static void chipone_pre_enable(struct drm_bridge *bridge)
+{
+	struct chipone *icn = bridge_to_chipone(bridge);
+
+	gpiod_set_value(icn->reset_gpio, 1);
+	msleep(20);
+
+	gpiod_set_value(icn->reset_gpio, 0);
+	msleep(20);
+
+	gpiod_set_value(icn->reset_gpio, 1);
+	msleep(50);
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
+	.post_disable = chipone_post_disable,
+	.enable = chipone_enable,
+	.pre_enable = chipone_pre_enable,
+	.attach = chipone_attach,
+};
+
+static int chipone_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct drm_panel *panel;
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
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->lanes = 4;
+
+	icn->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(icn->reset_gpio)) {
+		DRM_DEV_ERROR(dev, "failed to get reset GPIO\n");
+		return PTR_ERR(icn->reset_gpio);
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
+	icn->bridge.funcs = &chipone_bridge_funcs;
+	icn->bridge.type = DRM_MODE_CONNECTOR_DPI;
+	icn->bridge.of_node = dev->of_node;
+
+	drm_bridge_add(&icn->bridge);
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
+MODULE_DESCRIPTION("Chipone ICN6211 MIPI-DSI to RGB Convertor Bridge");
+MODULE_LICENSE("GPL");
-- 
2.25.1


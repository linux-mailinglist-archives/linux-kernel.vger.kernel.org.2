Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4591430AD29
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhBAQyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhBAQyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:54:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B57DC06174A;
        Mon,  1 Feb 2021 08:53:38 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q7so17329040wre.13;
        Mon, 01 Feb 2021 08:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dBHdALdEus3O4u73yaAo51PuLorYWKAPerj4FWe40+s=;
        b=TVsiha+XNfdW0LDdez60wodKt/zg1ZEnoFTFM8aNL2Wg0oLQ/RfrZXMHMwFE+HLMi+
         1f3/awSvrym2gDoS67TW1iX0iC8ty6sQz1+Q7x0u6hKv3jtcXVRPaF8M4mVcEYnRVniK
         eBHsCpkGuGkMX//wXBTTm1+Vquo+hjJHXfTBTrPhKYWQB1IKlvho8MsI2FDwIeqSCjYu
         j2e5IfWSWTdOvoyTFqOgNMUlLSHVTUOB4vwUjjugppI8XbcEQ7PhwPhD8sGIun345nE4
         IHWu0UdSYfKG68HisqhCVDBbEJaSmdUfk1C8b5bd5fsDj/kD4xt+oky+KmfdffDz0zJV
         wb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dBHdALdEus3O4u73yaAo51PuLorYWKAPerj4FWe40+s=;
        b=eCFL94AGYB5NBfpEzjOmhg+UbSEZ07vzkC6//zM0YfxgrHUj+1hmuu8ddebNzXYExt
         S3sXt+QI4Rvh2MtDTxpbXDlbT5rs6UDHdKEYDTJgxCLEGX4qYVvvP+zEFtLrkPRXIqsy
         nvSIl66UR8d4aKLcI6LkJTMVuy2lQPDJ/R1IWeka2wHfOzvqszHDoFd3YpIwzK4KFH40
         MbvNG16JaZDXmVpGIa5gkiV+TYhQNYDmO/zL9qxR14t0iQmlYhTurqD0fEu43LpS39IN
         2//04gdAkzjWvZdEN28E10iOs+THRzcM7lQR7KhfjKPeVPyFDyHtS2QeW9oVrtmanuoY
         tYPw==
X-Gm-Message-State: AOAM533UAB+wSkzyhTD1uOaTQhUOgpkyI3TAfBsc0ei5SEcqXrWnQqK3
        4hA1QAOZXLzMYa12pFVva+oqObDCcxMP9g==
X-Google-Smtp-Source: ABdhPJzUXIa09h6pTBqLSNvpje1ZAig60yeOMCH75zlEujWHi5874WGLfn4bzWAD7rx5CoC4OCcxpw==
X-Received: by 2002:a5d:4d08:: with SMTP id z8mr19282280wrt.240.1612198416954;
        Mon, 01 Feb 2021 08:53:36 -0800 (PST)
Received: from localhost (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id l18sm21171015wme.37.2021.02.01.08.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 08:53:36 -0800 (PST)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 2/2] drm/panel: Add panel for Samsung Galaxy S5
Date:   Mon,  1 Feb 2021 18:53:06 +0200
Message-Id: <20210201165307.51443-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201165307.51443-1-iskren.chernev@gmail.com>
References: <20210201165307.51443-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung Galaxy S5 uses the samsung s6e3fa2 AMOLED cmd LCD panel.

This driver was generated with [1], with the addition of
mipi_dsi_dcs_set_display_on at the end of the on method.

[1] https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig                 |   6 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6e3fa2.c | 299 ++++++++++++++++++
 3 files changed, 306 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e3fa2.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 4894913936e9..82dff2afd5f1 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -348,6 +348,12 @@ config DRM_PANEL_SAMSUNG_S6D16D0
 	depends on DRM_MIPI_DSI
 	select VIDEOMODE_HELPERS
 
+config DRM_PANEL_SAMSUNG_S6E3FA2
+	tristate "Samsung S6E3FA2 DSI cmd mode panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	select VIDEOMODE_HELPERS
+
 config DRM_PANEL_SAMSUNG_S6E3HA2
 	tristate "Samsung S6E3HA2 DSI video mode panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index cae4d976c069..87d3f76f050e 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) += panel-raydium-rm68200.o
 obj-$(CONFIG_DRM_PANEL_RONBO_RB070D30) += panel-ronbo-rb070d30.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D16D0) += panel-samsung-s6d16d0.o
+obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3FA2) += panel-samsung-s6e3fa2.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2) += panel-samsung-s6e3ha2.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03) += panel-samsung-s6e63j0x03.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0) += panel-samsung-s6e63m0.o
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3fa2.c b/drivers/gpu/drm/panel/panel-samsung-s6e3fa2.c
new file mode 100644
index 000000000000..8985fccf9792
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3fa2.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2021 Iskren Chernev <iskren.chernev@gmail.com>
+// Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree:
+// Copyright (c) 2021, The Linux Foundation. All rights reserved.
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+struct samsung_s6e3fa2 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct regulator_bulk_data supplies[2];
+	struct gpio_desc *reset_gpio;
+	bool prepared;
+};
+
+static inline
+struct samsung_s6e3fa2 *to_samsung_s6e3fa2(struct drm_panel *panel)
+{
+	return container_of(panel, struct samsung_s6e3fa2, panel);
+}
+
+#define dsi_generic_write_seq(dsi, seq...) do {				\
+		static const u8 d[] = { seq };				\
+		int ret;						\
+		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
+		if (ret < 0)						\
+			return ret;					\
+	} while (0)
+
+#define dsi_dcs_write_seq(dsi, seq...) do {				\
+		static const u8 d[] = { seq };				\
+		int ret;						\
+		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
+		if (ret < 0)						\
+			return ret;					\
+	} while (0)
+
+static void samsung_s6e3fa2_reset(struct samsung_s6e3fa2 *ctx)
+{
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(7000, 8000);
+}
+
+static int samsung_s6e3fa2_on(struct samsung_s6e3fa2 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	dsi_generic_write_seq(dsi, 0xf0, 0x5a, 0x5a);
+	dsi_generic_write_seq(dsi, 0xfc, 0x5a, 0x5a);
+	dsi_dcs_write_seq(dsi, 0xf2);
+	dsi_dcs_write_seq(dsi, 0xf9);
+	usleep_range(5000, 6000);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
+		return ret;
+	}
+	msleep(20);
+
+	dsi_generic_write_seq(dsi, 0xca,
+			      0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x80, 0x80,
+			      0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
+			      0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
+			      0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00,
+			      0x00);
+	dsi_generic_write_seq(dsi, 0xb2, 0x00, 0x0e, 0x00, 0x0e);
+	dsi_generic_write_seq(dsi, 0xb6,
+			      0x98, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03,
+			      0x55, 0x54, 0x20, 0x00, 0x0a, 0xaa, 0xaf, 0x0f,
+			      0x02, 0x22, 0x22, 0x10);
+	dsi_generic_write_seq(dsi, 0xb5, 0x41);
+	dsi_generic_write_seq(dsi, 0xf7, 0x03);
+	dsi_generic_write_seq(dsi, 0xf7, 0x00);
+	dsi_generic_write_seq(dsi, 0xb0, 0x02);
+	dsi_generic_write_seq(dsi, 0xfd, 0x0a);
+	dsi_generic_write_seq(dsi, 0xfe, 0x80);
+	dsi_generic_write_seq(dsi, 0xfe, 0x00);
+	dsi_generic_write_seq(dsi, 0x35, 0x00);
+	dsi_generic_write_seq(dsi, 0xbd, 0x05, 0x02, 0x02);
+	dsi_generic_write_seq(dsi, 0xf0, 0xa5, 0xa5);
+	dsi_generic_write_seq(dsi, 0xfc, 0xa5, 0xa5);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set display on: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int samsung_s6e3fa2_off(struct samsung_s6e3fa2 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_set_display_off(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set display off: %d\n", ret);
+		return ret;
+	}
+	usleep_range(10000, 11000);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
+		return ret;
+	}
+	msleep(120);
+
+	return 0;
+}
+
+static int samsung_s6e3fa2_prepare(struct drm_panel *panel)
+{
+	struct samsung_s6e3fa2 *ctx = to_samsung_s6e3fa2(panel);
+	struct device *dev = &ctx->dsi->dev;
+	int ret;
+
+	if (ctx->prepared)
+		return 0;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
+	samsung_s6e3fa2_reset(ctx);
+
+	ret = samsung_s6e3fa2_on(ctx);
+	if (ret < 0) {
+		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+		return ret;
+	}
+
+	ctx->prepared = true;
+	return 0;
+}
+
+static int samsung_s6e3fa2_unprepare(struct drm_panel *panel)
+{
+	struct samsung_s6e3fa2 *ctx = to_samsung_s6e3fa2(panel);
+	struct device *dev = &ctx->dsi->dev;
+	int ret;
+
+	if (!ctx->prepared)
+		return 0;
+
+	ret = samsung_s6e3fa2_off(ctx);
+	if (ret < 0)
+		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+
+	ctx->prepared = false;
+	return 0;
+}
+
+static const struct drm_display_mode samsung_s6e3fa2_mode = {
+	.clock = (1080 + 162 + 10 + 36) * (1920 + 13 + 2 + 3) * 60 / 1000,
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 162,
+	.hsync_end = 1080 + 162 + 10,
+	.htotal = 1080 + 162 + 10 + 36,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 13,
+	.vsync_end = 1920 + 13 + 2,
+	.vtotal = 1920 + 13 + 2 + 3,
+	.width_mm = 65,
+	.height_mm = 115,
+};
+
+static int samsung_s6e3fa2_get_modes(struct drm_panel *panel,
+				     struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &samsung_s6e3fa2_mode);
+	if (!mode)
+		return -ENOMEM;
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	connector->display_info.width_mm = mode->width_mm;
+	connector->display_info.height_mm = mode->height_mm;
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs samsung_s6e3fa2_panel_funcs = {
+	.prepare = samsung_s6e3fa2_prepare,
+	.unprepare = samsung_s6e3fa2_unprepare,
+	.get_modes = samsung_s6e3fa2_get_modes,
+};
+
+static int samsung_s6e3fa2_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct samsung_s6e3fa2 *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->supplies[0].supply = "iovdd";
+	ctx->supplies[1].supply = "vddr";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
+				      ctx->supplies);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get regulators\n");
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
+
+	drm_panel_init(&ctx->panel, dev, &samsung_s6e3fa2_panel_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+
+	drm_panel_add(&ctx->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
+		drm_panel_remove(&ctx->panel);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int samsung_s6e3fa2_remove(struct mipi_dsi_device *dsi)
+{
+	struct samsung_s6e3fa2 *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&ctx->panel);
+
+	return 0;
+}
+
+static const struct of_device_id samsung_s6e3fa2_of_match[] = {
+	{ .compatible = "samsung,s6e3fa2" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, samsung_s6e3fa2_of_match);
+
+static struct mipi_dsi_driver samsung_s6e3fa2_driver = {
+	.probe = samsung_s6e3fa2_probe,
+	.remove = samsung_s6e3fa2_remove,
+	.driver = {
+		.name = "panel-samsung-s6e3fa2",
+		.of_match_table = samsung_s6e3fa2_of_match,
+	},
+};
+module_mipi_dsi_driver(samsung_s6e3fa2_driver);
+
+MODULE_AUTHOR("Iskren Chernev <iskren.chernev@gmail.com>");
+MODULE_DESCRIPTION("DRM driver for samsung,s6e3fa2 panel");
+MODULE_LICENSE("GPL v2");
-- 
2.30.0


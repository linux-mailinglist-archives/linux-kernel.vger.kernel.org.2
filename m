Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78683E3AB6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 16:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhHHODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 10:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHHODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 10:03:53 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23E6C061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 07:03:33 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id m12so7673139qvt.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLrzj4bh0HvDcreSxDwqdh6zSSMVd/PhihKI8dZnQho=;
        b=UGybWrWE5J4OQ5KN0DSLGisLJPt/qmPgSwBvNaq5kXQ2noAkKLfXf/n0fduFYUjS4v
         lFufWIF9oHFntxrg93jxlWyZQgzDA+W/G77qWe9LdS+Wbp1ZfBxLSmcNonaVlqdR5RF6
         R9Ghy9JGwpzOgvhBA3mhrdw5UdkGO6A/IfT2oNSKPDLS3BEBGepJqcIx1FxoRaZbk9MY
         Eu2B031sIOhZL0Jn+Zr5vXEwTCpQN+FtWC2Q7E9QbKDeK/NPx4LkI/I8uqIIY46hzBQd
         hSMM4sBLSrWegv0KmJ8aQ2NsDLUz1gI8xPoMRFbiK6itcAsNt4pCevOTC3aZGqCWmJxj
         wkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=yLrzj4bh0HvDcreSxDwqdh6zSSMVd/PhihKI8dZnQho=;
        b=j729TJu3ORwkfg05X0VlgU4p42tsiqQVUmhNjSn3ptFbcm2lenIus2wMcfOYL1I5s3
         JyEMar0A6tGuSMrGjIN3IDYWPPNihMPxgcQQM4eDocbhD2T+glejCb828XvAv7GO8e/t
         FkznNg9aPnY25QV+MtY8ShEl66MZIfRXw8DQuzWEYXj9X4WTD16Z6X7GEdncG4ndy4QV
         A4PE7amccyUAeMkqtahps5TDoz+wK9ph6x/1MMUT9Ec2kafRlfIW8KQ/UkNdwEOkrS53
         rKYWweR3Mq7onNNJuq0Jv6SLQRmO0f0rJHetqYZlV1+tbAAHbon/Iuo6MKVac7BmFZh8
         cMzQ==
X-Gm-Message-State: AOAM532wy+QcKm1h/rb6GzMq1MpHWnZ/zof/wUV3tAH94Hj3oMajEgU0
        DLbxJSMmmFGwBOvcxC8J90o=
X-Google-Smtp-Source: ABdhPJxU0ovkSKs4L2mxlJiLM7t4VMJjj2lq46ukxj2eGxJukFGbNzL6fwSnRcg7Y2mF7HeGz/77KA==
X-Received: by 2002:a05:6214:965:: with SMTP id do5mr6055236qvb.0.1628431412582;
        Sun, 08 Aug 2021 07:03:32 -0700 (PDT)
Received: from localhost.localdomain ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id d19sm7509840qkj.40.2021.08.08.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 07:03:32 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     thierry.reding@gmail.com, airlied@linux.ie, sam@ravnborg.org,
        daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panel/tianma-tl057fvxp01: add panel for Motorola Moto G6
Date:   Sun,  8 Aug 2021 10:03:24 -0400
Message-Id: <20210808140324.14495-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a 5.7" 2160x1080 panel found on the Motorola Moto G6.
There may be other smartphones using it, as well.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig                 |  7 ++
 drivers/gpu/drm/panel/Makefile                |  1 +
 .../gpu/drm/panel/panel-tianma-tl057fvxp01.c  | 92 +++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-tianma-tl057fvxp01.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index beb581b96ecd..9e8a5fffa626 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -557,6 +557,13 @@ config DRM_PANEL_TDO_TL070WSH30
 	  24 bit RGB per pixel. It provides a MIPI DSI interface to
 	  the host, a built-in LED backlight and touch controller.
 
+config DRM_PANEL_TIANMA_TL057FVXP01
+	tristate "Tianma TL057FVXP01 panel"
+	select DRM_PANEL_MIPI_DSI_COMMON
+	help
+	  Say Y here if you want to enable support for the Tianma TL057FVXP01
+	  2160x1080 5.7" panel (found on the Motorola Moto G6).
+
 config DRM_PANEL_TPO_TD028TTEC1
 	tristate "Toppoly (TPO) TD028TTEC1 panel driver"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index c8132050bcec..9bdc2a12e719 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
 obj-$(CONFIG_DRM_PANEL_SONY_ACX424AKP) += panel-sony-acx424akp.o
 obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
 obj-$(CONFIG_DRM_PANEL_TDO_TL070WSH30) += panel-tdo-tl070wsh30.o
+obj-$(CONFIG_DRM_PANEL_TIANMA_TL057FVXP01) += panel-tianma-tl057fvxp01.o
 obj-$(CONFIG_DRM_PANEL_TPO_TD028TTEC1) += panel-tpo-td028ttec1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TPG110) += panel-tpo-tpg110.o
diff --git a/drivers/gpu/drm/panel/panel-tianma-tl057fvxp01.c b/drivers/gpu/drm/panel/panel-tianma-tl057fvxp01.c
new file mode 100644
index 000000000000..903ce8f35b75
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-tianma-tl057fvxp01.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021 Julian Braha <julianbraha@gmail.com>
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include <video/mipi_display.h>
+
+#include "panel-mipi-dsi-common.h"
+
+static void tianma_tl057fvxp01_reset(struct gpio_desc *reset_gpio)
+{
+	gpiod_set_value_cansleep(reset_gpio, 0);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(reset_gpio, 1);
+	usleep_range(1000, 2000);
+	gpiod_set_value_cansleep(reset_gpio, 0);
+	usleep_range(10000, 11000);
+}
+
+static int tianma_tl057fvxp01_on(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	dsi_dcs_write_seq(dsi, 0x00, 0x00);
+	dsi_dcs_write_seq(dsi, 0xff, 0x19, 0x11, 0x01);
+	dsi_dcs_write_seq(dsi, 0x00, 0x80);
+	dsi_dcs_write_seq(dsi, 0xff, 0x19, 0x11);
+	dsi_dcs_write_seq(dsi, 0x00, 0xb0);
+	dsi_dcs_write_seq(dsi, 0xb3, 0x04, 0x38, 0x08, 0x70);
+	dsi_dcs_write_seq(dsi, 0x00, 0x00);
+	dsi_dcs_write_seq(dsi, 0xff, 0xff, 0xff, 0xff);
+	dsi_dcs_write_seq(dsi, 0x35, 0x00);
+	dsi_dcs_write_seq(dsi, 0x51, 0xcc, 0x08);
+	dsi_dcs_write_seq(dsi, 0x53, 0x2c);
+	dsi_dcs_write_seq(dsi, 0x55, 0x01);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
+		return ret;
+	}
+	msleep(120);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set display on: %d\n", ret);
+		return ret;
+	}
+	usleep_range(10000, 11000);
+
+	return 0;
+}
+
+static const struct panel_mipi_dsi_info tianma_tl057fvxp01_info = {
+	.mode = {
+		.clock = (1080 + 53 + 4 + 53) * (2160 + 14 + 1 + 11) * 60 / 1000,
+		.hdisplay = 1080,
+		.hsync_start = 1080 + 53,
+		.hsync_end = 1080 + 53 + 4,
+		.htotal = 1080 + 53 + 4 + 53,
+		.vdisplay = 2160,
+		.vsync_start = 2160 + 14,
+		.vsync_end = 2160 + 14 + 1,
+		.vtotal = 2160 + 14 + 1 + 11,
+		.width_mm = 62,
+		.height_mm = 110,
+	},
+
+	.reset = tianma_tl057fvxp01_reset,
+	.power_on = tianma_tl057fvxp01_on,
+
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO
+		    | MIPI_DSI_MODE_VIDEO_BURST
+		    | MIPI_DSI_CLOCK_NON_CONTINUOUS
+		    | MIPI_DSI_MODE_LPM
+};
+
+MIPI_DSI_PANEL_DRIVER(tianma_tl057fvxp01, "tianma-tl057fvxp01", "tianma,tl057fvxp01");
+
+MODULE_AUTHOR("Julian Braha <julianbraha@gmail.com>");
+MODULE_DESCRIPTION("Tianma TL057FVXP01 panel driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392F141D72B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349679AbhI3KHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349731AbhI3KHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:07:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F08AC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 03:05:22 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mVsw8-00082R-U7; Thu, 30 Sep 2021 12:05:08 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mVsw3-00046S-BY; Thu, 30 Sep 2021 12:05:03 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 3/3] panel-simple: add LOGIC Technologies LTTD800480070-L2RT panel
Date:   Thu, 30 Sep 2021 12:05:01 +0200
Message-Id: <20210930100501.15690-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930100501.15690-1-o.rempel@pengutronix.de>
References: <20210930100501.15690-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Søren Andersen <san@skov.dk>

Add support for the Logic Technologies LTTD800x480 L2RT 7" 800x480 TFT
Resistive Touch Module.

Signed-off-by: Søren Andersen <san@skov.dk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/gpu/drm/panel/panel-simple.c | 35 ++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index a03b60f6fa99..fdcba94c02da 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3139,6 +3139,38 @@ static const struct panel_desc logictechno_lt170410_2whc = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct drm_display_mode logictechno_lttd800480070_l2rt_mode = {
+	.clock = 33000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 112,
+	.hsync_end = 800 + 112 + 3,
+	.htotal = 800 + 112 + 3 + 85,
+	.vdisplay = 480,
+	.vsync_start = 480 + 38,
+	.vsync_end = 480 + 38 + 3,
+	.vtotal = 480 + 38 + 3 + 29,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc logictechno_lttd800480070_l2rt = {
+	.modes = &logictechno_lttd800480070_l2rt_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.delay = {
+		.prepare = 45,
+		.enable = 100,
+		.disable = 100,
+		.unprepare = 45
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
 static const struct drm_display_mode logictechno_lttd800480070_l6wh_rt_mode = {
 	.clock = 33000,
 	.hdisplay = 800,
@@ -4754,6 +4786,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "logictechno,lt170410-2whc",
 		.data = &logictechno_lt170410_2whc,
+	}, {
+		.compatible = "logictechno,lttd800480070-l2rt",
+		.data = &logictechno_lttd800480070_l2rt,
 	}, {
 		.compatible = "logictechno,lttd800480070-l6wh-rt",
 		.data = &logictechno_lttd800480070_l6wh_rt,
-- 
2.30.2


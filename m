Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3E3E13BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbhHELUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbhHELUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:20:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806DBC0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 04:19:51 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mBbPf-00080h-Iu; Thu, 05 Aug 2021 13:19:47 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mBbPf-0003XV-0y; Thu, 05 Aug 2021 13:19:47 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/panel: simple: add LOGIC Technologies LTTD800480070-L6WH-RT
Date:   Thu,  5 Aug 2021 13:19:44 +0200
Message-Id: <20210805111944.13533-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210805111944.13533-1-o.rempel@pengutronix.de>
References: <20210805111944.13533-1-o.rempel@pengutronix.de>
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

Add support for the LOGIC Technologies, Inc LTTD800480070-L6WH-RT

Co-Developed-by: Søren Andersen <san@skov.dk>
Co-Developed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Søren Andersen <san@skov.dk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/gpu/drm/panel/panel-simple.c | 35 ++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 58ba26dbf852..b48ed9db1ac0 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2967,6 +2967,38 @@ static const struct panel_desc logictechno_lt170410_2whc = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct drm_display_mode logictechno_lttd800480070_l6wh_rt_mode = {
+	.clock = 33000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 154,
+	.hsync_end = 800 + 154 + 3,
+	.htotal = 800 + 154 + 3 + 43,
+	.vdisplay = 480,
+	.vsync_start = 480 + 47,
+	.vsync_end = 480 + 47 + 3,
+	.vtotal = 480 + 47 + 3 + 20,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc logictechno_lttd800480070_l6wh_rt = {
+	.modes = &logictechno_lttd800480070_l6wh_rt_mode,
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
 static const struct drm_display_mode mitsubishi_aa070mc01_mode = {
 	.clock = 30400,
 	.hdisplay = 800,
@@ -4492,6 +4524,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "logictechno,lt170410-2whc",
 		.data = &logictechno_lt170410_2whc,
+	}, {
+		.compatible = "logictechno,lttd800480070-l6wh-rt",
+		.data = &logictechno_lttd800480070_l6wh_rt,
 	}, {
 		.compatible = "mitsubishi,aa070mc01-ca1",
 		.data = &mitsubishi_aa070mc01,
-- 
2.30.2


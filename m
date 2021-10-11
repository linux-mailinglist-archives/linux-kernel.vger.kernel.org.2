Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00409428E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbhJKNpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:45:22 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:59570 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237310AbhJKNoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:44:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 78C9FFB06;
        Mon, 11 Oct 2021 15:41:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hEcraL-f4YQk; Mon, 11 Oct 2021 15:41:40 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ondrej Jirman <megous@megous.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/5] drm/panel: mantix: Add media bus format
Date:   Mon, 11 Oct 2021 15:41:24 +0200
Message-Id: <75fbe7139a84fa133499afe242c204ba4516da98.1633959458.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633959458.git.agx@sigxcpu.org>
References: <cover.1633959458.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the DSI bridge to detect the correct bus format.
We currently only support MEDIA_BUS_FMT_RGB888_1X24.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
index f0e9bce23c41..d6bcf1045255 100644
--- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -8,6 +8,7 @@
 #include <linux/backlight.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/media-bus-format.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
@@ -232,6 +233,10 @@ static const struct drm_display_mode default_mode_ys = {
 	.height_mm   = 130,
 };
 
+static const u32 mantix_bus_formats[] = {
+	MEDIA_BUS_FMT_RGB888_1X24,
+};
+
 static int mantix_get_modes(struct drm_panel *panel,
 			    struct drm_connector *connector)
 {
@@ -253,6 +258,10 @@ static int mantix_get_modes(struct drm_panel *panel,
 	connector->display_info.height_mm = mode->height_mm;
 	drm_mode_probed_add(connector, mode);
 
+	drm_display_info_set_bus_formats(&connector->display_info,
+					 mantix_bus_formats,
+					 ARRAY_SIZE(mantix_bus_formats));
+
 	return 1;
 }
 
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB9341AE91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbhI1MSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:18:21 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:46384 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240513AbhI1MSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:18:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 785A6FB06;
        Tue, 28 Sep 2021 14:16:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oubM4zC7mO74; Tue, 28 Sep 2021 14:16:25 +0200 (CEST)
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
Subject: [PATCH v1 5/5] drm/panel: st7703: Add media bus format
Date:   Tue, 28 Sep 2021 14:16:12 +0200
Message-Id: <75ee71d779e698e374b4b7c9963d58d852afe17f.1632828477.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1632828477.git.agx@sigxcpu.org>
References: <cover.1632828477.git.agx@sigxcpu.org>
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
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index a2c303e5732c..73f69c929a75 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -453,6 +453,10 @@ static int st7703_prepare(struct drm_panel *panel)
 	return ret;
 }
 
+static const u32 mantix_bus_formats[] = {
+	MEDIA_BUS_FMT_RGB888_1X24,
+};
+
 static int st7703_get_modes(struct drm_panel *panel,
 			    struct drm_connector *connector)
 {
@@ -474,6 +478,10 @@ static int st7703_get_modes(struct drm_panel *panel,
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


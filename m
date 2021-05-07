Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F753761AC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbhEGIHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:07:11 -0400
Received: from atl4mhfb01.myregisteredsite.com ([209.17.115.55]:45090 "EHLO
        atl4mhfb01.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235320AbhEGIHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:07:09 -0400
Received: from jax4mhob24.registeredsite.com (jax4mhob24.registeredsite.com [64.69.218.112])
        by atl4mhfb01.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 14780cPS024657
        for <linux-kernel@vger.kernel.org>; Fri, 7 May 2021 04:00:38 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.206])
        by jax4mhob24.registeredsite.com (8.14.4/8.14.4) with ESMTP id 14780UBH130539
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 7 May 2021 04:00:30 -0400
Received: (qmail 24178 invoked by uid 0); 7 May 2021 08:00:30 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 7 May 2021 08:00:30 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 2/3] drm/panel: Add Innolux G104AGE-L02 to panel-simple
Date:   Fri,  7 May 2021 10:00:16 +0200
Message-Id: <20210507080017.2794-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210507080017.2794-1-mike.looijmans@topic.nl>
References: <20210507080017.2794-1-mike.looijmans@topic.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the Innolux G104AGE-L02 which is a 800x600 TFT
display panel with LVDS interface.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/gpu/drm/panel/panel-simple.c | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index be312b5c04dd..8b7732249d13 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2352,6 +2352,37 @@ static const struct panel_desc innolux_g101ice_l01 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing innolux_g104age_l02_timing = {
+	.pixelclock = { 30000000, 41666666, 50000000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 80, 128, 130 },
+	.hback_porch = { 79, 127, 129 },
+	.hsync_len = { 1, 1, 1 },
+	.vactive = { 600, 600, 600 },
+	.vfront_porch = { 4, 29, 212 },
+	.vback_porch = { 3, 28, 211 },
+	.vsync_len = { 1, 1, 1 },
+	.flags = DISPLAY_FLAGS_DE_HIGH |
+		 DISPLAY_FLAGS_HSYNC_HIGH |
+		 DISPLAY_FLAGS_VSYNC_HIGH,
+};
+
+static const struct panel_desc innolux_g104age_l02 = {
+	.timings = &innolux_g104age_l02_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 211,  /* 211.2 X 158.4(mm) */
+		.height = 158,
+	},
+	.delay = {
+		.enable = 200,
+		.disable = 200,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct display_timing innolux_g121i1_l01_timing = {
 	.pixelclock = { 67450000, 71000000, 74550000 },
 	.hactive = { 1280, 1280, 1280 },
@@ -4347,6 +4378,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,g101ice-l01",
 		.data = &innolux_g101ice_l01
+	}, {
+		.compatible = "innolux,g104age-l02",
+		.data = &innolux_g104age_l02
 	}, {
 		.compatible = "innolux,g121i1-l01",
 		.data = &innolux_g121i1_l01
-- 
2.17.1


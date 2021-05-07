Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854EB3761AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbhEGIHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:07:08 -0400
Received: from atl4mhfb02.myregisteredsite.com ([209.17.115.118]:49234 "EHLO
        atl4mhfb02.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235293AbhEGIHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:07:07 -0400
Received: from jax4mhob01.registeredsite.com (jax4mhob01.myregisteredsite.com [64.69.218.81])
        by atl4mhfb02.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 14780hex024937
        for <linux-kernel@vger.kernel.org>; Fri, 7 May 2021 04:00:43 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.206])
        by jax4mhob01.registeredsite.com (8.14.4/8.14.4) with ESMTP id 14780XDa003784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 7 May 2021 04:00:42 -0400
Received: (qmail 24284 invoked by uid 0); 7 May 2021 08:00:32 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 7 May 2021 08:00:31 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 3/3] drm/panel: Add Yes Optoelectronics YTS700TLBC-02-100C to panel-simple
Date:   Fri,  7 May 2021 10:00:17 +0200
Message-Id: <20210507080017.2794-3-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210507080017.2794-1-mike.looijmans@topic.nl>
References: <20210507080017.2794-1-mike.looijmans@topic.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the Yes YTS700TLBC-02-100C which is a 1024x600 TFT
display panel with LVDS interface.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/gpu/drm/panel/panel-simple.c | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 8b7732249d13..c9815faf8c77 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4139,6 +4139,33 @@ static const struct panel_desc winstar_wf35ltiacd = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
+static const struct display_timing yes_optoelectronics_yts700tlbc_02_100c_timing = {
+	.pixelclock = { 40800000, 50000000, 67200000 },
+	.hactive = { 1024, 1024, 1024 },
+	.hfront_porch = { 16, 127, 216 },
+	.hback_porch = { 160, 160, 160 },
+	.hsync_len = { 1, 1, 1 },
+	.vactive = { 600, 600, 600 },
+	.vfront_porch = { 1, 11, 127 },
+	.vback_porch = { 23, 23, 23 },
+	.vsync_len = { 1, 1, 1 },
+	.flags = DISPLAY_FLAGS_DE_HIGH |
+		 DISPLAY_FLAGS_HSYNC_LOW |
+		 DISPLAY_FLAGS_VSYNC_LOW,
+};
+
+static const struct panel_desc yes_optoelectronics_yts700tlbc_02_100c = {
+	.timings = &yes_optoelectronics_yts700tlbc_02_100c_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode yes_optoelectronics_ytc700tlag_05_201c_mode = {
 	.clock = 51200,
 	.hdisplay = 1024,
@@ -4606,6 +4633,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "yes-optoelectronics,ytc700tlag-05-201c",
 		.data = &yes_optoelectronics_ytc700tlag_05_201c,
+	}, {
+		.compatible = "yes-optoelectronics,yts700tlbc-02-100c",
+		.data = &yes_optoelectronics_yts700tlbc_02_100c,
 	}, {
 		/* Must be the last entry */
 		.compatible = "panel-dpi",
-- 
2.17.1


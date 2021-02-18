Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9B731F2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBRW5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:57:12 -0500
Received: from smtpcmd0991.aruba.it ([62.149.156.91]:60381 "EHLO
        smtpcmd0991.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhBRW4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:56:50 -0500
Received: from ubuntu.localdomain ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id CsCZl9zcdJFRNCsCtlTfUC; Thu, 18 Feb 2021 23:55:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1613688935; bh=q9L05eGn0HIDk98um6gpViXmrMbpn05ZRhCwVCEpaBQ=;
        h=From:To:Subject:Date:MIME-Version;
        b=h1KONaoCxBHlYTuXin/rVbpPZYfgzLJcKnAVh+M7s/TwtXbnbZ2J/GXw1klyqzVjP
         msmENJbxrLpdS3DgpVUoKInKqhSQisO0QOSsTQoxm9d7nm/DLRZz0OpGLa5qr+HZnW
         XvnGMRd2IHrztDApNiEaK5FmLAY6hf8v9+h/tzowFBFdn/R5W+OL1vA1Jk2umgt6Lq
         XYe6pJ4yYKDFWCsoY7PcGnXhL3YTEsJGRoD/FAJc3RF7b80ZZRlcGsBOqOQEwJRh17
         gd9NI3PfKBjVKxxBaih6bpq5aR8h34U8EFXof2FMHavjUulMfV0FEIQkzAXMdwKUOP
         dtEG46f7jRy2g==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>, allen <allen.chen@ite.com.tw>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Max Merchel <Max.Merchel@tq-group.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] drm/panel: simple: add Jenson JT60245-01
Date:   Thu, 18 Feb 2021 23:54:54 +0100
Message-Id: <20210218225458.823773-7-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218225458.823773-1-giulio.benetti@benettiengineering.com>
References: <20210218225458.823773-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJqai42glsm/W9k4RRLq+9Qc8Z0UDeUTqa9M6zQ8skSDd1D/PrMDE2nvZkwNpC9CqeJjNBJHkk9XM/PqbyqApSoup5sCKHnGVngtDu0r2YQ+htnKCf/8
 8xnwtMDBLg632aG0h5V6bl570aFV4MLgRbqte9+dG6msbwB7umlPNBbzG28Nyw0BKwctrp3jDDvJOPp8OX2R4M3F+5uK45bAnuIFLXN5YuCYT4hedxPnAh5E
 aVjWQP2c51NgRv/5nvZfXAq2d5hjuqwtFdg2YMnwr/Vd/aI2ZqYuyGlDwbOWdPWTDqyvBg1ulN4uw5RU7NxqbaK6u7RBToeY6JuAO7VNqE9AgfolM9EgLry2
 gAf8jt2fnEhcsI3gO7vGAyBtWQo3ZrjVJD2QoWs9djfhDgqBbeyzmi7khQt06Np6lbZ/E9QEQAy93Hi3BjvDsMtgP3WH63nMeFxlaM54ZzTgbhwqnWYrV7j5
 MUpI+CNwk3xBGYVwXRDbuctRWGHBEsfQxD53EXElMnPRWSMjqOJ2iyK3bIEgx9Fv3ZrL5ndA5Q34AiME+saLFgGUft6OQyu8HXAC4sh5Q/X2QOBV0cdrqC80
 uoQLuNdG4z8elWuGvRVT097O0XIkJ1RYQrvUCHJIkakjiudLhckdXe7Y9dvO3pbieJ2KYk6lCcwc8alVEgFpWdKVArroCE5IyQhbzfHQNJaT/uB9lb/8lho8
 vSgrOgqQOPuvfNjl+tGRC5GlOR1WqSCUtRvI67rPzghCABTVKjsmTzv3/UhlQZoI6gAiE+g+RoVDnQjyuZt1wtwbv9YPeOSKbeaGWwWTpWvJJt2JLIciAg==
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

This patch adds support for Jenson JT60245-01 800x480 7" panel to DRM
simple panel driver.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 41bbec72b2da..f268ad5f5345 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2396,6 +2396,30 @@ static const struct panel_desc ivo_m133nwf4_r0 = {
 	.connector_type = DRM_MODE_CONNECTOR_eDP,
 };
 
+static const struct drm_display_mode jenson_jt60245_01_mode = {
+	.clock = 35000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 210,
+	.hsync_end = 800 + 210 + 20,
+	.htotal = 800 + 210 + 20 + 46,
+	.vdisplay = 480,
+	.vsync_start = 480 + 22,
+	.vsync_end = 480 + 22 + 10,
+	.vtotal = 480 + 22 + 10 + 23,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc jenson_jt60245_01 = {
+	.modes = &jenson_jt60245_01_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE,
+};
+
 static const struct drm_display_mode kingdisplay_kd116n21_30nv_a010_mode = {
 	.clock = 81000,
 	.hdisplay = 1366,
@@ -4162,6 +4186,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "ivo,m133nwf4-r0",
 		.data = &ivo_m133nwf4_r0,
+	}, {
+		.compatible = "jenson,jt60245-01",
+		.data = &jenson_jt60245_01,
 	}, {
 		.compatible = "kingdisplay,kd116n21-30nv-a010",
 		.data = &kingdisplay_kd116n21_30nv_a010,
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC97E3D4728
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 12:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhGXJyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 05:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbhGXJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 05:54:19 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC81CC061765;
        Sat, 24 Jul 2021 03:34:48 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b21so4758575ljo.13;
        Sat, 24 Jul 2021 03:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnvkl849T6gYuAbsy2a/smQSm1SP3pjdPoq4R1g+NLM=;
        b=lQpnOGYtl/yRkXOSuo9lJbxSkehxRtOti4FgfX/yZT+78H05XEYfw80BHidzyS5bzF
         hwLbtaSL+/8Eznl87scgXPe93+9yRJ5+2BHLAetQHEVrT/klxxjhVe0N4AOrOj5giINh
         OZNp3MwF62NluqjabkdheKRvH8p+0tVblZANZXwiQMXPcuOTQQp2fbf7/aarkbYiGbf9
         uO3TtJ07Rhd0Jd6qSfLlo+UkQD0L3xglECXZdU+xRoiamygDuOjWF6tZXdwED3d1b41/
         RJg+mVTOQ8Wjyny5MKqmf+1x9SPi2ssAGYz33lmZmPSld3aXz5v1qCicv07tHhaPrtkh
         Rbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnvkl849T6gYuAbsy2a/smQSm1SP3pjdPoq4R1g+NLM=;
        b=MkwBhDcC97Gj9g6NVNxnVPp3y2POemil9RG1JFoIi9+KJuJOIxQqZrHmiQZfwUVp+N
         HsQ/lGzLAtpGT7OWoGKMeQIqUFGozli8MslErJMs5oJugi5X5Soowpm70yGrQ7S5VLNY
         Eg25UfLChLxNChuJ+zwboZODfre2DL++r51TXJ169QJgVdm7Tj9hbvdTnI0PInqsHP32
         nBStpUAGemdkILfY1loy5Jg3mhUQ6ok0IznaQYINmscYoiiuuRzi7skYDdE1KmECkjis
         lREgigzfx5LefCTxUQdCzYdUxEKA3L1kTIFTqHRul6DlXOEqKWTldZ71521KEq1+VtDl
         PqjQ==
X-Gm-Message-State: AOAM533Yk25t+ldDvhJPUjw9q0SwEykxtn7vbFmz4duRi5bMENpB/CLd
        Kd2VUubm5YmqV+no9HQWBD8=
X-Google-Smtp-Source: ABdhPJwoA8KA+e2Jba9pTjxOTeKuhggtbmOaNQFYFb5CrkJpYE9rXyV/Ets6mpV7g7qZ7Wjm9r18Pw==
X-Received: by 2002:a2e:9e05:: with SMTP id e5mr5955190ljk.141.1627122887094;
        Sat, 24 Jul 2021 03:34:47 -0700 (PDT)
Received: from akaWolf-PC.. ([194.79.5.201])
        by smtp.gmail.com with ESMTPSA id v22sm2158938lfi.270.2021.07.24.03.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 03:34:46 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH v2 3/3] drm/panel-simple: add Gopher 2b LCD panel
Date:   Sat, 24 Jul 2021 13:33:58 +0300
Message-Id: <20210724103358.1632020-4-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210724103358.1632020-1-akawolf0@gmail.com>
References: <20210724103358.1632020-1-akawolf0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gopher 2b LCD panel is used in Gopher 2b handhelds.
It's simple panel with NewVision NV3047 driver, but SPI lines are not connected.
It has no specific name, since it's unique to that handhelds.
lot name at AliExpress: 4.3 inch 40PIN TFT LCD Screen COG NV3047 Drive IC 480(RGB)*272 No Touch 24Bit RGB Interface

Signed-off-by: Artjom Vejsel <akawolf0@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 43 ++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9b286bd4444f..9676e25accb3 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4306,6 +4306,46 @@ static const struct panel_desc yes_optoelectronics_ytc700tlag_05_201c = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct drm_display_mode qishenglong_gopher2b_lcd_panel_modes[] = {
+	{ /* 60 Hz */
+		.clock = 10800,
+		.hdisplay = 480,
+		.hsync_start = 480 + 77,
+		.hsync_end = 480 + 77 + 41,
+		.htotal = 480 + 77 + 41 + 2,
+		.vdisplay = 272,
+		.vsync_start = 272 + 16,
+		.vsync_end = 272 + 16 + 10,
+		.vtotal = 272 + 16 + 10 + 2,
+		.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+	},
+	{ /* 50 Hz */
+		.clock = 10800,
+		.hdisplay = 480,
+		.hsync_start = 480 + 17,
+		.hsync_end = 480 + 17 + 41,
+		.htotal = 480 + 17 + 41 + 2,
+		.vdisplay = 272,
+		.vsync_start = 272 + 116,
+		.vsync_end = 272 + 116 + 10,
+		.vtotal = 272 + 116 + 10 + 2,
+		.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+	},
+};
+
+static const struct panel_desc qishenglong_gopher2b_lcd_panel = {
+	.modes = qishenglong_gopher2b_lcd_panel_modes,
+	.num_modes = ARRAY_SIZE(qishenglong_gopher2b_lcd_panel_modes),
+	.bpc = 8,
+	.size = {
+		.width = 95,
+		.height = 54,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
 static const struct drm_display_mode arm_rtsm_mode[] = {
 	{
 		.clock = 65000,
@@ -4753,6 +4793,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "yes-optoelectronics,ytc700tlag-05-201c",
 		.data = &yes_optoelectronics_ytc700tlag_05_201c,
+	}, {
+		.compatible = "qishenglong,gopher2b-lcd-panel",
+		.data = &qishenglong_gopher2b_lcd_panel,
 	}, {
 		/* Must be the last entry */
 		.compatible = "panel-dpi",
-- 
2.32.0


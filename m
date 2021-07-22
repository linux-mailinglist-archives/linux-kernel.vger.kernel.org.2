Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DB33D2532
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhGVNZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhGVNZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:25:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54032C061575;
        Thu, 22 Jul 2021 07:06:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id v6so8726572lfp.6;
        Thu, 22 Jul 2021 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8P+SNIm7ys6Pm3nFiUXaaTArhPHCRQdekLUEbPgIWuY=;
        b=JEm96QwhXUz7bAeQpkiWigh8u7b05RgHuD0u6usLs5C18FXpJmnuutQsR8bGfCqSqj
         vNY1t7JRidi1/S4YbGvF2rDqWj51nRdB+mHSfif3p2IGdckpIcr0wHjm8re5gYKcoF0W
         7QkxlrAkDqn6aI5pUI+mYHOh+XKuZyMjsbj+gA5vJRXSkgs+zd6f9kmsJPhpOyeFVxPf
         jy2cYnaP6s6jy6VVwXA2Toa+Syn6hv0olVcnQJpB0ygAGO0FW0OCVzJGoWhVqUeccRQ1
         IIjLjwOUUwbMKKXfpB0ffpn4v06nbIobYu6mMNnG+2WNdcoolsraWjUj21Vg0b8quGu5
         CVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8P+SNIm7ys6Pm3nFiUXaaTArhPHCRQdekLUEbPgIWuY=;
        b=Wn0d5ghxuhAk5WegZfB8mrE2cHErILbxx1E90Kl1bD/SLXc4JqzNHUo0/C7t76NwLk
         pnIhRrUb9m2DGAFyup2Vo8k2KdIajpACMzAMWI0KsWBnunSD0euYRTRZKb9KIi0/zEHQ
         WfKWzcpTlnzTwmKbljgowy57J5XScZTbgM4nliUtJ8XXBjQRTi58FA6cPW1xhin5//y9
         4vmW1M1mCugwPCtyM3aKGs0ejvVp79HGuYlU13Zegsydcz+DKiL5AdneJJs4BBUIPY4d
         IcyTHsUpSsNMWQqzmg6C7TZk3Tsue/FU/5ZgVQGBQ8EBEuK8wiJVYnLHGlmWAbaWKESm
         vYAw==
X-Gm-Message-State: AOAM531if2bOVx5C/hr0uH1XqjsflNXT3R2RjviGN0U0rvHD3VgJLDNf
        vwPZccpg1J7WHk4tTSOkAb/JG/XmpatM5w==
X-Google-Smtp-Source: ABdhPJwIOUSQmsam9/2wyWQVAgpLviDfVIYK7k0C/PaMYboRYoaohZgwvnmlH0s1teitKY8EPyUcQw==
X-Received: by 2002:a19:771c:: with SMTP id s28mr28487458lfc.358.1626962764736;
        Thu, 22 Jul 2021 07:06:04 -0700 (PDT)
Received: from akaWolf-PC.. ([194.79.5.201])
        by smtp.gmail.com with ESMTPSA id p8sm190584lfu.163.2021.07.22.07.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 07:06:04 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH 3/3] drm/panel-simple: add Gopher 2b LCD panel
Date:   Thu, 22 Jul 2021 17:04:32 +0300
Message-Id: <20210722140432.1426173-4-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722140432.1426173-1-akawolf0@gmail.com>
References: <20210722140432.1426173-1-akawolf0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gopher 2b LCD panel is used in Gopher 2b handhelds.
It's simple panel with NewVision NV3047 driver,
but SPI lines are not connected.
It has no specific name, since it's unique to that handhelds.
lot name at AliExpress: 4.3 inch 40PIN TFT LCD Screen COG
NV3047 Drive IC 480(RGB)*272 No Touch 24Bit RGB Interface

Signed-off-by: Artjom Vejsel <akawolf0@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 44 ++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9b286bd4444f..9cce6b63a147 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4306,6 +4306,47 @@ static const struct panel_desc yes_optoelectronics_ytc700tlag_05_201c = {
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
+	.num_modes = 1,
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
@@ -4753,6 +4794,9 @@ static const struct of_device_id platform_of_match[] = {
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

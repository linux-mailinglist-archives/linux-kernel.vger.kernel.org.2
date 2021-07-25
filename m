Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B263D5060
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 00:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhGYVfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 17:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhGYVfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 17:35:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23DFC061757;
        Sun, 25 Jul 2021 15:16:08 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bp1so12043392lfb.3;
        Sun, 25 Jul 2021 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6B4jEJL67NPET91efGnsWZsqxuxCtq/o5nz6hNotkO4=;
        b=BxSZFFCUwe+jQ8T87WItuzNoJcDlu154rWQJJMghA8dQX0fmzhKsCmr6QRDL0iFKIz
         UVIw3FhQlxabjAxaGoUF7/kUm8Q2mkaEj2HiMhDq4q/sTnyJW7P8qZPsIHo5hIq9FP07
         vHiisc+pC5Vw4cInOEEw7a9b6eeBoDRohH+IaPdi9pd9hrqIbXmde5jeEKxpGHMK0K8a
         1fLEasbCkIJPVrnzNSS0k4frtmAsKx3WtbKySH0Y9X7LKjfTNoMlWDnqr7j6v0xBbI8n
         uMYJonkT5ZRGUye9Dr5lja7Y1jmOeubtfoaBH03TJHW0icvayPE3JbFkf7Q9fYNSrDwd
         2rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6B4jEJL67NPET91efGnsWZsqxuxCtq/o5nz6hNotkO4=;
        b=hBJR7cGjMhRY3cjhe1CFuCclU7j+ybJ300HItAQcg0wSYvMovj5o+fA058YX3TNUUK
         VIi+Ad8L4/q62u3D8kmsNk63moXVec/Q3kSj+z2jOr1Sckgngf82+LXqhWgqTk/+MAws
         Wx6EO36GEIPT+3Ly0WJuB9YwlBuJxB3rU3s9dfcP0sl8RZLcGUwW6nzBcvdhwC9dmCy3
         wCF5ImbgB4yuivSXrK51E8r+aQEZadsaNvGH6QUuqhdquvcaERTSpVsx0PknjJftpyrf
         9YJhy/ry408VpkZYgOrCQepd6A8tlOReRL7eVouHQcS6Ogfpppy4JmPppS1vUSka+F1j
         tx8A==
X-Gm-Message-State: AOAM530G0zl+YBn8RtQ4IfBVFdqdBSAE6oxUvIOrHBZgTJlVhm6balWi
        naWiyTr6j19kO2clIV8Sp78=
X-Google-Smtp-Source: ABdhPJxL2L6D6hlrndH5ArxdXn3vZvFTY6HE9Ya6xghjgEv7cqSHBJqJh4TBbw6snIoS0QyU9IdSpQ==
X-Received: by 2002:ac2:4888:: with SMTP id x8mr10406743lfc.19.1627251367371;
        Sun, 25 Jul 2021 15:16:07 -0700 (PDT)
Received: from akaWolf-PC.. ([194.79.5.201])
        by smtp.gmail.com with ESMTPSA id z12sm2862647lfu.53.2021.07.25.15.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 15:16:06 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH v3 3/3] drm/panel-simple: add Gopher 2b LCD panel
Date:   Mon, 26 Jul 2021 01:15:27 +0300
Message-Id: <20210725221527.1771892-4-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210725221527.1771892-1-akawolf0@gmail.com>
References: <20210725221527.1771892-1-akawolf0@gmail.com>
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
index 9b286bd4444f..6b69c0c70814 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3563,6 +3563,46 @@ static const struct panel_desc qd43003c0_40 = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
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
 static const struct display_timing rocktech_rk070er9427_timing = {
 	.pixelclock = { 26400000, 33300000, 46800000 },
 	.hactive = { 800, 800, 800 },
@@ -4651,6 +4691,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "qiaodian,qd43003c0-40",
 		.data = &qd43003c0_40,
+	}, {
+		.compatible = "qishenglong,gopher2b-lcd-panel",
+		.data = &qishenglong_gopher2b_lcd_panel,
 	}, {
 		.compatible = "rocktech,rk070er9427",
 		.data = &rocktech_rk070er9427,
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9FD3D65D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhGZQyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbhGZQyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:54:22 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8889C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:34:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so9357806otu.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6vcmdJW0PQwHX3N7q/LEirUpgpEmrk9ZWnfdjvnD6Jk=;
        b=nLHtI5JJvX9xtd7elYmv5mrwhLNRE1SFbDt8Hzb3bV4/IjlXMW+HUjFbztwqRDg363
         gdppbsUhRFsLlctiHkM+9XscRrpYT+/xmXJO65+5z5dQi7huKXI8i1OWIAE1r4/bcIev
         XYw9AY5CApf+ZA9ZIYNfN/UTclla7SICAY006mFZhWEW+VTP6gET/enl5BnAP9MwW0CS
         J8YOa2K8dUvHygM/dlLe0v/T5TZCGqU0cT/VAhXIUR4xRlkk8ToBBBMdbNVIHnvB4SFv
         2wnBmb5fUSkBJo+KnX25L+lZWUBHgjU8w9We1btPimzVKy2VnfLf023t/NlnU/eejiAF
         fT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vcmdJW0PQwHX3N7q/LEirUpgpEmrk9ZWnfdjvnD6Jk=;
        b=uk5v0azVa2YsoK2TCK2D43ds96MjFew6UC4tJsftcwv+jFyPrn95Fa3+MU+0uGwmvc
         nb9rofKVmS9bk0BgZhCdJD7ts9AdTPbxjKkBEeydtC9Hj3elawfEyivx1MCVQGMx+rdL
         WTiVjNR0CjRVrCmg17UaN4EdWKn2243v1jC8D2ryi4U2RaDIVsYDC6ICKuR0/KMpE4cQ
         PxvE3VQs5K05m+itERezLOKvc6/MaBC2JaOy22i6YM2zdC+QVMs//NFSjRE5jP/ykRIz
         HbNth09z/7GsD9laE8KGyWXqmmpJTnyEK6e+xQac3L7j994d8L2rTN6mPkoKdpg6u+d7
         2HhA==
X-Gm-Message-State: AOAM532LA45HtSK5QJXaXqIdyet8ONkVRdAjEh8LFcI4bX5ThKVMEnRN
        gZGk9seylbKomw43xOg1WumGafQH1uEdVw==
X-Google-Smtp-Source: ABdhPJztOzkgX+7urD2V90sFSZLX88MlP0aAgAWiiwYZyalCxrrj2COGktvlJXnrIRyp4ra/dedq4Q==
X-Received: by 2002:a9d:448:: with SMTP id 66mr7390470otc.345.1627320890170;
        Mon, 26 Jul 2021 10:34:50 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s24sm69328ooq.37.2021.07.26.10.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 10:34:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/panel: simple: Add support for two more AUO panels
Date:   Mon, 26 Jul 2021 10:33:00 -0700
Message-Id: <20210726173300.432039-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210726173300.432039-1-bjorn.andersson@linaro.org>
References: <20210726173300.432039-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition of the AUO B133HAN05.4 13.3" FHD panel and the
B140HAN06.4 14.0" FHD panel.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 66 ++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 21939d4352cf..fcf6cbbfdedb 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1080,6 +1080,36 @@ static const struct panel_desc auo_b133xtn01 = {
 	},
 };
 
+static const struct drm_display_mode auo_b133han05_mode = {
+	.clock = 142600,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 58,
+	.hsync_end = 1920 + 58 + 42,
+	.htotal = 1920 + 58 + 42 + 60,
+	.vdisplay = 1080,
+	.vsync_start = 1080 + 3,
+	.vsync_end = 1080 + 3 + 5,
+	.vtotal = 1080 + 3 + 5 + 54,
+};
+
+static const struct panel_desc auo_b133han05 = {
+	.modes = &auo_b133han05_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 293,
+		.height = 165,
+	},
+	.delay = {
+		.prepare = 100,
+		.enable = 20,
+		.unprepare = 50,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DATA_MSB_TO_LSB,
+	.connector_type = DRM_MODE_CONNECTOR_eDP,
+};
+
 static const struct drm_display_mode auo_b133htn01_mode = {
 	.clock = 150660,
 	.hdisplay = 1920,
@@ -1107,6 +1137,36 @@ static const struct panel_desc auo_b133htn01 = {
 	},
 };
 
+static const struct drm_display_mode auo_b140han06_mode = {
+	.clock = 141000,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 16,
+	.hsync_end = 1920 + 16 + 16,
+	.htotal = 1920 + 16 + 16 + 152,
+	.vdisplay = 1080,
+	.vsync_start = 1080 + 3,
+	.vsync_end = 1080 + 3 + 14,
+	.vtotal = 1080 + 3 + 14 + 19,
+};
+
+static const struct panel_desc auo_b140han06 = {
+	.modes = &auo_b140han06_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 309,
+		.height = 174,
+	},
+	.delay = {
+		.prepare = 100,
+		.enable = 20,
+		.unprepare = 50,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DATA_MSB_TO_LSB,
+	.connector_type = DRM_MODE_CONNECTOR_eDP,
+};
+
 static const struct display_timing auo_g070vvn01_timings = {
 	.pixelclock = { 33300000, 34209000, 45000000 },
 	.hactive = { 800, 800, 800 },
@@ -4233,9 +4293,15 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,b116xw03",
 		.data = &auo_b116xw03,
+	}, {
+		.compatible = "auo,b133han05",
+		.data = &auo_b133han05,
 	}, {
 		.compatible = "auo,b133htn01",
 		.data = &auo_b133htn01,
+	}, {
+		.compatible = "auo,b140han06",
+		.data = &auo_b140han06,
 	}, {
 		.compatible = "auo,b133xtn01",
 		.data = &auo_b133xtn01,
-- 
2.29.2


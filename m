Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCDA3EF043
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhHQQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHQQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:37:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EE5C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 09:36:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b10so31334185eju.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUvwlKWhGLRCmR/vgTBa/y/Y0LZjj+6hoHG51z0UIpA=;
        b=ItwJNR6dZAWtE5x5L9P9DwShoDVmdWsgbe889cJQMar4e577WNkGJTLeHstF+UZp4B
         V6MHN60I03tqUGVlwFIF31Qn+gzfrWRtC2zwT2YJgZmortO9kI4aUt1gw2PMPC9L8362
         StM1AdvyuQbbL7kJ6StSoXAp6yXw0bf1ivkviKZ+/XAhru2ZhK39whKdC5Bxez5PMMld
         dV7QcIuscG3exs8DGYRXKlE7l2GlYrdaW3QUYFS5I4fiGQSiFT3EfzGjiSb9sQzB/5/o
         /C9jBPfPr5iPsbMhttnmcnSIIxHcQQ7Px8EZhtTGFbcgyuKjJeoM80Cex3+EjtYLSQun
         ILeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUvwlKWhGLRCmR/vgTBa/y/Y0LZjj+6hoHG51z0UIpA=;
        b=fem2eF145qZ8Gaie5k4kmB0mZiUPfpxttfZZiXxxTAG1+RO/GkPeHm/owclMoi+blK
         VNMsvzU8h+n4hIC1UIeN1N8AX662DFuNrFsEYOv5gDG5eBLl1M8W2a/zQugAgnpRFDX2
         Icor1StqZSWUmdJz4L6ka65fRTZnFFExbweUHCARYtxHIn9sR0GxFV+EFbV/34sMEwrj
         N1D5o+arlrvQL2Gstw4cq5nP5fznc0VRfzIDoQVqMcyvJKt+0Vmi880cjB6Kx2S8OMgs
         fUj+9I4o7XG0m/xDrqgVBWMeexoI23FvEMllptuy0nEOmv+uUE1T/lLEVnpqfRPaHbet
         dgnA==
X-Gm-Message-State: AOAM533FZ2l28xxqgN2Lq/V2NBbGZrEBFtok3ZGqSctXjRNpbvTOb/PW
        J4FM9+1Q1/9nw/ddVsvxnl8=
X-Google-Smtp-Source: ABdhPJzlvdE3sEZ6wE4mp1nxuzzLEnBAbGmHvdl/VEt9bm4Ec7nGWqd9jyXG4yFjbClRdrDPxTVCbg==
X-Received: by 2002:a17:906:b18e:: with SMTP id w14mr4954643ejy.63.1629218185929;
        Tue, 17 Aug 2021 09:36:25 -0700 (PDT)
Received: from localhost.localdomain ([213.91.86.150])
        by smtp.googlemail.com with ESMTPSA id r2sm1313795edv.78.2021.08.17.09.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 09:36:25 -0700 (PDT)
From:   Nikola Pavlica <pavlica.nikola@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nikola Pavlica <pavlica.nikola@gmail.com>
Subject: [PATCH] drm/panel-simple: Add Vivax TPC-9150 panel v3
Date:   Tue, 17 Aug 2021 18:36:05 +0200
Message-Id: <20210817163605.1077257-1-pavlica.nikola@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The model and make of the LCD panel of the Vivax TPC-9150 is unknown,
hence the panel settings that were retrieved with a FEX dump are named
after the device NOT the actual panel.

The LCD in question is a 50 pin MISO TFT LCD panel of the resolution
1024x600 used by the aforementioned device.

Version 2, as Thierry kindly suggested that I fix the order in which the
panel was ordered compared to others.

Version 3, filling in the required info suggested by Sam. Plus some
factual issues that I've corrected myself (tested working)

Thanks,
Nikola

Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4e2dad314c79..f6b3e58c162b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3989,6 +3989,32 @@ static const struct panel_desc urt_umsh_8596md_parallel = {
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
+static const struct drm_display_mode vivax_tpc9150_panel_mode = {
+	.clock = 60000,
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 160,
+	.hsync_end = 1024 + 160 + 100,
+	.htotal = 1024 + 160 + 100 + 60,
+	.vdisplay = 600,
+	.vsync_start = 600 + 12,
+	.vsync_end = 600 + 12 + 10,
+	.vtotal = 600 + 12 + 10 + 13,
+};
+
+static const struct panel_desc vivax_tpc9150_panel = {
+	.modes = &vivax_tpc9150_panel_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 200,
+		.height = 115,
+	},
+	.bpc = 6,
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+
 static const struct drm_display_mode vl050_8048nt_c01_mode = {
 	.clock = 33333,
 	.hdisplay = 800,
@@ -4490,6 +4516,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "urt,umsh-8596md-20t",
 		.data = &urt_umsh_8596md_parallel,
+	}, {
+		.compatible = "vivax,tpc9150-panel",
+		.data = &vivax_tpc9150_panel,
 	}, {
 		.compatible = "vxt,vl050-8048nt-c01",
 		.data = &vl050_8048nt_c01,
-- 
2.32.0


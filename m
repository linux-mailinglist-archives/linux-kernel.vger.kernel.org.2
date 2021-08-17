Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224973EEFE3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbhHQP71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbhHQP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:58:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8FDC0604C7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 08:54:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g21so18382629edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hPVxIIYJMTAKAHkD7g8fS9aJ8RhBft7CiFNnTlXmcMk=;
        b=CEX2uMQl1Es2j48M4bpAu8pwcPofi/4shuRHG1C7Y6f8/SydLf0eFWV39lObiTbvt/
         LYAGN7AG/iADsItx2zwyLknQVPhPLe+icGygMnVFUBo/pLrzkJPpYyrR5l+cHc+7ewv8
         ej4xSv1/QPmPRkG1knX0YAfsquy10AS/jM301s3JX8VwUxxhnX2RXxWelHabAwzmZWHF
         eHMWyCarIsxMNzFlLFPilAG6CnY7tZZf7RY5i4FS5XZTfGH4V0ima1sOstPZ2d1C0UPd
         XPd8F9nKkGYkubCLZRm+IThPuwpsY8HzXDZAFP+MR9W+UIuwpXrQTRS1K/3vmZjq87Rt
         TMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hPVxIIYJMTAKAHkD7g8fS9aJ8RhBft7CiFNnTlXmcMk=;
        b=VkBe0b8q5hFn4/DMeBxPbPnsmmd7A3ZUojoGmN4IBez+BhUN4R4iIRkPshKCbuvPYS
         WZXOpm0z07peCCLsU4z+u3zD6Op2GB+SWJCGCKP68GGcrfqemPe7owgLcIRCZKUnJnnO
         HNbTFD5aGTfi/1l0fyJMGEKwHz7+4pyktFMgghSjVAtwBvUTHkBZjdDtqLfwMKTxd8qZ
         H6qdGzWbfZEYvF3KE+rW+kxY+gjdTYwH4Jmwu2fNnZ7se7z/Js84BFlc784ybg3QFxH+
         R3c6DIUuUA5+2Yqlv3sGfoiwWyVY/RNkL0JuX70ERKH5NehuQmOPi+yFi+hfkBH3OYFQ
         r7TA==
X-Gm-Message-State: AOAM5324z1kS7OA+EketRmeWI0zPxKOeJXC5QvBvWflYRUH4Ng8bYTj1
        1TPgWtmuws9uV0Jj3cWoFCg=
X-Google-Smtp-Source: ABdhPJxy0HY2v5O50hYmO13eRTAGRQwTB2VT9OMXIqIlOtPKgMIMn6Xn+EAWqPjWa8zaWD7LdQ0LfQ==
X-Received: by 2002:aa7:da4a:: with SMTP id w10mr4813168eds.206.1629215646702;
        Tue, 17 Aug 2021 08:54:06 -0700 (PDT)
Received: from localhost.localdomain ([213.91.86.150])
        by smtp.googlemail.com with ESMTPSA id u2sm934555ejc.61.2021.08.17.08.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 08:54:05 -0700 (PDT)
From:   Nikola Pavlica <pavlica.nikola@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nikola Pavlica <pavlica.nikola@gmail.com>
Subject: [PATCH] drm/panel-simple: Add Vivax TPC-9150 panel v2
Date:   Tue, 17 Aug 2021 17:53:43 +0200
Message-Id: <20210817155343.1063402-1-pavlica.nikola@gmail.com>
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

Thanks,
Nikola

Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4e2dad314c79..9f6080e57771 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3989,6 +3989,30 @@ static const struct panel_desc urt_umsh_8596md_parallel = {
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
+		.width = 223,
+		.height = 125,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+};
+
+
 static const struct drm_display_mode vl050_8048nt_c01_mode = {
 	.clock = 33333,
 	.hdisplay = 800,
@@ -4490,6 +4514,9 @@ static const struct of_device_id platform_of_match[] = {
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


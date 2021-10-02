Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3147741FE0B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 22:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhJBUcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 16:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbhJBUcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 16:32:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E50C061714
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 13:30:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v10so48374395edj.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBU/eugVLHJnNv/7vjHoBSC9sRWw65Q/giAQQj/u/t8=;
        b=b/CeJaD8yfh+cEsjmwl996oH73CaUi75zCCE5VRa8F7nxP/NxkraOciEGvbiJoNEzp
         +oW6Xd34ERPYyf1qY+bn+kXN8izgZqdQNv8jEPQoQ87L0vZdofYPrLK/y3bphrL0OiVW
         1SNwWoSHkW0V3gYlLZTI7Ifk+PnSgGegB0JeCcXeN6mamZnypQMns9t4GzwadKTtVOW/
         2AleWrGdSz/Kir3eWbCyo6/sKMdpFGKUPD7AyS+06/5PIqrKHtZxRSr7ItlRWHaCeu/v
         WF3NlwF9wbkfYUXM2uv4igcA1dWJgXv0ItKsBr3r7Kvg4Igr1T4qUCyOoulYlZj/Vj5s
         pDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBU/eugVLHJnNv/7vjHoBSC9sRWw65Q/giAQQj/u/t8=;
        b=Rqc7Uh70/8TkgTOmKLJB236A8BkRP/040CpjypG5I1jSmHjjfZeIJiIyqTZdPkIQtI
         xWzT+Cn3j6vfglk4uY5tcHAld1G7DgMP7cnSf/FW6zknENKFuoG4B7lcx0t8upykv60K
         2JCsJRvhmUrwpyw4ax+OiI4mEYDj3PIGAenaf3gJmWSKDJsx9zRJHUFqeCHLT5TQ9zBb
         F4liozJT9icCFJU+3cza7YvkzukoPd2NxU/oVok5/rAbg3HdNVAYvpCebP8UXthBr9rI
         ZqeTU1M0uCPFMIVJ4GyDCCB3wrR62NA/VdoL3mo8Bua2TRYK8Mkx4Vm+1F4saTji7fvK
         af+g==
X-Gm-Message-State: AOAM533p8ZRs1USHZld7P3WpFxMr04Qhm70L0Gce/Zx3S5v/nK5ET2ND
        mc+WkZM4mwmXTdnRkosUHCg=
X-Google-Smtp-Source: ABdhPJx0S0kiFv98tbJRmbvSsqgbY9akIIk3ZoTQPW1J2YwdvOXC+1NnMakIZPRfscPxkErwSk9PnA==
X-Received: by 2002:a05:6402:713:: with SMTP id w19mr6484692edx.366.1633206631522;
        Sat, 02 Oct 2021 13:30:31 -0700 (PDT)
Received: from localhost.localdomain ([213.91.86.150])
        by smtp.gmail.com with ESMTPSA id dt4sm4615804ejb.27.2021.10.02.13.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 13:30:31 -0700 (PDT)
From:   Nikola Pavlica <pavlica.nikola@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nikola Pavlica <pavlica.nikola@gmail.com>
Subject: [PATCH] drm/panel-simple: Add Vivax TPC-9150 panel v5
Date:   Sat,  2 Oct 2021 22:30:17 +0200
Message-Id: <20211002203017.509940-1-pavlica.nikola@gmail.com>
X-Mailer: git-send-email 2.33.0
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

Version 4, rearranged the display parameters and fix invalid bit format
issue. (Thanks Sam)

Version 5, referred to FEX file instead of manual debugging for
information.

NOTE: Seperate dt-binding patch has been sent to THAT mailing list. So
that's why they're NOT included here. Advise freely if that's not how
you're supposed to do it.

Thanks,
Nikola

Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9b6c4e6c3..680fd3f72 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4363,6 +4363,32 @@ static const struct panel_desc urt_umsh_8596md_parallel = {
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
+	.bpc = 6,
+	.size = {
+		.width = 200,
+		.height = 115,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+
 static const struct drm_display_mode vl050_8048nt_c01_mode = {
 	.clock = 33333,
 	.hdisplay = 800,
@@ -4891,6 +4917,9 @@ static const struct of_device_id platform_of_match[] = {
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
2.33.0


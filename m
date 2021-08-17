Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE983EE885
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhHQIcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbhHQIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:32:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC578C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:32:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b10so28534240eju.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=McC8S/bFHuSwRDT9VMEJP32+dSnc9rWytA/mVOlvx/s=;
        b=AIA3jon3fcIEdq7TSD0sgFmfbyrXMgjw5dWIMmxO8hDjibdmLplXn3aTJuYjYcGkg9
         Lx29sA2LQM4NKRhLaBlBZpyCycxDyg2ZoIjZdVvBWjYEQkH+bYa8ZtnKv1TvJWgE1nFA
         rJf0qohjLDPp3pUkTZn84rzH+filXNXRAPz8RCdTKmiMaDaY4/N3q+xVXsm0t1sf7t5b
         RSkC/zcxzrV5yOoh4D+c9+2K+1dSLRVj4E4ICtYFohxsjiDYcpTZGd/j40ClKqB+AtHo
         n5hbOwAf0Y/OXLFQ6LBKukW0DWrmrOBYqG7J9eZ5+mpN4lr3fvdZIluAYafW+hwUypOf
         UnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=McC8S/bFHuSwRDT9VMEJP32+dSnc9rWytA/mVOlvx/s=;
        b=FPK8DIiTFaZqjd7h+2esTVPB4sFPmkduZAJItZVXg7XGwoNVdxNBZI4kIZPKwgao6a
         iYetU+SA/jnrSuS7f33dxtyomP/A0wZhWk3T1gBntiKsJ3t4xMHbRB29rjQqVtZCsUOI
         lRf8SNswlCCbaW8B/LDdP3DS5GEtdltnxR7fMNT4VIl+pU0SU6eUVYsPe8TDSgMfo2Dk
         stWwwxLqQFuSxeV1BpBrW5KSretY6he3N4FL6Gnx6CutFagMdL/077/Um5WSx/ckgLKw
         5B9mSn6yKxtjRpMILis2tGak4UMddaODvaLs77xrZItrhdaZ1SZhse/vGKqyoKbwYlUL
         Sg0g==
X-Gm-Message-State: AOAM5331RbOPeko59TKxwmNWCTvliX77YCWaBY4lazWnw07lMkCC6SVh
        GT8Qga3ahK2cPQAs/o4LhK8=
X-Google-Smtp-Source: ABdhPJx9ULim+GbyMepEG7BJqpc7mloIkbJBf2opDUr1KyybekscBrNW+WTqvS4do7tk1DbPcyO0oA==
X-Received: by 2002:a17:906:dc4:: with SMTP id p4mr171310eji.66.1629189140375;
        Tue, 17 Aug 2021 01:32:20 -0700 (PDT)
Received: from localhost.localdomain (neth7.eastcode.net. [79.143.160.90])
        by smtp.googlemail.com with ESMTPSA id e22sm675850eds.45.2021.08.17.01.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:32:19 -0700 (PDT)
From:   Nikola Pavlica <pavlica.nikola@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nikola Pavlica <pavlica.nikola@gmail.com>
Subject: [PATCH] drm/panel-simple: Add Vivax TPC-9150 panel
Date:   Tue, 17 Aug 2021 10:32:01 +0200
Message-Id: <20210817083201.675133-1-pavlica.nikola@gmail.com>
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

Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4e2dad314c79..97fc3c5740bb 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4090,6 +4090,29 @@ static const struct panel_desc arm_rtsm = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
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
 static const struct of_device_id platform_of_match[] = {
 	{
 		.compatible = "ampire,am-1280800n3tzqw-t00h",
@@ -4103,6 +4126,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "arm,rtsm-display",
 		.data = &arm_rtsm,
+	}, {
+		.compatible = "vivax,tpc9150-panel",
+		.data = &vivax_tpc9150_panel,
 	}, {
 		.compatible = "armadeus,st0700-adapt",
 		.data = &armadeus_st0700_adapt,
-- 
2.32.0


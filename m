Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E376536ABCB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 07:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhDZFTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 01:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDZFTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:19:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875FEC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 22:18:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c17so3533957pfn.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 22:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rywd4hnCU7/9HbcJL7DvcHVAqfAUpeGMenv4sbpVbPg=;
        b=CMuN3mkwvDeBeo432fJqHbMLRzEVmCttlBmiosgZBn6YtxAtX3SdqsA/L1SMRjW9ur
         9XWuMBU85KPQFbaIp9agcRrNzYz+6GDBENoGt+eLtSlOGlCVX7M/PgZ9Ubulq3afmzix
         hqgf+PNXSL2SsYA+i4P1wf/yD2MUmmz5/AgHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rywd4hnCU7/9HbcJL7DvcHVAqfAUpeGMenv4sbpVbPg=;
        b=Jmeq5XzJ20tASOyhPi3EOVGTkd/OKQCbBVwxPKY0NluezYoB58fjgJp27R8tQge9nr
         2dY75pf6ipdAfrBkMNVCSEpxUVtnm0ssDVKaCdHbmKbcmSN0EJEC23CAQnU0UGFyOkb+
         jgLvaH4D4doK5oq73c5rXTVpOtdizhGVGVxMAtSSx5zqPj/Jv109+8uuPKkfYaPWJQws
         ug1Zj+ouPeTAy0G7Fg124DaZQ3m9HZUhAVUvtnuUCHSbLAsg96AucBA7BOeD9clwpadx
         BajqjcoDrgV8e3J3Q+rSPOQSUyB47A0owzkwmsDPxaFbJ1mD6qPMMSd9a13uICdEnB32
         C8nQ==
X-Gm-Message-State: AOAM531ug4OClPlRygyGn3fLwPaIOy6zpXRMDUzVABKLPmuV4GYVHD00
        WHoYMKo0CzSKKcIvFW3dezu/Ng==
X-Google-Smtp-Source: ABdhPJxFS+sK39f/LfL1MlXA47wSW7gVZjlZJquRa9ML43FqezaUaeqZhJtTKM3L+YRD6QTNPxsgbg==
X-Received: by 2002:aa7:860f:0:b029:265:4428:3104 with SMTP id p15-20020aa7860f0000b029026544283104mr15822916pfn.75.1619414333766;
        Sun, 25 Apr 2021 22:18:53 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:49dc:8519:4648:67e])
        by smtp.gmail.com with ESMTPSA id h9sm9928420pgl.67.2021.04.25.22.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 22:18:53 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] gpu: drm: init set panel orientation property earlier
Date:   Mon, 26 Apr 2021 13:18:47 +0800
Message-Id: <20210426051848.2600890-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_dev_register() sets connector->registration_state to
DRM_CONNECTOR_REGISTERED and dev->registered to true. If
drm_connector_set_panel_orientation() is first called after
drm_dev_register(), it will fail several checks and results in following
warning.

Create panel orientation property in drm_connector_init()
and set default value to UNKNOWN. Let the panel set the real value
later.

[    4.480976] ------------[ cut here ]------------
[    4.485603] WARNING: CPU: 5 PID: 369 at drivers/gpu/drm/drm_mode_object.c:45 __drm_mode_object_add+0xb4/0xbc
<snip>
[    4.609772] Call trace:
[    4.612208]  __drm_mode_object_add+0xb4/0xbc
[    4.616466]  drm_mode_object_add+0x20/0x2c
[    4.620552]  drm_property_create+0xdc/0x174
[    4.624723]  drm_property_create_enum+0x34/0x98
[    4.629241]  drm_connector_set_panel_orientation+0x64/0xa0
[    4.634716]  boe_panel_get_modes+0x88/0xd8
[    4.638802]  drm_panel_get_modes+0x2c/0x48
[    4.642887]  panel_bridge_get_modes+0x1c/0x28
[    4.647233]  drm_bridge_connector_get_modes+0xa0/0xd4
[    4.652273]  drm_helper_probe_single_connector_modes+0x218/0x700
[    4.658266]  drm_mode_getconnector+0x1b4/0x45c
[    4.662699]  drm_ioctl_kernel+0xac/0x128
[    4.666611]  drm_ioctl+0x268/0x410
[    4.670002]  drm_compat_ioctl+0xdc/0xf0
[    4.673829]  __arm64_compat_sys_ioctl+0xc8/0x100
[    4.678436]  el0_svc_common+0xf4/0x1c0
[    4.682174]  do_el0_svc_compat+0x28/0x3c
[    4.686088]  el0_svc_compat+0x10/0x1c
[    4.689738]  el0_sync_compat_handler+0xa8/0xcc
[    4.694171]  el0_sync_compat+0x178/0x180
[    4.698082] ---[ end trace b4f2db9d9c88610b ]---
[    4.702721] ------------[ cut here ]------------
[    4.707329] WARNING: CPU: 5 PID: 369 at drivers/gpu/drm/drm_mode_object.c:243 drm_object_attach_property+0x48/0xb8
<snip>
[    4.833830] Call trace:
[    4.836266]  drm_object_attach_property+0x48/0xb8
[    4.840958]  drm_connector_set_panel_orientation+0x84/0xa0
[    4.846432]  boe_panel_get_modes+0x88/0xd8
[    4.850516]  drm_panel_get_modes+0x2c/0x48
[    4.854600]  panel_bridge_get_modes+0x1c/0x28
[    4.858946]  drm_bridge_connector_get_modes+0xa0/0xd4
[    4.863984]  drm_helper_probe_single_connector_modes+0x218/0x700
[    4.869978]  drm_mode_getconnector+0x1b4/0x45c
[    4.874410]  drm_ioctl_kernel+0xac/0x128
[    4.878320]  drm_ioctl+0x268/0x410
[    4.881711]  drm_compat_ioctl+0xdc/0xf0
[    4.885536]  __arm64_compat_sys_ioctl+0xc8/0x100
[    4.890142]  el0_svc_common+0xf4/0x1c0
[    4.893879]  do_el0_svc_compat+0x28/0x3c
[    4.897791]  el0_svc_compat+0x10/0x1c
[    4.901441]  el0_sync_compat_handler+0xa8/0xcc
[    4.905873]  el0_sync_compat+0x178/0x180
[    4.909783] ---[ end trace b4f2db9d9c88610c ]---

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v1:
https://patchwork.kernel.org/project/linux-mediatek/patch/20210409045314.3420733-1-hsinyi@chromium.org/
---
 drivers/gpu/drm/drm_connector.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 7631f76e7f34..a1acb4af0ef4 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -303,6 +303,10 @@ int drm_connector_init(struct drm_device *dev,
 				   config->tile_property,
 				   0);
 
+	drm_object_attach_property(&connector->base,
+				   config->panel_orientation_property,
+				   DRM_MODE_PANEL_ORIENTATION_UNKNOWN);
+
 	if (drm_core_check_feature(dev, DRIVER_ATOMIC)) {
 		drm_object_attach_property(&connector->base, config->prop_crtc_id, 0);
 	}
@@ -1210,7 +1214,7 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
  *	INPUT_PROP_DIRECT) will still map 1:1 to the actual LCD panel
  *	coordinates, so if userspace rotates the picture to adjust for
  *	the orientation it must also apply the same transformation to the
- *	touchscreen input coordinates. This property is initialized by calling
+ *	touchscreen input coordinates. This property value is set by calling
  *	drm_connector_set_panel_orientation() or
  *	drm_connector_set_panel_orientation_with_quirk()
  *
@@ -1298,6 +1302,14 @@ int drm_connector_create_standard_properties(struct drm_device *dev)
 		return -ENOMEM;
 	dev->mode_config.hdr_output_metadata_property = prop;
 
+	prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
+					"panel orientation",
+					drm_panel_orientation_enum_list,
+					ARRAY_SIZE(drm_panel_orientation_enum_list));
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.panel_orientation_property = prop;
+
 	return 0;
 }
 
@@ -2205,19 +2217,9 @@ int drm_connector_set_panel_orientation(
 	info->panel_orientation = panel_orientation;
 
 	prop = dev->mode_config.panel_orientation_property;
-	if (!prop) {
-		prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
-				"panel orientation",
-				drm_panel_orientation_enum_list,
-				ARRAY_SIZE(drm_panel_orientation_enum_list));
-		if (!prop)
-			return -ENOMEM;
-
-		dev->mode_config.panel_orientation_property = prop;
-	}
 
-	drm_object_attach_property(&connector->base, prop,
-				   info->panel_orientation);
+	drm_object_property_set_value(&connector->base, prop,
+				      info->panel_orientation);
 	return 0;
 }
 EXPORT_SYMBOL(drm_connector_set_panel_orientation);
-- 
2.31.1.498.g6c1eba8ee3d-goog


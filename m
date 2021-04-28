Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1DA36DDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbhD1RF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbhD1RFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:05:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C402C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:04:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lr7so14996383pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IL6VtwyrB5+6ourxVlpFTYNY9lv5VYl4yNeQCMyMGW4=;
        b=jBIBU3rmtD8yOrvV4BbfL6jvMl3ciy0ye03wj6yDfhp2J/1kUnpGeFR/OS8HIQf6PN
         Xh/U+XybtGkfUTkRvE0s0FDOeAbg8FFa8ipJ1Rn6jBnP5+5xfZGIm6M1terr4mPVdDik
         GXhE2PugYOf1BqEw59QPcjed52ZYlVnVxSDqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IL6VtwyrB5+6ourxVlpFTYNY9lv5VYl4yNeQCMyMGW4=;
        b=Q9rq0GGMs2kGXfC3jD6oFvU0NhtAPs1U3Q78tUM/APr7LBv18Asbqcc6geqpuTZnSJ
         tUHIGOxpDwv7FlRCo4WjU9+Oyb5WfP4m2NCXAF3IDlTI4wYTIjRDJC9rmhYS5+E2HnLq
         Uihes86AatCb1UaWeI044c86NYd2484F57XGlMYkLPRMllHqb10VUU4y21PEPCzU51OX
         2P0g9IwXxIbzDA0dczL6dTq3sCfSWXrRR8ioHqYaTxR9cZ41bSc9zH9075maEjwzMSdE
         w9+WPlHQZeYPcyIjcS9bmWE3flBVl+3qxm1zNkrmU8uyUUJchrygqFnW5vS/zlIziFob
         FTFw==
X-Gm-Message-State: AOAM530MOxfMAxcl20A4RSyOeNv3Drq3Ib83fr8MUOWpWHLYqn9P/WoM
        w1rD+rT84cIRQkic9DtilXUWcQ==
X-Google-Smtp-Source: ABdhPJx8QtZB1FX3UuGgKCpu+6pIJEYE2bHczJrQxYOtaGxXbs4f9PBgFNWspYeBzunpHZpovHfMGg==
X-Received: by 2002:a17:902:7c94:b029:e6:e1d7:62b7 with SMTP id y20-20020a1709027c94b02900e6e1d762b7mr30895825pll.29.1619629461545;
        Wed, 28 Apr 2021 10:04:21 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1faf:c32e:8742:d913])
        by smtp.gmail.com with ESMTPSA id c8sm244351pfp.160.2021.04.28.10.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:04:20 -0700 (PDT)
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
Subject: [PATCH v5 1/4] gpu: drm: separate panel orientation property creating and value setting
Date:   Thu, 29 Apr 2021 01:04:13 +0800
Message-Id: <20210428170416.1027484-1-hsinyi@chromium.org>
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

Add a function to create panel orientation property and set default value
to UNKNOWN, so drivers can call this function to init the property earlier
, and let the panel set the real value later.

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
v5:
don't create property in set_panel_orientation.

v4, v3:
create property in dsi driver and set value in panel.

v2:
create property in connector init
https://patchwork.kernel.org/project/linux-mediatek/patch/20210426051848.2600890-1-hsinyi@chromium.org/

v1:
set panel orientation in dsi driver
https://patchwork.kernel.org/project/linux-mediatek/patch/20210409045314.3420733-1-hsinyi@chromium.org/
---
 drivers/gpu/drm/drm_connector.c | 58 ++++++++++++++++++++++++---------
 include/drm/drm_connector.h     |  2 ++
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 7631f76e7f34..7189baaabf41 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1210,7 +1210,7 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
  *	INPUT_PROP_DIRECT) will still map 1:1 to the actual LCD panel
  *	coordinates, so if userspace rotates the picture to adjust for
  *	the orientation it must also apply the same transformation to the
- *	touchscreen input coordinates. This property is initialized by calling
+ *	touchscreen input coordinates. This property value is set by calling
  *	drm_connector_set_panel_orientation() or
  *	drm_connector_set_panel_orientation_with_quirk()
  *
@@ -2173,8 +2173,8 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
  * @connector: connector for which to set the panel-orientation property.
  * @panel_orientation: drm_panel_orientation value to set
  *
- * This function sets the connector's panel_orientation and attaches
- * a "panel orientation" property to the connector.
+ * This function sets the connector's panel_orientation value. If the property
+ * doesn't exist, it will return an error.
  *
  * Calling this function on a connector where the panel_orientation has
  * already been set is a no-op (e.g. the orientation has been overridden with
@@ -2205,19 +2205,11 @@ int drm_connector_set_panel_orientation(
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
+	if (WARN_ON(!prop))
+		return -EINVAL;
 
-	drm_object_attach_property(&connector->base, prop,
-				   info->panel_orientation);
+	drm_object_property_set_value(&connector->base, prop,
+				      info->panel_orientation);
 	return 0;
 }
 EXPORT_SYMBOL(drm_connector_set_panel_orientation);
@@ -2225,7 +2217,7 @@ EXPORT_SYMBOL(drm_connector_set_panel_orientation);
 /**
  * drm_connector_set_panel_orientation_with_quirk -
  *	set the connector's panel_orientation after checking for quirks
- * @connector: connector for which to init the panel-orientation property.
+ * @connector: connector for which to set the panel-orientation property.
  * @panel_orientation: drm_panel_orientation value to set
  * @width: width in pixels of the panel, used for panel quirk detection
  * @height: height in pixels of the panel, used for panel quirk detection
@@ -2252,6 +2244,40 @@ int drm_connector_set_panel_orientation_with_quirk(
 }
 EXPORT_SYMBOL(drm_connector_set_panel_orientation_with_quirk);
 
+/**
+ * drm_connector_init_panel_orientation_property -
+ * 	create the connector's panel orientation property
+ *
+ * This function attaches a "panel orientation" property to the connector
+ * and initializes its value to DRM_MODE_PANEL_ORIENTATION_UNKNOWN.
+ *
+ * The value of the property can be set by drm_connector_set_panel_orientation()
+ * or drm_connector_set_panel_orientation_with_quirk() later.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_init_panel_orientation_property(
+	struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+
+	prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
+			"panel orientation",
+			drm_panel_orientation_enum_list,
+			ARRAY_SIZE(drm_panel_orientation_enum_list));
+	if (!prop)
+		return -ENOMEM;
+
+	dev->mode_config.panel_orientation_property = prop;
+	drm_object_attach_property(&connector->base, prop,
+				   DRM_MODE_PANEL_ORIENTATION_UNKNOWN);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_init_panel_orientation_property);
+
 int drm_connector_set_obj_prop(struct drm_mode_object *obj,
 				    struct drm_property *property,
 				    uint64_t value)
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 1922b278ffad..4396c1c4a5db 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1696,6 +1696,8 @@ int drm_connector_set_panel_orientation_with_quirk(
 	struct drm_connector *connector,
 	enum drm_panel_orientation panel_orientation,
 	int width, int height);
+int drm_connector_init_panel_orientation_property(
+	struct drm_connector *connector);
 int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 					  int min, int max);
 
-- 
2.31.1.498.g6c1eba8ee3d-goog


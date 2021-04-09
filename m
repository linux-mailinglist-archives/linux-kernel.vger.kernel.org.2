Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B8835942E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhDIExc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhDIExb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:53:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50907C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 21:53:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ha17so2286205pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 21:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8tMg25UODn9zLUOH4J81Emc3aCsG/EQSjte3RxVFwU=;
        b=VOyYiA7av5Bi6O4IQeERXt8QsT+l7zDqkusCiXRR6I6d6aEWWRveSCJzo+jMpzWMYX
         995UQaizcAn0Gn1/TUm1Zbpoun/QWNaS3N/MUEX8ihV9QpVgJ4tWnFL/PkYWQMetjf9y
         H8qMY2CgRr0JwIhO6HKkNQFHQWMMulSZkXb4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8tMg25UODn9zLUOH4J81Emc3aCsG/EQSjte3RxVFwU=;
        b=i85gpEH8UZWlvFhi7+A9lfR5S9NnOYcgWkxi2TJyAGSMRnZ3BNszIlpXEuSodOtSYf
         ejxs5yv2kdn/6dDr67ufU9NGMKj/VO+aLyeMciO1qHiKxj3uEPqa/o4Px/Npmx4oikvI
         f4D0HWqY/Fn/liGQxOUfb9iZyQQIxP4QBMAKyN0eeqxtKJofb8TCC2EHCEXMJ7E5gw7k
         9/B4kL1F86UrAH50AeicTqaUXzm3yfhARYnuRbYRp9+wqQlafTtGd7Pg2AYnvfaHxpLp
         vQj5piRq+SJTPMRvK4Z/BhXD2eYXXxQdAceYqAD6WYALyfYI39YGiA6GhAk/lyxk3WxJ
         fE8w==
X-Gm-Message-State: AOAM5303od5hBbAZP1z65Y1m20fks8cbK7NdXrk4tvKSTrz+IV84O+c8
        +lC1YKj1h6UgMx1RCi2OZY0RcQ==
X-Google-Smtp-Source: ABdhPJyiCXafNiJ32rllXnQwLlA8TSdl0M9YXElPFDmX+now4Elzlf3lVZHWQ6cxIai9C+eZPZH4fA==
X-Received: by 2002:a17:902:6f10:b029:e9:7fdf:4902 with SMTP id w16-20020a1709026f10b02900e97fdf4902mr8114984plk.41.1617943998661;
        Thu, 08 Apr 2021 21:53:18 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:f9f6:696:a955:72e9])
        by smtp.gmail.com with ESMTPSA id p2sm900696pgm.24.2021.04.08.21.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:53:18 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/2] drm/mediatek: set panel orientation before drm_dev_register().
Date:   Fri,  9 Apr 2021 12:53:13 +0800
Message-Id: <20210409045314.3420733-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_dev_register() sets connector->registration_state to
DRM_CONNECTOR_REGISTERED and dev->registered to true. If
drm_connector_set_panel_orientation() is first called after
drm_dev_register(), it will fail several checks and results in following
warning. So set panel orientation in dsi before drm_dev_register() is
called.

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
 drivers/gpu/drm/mediatek/mtk_dsi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index ae403c67cbd9..45a702ee09f3 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -205,6 +205,7 @@ struct mtk_dsi {
 	u32 irq_data;
 	wait_queue_head_t irq_wait_queue;
 	const struct mtk_dsi_driver_data *driver_data;
+	enum drm_panel_orientation orientation;
 };
 
 static inline struct mtk_dsi *bridge_to_dsi(struct drm_bridge *b)
@@ -966,6 +967,8 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 	}
 	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
 
+	drm_connector_set_panel_orientation(dsi->connector, dsi->orientation);
+
 	return 0;
 
 err_cleanup_encoder:
@@ -1029,6 +1032,12 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 			ret = PTR_ERR(dsi->next_bridge);
 			goto err_unregister_host;
 		}
+
+		ret = of_drm_get_panel_orientation(panel->dev->of_node, &dsi->orientation);
+		if (ret) {
+			dev_err(dev, "failed to get panel orientation %d\n", ret);
+			return ret;
+		}
 	}
 
 	dsi->driver_data = of_device_get_match_data(dev);
-- 
2.31.1.295.g9ea45b61b8-goog


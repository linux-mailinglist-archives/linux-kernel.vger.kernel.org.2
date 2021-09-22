Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA13415149
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbhIVUUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbhIVUUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:20:00 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5685CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:18:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t8so10630347wri.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCvTvkJUQlqkrEgBfGXbFyfCutXgnQcemIuNKLehIWY=;
        b=nkyrvfcPPhzu6NsTLf6nC9ipcld/bGYA1rhaaKHiAyGOenjoYmGFDHOuo06uhvXXg+
         hNm3/sc5CqXW/twKbz8vc8z2+TUagU/m/lervdQJy3iacEH8Ddq8dCarwq+V3mnpZu0a
         QU86UoRcEeqZuZbyU2bh3lmF3YQFGzpZKY5uSHIC+S6uzQeJtUq/tjh7q18ahUkRucOz
         nPieQdBC8QWykUaAOKTzUMqM7J083M4O/2kQDBKGnsIlxotVzFrB5Z4ND3PAUsM9NJQY
         dPxmvaZk+rpAu5LrAdUgqQnZ5bv0YlKCSi9GlRLw+TWQJFXM4Ts9osta/7S5idxr1pBL
         39JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCvTvkJUQlqkrEgBfGXbFyfCutXgnQcemIuNKLehIWY=;
        b=411gPc9kN2lX0B8qfKIejBc1jx8kCkS/TGyYUqpwRosOCF8OxrlN7802WTgfWWgFPH
         jHKn5u5XMnJKvFb+RaI7AhMukLVtW9/VmIVVCtOBQ9F9p2ff0Ie3eiH9FZStdNDhb1lB
         7pWxapR/OIiViFdPGM+yS0eOWwCAUOfMZ9Vs/FSIifzGA119KF5HSyh0HbdjBTHZG1wl
         vHZoaVGhlXySl6smPNG/YvxLfa2WhtKHZT0P6/RV0MaIHx/GnjUph9Cgvn5poqWFf9U0
         ks1YhFbXvel9ki7EbJFWMBoprbna+BPSn5K/HPn5e4TOXsmI3Wls9jB0jC1Cyqgl+xwS
         Ydyw==
X-Gm-Message-State: AOAM531edeol0wI5IPQCqFxxIyn+x9UZOlzYt6cMuIyJURJyKzSLGk0m
        rrJGSGh0e2ViKBNzbBq6Ug==
X-Google-Smtp-Source: ABdhPJypIchsBJzI6Lxf0kWAKhQx89UYepmgXRdZtW4mKvLSeVWLGLRt3qS3redFXcNxxjVK0n+NTA==
X-Received: by 2002:adf:e684:: with SMTP id r4mr931057wrm.229.1632341908964;
        Wed, 22 Sep 2021 13:18:28 -0700 (PDT)
Received: from alex-ThinkPad-E480.. (ip5b434083.dynamic.kabel-deutschland.de. [91.67.64.131])
        by smtp.googlemail.com with ESMTPSA id v8sm3147188wrt.12.2021.09.22.13.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:18:28 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH] drm/rockchip: rgb: make connector a pointer in struct rockchip_rgb
Date:   Wed, 22 Sep 2021 22:17:58 +0200
Message-Id: <20210922201758.7204-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported at [1] Coverity complains about an used value.

Let's make drm_connector a pointer in struct rockchip_rgb and "remove
redundant assignment of pointer connector".

[1] https://lkml.org/lkml/2021/9/22/432

Fixes: 2e87bf389e13 ("drm/rockchip: add DRM_BRIDGE_ATTACH_NO_CONNECTOR flag to drm_bridge_attach")
Addresses-Coverity: ("Unused value")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_rgb.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index 09be9678f2bd..fe932c26c3e0 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -28,7 +28,7 @@ struct rockchip_rgb {
 	struct drm_device *drm_dev;
 	struct drm_bridge *bridge;
 	struct drm_encoder encoder;
-	struct drm_connector connector;
+	struct drm_connector *connector;
 	int output_mode;
 };
 
@@ -82,7 +82,6 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 	int ret = 0, child_count = 0;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
-	struct drm_connector *connector;
 
 	rgb = devm_kzalloc(dev, sizeof(*rgb), GFP_KERNEL);
 	if (!rgb)
@@ -150,17 +149,16 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 	if (ret)
 		goto err_free_encoder;
 
-	connector = &rgb->connector;
-	connector = drm_bridge_connector_init(rgb->drm_dev, encoder);
-	if (IS_ERR(connector)) {
+	rgb->connector = drm_bridge_connector_init(rgb->drm_dev, encoder);
+	if (IS_ERR(rgb->connector)) {
 		DRM_DEV_ERROR(drm_dev->dev,
 			      "failed to initialize bridge connector: %pe\n",
-			      connector);
-		ret = PTR_ERR(connector);
+			      rgb->connector);
+		ret = PTR_ERR(rgb->connector);
 		goto err_free_encoder;
 	}
 
-	ret = drm_connector_attach_encoder(connector, encoder);
+	ret = drm_connector_attach_encoder(rgb->connector, encoder);
 	if (ret < 0) {
 		DRM_DEV_ERROR(drm_dev->dev,
 			      "failed to attach encoder: %d\n", ret);
@@ -170,7 +168,7 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 	return rgb;
 
 err_free_connector:
-	drm_connector_cleanup(connector);
+	drm_connector_cleanup(rgb->connector);
 err_free_encoder:
 	drm_encoder_cleanup(encoder);
 	return ERR_PTR(ret);
@@ -180,7 +178,7 @@ EXPORT_SYMBOL_GPL(rockchip_rgb_init);
 void rockchip_rgb_fini(struct rockchip_rgb *rgb)
 {
 	drm_panel_bridge_remove(rgb->bridge);
-	drm_connector_cleanup(&rgb->connector);
+	drm_connector_cleanup(rgb->connector);
 	drm_encoder_cleanup(&rgb->encoder);
 }
 EXPORT_SYMBOL_GPL(rockchip_rgb_fini);
-- 
2.30.2


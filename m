Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F483437B29
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhJVQ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 12:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhJVQ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 12:56:39 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4D7C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 09:54:21 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id o13so2803482qvm.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 09:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b2w3PlPqpKQiMzqSOq5AVpJBVHNhIVKPGfoHVzEVCds=;
        b=LMCZZ0U72keGDqd5g6LTFWWQiy/YVwZc2dAtLXVKcrdmCzA12oJxAZH5SvZ3f1H8bL
         tu1tWEQevUx5Pw2nn+MvTcDRic/fdC2Ek13oTIxJ8sObiivCqSYWNecE0DEsV7rDem22
         njqjHUvJLa4TbcemjASBSKJhnCYr9lJKJywmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b2w3PlPqpKQiMzqSOq5AVpJBVHNhIVKPGfoHVzEVCds=;
        b=wOnMikXKJ37ku8O2iziGKYDstCpjciyxgkyTD2FqFJPPmxNDjZfoz5nivaDEGMDNWB
         N4qgwAm3VcbEqEF9UooTPbQ73x5a2lIP0iRdZkG3Q/e5aR0fJgtnEJ8QQmjrnMe14SP+
         RHEfxl0LvJKEk18wgl/dZUaxTdRunaufugKC+/J5GUucNSbPLmmeMCf0Z/6zgEa8ZA5/
         0bDVoF29ZaFfWYF885PElyetkmQoV5q3e7UGu1n2dq+ipO+j7zfPwF0tc1qtSSO036qs
         TTGWILZ/fJwv6PsIRAmdXgC4EWVoZr+3FCvqHtUtQU1DFQwJCwPQLnH/iduZvscc6812
         lZRA==
X-Gm-Message-State: AOAM530fPdJ9ShZvxwyF4JgoRE3YOC/V80uOja5kwtNpEYO+a0lII2v1
        p/2qJac3RhF50mZSyc5Uxy8nuA==
X-Google-Smtp-Source: ABdhPJxDLKxCGk4B/SAq3N2iCVgytTX5QVoCrgIAKMUMHGtLMrozyd23amkOxXpGmY0w2Lb7ge9JfA==
X-Received: by 2002:a0c:aac2:: with SMTP id g2mr696582qvb.41.1634921659807;
        Fri, 22 Oct 2021 09:54:19 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com ([2620:0:1003:314:6c36:8d9f:c50a:b0f0])
        by smtp.gmail.com with ESMTPSA id p19sm4432133qtk.20.2021.10.22.09.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 09:54:19 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     seanpaul@chromium.org, Mark Yacoub <markyacoub@google.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: Set Rotation default value to 1.
Date:   Fri, 22 Oct 2021 12:54:02 -0400
Message-Id: <20211022165409.178281-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yacoub <markyacoub@google.com>

[Why]
The Rotation prob is a bitmask value. It must always have a valid value.
A default NO rotation is equal to 1 not 0.

[How]
1. At the reset hook, call __drm_atomic_helper_plane_reset which is
called at the initialization of the plane and sets the default value of
all planes to DRM_MODE_ROTATE_0 which is equal to 1.
2. At the ovl layer check, do no overwrite the state->rotation value 0
if DRM_MODE_ROTATE_0 is set. We should not change the value that the
userspace has set, especially if it's an unsupported value.

Tested on Jacuzzi(MTK).
Fixes IGT@kms_properties@plane-properties-{legacy,atomic} and
IGT@kms_properties@get_properties-sanity-{atomic,non-atomic}

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  2 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     | 20 +++++++-------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  5 ++---
 drivers/gpu/drm/mediatek/mtk_drm_plane.c    |  3 ++-
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 86c3068894b11..2fc566964f68e 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -64,7 +64,7 @@ void mtk_ovl_config(struct device *dev, unsigned int w,
 		    unsigned int h, unsigned int vrefresh,
 		    unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
 int mtk_ovl_layer_check(struct device *dev, unsigned int idx,
-			struct mtk_plane_state *mtk_state);
+			const struct mtk_plane_state *mtk_state);
 void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 			  struct mtk_plane_state *state,
 			  struct cmdq_pkt *cmdq_pkt);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index ea5760f856ec6..13999564304bc 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -190,19 +190,15 @@ unsigned int mtk_ovl_supported_rotations(struct device *dev)
 }
 
 int mtk_ovl_layer_check(struct device *dev, unsigned int idx,
-			struct mtk_plane_state *mtk_state)
+			const struct mtk_plane_state *mtk_state)
 {
-	struct drm_plane_state *state = &mtk_state->base;
-	unsigned int rotation = 0;
+	const struct drm_plane_state *state = &mtk_state->base;
+	unsigned int rotation = drm_rotation_simplify(
+		state->rotation,
+		DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y);
 
-	rotation = drm_rotation_simplify(state->rotation,
-					 DRM_MODE_ROTATE_0 |
-					 DRM_MODE_REFLECT_X |
-					 DRM_MODE_REFLECT_Y);
-	rotation &= ~DRM_MODE_ROTATE_0;
-
-	/* We can only do reflection, not rotation */
-	if ((rotation & DRM_MODE_ROTATE_MASK) != 0)
+	/* We can only do reflection, not non-zero rotation */
+	if (((rotation & ~DRM_MODE_ROTATE_0) & DRM_MODE_ROTATE_MASK) != 0)
 		return -EINVAL;
 
 	/*
@@ -212,8 +208,6 @@ int mtk_ovl_layer_check(struct device *dev, unsigned int idx,
 	if (state->fb->format->is_yuv && rotation != 0)
 		return -EINVAL;
 
-	state->rotation = rotation;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 1b582262b682b..530bdd031933f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -53,9 +53,8 @@ struct mtk_ddp_comp_funcs {
 	void (*disable_vblank)(struct device *dev);
 	unsigned int (*supported_rotations)(struct device *dev);
 	unsigned int (*layer_nr)(struct device *dev);
-	int (*layer_check)(struct device *dev,
-			   unsigned int idx,
-			   struct mtk_plane_state *state);
+	int (*layer_check)(struct device *dev, unsigned int idx,
+			   const struct mtk_plane_state *state);
 	void (*layer_config)(struct device *dev, unsigned int idx,
 			     struct mtk_plane_state *state,
 			     struct cmdq_pkt *cmdq_pkt);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index e6dcb34d30522..accd26481b9fb 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -44,9 +44,10 @@ static void mtk_plane_reset(struct drm_plane *plane)
 		state = kzalloc(sizeof(*state), GFP_KERNEL);
 		if (!state)
 			return;
-		plane->state = &state->base;
 	}
 
+	__drm_atomic_helper_plane_reset(plane, &state->base);
+
 	state->base.plane = plane;
 	state->pending.format = DRM_FORMAT_RGB565;
 }
-- 
2.33.0.1079.g6e70778dc9-goog


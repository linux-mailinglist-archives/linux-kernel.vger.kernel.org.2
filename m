Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF843CECB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbhJ0QhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhJ0QhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:37:03 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D33C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:34:37 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id i9so2495957qki.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzEz2Tw9Lfz5TOURnPsgcxiiiKcelHawM6M06oI35wU=;
        b=gcRorwC7RJAqNvB7/sLymu7rx6X+O1XtByB+a+Kn+pZd3/Iiplo/FoBRQFBCNSKabP
         bGhaHY2iEz1rZS6GpD5S/JGKwxkOVgVUQjKgrDJjALr4EG9Np8HAWWYh8aDK2Ci5NMlQ
         FacI5apkn6GWgiQ14F/p1pyfSM+jwmHgrR+dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzEz2Tw9Lfz5TOURnPsgcxiiiKcelHawM6M06oI35wU=;
        b=KXa3AH74WJk9/hdhlHtD+zbNClvq2nimhruEs0FZMVTco3M5jXTY1hFI8uHIMhHbWd
         7l7dhHWyuywas1cNhFbzFQnI2T/GKsIGIhTUbJO6w2U0dZBy1J+N40OZGsWQAGlO1beQ
         aQq9sMlb+rdhHbQxZf5MmfeTBV1jyquHOIzGPRcq2ySw5i4adGWBfLl7FiSo9cso19EH
         WhpBjNhuoYryOeT1Eij8+wVxt1/zr4jfELRutU/iqKGcMIGCmzTPoNlLUFt5dBLzayZf
         XykbRzuhMaDMXClhlW2QsrxCTbwjxec99chWyuXB1E3r7j+UBciPt0UjOXL4xUTw6HH8
         BYkQ==
X-Gm-Message-State: AOAM531hOvCdTRqBwKesUwYs3EYS5JB/BXF6vAEEcEa4Px5ioRMYpHuu
        zUR+sTo12f4RAG3xmzQv7J0H9TFEmWYrdqS4
X-Google-Smtp-Source: ABdhPJxG7Rr5qnj7oR0gtCLURtoKJQbXg1qgWb+ARuyyWRimCB6s7AMBNpQzrOt44941nGvLb9EdlQ==
X-Received: by 2002:a05:620a:108d:: with SMTP id g13mr2612236qkk.387.1635352476820;
        Wed, 27 Oct 2021 09:34:36 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com ([2620:0:1003:314:121e:94ae:f1a6:940c])
        by smtp.gmail.com with ESMTPSA id a20sm249675qtb.15.2021.10.27.09.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 09:34:36 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
Cc:     seanpaul@chromium.org, Mark Yacoub <markyacoub@google.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: Do not overwrite user state rotation value.
Date:   Wed, 27 Oct 2021 12:34:31 -0400
Message-Id: <20211027163433.2017401-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yacoub <markyacoub@google.com>

[Why]
The rotation property must have a valid bitmask value. 0 isn't a valid
value.
The state should not be overwritten when performing an overlay value
check.

[How]
Do not overwrite state during the check.

Resolves: IGT@kms_properties@get_properties-sanity-{atomic,non-atomic}

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  2 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     | 20 +++++++-------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  5 ++---
 3 files changed, 10 insertions(+), 17 deletions(-)

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
-- 
2.33.0.1079.g6e70778dc9-goog


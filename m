Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342F2339D6A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 10:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhCMJoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 04:44:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhCMJnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 04:43:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B397164F14;
        Sat, 13 Mar 2021 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615628635;
        bh=ymSvKKXkySAaTw1aQJH2nwYOEfn49ej0hD436KOzGgI=;
        h=From:To:Cc:Subject:Date:From;
        b=SpKwZx/ivwzE7HQSnOwj8SeoRatPxhdPr1nx2eUwahvYS4f2DYeKZnO+Ab4W6TLhO
         vSl7Vufuuj8vFSdi9MVYZosTRUvH7xDO5fsQn3l4wHt55E4QVQ9OUD/JWQ7GyzDkN7
         /EH/uYfVJhfpIdmHn+SWWYdKgdBm1kvgZtDk7vI8awzLBFITpts/K1G7ME+psbXPCU
         BsXxDc1ViTiBas6bdMJ/ZwlF+51ZyxPZ9BhrG06s3jZ50JWbXKuJ0ya/nqsxMGVTWI
         6pHnQLpjC7GdQObrJamifYaKhNsmEM1Zw7Z82dVmh+6qiErGIYRuEa2Kk8t0vukNWn
         YLmbec9AeLltA==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH] drm/mediatek: crtc: Make config-updating atomic
Date:   Sat, 13 Mar 2021 17:43:31 +0800
Message-Id: <20210313094331.26374-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While updating config, the irq would occur and get the partial
config, so use variable config_updating to make updating atomic.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 8b0de90156c6..870f66210848 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -61,6 +61,7 @@ struct mtk_drm_crtc {
 
 	/* lock for display hardware access */
 	struct mutex			hw_lock;
+	bool				config_updating;
 };
 
 struct mtk_crtc_state {
@@ -97,7 +98,7 @@ static void mtk_drm_crtc_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
 static void mtk_drm_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
 {
 	drm_crtc_handle_vblank(&mtk_crtc->base);
-	if (mtk_crtc->pending_needs_vblank) {
+	if (!mtk_crtc->config_updating && mtk_crtc->pending_needs_vblank) {
 		mtk_drm_crtc_finish_page_flip(mtk_crtc);
 		mtk_crtc->pending_needs_vblank = false;
 	}
@@ -425,7 +426,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc,
 	}
 }
 
-static void mtk_drm_crtc_hw_config(struct mtk_drm_crtc *mtk_crtc)
+static void mtk_drm_crtc_update_config(struct mtk_drm_crtc *mtk_crtc,
+				       bool needs_vblank)
 {
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	struct cmdq_pkt *cmdq_handle;
@@ -436,6 +438,10 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_crtc *mtk_crtc)
 	int i;
 
 	mutex_lock(&mtk_crtc->hw_lock);
+	mtk_crtc->config_updating = true;
+	if (needs_vblank)
+		mtk_crtc->pending_needs_vblank = true;
+
 	for (i = 0; i < mtk_crtc->layer_nr; i++) {
 		struct drm_plane *plane = &mtk_crtc->planes[i];
 		struct mtk_plane_state *plane_state;
@@ -472,6 +478,7 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_crtc *mtk_crtc)
 		cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cmdq_handle);
 	}
 #endif
+	mtk_crtc->config_updating = false;
 	mutex_unlock(&mtk_crtc->hw_lock);
 }
 
@@ -532,7 +539,7 @@ void mtk_drm_crtc_async_update(struct drm_crtc *crtc, struct drm_plane *plane,
 		return;
 
 	plane_helper_funcs->atomic_update(plane, new_state);
-	mtk_drm_crtc_hw_config(mtk_crtc);
+	mtk_drm_crtc_update_config(mtk_crtc, false);
 }
 
 static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
@@ -582,7 +589,7 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 	}
 	mtk_crtc->pending_planes = true;
 
-	mtk_drm_crtc_hw_config(mtk_crtc);
+	mtk_drm_crtc_update_config(mtk_crtc, false);
 	/* Wait for planes to be disabled */
 	drm_crtc_wait_one_vblank(crtc);
 
@@ -618,14 +625,12 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
 	int i;
 
-	if (mtk_crtc->event)
-		mtk_crtc->pending_needs_vblank = true;
 	if (crtc->state->color_mgmt_changed)
 		for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
 			mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], crtc->state);
 			mtk_ddp_ctm_set(mtk_crtc->ddp_comp[i], crtc->state);
 		}
-	mtk_drm_crtc_hw_config(mtk_crtc);
+	mtk_drm_crtc_update_config(mtk_crtc, !!mtk_crtc->event);
 }
 
 static const struct drm_crtc_funcs mtk_crtc_funcs = {
-- 
2.17.1


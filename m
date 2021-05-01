Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9641D37051D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 05:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhEADOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 23:14:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56072 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231620AbhEADOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 23:14:38 -0400
X-UUID: 383546de30194295a786af647795be35-20210501
X-UUID: 383546de30194295a786af647795be35-20210501
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1831589728; Sat, 01 May 2021 11:13:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 1 May 2021 11:13:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 1 May 2021 11:13:43 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>
Subject: [PATCH 2/2] drm/mediatek: clear pending flag when cmdq packet is done.
Date:   Sat, 1 May 2021 11:13:39 +0800
Message-ID: <1619838819-11309-3-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1619838819-11309-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1619838819-11309-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cmdq mode, packet may be flushed before it is executed, so
the pending flag should be cleared after cmdq packet is done.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 57 ++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index c37881b..6a3cf47 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -231,18 +231,57 @@ static void ddp_cmdq_cb(struct cmdq_cb_data data)
 {
 	struct mtk_cmdq_cb_data *cb_data = data.data;
 	struct mtk_drm_crtc *mtk_crtc;
+	struct mtk_crtc_state *state;
+	unsigned int i;
 
 	if (!cb_data) {
 		DRM_ERROR("cmdq callback data is null pointer!\n");
 		return;
 	}
 
+	if (data.sta == CMDQ_CB_ERROR) {
+		DRM_WARN("cmdq callback error!!\n");
+		goto destroy_pkt;
+	}
+
 	mtk_crtc = cb_data->mtk_crtc;
 	if (!mtk_crtc) {
 		DRM_ERROR("cmdq callback mtk_crtc is null pointer!\n");
 		goto destroy_pkt;
 	}
 
+	state = to_mtk_crtc_state(mtk_crtc->base.state);
+
+	if (state->pending_config) {
+		state->pending_config = false;
+	}
+
+	if (mtk_crtc->pending_planes) {
+		for (i = 0; i < mtk_crtc->layer_nr; i++) {
+			struct drm_plane *plane = &mtk_crtc->planes[i];
+			struct mtk_plane_state *plane_state;
+
+			plane_state = to_mtk_plane_state(plane->state);
+
+			if (plane_state->pending.config)
+				plane_state->pending.config = false;
+		}
+		mtk_crtc->pending_planes = false;
+	}
+
+	if (mtk_crtc->pending_async_planes) {
+		for (i = 0; i < mtk_crtc->layer_nr; i++) {
+			struct drm_plane *plane = &mtk_crtc->planes[i];
+			struct mtk_plane_state *plane_state;
+
+			plane_state = to_mtk_plane_state(plane->state);
+
+			if (plane_state->pending.async_config)
+				plane_state->pending.async_config = false;
+		}
+		mtk_crtc->pending_async_planes = false;
+	}
+
 	mtk_drm_finish_page_flip(mtk_crtc);
 
 destroy_pkt:
@@ -403,7 +442,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc,
 				    state->pending_vrefresh, 0,
 				    cmdq_handle);
 
-		state->pending_config = false;
+		if (!cmdq_handle)
+			state->pending_config = false;
 	}
 
 	if (mtk_crtc->pending_planes) {
@@ -423,9 +463,12 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc,
 				mtk_ddp_comp_layer_config(comp, local_layer,
 							  plane_state,
 							  cmdq_handle);
-			plane_state->pending.config = false;
+			if (!cmdq_handle)
+				plane_state->pending.config = false;
 		}
-		mtk_crtc->pending_planes = false;
+
+		if (!cmdq_handle)
+			mtk_crtc->pending_planes = false;
 	}
 
 	if (mtk_crtc->pending_async_planes) {
@@ -445,9 +488,13 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc,
 				mtk_ddp_comp_layer_config(comp, local_layer,
 							  plane_state,
 							  cmdq_handle);
-			plane_state->pending.async_config = false;
+
+			if (!cmdq_handle)
+				plane_state->pending.async_config = false;
 		}
-		mtk_crtc->pending_async_planes = false;
+
+		if (!cmdq_handle)
+			mtk_crtc->pending_async_planes = false;
 	}
 }
 
-- 
1.8.1.1.dirty


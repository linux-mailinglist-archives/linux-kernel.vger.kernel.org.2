Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494FC37051C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 05:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhEADOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 23:14:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52571 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231566AbhEADOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 23:14:37 -0400
X-UUID: 8aa91796ce2e4c889ea0403a3d7de49b-20210501
X-UUID: 8aa91796ce2e4c889ea0403a3d7de49b-20210501
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2114226936; Sat, 01 May 2021 11:13:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 1 May 2021 11:13:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 1 May 2021 11:13:42 +0800
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
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH 1/2] drm/mediatek: move page flip handle into cmdq cb
Date:   Sat, 1 May 2021 11:13:38 +0800
Message-ID: <1619838819-11309-2-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1619838819-11309-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1619838819-11309-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move page flip handle into cmdq cb
irq callback will before cmdq flush ddp register
into hardware, that will cause the display frame page
flip event before it realy display out time

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 46 ++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 8b0de90..c37881b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -72,6 +72,13 @@ struct mtk_crtc_state {
 	unsigned int			pending_vrefresh;
 };
 
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+struct mtk_cmdq_cb_data {
+	struct cmdq_pkt			*cmdq_handle;
+	struct mtk_drm_crtc		*mtk_crtc;
+};
+#endif
+
 static inline struct mtk_drm_crtc *to_mtk_crtc(struct drm_crtc *c)
 {
 	return container_of(c, struct mtk_drm_crtc, base);
@@ -96,7 +103,6 @@ static void mtk_drm_crtc_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
 
 static void mtk_drm_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
 {
-	drm_crtc_handle_vblank(&mtk_crtc->base);
 	if (mtk_crtc->pending_needs_vblank) {
 		mtk_drm_crtc_finish_page_flip(mtk_crtc);
 		mtk_crtc->pending_needs_vblank = false;
@@ -223,7 +229,27 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plane(struct drm_crtc *crtc,
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 static void ddp_cmdq_cb(struct cmdq_cb_data data)
 {
-	cmdq_pkt_destroy(data.data);
+	struct mtk_cmdq_cb_data *cb_data = data.data;
+	struct mtk_drm_crtc *mtk_crtc;
+
+	if (!cb_data) {
+		DRM_ERROR("cmdq callback data is null pointer!\n");
+		return;
+	}
+
+	mtk_crtc = cb_data->mtk_crtc;
+	if (!mtk_crtc) {
+		DRM_ERROR("cmdq callback mtk_crtc is null pointer!\n");
+		goto destroy_pkt;
+	}
+
+	mtk_drm_finish_page_flip(mtk_crtc);
+
+destroy_pkt:
+	if (cb_data->cmdq_handle)
+		cmdq_pkt_destroy(cb_data->cmdq_handle);
+
+	kfree(cb_data);
 }
 #endif
 
@@ -463,13 +489,20 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_crtc *mtk_crtc)
 	}
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	if (mtk_crtc->cmdq_client) {
+		struct mtk_cmdq_cb_data *cb_data;
+
 		mbox_flush(mtk_crtc->cmdq_client->chan, 2000);
 		cmdq_handle = cmdq_pkt_create(mtk_crtc->cmdq_client, PAGE_SIZE);
 		cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
 		cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, false);
 		mtk_crtc_ddp_config(crtc, cmdq_handle);
 		cmdq_pkt_finalize(cmdq_handle);
-		cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cmdq_handle);
+
+		cb_data = kmalloc(sizeof(*cb_data), GFP_KERNEL);
+		cb_data->cmdq_handle = cmdq_handle;
+		cb_data->mtk_crtc = mtk_crtc;
+
+		cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cb_data);
 	}
 #endif
 	mutex_unlock(&mtk_crtc->hw_lock);
@@ -488,7 +521,14 @@ static void mtk_crtc_ddp_irq(void *data)
 #endif
 		mtk_crtc_ddp_config(crtc, NULL);
 
+	drm_crtc_handle_vblank(&mtk_crtc->base);
+
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	if (!priv->data->shadow_register && !mtk_crtc->cmdq_client)
+		mtk_drm_finish_page_flip(mtk_crtc);
+#else
 	mtk_drm_finish_page_flip(mtk_crtc);
+#endif
 }
 
 static int mtk_drm_crtc_enable_vblank(struct drm_crtc *crtc)
-- 
1.8.1.1.dirty


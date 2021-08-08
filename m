Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751943E3D33
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 01:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhHHXsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 19:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231675AbhHHXsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 19:48:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95FAA60F4B;
        Sun,  8 Aug 2021 23:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628466476;
        bh=irCDUoflXrwrU0O7GCvMgdGWeBXXUYACkrzcuuKo/AY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FMXcAu5EM7JgFWHb237ckQQzfPfyJr5XZ+9q+pWFm7kx2NwHfhDPpRl683WqMM1qU
         1juvUmx6xH+x9IIq6itTIV9y7ldz6yVWqAIMfrAuro3+hSMGW1NKDc+XSCG1s/fdqR
         6Q14UIWpfhlTUelLgp0XK0IBS0m/jOAB9MyiKcPjZ3143EafxdAmOA01xfpa3bz++U
         296FhikaurV1KOa65KR2kFTVkBP25f8SIphaF/9tIDRp9MGqVmt5LSor6NUASn1bWb
         bEbrMSSZ6Z0r6JJz/aLPwcgL3PryeXRH84BegNZBWxCU2bXDtQXbyju0NukqBHzbY5
         qjk+F85nfJzgw==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v2 4/4] drm/mediatek: Add cmdq_handle in mtk_crtc
Date:   Mon,  9 Aug 2021 07:47:33 +0800
Message-Id: <20210808234733.14782-5-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210808234733.14782-1-chunkuang.hu@kernel.org>
References: <20210808234733.14782-1-chunkuang.hu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One mtk_crtc need just one cmdq_handle, so add one cmdq_handle
in mtk_crtc to prevent frequently allocation and free of
cmdq_handle.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 28 ++++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index ad4c1a3a9294..2d9becec04a9 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -54,6 +54,7 @@ struct mtk_drm_crtc {
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	struct mbox_client		cmdq_cl;
 	struct mbox_chan		*cmdq_chan;
+	struct cmdq_pkt			cmdq_handle;
 	u32				cmdq_event;
 	u32				cmdq_vblank_cnt;
 #endif
@@ -226,19 +227,16 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plane(struct drm_crtc *crtc,
 }
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-static struct cmdq_pkt *mtk_drm_cmdq_pkt_create(struct mbox_chan *chan, size_t size)
+static int mtk_drm_cmdq_pkt_create(struct mbox_chan *chan, struct cmdq_pkt *pkt,
+				    size_t size)
 {
-	struct cmdq_pkt *pkt;
 	struct device *dev;
 	dma_addr_t dma_addr;
 
-	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
-	if (!pkt)
-		return ERR_PTR(-ENOMEM);
 	pkt->va_base = kzalloc(size, GFP_KERNEL);
 	if (!pkt->va_base) {
 		kfree(pkt);
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 	pkt->buf_size = size;
 
@@ -249,12 +247,12 @@ static struct cmdq_pkt *mtk_drm_cmdq_pkt_create(struct mbox_chan *chan, size_t s
 		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
 		kfree(pkt->va_base);
 		kfree(pkt);
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 
 	pkt->pa_base = dma_addr;
 
-	return pkt;
+	return 0;
 }
 
 static void mtk_drm_cmdq_pkt_destroy(struct mbox_chan *chan, struct cmdq_pkt *pkt)
@@ -477,7 +475,7 @@ static void mtk_drm_crtc_update_config(struct mtk_drm_crtc *mtk_crtc,
 				       bool needs_vblank)
 {
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	struct cmdq_pkt *cmdq_handle;
+	struct cmdq_pkt *cmdq_handle = &mtk_crtc->cmdq_handle;
 #endif
 	struct drm_crtc *crtc = &mtk_crtc->base;
 	struct mtk_drm_private *priv = crtc->dev->dev_private;
@@ -517,7 +515,7 @@ static void mtk_drm_crtc_update_config(struct mtk_drm_crtc *mtk_crtc,
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	if (mtk_crtc->cmdq_chan) {
 		mbox_flush(mtk_crtc->cmdq_chan, 2000);
-		cmdq_handle = mtk_drm_cmdq_pkt_create(mtk_crtc->cmdq_chan, PAGE_SIZE);
+		cmdq_handle->cmd_buf_size = 0;
 		cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
 		cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, false);
 		mtk_crtc_ddp_config(crtc, cmdq_handle);
@@ -915,6 +913,16 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 				drm_crtc_index(&mtk_crtc->base));
 			mbox_free_channel(mtk_crtc->cmdq_chan);
 			mtk_crtc->cmdq_chan = NULL;
+		} else {
+			ret = mtk_drm_cmdq_pkt_create(mtk_crtc->cmdq_chan,
+						       &mtk_crtc->cmdq_handle,
+						       PAGE_SIZE);
+			if (ret) {
+				dev_dbg(dev, "mtk_crtc %d failed to create cmdq packet\n",
+					drm_crtc_index(&mtk_crtc->base));
+				mbox_free_channel(mtk_crtc->cmdq_chan);
+				mtk_crtc->cmdq_chan = NULL;
+			}
 		}
 	}
 #endif
-- 
2.25.1


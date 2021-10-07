Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2016D4260C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbhJGXzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241436AbhJGXzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:55:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2343061090;
        Thu,  7 Oct 2021 23:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633650804;
        bh=mPRVdtxzBthmAzQsdEWN6hMyf+MHv7KWVtcwYta4aVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/ZAdieFY4/KWaLn+0UR5xpDC91Z8RhCchUxaUJdafOwY8GM8CymsakgPE9E35EAs
         n3oZSE2AqABe3dct69b0UJSk+dAHpVpFguP+NL8FfX+/pWNOkIC1QaBq9h3evTvSxY
         xrDFrJX6a5pLzWaNsSkiOhpCdnC1EtVNlqCEnqpB9xOgHUCfusG0OaFp1tKD3Q4m1V
         kK8eOpr1aGdi0PMJpmsX78d88kdNLKf7mmqQp2ZE7wUxA3gVAh++na9XmAJkhCdi/J
         o3wTyDJp3fm4VVlP0mxI2mg0drQ5G4P0rKJ6I3zSaL33Ur4IM/IhB5IwpyflaEN320
         dqeShNSkuMuTQ==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 4/5] Revert "drm/mediatek: Remove struct cmdq_client"
Date:   Fri,  8 Oct 2021 07:53:09 +0800
Message-Id: <20211007235310.14626-5-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007235310.14626-1-chunkuang.hu@kernel.org>
References: <20211007235310.14626-1-chunkuang.hu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f4be17cd5b14dd73545b0e014a63ebe9ab5ef837.

Commit c1ec54b7b5af
("drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb")
would cause numerous mtk cmdq mailbox driver warning:

WARNING: CPU: 0 PID: 0 at drivers/mailbox/mtk-cmdq-mailbox.c:198
cmdq_task_exec_done+0xb8/0xe0

So revert that patch and all the patches depend on that patch.

Reported-by: Enric Balletbo Serra <eballetbo@gmail.com>
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 80 ++++++-------------------
 1 file changed, 18 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 0cd5b9ed8956..3f9802d21bf0 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -52,8 +52,7 @@ struct mtk_drm_crtc {
 	bool				pending_async_planes;
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	struct mbox_client		cmdq_cl;
-	struct mbox_chan		*cmdq_chan;
+	struct cmdq_client		*cmdq_client;
 	u32				cmdq_event;
 #endif
 
@@ -225,51 +224,11 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plane(struct drm_crtc *crtc,
 }
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-static struct cmdq_pkt *mtk_drm_cmdq_pkt_create(struct mbox_chan *chan, size_t size)
-{
-	struct cmdq_pkt *pkt;
-	struct device *dev;
-	dma_addr_t dma_addr;
-
-	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
-	if (!pkt)
-		return ERR_PTR(-ENOMEM);
-	pkt->va_base = kzalloc(size, GFP_KERNEL);
-	if (!pkt->va_base) {
-		kfree(pkt);
-		return ERR_PTR(-ENOMEM);
-	}
-	pkt->buf_size = size;
-
-	dev = chan->mbox->dev;
-	dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
-				  DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, dma_addr)) {
-		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
-		kfree(pkt->va_base);
-		kfree(pkt);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	pkt->pa_base = dma_addr;
-
-	return pkt;
-}
-
-static void mtk_drm_cmdq_pkt_destroy(struct mbox_chan *chan, struct cmdq_pkt *pkt)
-{
-	dma_unmap_single(chan->mbox->dev, pkt->pa_base, pkt->buf_size,
-			 DMA_TO_DEVICE);
-	kfree(pkt->va_base);
-	kfree(pkt);
-}
-
 static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 {
-	struct mtk_drm_crtc *mtk_crtc = container_of(cl, struct mtk_drm_crtc, cmdq_cl);
 	struct cmdq_cb_data *data = mssg;
 
-	mtk_drm_cmdq_pkt_destroy(mtk_crtc->cmdq_chan, data->pkt);
+	cmdq_pkt_destroy(data->pkt);
 }
 #endif
 
@@ -513,19 +472,19 @@ static void mtk_drm_crtc_update_config(struct mtk_drm_crtc *mtk_crtc,
 		mtk_mutex_release(mtk_crtc->mutex);
 	}
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	if (mtk_crtc->cmdq_chan) {
-		mbox_flush(mtk_crtc->cmdq_chan, 2000);
-		cmdq_handle = mtk_drm_cmdq_pkt_create(mtk_crtc->cmdq_chan, PAGE_SIZE);
+	if (mtk_crtc->cmdq_client) {
+		mbox_flush(mtk_crtc->cmdq_client->chan, 2000);
+		cmdq_handle = cmdq_pkt_create(mtk_crtc->cmdq_client, PAGE_SIZE);
 		cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
 		cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, false);
 		mtk_crtc_ddp_config(crtc, cmdq_handle);
 		cmdq_pkt_finalize(cmdq_handle);
-		dma_sync_single_for_device(mtk_crtc->cmdq_chan->mbox->dev,
+		dma_sync_single_for_device(mtk_crtc->cmdq_client->chan->mbox->dev,
 					    cmdq_handle->pa_base,
 					    cmdq_handle->cmd_buf_size,
 					    DMA_TO_DEVICE);
-		mbox_send_message(mtk_crtc->cmdq_chan, cmdq_handle);
-		mbox_client_txdone(mtk_crtc->cmdq_chan, 0);
+		mbox_send_message(mtk_crtc->cmdq_client->chan, cmdq_handle);
+		mbox_client_txdone(mtk_crtc->cmdq_client->chan, 0);
 	}
 #endif
 	mtk_crtc->config_updating = false;
@@ -539,7 +498,7 @@ static void mtk_crtc_ddp_irq(void *data)
 	struct mtk_drm_private *priv = crtc->dev->dev_private;
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	if (!priv->data->shadow_register && !mtk_crtc->cmdq_chan)
+	if (!priv->data->shadow_register && !mtk_crtc->cmdq_client)
 #else
 	if (!priv->data->shadow_register)
 #endif
@@ -879,20 +838,17 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	mutex_init(&mtk_crtc->hw_lock);
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	mtk_crtc->cmdq_cl.dev = mtk_crtc->mmsys_dev;
-	mtk_crtc->cmdq_cl.tx_block = false;
-	mtk_crtc->cmdq_cl.knows_txdone = true;
-	mtk_crtc->cmdq_cl.rx_callback = ddp_cmdq_cb;
-	mtk_crtc->cmdq_chan =
-			mbox_request_channel(&mtk_crtc->cmdq_cl,
-					      drm_crtc_index(&mtk_crtc->base));
-	if (IS_ERR(mtk_crtc->cmdq_chan)) {
+	mtk_crtc->cmdq_client =
+			cmdq_mbox_create(mtk_crtc->mmsys_dev,
+					 drm_crtc_index(&mtk_crtc->base));
+	if (IS_ERR(mtk_crtc->cmdq_client)) {
 		dev_dbg(dev, "mtk_crtc %d failed to create mailbox client, writing register by CPU now\n",
 			drm_crtc_index(&mtk_crtc->base));
-		mtk_crtc->cmdq_chan = NULL;
+		mtk_crtc->cmdq_client = NULL;
 	}
 
-	if (mtk_crtc->cmdq_chan) {
+	if (mtk_crtc->cmdq_client) {
+		mtk_crtc->cmdq_client->client.rx_callback = ddp_cmdq_cb;
 		ret = of_property_read_u32_index(priv->mutex_node,
 						 "mediatek,gce-events",
 						 drm_crtc_index(&mtk_crtc->base),
@@ -900,8 +856,8 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 		if (ret) {
 			dev_dbg(dev, "mtk_crtc %d failed to get mediatek,gce-events property\n",
 				drm_crtc_index(&mtk_crtc->base));
-			mbox_free_channel(mtk_crtc->cmdq_chan);
-			mtk_crtc->cmdq_chan = NULL;
+			cmdq_mbox_destroy(mtk_crtc->cmdq_client);
+			mtk_crtc->cmdq_client = NULL;
 		}
 	}
 #endif
-- 
2.25.1


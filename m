Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236113E3D30
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 01:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhHHXsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 19:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhHHXsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 19:48:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0ADF960F38;
        Sun,  8 Aug 2021 23:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628466470;
        bh=/wtDrP5iuggwVl9aJiLqEemxJKIrDTTzHICklU/8cNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5YBEgqXYnsQJ6Tli97lNxB+bL+6QXVLZ49ob2IJj+6oTTYbTmhXIu5uQoLaRDYSF
         3kkFty3f1MrduPd9bvSZMybyuHEKkbSy09iXk/v8t+wIXBLx90wKpxznH1wdtf2tIr
         fadKQb2EqxXpH0Lef9vW2tghgCZMD61i5+uALAA4NSgTcBIPTXOb4SqtC8m//5Cx6q
         BYqT2MAFLpCdYW5esqpLNqfy+ZVvHh5mE5uxeg9Zj1AXhBlgtJe50VTCdu8AIRe3gx
         tUoCEcpWj90Cw8pZ86vJXtbfYuhHz3WalCatLmXQoKHm7eqfylxKaYOcB+NXhXxmrG
         ojVLyX7HTJhoA==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v2 1/4] drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb
Date:   Mon,  9 Aug 2021 07:47:30 +0800
Message-Id: <20210808234733.14782-2-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210808234733.14782-1-chunkuang.hu@kernel.org>
References: <20210808234733.14782-1-chunkuang.hu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rx_callback is a standard mailbox callback mechanism and could cover the
function of proprietary cmdq_task_cb, so use the standard one instead of
the proprietary one.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 474efb844249..cac8fe219c95 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/mailbox_controller.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/mediatek/mtk-cmdq.h>
 #include <linux/soc/mediatek/mtk-mmsys.h>
@@ -222,9 +224,11 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plane(struct drm_crtc *crtc,
 }
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-static void ddp_cmdq_cb(struct cmdq_cb_data data)
+static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 {
-	cmdq_pkt_destroy(data.data);
+	struct cmdq_cb_data *data = mssg;
+
+	cmdq_pkt_destroy(data->pkt);
 }
 #endif
 
@@ -475,7 +479,12 @@ static void mtk_drm_crtc_update_config(struct mtk_drm_crtc *mtk_crtc,
 		cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, false);
 		mtk_crtc_ddp_config(crtc, cmdq_handle);
 		cmdq_pkt_finalize(cmdq_handle);
-		cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cmdq_handle);
+		dma_sync_single_for_device(mtk_crtc->cmdq_client->chan->mbox->dev,
+					    cmdq_handle->pa_base,
+					    cmdq_handle->cmd_buf_size,
+					    DMA_TO_DEVICE);
+		mbox_send_message(mtk_crtc->cmdq_client->chan, cmdq_handle);
+		mbox_client_txdone(mtk_crtc->cmdq_client->chan, 0);
 	}
 #endif
 	mtk_crtc->config_updating = false;
@@ -842,6 +851,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	}
 
 	if (mtk_crtc->cmdq_client) {
+		mtk_crtc->cmdq_client->client.rx_callback = ddp_cmdq_cb;
 		ret = of_property_read_u32_index(priv->mutex_node,
 						 "mediatek,gce-events",
 						 drm_crtc_index(&mtk_crtc->base),
-- 
2.25.1


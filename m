Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D914260C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242001AbhJGXz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241345AbhJGXzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:55:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE4A360F46;
        Thu,  7 Oct 2021 23:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633650806;
        bh=zY4CHOcf904wGrBQIxRY3emDUZoEa9VuYr4ZkjX6geQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohu/VgY0pgkqa/F631/k3noWQLk9VGF0KDNVP41JOic2ahGX3nNV7lL7ooeb114kP
         RIOaRgYG2rkLeFEj8JjMczdSALZPkh+XivrJmeShhEPENiHVz9vGKgnHdzzjEqTndO
         DhQRTDJlXeG4Ie5+fP1IYgC8IrmYTNzmxBRgXX/eMowLTQt0kxbBj6GY5YTR3Hgv3+
         V+cAIed/0S9UwfVbahJBXX/gEB2CrI9iAWsbyu6dqiv5sH62SUx+qPfu9QxwJwzPEz
         4rtT+s5Z5AEXRCdS2pnuW3s8fpN0OyhfLkbUOR3sF858WTX4FYxAZrH54MOs1ZwoPb
         biZ6TIMNwqNAw==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 5/5] Revert "drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb"
Date:   Fri,  8 Oct 2021 07:53:10 +0800
Message-Id: <20211007235310.14626-6-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007235310.14626-1-chunkuang.hu@kernel.org>
References: <20211007235310.14626-1-chunkuang.hu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c1ec54b7b5af25c779192253f5a9f05e95cb43d7.

Commit c1ec54b7b5af
("drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb")
would cause numerous mtk cmdq mailbox driver warning:

WARNING: CPU: 0 PID: 0 at drivers/mailbox/mtk-cmdq-mailbox.c:198
cmdq_task_exec_done+0xb8/0xe0

So revert that patch.

Reported-by: Enric Balletbo Serra <eballetbo@gmail.com>
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 3f9802d21bf0..a4e80e499674 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -4,8 +4,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/dma-mapping.h>
-#include <linux/mailbox_controller.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/mediatek/mtk-cmdq.h>
 #include <linux/soc/mediatek/mtk-mmsys.h>
@@ -224,11 +222,9 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plane(struct drm_crtc *crtc,
 }
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
+static void ddp_cmdq_cb(struct cmdq_cb_data data)
 {
-	struct cmdq_cb_data *data = mssg;
-
-	cmdq_pkt_destroy(data->pkt);
+	cmdq_pkt_destroy(data.data);
 }
 #endif
 
@@ -479,12 +475,7 @@ static void mtk_drm_crtc_update_config(struct mtk_drm_crtc *mtk_crtc,
 		cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, false);
 		mtk_crtc_ddp_config(crtc, cmdq_handle);
 		cmdq_pkt_finalize(cmdq_handle);
-		dma_sync_single_for_device(mtk_crtc->cmdq_client->chan->mbox->dev,
-					    cmdq_handle->pa_base,
-					    cmdq_handle->cmd_buf_size,
-					    DMA_TO_DEVICE);
-		mbox_send_message(mtk_crtc->cmdq_client->chan, cmdq_handle);
-		mbox_client_txdone(mtk_crtc->cmdq_client->chan, 0);
+		cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cmdq_handle);
 	}
 #endif
 	mtk_crtc->config_updating = false;
@@ -848,7 +839,6 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	}
 
 	if (mtk_crtc->cmdq_client) {
-		mtk_crtc->cmdq_client->client.rx_callback = ddp_cmdq_cb;
 		ret = of_property_read_u32_index(priv->mutex_node,
 						 "mediatek,gce-events",
 						 drm_crtc_index(&mtk_crtc->base),
-- 
2.25.1


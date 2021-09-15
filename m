Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABE340D021
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhIOX2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhIOX2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:28:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55973610D1;
        Wed, 15 Sep 2021 23:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748451;
        bh=/pHZKjT+pK/1LLZ5p5KaN2fpNBbhL7onpG139zCfXuk=;
        h=From:To:Cc:Subject:Date:From;
        b=P2mqL6E1pIgWqMQjOc7xJuwwcb6dp92WJ/J3fSUNbG1pYk1UuHKBwNAKxB81LxnvN
         84m5OYztHBF+jpAQJ5kVIeoRB59Le+iN1uOJmMFu6zlNtllK7lUs9wGaS1W+J/3jZz
         NcISMfDzNI/TQ56d3N7RM3D+amafIsLM5rIbGcNsIRdzbXrQQMp+0FZLhEODibttiJ
         LLwdP3VwDcLyCCdNolLz9MrboDxk9ezePhoEhMxbTTpjpwl6C08YMal2CcU8hUMhJa
         kDdSbqtnYalH21wtKfiMy33dl0AffYS9P94OuhjfkSkdx0oy38/daVEqBXwkfQQaPW
         lwEc92n/qX/fw==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH] soc: mediatek: cmdq: Use mailbox rx_callback instead of cmdq_task_cb
Date:   Thu, 16 Sep 2021 07:27:22 +0800
Message-Id: <20210915232722.10031-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rx_callback is a standard mailbox callback mechanism and could cover the
function of proprietary cmdq_task_cb, so use the standard one instead of
the proprietary one. Client has changed to use the standard callback
machanism and sync dma buffer in client driver, so remove the proprietary
callback in cmdq helper.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 25 +------------------------
 include/linux/soc/mediatek/mtk-cmdq.h  |  5 +----
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 3c8e4212d941..c1837a468267 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -425,34 +425,11 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 }
 EXPORT_SYMBOL(cmdq_pkt_finalize);
 
-static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
-{
-	struct cmdq_pkt *pkt = (struct cmdq_pkt *)data.data;
-	struct cmdq_task_cb *cb = &pkt->cb;
-	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
-
-	dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base,
-				pkt->cmd_buf_size, DMA_TO_DEVICE);
-	if (cb->cb) {
-		data.data = cb->data;
-		cb->cb(data);
-	}
-}
-
-int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
-			 void *data)
+int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
 {
 	int err;
 	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
 
-	pkt->cb.cb = cb;
-	pkt->cb.data = data;
-	pkt->async_cb.cb = cmdq_pkt_flush_async_cb;
-	pkt->async_cb.data = pkt;
-
-	dma_sync_single_for_device(client->chan->mbox->dev, pkt->pa_base,
-				   pkt->cmd_buf_size, DMA_TO_DEVICE);
-
 	err = mbox_send_message(client->chan, pkt);
 	if (err < 0)
 		return err;
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index ac6b5f3cba95..2b498f4f3946 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -268,8 +268,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
  * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
  *                          packet and call back at the end of done packet
  * @pkt:	the CMDQ packet
- * @cb:		called at the end of done packet
- * @data:	this data will pass back to cb
  *
  * Return: 0 for success; else the error code is returned
  *
@@ -277,7 +275,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
  * at the end of done packet. Note that this is an ASYNC function. When the
  * function returned, it may or may not be finished.
  */
-int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
-			 void *data);
+int cmdq_pkt_flush_async(struct cmdq_pkt *pkt);
 
 #endif	/* __MTK_CMDQ_H__ */
-- 
2.25.1


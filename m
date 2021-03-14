Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0AC33A8D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 00:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhCNXeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 19:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhCNXdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 19:33:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0190364E86;
        Sun, 14 Mar 2021 23:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615764816;
        bh=Sb/aUOEVrGZsj+WwC31AWifEfTb5okFWSJJBDazvLWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8X8+nqsqw3JfWwp699qB+lHkbMabIqGvdJeOa5nuVwh/jwA7jE6Ch/7ySN6gEjY5
         3gLG+M74VYgoeN4uUOuVaydTi5hbhy4rkIUzLoHO3N3nxqGMMLRKcUwP1PKEVsvfPI
         ZU+hvNi9npXXQ+eqxenxZsCNpZuNiJBVNq3kBl5SpV2G9ecEnZfpxovZ3815tu9UF5
         gis0mNTn47sgx6DK+wdKF1crbA99YXRd1/TO5zGFxMOGa4zOc6vpWejIu/XKMPc2+N
         8b/kIU4I11skDc6E6mALf1yuCghY7jnfrb7fQMbj4j+kK9AX9EtesoHbfUwNpZuvTd
         2ROg1Zm/OW74w==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 2/3] mailbox: mtk-cmdq: Use mailbox rx_callback
Date:   Mon, 15 Mar 2021 07:33:22 +0800
Message-Id: <20210314233323.23377-3-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210314233323.23377-1-chunkuang.hu@kernel.org>
References: <20210314233323.23377-1-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rx_callback is a standard mailbox callback mechanism and could cover the
function of proprietary cmdq_task_cb, so use the standard one instead of
the proprietary one. But the client driver has already used cmdq_task_cb,
so keep cmdq_task_cb until all client driver use rx_callback instead of
cmdq_task_cb.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Houlong Wei <houlong.wei@mediatek.com>
Cc: Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 3d37c1cd40f1..ef59e2234f22 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -188,7 +188,10 @@ static void cmdq_task_exec_done(struct cmdq_task *task, int sta)
 	WARN_ON(cb->cb == (cmdq_async_flush_cb)NULL);
 	data.sta = sta;
 	data.data = cb->data;
-	cb->cb(data);
+	if (cb->cb)
+		cb->cb(data);
+
+	mbox_chan_received_data(task->thread->chan, &data);
 
 	list_del(&task->list_entry);
 }
@@ -451,12 +454,13 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 
 	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
 				 list_entry) {
+		data.sta = -ECONNABORTED;
+		data.data = cb->data;
 		cb = &task->pkt->async_cb;
-		if (cb->cb) {
-			data.sta = -ECONNABORTED;
-			data.data = cb->data;
+		if (cb->cb)
 			cb->cb(data);
-		}
+
+		mbox_chan_received_data(task->thread->chan, &data);
 		list_del(&task->list_entry);
 		kfree(task);
 	}
-- 
2.17.1


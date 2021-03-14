Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3005F33A8D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 00:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCNXeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 19:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhCNXde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 19:33:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF80964E7C;
        Sun, 14 Mar 2021 23:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615764814;
        bh=i8JUe2VjLZUuVjVLi3BHMdhFn1Aqxj0nLCJrxMeGiq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPb1J5P5E4HfJeHHqzfPqdE1juViiKpEUpd4NCazAJvWyy9zRda+iEUj+NOhAm3IN
         mM3eXeORFg406wmSbWp4PNzaFF5tyFKiQrp0lastogEzPQhn2R91NS4zl69fqgw5g5
         BxtDPMAit3XYtVVYRNlLtR9AkvxbUcOXN0zvtRE3mZYQwEklR115jmM1ldxN99FqCU
         IRI+wSMwuFXN8+3a4jFo8UnLnabnI1Myp8v1yh854E+EQkEBIprJR6TiNI5fdni3rz
         SFEhIQ593THRhGdYMXWR6Xhk7x5LnPs/ohqvw+F8MLcL2eEGIqR1QHeBjyfTFI+lJV
         k7jaYs6U6OS4w==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 1/3] mailbox: mtk-cmdq: Remove cmdq_cb_status
Date:   Mon, 15 Mar 2021 07:33:21 +0800
Message-Id: <20210314233323.23377-2-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210314233323.23377-1-chunkuang.hu@kernel.org>
References: <20210314233323.23377-1-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmdq_cb_status is an error status. Use the standard error number
instead of cmdq_cb_status to prevent status duplication.

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
 drivers/mailbox/mtk-cmdq-mailbox.c       | 10 +++++-----
 include/linux/mailbox/mtk-cmdq-mailbox.h |  7 +------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 5665b6ea8119..3d37c1cd40f1 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -180,7 +180,7 @@ static bool cmdq_thread_is_in_wfe(struct cmdq_thread *thread)
 	return readl(thread->base + CMDQ_THR_WAIT_TOKEN) & CMDQ_THR_IS_WAITING;
 }
 
-static void cmdq_task_exec_done(struct cmdq_task *task, enum cmdq_cb_status sta)
+static void cmdq_task_exec_done(struct cmdq_task *task, int sta)
 {
 	struct cmdq_task_cb *cb = &task->pkt->async_cb;
 	struct cmdq_cb_data data;
@@ -244,10 +244,10 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 			curr_task = task;
 
 		if (!curr_task || curr_pa == task_end_pa - CMDQ_INST_SIZE) {
-			cmdq_task_exec_done(task, CMDQ_CB_NORMAL);
+			cmdq_task_exec_done(task, 0);
 			kfree(task);
 		} else if (err) {
-			cmdq_task_exec_done(task, CMDQ_CB_ERROR);
+			cmdq_task_exec_done(task, -ENOEXEC);
 			cmdq_task_handle_error(curr_task);
 			kfree(task);
 		}
@@ -415,7 +415,7 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 
 	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
 				 list_entry) {
-		cmdq_task_exec_done(task, CMDQ_CB_ERROR);
+		cmdq_task_exec_done(task, -ECONNABORTED);
 		kfree(task);
 	}
 
@@ -453,7 +453,7 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 				 list_entry) {
 		cb = &task->pkt->async_cb;
 		if (cb->cb) {
-			data.sta = CMDQ_CB_ERROR;
+			data.sta = -ECONNABORTED;
 			data.data = cb->data;
 			cb->cb(data);
 		}
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index d5a983d65f05..2f7d9a37d611 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -65,13 +65,8 @@ enum cmdq_code {
 	CMDQ_CODE_LOGIC = 0xa0,
 };
 
-enum cmdq_cb_status {
-	CMDQ_CB_NORMAL = 0,
-	CMDQ_CB_ERROR
-};
-
 struct cmdq_cb_data {
-	enum cmdq_cb_status	sta;
+	int			sta;
 	void			*data;
 };
 
-- 
2.17.1


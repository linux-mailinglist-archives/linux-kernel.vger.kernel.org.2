Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09705333AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 11:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhCJK5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 05:57:25 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:58802 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232613AbhCJK5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:57:06 -0500
X-UUID: 9159b1557cdf439bb05f54039e670d02-20210310
X-UUID: 9159b1557cdf439bb05f54039e670d02-20210310
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 135118957; Wed, 10 Mar 2021 18:57:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 10 Mar 2021 18:57:01 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Mar 2021 18:57:00 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [RESEND PATCH v1 2/2] Revert "mailbox: mediatek: remove implementation related to atomic_exec"
Date:   Wed, 10 Mar 2021 18:56:52 +0800
Message-ID: <1615373812-16204-3-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1615373812-16204-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1615373812-16204-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c9ea564f3d9dd20d88bd34f40a6ff6d31a0d7e8c.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 80 +++++++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 5665b6e..e0d9a86 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -56,6 +56,7 @@ struct cmdq_thread {
 	void __iomem		*base;
 	struct list_head	task_busy_list;
 	u32			priority;
+	bool			atomic_exec;
 };
 
 struct cmdq_task {
@@ -168,18 +169,56 @@ static void cmdq_task_insert_into_thread(struct cmdq_task *task)
 	dma_sync_single_for_cpu(dev, prev_task->pa_base,
 				prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
 	prev_task_base[CMDQ_NUM_CMD(prev_task->pkt) - 1] =
-		(u64)CMDQ_JUMP_BY_PA << 32 | task->pa_base;
+		(u64)CMDQ_JUMP_BY_PA << 32 |
+		(task->pa_base >> task->cmdq->shift_pa);
 	dma_sync_single_for_device(dev, prev_task->pa_base,
 				   prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
 
 	cmdq_thread_invalidate_fetched_data(thread);
 }
 
+static bool cmdq_command_is_wfe(u64 cmd)
+{
+	u64 wfe_option = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
+	u64 wfe_op = (u64)(CMDQ_CODE_WFE << CMDQ_OP_CODE_SHIFT) << 32;
+	u64 wfe_mask = (u64)CMDQ_OP_CODE_MASK << 32 | 0xffffffff;
+
+	return ((cmd & wfe_mask) == (wfe_op | wfe_option));
+}
+
+/* we assume tasks in the same display GCE thread are waiting the same event. */
+static void cmdq_task_remove_wfe(struct cmdq_task *task)
+{
+	struct device *dev = task->cmdq->mbox.dev;
+	u64 *base = task->pkt->va_base;
+	int i;
+
+	dma_sync_single_for_cpu(dev, task->pa_base, task->pkt->cmd_buf_size,
+				DMA_TO_DEVICE);
+	for (i = 0; i < CMDQ_NUM_CMD(task->pkt); i++)
+		if (cmdq_command_is_wfe(base[i]))
+			base[i] = (u64)CMDQ_JUMP_BY_OFFSET << 32 |
+				  (CMDQ_JUMP_PASS >> task->cmdq->shift_pa);
+	dma_sync_single_for_device(dev, task->pa_base, task->pkt->cmd_buf_size,
+				   DMA_TO_DEVICE);
+}
+
 static bool cmdq_thread_is_in_wfe(struct cmdq_thread *thread)
 {
 	return readl(thread->base + CMDQ_THR_WAIT_TOKEN) & CMDQ_THR_IS_WAITING;
 }
 
+static void cmdq_thread_wait_end(struct cmdq_thread *thread,
+				 unsigned long end_pa)
+{
+	struct device *dev = thread->chan->mbox->dev;
+	unsigned long curr_pa;
+
+	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_CURR_ADDR,
+			curr_pa, curr_pa == end_pa, 1, 20))
+		dev_err(dev, "GCE thread cannot run to end.\n");
+}
+
 static void cmdq_task_exec_done(struct cmdq_task *task, enum cmdq_cb_status sta)
 {
 	struct cmdq_task_cb *cb = &task->pkt->async_cb;
@@ -371,15 +410,37 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 			cmdq->shift_pa;
 		end_pa = readl(thread->base + CMDQ_THR_END_ADDR) <<
 			cmdq->shift_pa;
-		/* check boundary */
-		if (curr_pa == end_pa - CMDQ_INST_SIZE ||
-		    curr_pa == end_pa) {
-			/* set to this task directly */
-			writel(task->pa_base >> cmdq->shift_pa,
-			       thread->base + CMDQ_THR_CURR_ADDR);
+
+		/*
+		 * Atomic execution should remove the following wfe, i.e. only
+		 * wait event at first task, and prevent to pause when running.
+		 */
+		if (thread->atomic_exec) {
+			/* GCE is executing if command is not WFE */
+			if (!cmdq_thread_is_in_wfe(thread)) {
+				cmdq_thread_resume(thread);
+				cmdq_thread_wait_end(thread,
+						     end_pa >> cmdq->shift_pa);
+				WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
+				/* set to this task directly */
+				writel(task->pa_base >> cmdq->shift_pa,
+				       thread->base + CMDQ_THR_CURR_ADDR);
+			} else {
+				cmdq_task_insert_into_thread(task);
+				cmdq_task_remove_wfe(task);
+				smp_mb(); /* modify jump before enable thread */
+			}
 		} else {
-			cmdq_task_insert_into_thread(task);
-			smp_mb(); /* modify jump before enable thread */
+			/* check boundary */
+			if (curr_pa == end_pa - CMDQ_INST_SIZE ||
+			    curr_pa == end_pa) {
+				/* set to this task directly */
+				writel(task->pa_base >> cmdq->shift_pa,
+				       thread->base + CMDQ_THR_CURR_ADDR);
+			} else {
+				cmdq_task_insert_into_thread(task);
+				smp_mb(); /* modify jump before enable thread */
+			}
 		}
 		writel((task->pa_base + pkt->cmd_buf_size) >> cmdq->shift_pa,
 		       thread->base + CMDQ_THR_END_ADDR);
@@ -500,6 +561,7 @@ static struct mbox_chan *cmdq_xlate(struct mbox_controller *mbox,
 
 	thread = (struct cmdq_thread *)mbox->chans[ind].con_priv;
 	thread->priority = sp->args[1];
+	thread->atomic_exec = (sp->args[2] != 0);
 	thread->chan = &mbox->chans[ind];
 
 	return &mbox->chans[ind];
-- 
1.8.1.1.dirty


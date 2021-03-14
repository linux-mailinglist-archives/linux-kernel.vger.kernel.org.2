Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4D33A8D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 00:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhCNXeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 19:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhCNXdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 19:33:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18CA464E87;
        Sun, 14 Mar 2021 23:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615764818;
        bh=p+OvM6cie0qKQc+LIUuhfUzqA36ufYyQPLO73t0gzik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPgXTYCzqM4a6K7sWlMCn+e2ClGBUFDx9R3DVzYsJI3kkx4WQ9CTdOL4MIaqcL2UE
         VPbuUj0r37ECiNlAZkveEHUxbjynmYxcxhqXPLzVf0Ngd3fqaHaKu0CJw8E0vjoBgu
         jOPy1ws/Pi7f73G0Tky3T0ZMbdaXag7EzdRcMofnp8BAoEWpo/TIcf/y/fYEP2M5tX
         Kij42ZYVDCUULnTRZwp1feySZjLShJoCLBnmLr3v8gikKSfUJJwlaWuRdE9GqRSqmA
         5i4+ki+II70EcGxlWhKTsNour1xm8dZaivwEeIH9gjxNT9kb0X2BqqJPqbCXu2nwN0
         h2wWIoKfri+Sg==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 3/3] mailbox: mtk-cmdq: Add struct cmdq_pkt in struct cmdq_cb_data
Date:   Mon, 15 Mar 2021 07:33:23 +0800
Message-Id: <20210314233323.23377-4-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210314233323.23377-1-chunkuang.hu@kernel.org>
References: <20210314233323.23377-1-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current client use 'struct cmdq_pkt' as callback data, so
change 'void *data' to 'struct cmdq_pkt *pkt'. Keep data
until client use pkt instead of data.

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
 drivers/mailbox/mtk-cmdq-mailbox.c       | 2 ++
 include/linux/mailbox/mtk-cmdq-mailbox.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index ef59e2234f22..99a9e0787501 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -188,6 +188,7 @@ static void cmdq_task_exec_done(struct cmdq_task *task, int sta)
 	WARN_ON(cb->cb == (cmdq_async_flush_cb)NULL);
 	data.sta = sta;
 	data.data = cb->data;
+	data.pkt = task->pkt;
 	if (cb->cb)
 		cb->cb(data);
 
@@ -456,6 +457,7 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 				 list_entry) {
 		data.sta = -ECONNABORTED;
 		data.data = cb->data;
+		data.pkt = task->pkt;
 		cb = &task->pkt->async_cb;
 		if (cb->cb)
 			cb->cb(data);
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index 2f7d9a37d611..44365aab043c 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -68,6 +68,7 @@ enum cmdq_code {
 struct cmdq_cb_data {
 	int			sta;
 	void			*data;
+	struct cmdq_pkt		*pkt;
 };
 
 typedef void (*cmdq_async_flush_cb)(struct cmdq_cb_data data);
-- 
2.17.1


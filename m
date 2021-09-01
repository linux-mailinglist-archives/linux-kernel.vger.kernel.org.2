Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F14B3FD3F6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242385AbhIAGsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:48:06 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:39446 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242386AbhIAGsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:48:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Umr7Ulw_1630478825;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Umr7Ulw_1630478825)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Sep 2021 14:47:06 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] block/mq-deadline: Fix unused-function compilation warning
Date:   Wed,  1 Sep 2021 14:47:05 +0800
Message-Id: <20210901064705.55071-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_BLK_DEBUG_FS is not defined, the following compilation warning
will be reported:

  block/mq-deadline.c:274:12: warning: ‘dd_queued’ defined but not used [-Wunused-function]
   static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)

Move the function dd_queued() to the scope of this config and mark it
inline.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 block/mq-deadline.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3c3693c34f06..084314ee878d 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -270,12 +270,6 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	deadline_remove_request(rq->q, per_prio, rq);
 }
 
-/* Number of requests queued for a given priority level. */
-static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
-{
-	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
-}
-
 /*
  * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
  * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
@@ -953,6 +947,12 @@ static int dd_async_depth_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+/* Number of requests queued for a given priority level. */
+static inline u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
+{
+	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
+}
+
 static int dd_queued_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
-- 
2.19.1.3.ge56e4f7


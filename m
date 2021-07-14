Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164903C81CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbhGNJkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:40:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11413 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238860AbhGNJkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:40:08 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GPslB5QtfzccyK;
        Wed, 14 Jul 2021 17:33:58 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 17:37:16 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 14
 Jul 2021 17:37:15 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 2/3] block, bfq: add support to record request size information
Date:   Wed, 14 Jul 2021 17:45:28 +0800
Message-ID: <20210714094529.758808-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714094529.758808-1-yukuai3@huawei.com>
References: <20210714094529.758808-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bfq keep dispatching requests with same size, the following
information are stored if CONFIG_BFQ_GROUP_IOSCHED is enabled:

1) the size
2) the count of requests
3) when the first request was dispatched

These will be used in later patch to support concurrent sync
io in such situation.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 15 +++++++++++++++
 block/bfq-iosched.h | 16 ++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 2768a4c1cc45..e5a1093ec30a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4920,6 +4920,20 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
 		bfq_tot_busy_queues(bfqd) > 0;
 }
 
+static void bfq_update_dispatch_size_info(struct bfq_data *bfqd,
+					  unsigned int size)
+{
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	if (bfqd->dispatch_size == size) {
+		bfqd->dispatch_count++;
+	} else {
+		bfqd->dispatch_size = size;
+		bfqd->dispatch_count = 1;
+		bfqd->dispatch_time = jiffies;
+	}
+#endif
+}
+
 static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
@@ -5003,6 +5017,7 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 		bfqd->rq_in_driver++;
 start_rq:
 		rq->rq_flags |= RQF_STARTED;
+		bfq_update_dispatch_size_info(bfqd, blk_rq_bytes(rq));
 	}
 exit:
 	return rq;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 99c2a3cb081e..4b9d95447a50 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -768,6 +768,22 @@ struct bfq_data {
 	 * function)
 	 */
 	unsigned int word_depths[2][2];
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	/* the size of last dispatched request */
+	unsigned int dispatch_size;
+	/*
+	 * If bfq keep dispatching requests with same size, this store the
+	 * count of requests. We use unsigned long here, so we don't care
+	 * about overflow.
+	 */
+	unsigned long dispatch_count;
+	/*
+	 * If bfq keep dispatching requests with same size, this store the
+	 * time when the first request was dispatched.
+	 */
+	unsigned long dispatch_time;
+#endif
 };
 
 enum bfqq_state_flags {
-- 
2.31.1


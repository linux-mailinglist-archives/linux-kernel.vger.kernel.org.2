Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FECB3DC3CE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 08:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbhGaGK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 02:10:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7908 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbhGaGKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 02:10:51 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GcDLR3DbFz80yh;
        Sat, 31 Jul 2021 14:06:55 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 31 Jul 2021 14:10:43 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 31
 Jul 2021 14:10:42 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] blk-mq: clear active_queues before clearing BLK_MQ_F_TAG_QUEUE_SHARED
Date:   Sat, 31 Jul 2021 14:21:30 +0800
Message-ID: <20210731062130.1533893-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We run a test that delete and recover devcies frequently(two devices on
the same host), and we found that 'active_queues' is super big after a
period of time.

If device a and device b share a tag set, and a is deleted, then
blk_mq_exit_queue() will clear BLK_MQ_F_TAG_QUEUE_SHARED because there
is only one queue that are using the tag set. However, if b is still
active, the active_queues of b might never be cleared even if b is
deleted.

Thus clear active_queues before BLK_MQ_F_TAG_QUEUE_SHARED is cleared.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c4ac51e54eb..2fe396385a4a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2994,10 +2994,12 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 	int i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		if (shared)
+		if (shared) {
 			hctx->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
-		else
+		} else {
+			blk_mq_tag_idle(hctx);
 			hctx->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
+		}
 	}
 }
 
-- 
2.31.1


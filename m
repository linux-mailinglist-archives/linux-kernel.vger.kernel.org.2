Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CE240C12E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhIOIHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:07:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19980 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbhIOIHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:07:07 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H8Xjc0L9szYpbq;
        Wed, 15 Sep 2021 16:01:40 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 16:05:46 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 15
 Sep 2021 16:05:45 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>,
        <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v6 2/6] nbd: make sure request completion won't concurrent
Date:   Wed, 15 Sep 2021 16:15:33 +0800
Message-ID: <20210915081537.1684327-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915081537.1684327-1-yukuai3@huawei.com>
References: <20210915081537.1684327-1-yukuai3@huawei.com>
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

commit cddce0116058 ("nbd: Aovid double completion of a request")
try to fix that nbd_clear_que() and recv_work() can complete a
request concurrently. However, the problem still exists:

t1                    t2                     t3

nbd_disconnect_and_put
 flush_workqueue
                      recv_work
                       blk_mq_complete_request
                        blk_mq_complete_request_remote -> this is true
                         WRITE_ONCE(rq->state, MQ_RQ_COMPLETE)
                          blk_mq_raise_softirq
                                             blk_done_softirq
                                              blk_complete_reqs
                                               nbd_complete_rq
                                                blk_mq_end_request
                                                 blk_mq_free_request
                                                  WRITE_ONCE(rq->state, MQ_RQ_IDLE)
  nbd_clear_que
   blk_mq_tagset_busy_iter
    nbd_clear_req
                                                   __blk_mq_free_request
                                                    blk_mq_put_tag
     blk_mq_complete_request -> complete again

There are three places where request can be completed in nbd:
recv_work(), nbd_clear_que() and nbd_xmit_timeout(). Since they
all hold cmd->lock before completing the request, it's easy to
avoid the problem by setting and checking a cmd flag.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 23ded569e8d3..614c6ab2b8fe 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -406,7 +406,11 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	if (!mutex_trylock(&cmd->lock))
 		return BLK_EH_RESET_TIMER;
 
-	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
+	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
+		mutex_unlock(&cmd->lock);
+		return BLK_EH_DONE;
+	}
+
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		cmd->status = BLK_STS_TIMEOUT;
 		mutex_unlock(&cmd->lock);
@@ -841,7 +845,10 @@ static bool nbd_clear_req(struct request *req, void *data, bool reserved)
 		return true;
 
 	mutex_lock(&cmd->lock);
-	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
+	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
+		mutex_unlock(&cmd->lock);
+		return true;
+	}
 	cmd->status = BLK_STS_IOERR;
 	mutex_unlock(&cmd->lock);
 
-- 
2.31.1


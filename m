Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725023F5FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhHXODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:03:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8923 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbhHXOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:02:59 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gv9fy1bY4z8tlH;
        Tue, 24 Aug 2021 21:58:02 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 24 Aug 2021 22:02:10 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 24
 Aug 2021 22:02:09 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>,
        <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 5/5] nbd: don't start request if nbd_queue_rq() failed
Date:   Tue, 24 Aug 2021 22:12:27 +0800
Message-ID: <20210824141227.808340-6-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824141227.808340-1-yukuai3@huawei.com>
References: <20210824141227.808340-1-yukuai3@huawei.com>
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

Currently, blk_mq_end_request() will be called if nbd_queue_rq()
failed, thus start request in such situation is useless.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4d5098d01758..c22dbb9b5065 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -944,7 +944,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Socks array is empty\n");
-		blk_mq_start_request(req);
 		return -EINVAL;
 	}
 	config = nbd->config;
@@ -953,7 +952,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on invalid socket\n");
 		nbd_config_put(nbd);
-		blk_mq_start_request(req);
 		return -EINVAL;
 	}
 	cmd->status = BLK_STS_OK;
@@ -977,7 +975,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 			 */
 			sock_shutdown(nbd);
 			nbd_config_put(nbd);
-			blk_mq_start_request(req);
 			return -EIO;
 		}
 		goto again;
-- 
2.31.1


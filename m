Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8A3A7AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhFOJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:32:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6505 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhFOJcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:32:16 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G42yq3M9tzZhSq;
        Tue, 15 Jun 2021 17:27:15 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 17:30:06 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 17:30:06 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2] mtd: mtd_blkdevs: Initialize rq.limits.discard_granularity
Date:   Tue, 15 Jun 2021 17:39:05 +0800
Message-ID: <20210615093905.3473709-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b35fd7422c2f8("block: check queue's limits.discard_granularity
in __blkdev_issue_discard()") checks rq.limits.discard_granularity in
__blkdev_issue_discard(), we may get following warnings on formatted ftl:

  WARNING: CPU: 2 PID: 7313 at block/blk-lib.c:51
  __blkdev_issue_discard+0x2a7/0x390

Reproducer:
  1. ftl_format /dev/mtd0
  2. modprobe ftl
  3. mkfs.vfat /dev/ftla
  4. mount -odiscard /dev/ftla temp
  5. dd if=/dev/zero of=temp/tst bs=1M count=10 oflag=direct
  6. dd if=/dev/zero of=temp/tst bs=1M count=10 oflag=direct

Fix it by initializing rq.limits.discard_granularity if device supports
discard operation.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/mtd_blkdevs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 01bf234e7f3a..6eac1c9c164d 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -413,6 +413,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	if (tr->discard) {
 		blk_queue_flag_set(QUEUE_FLAG_DISCARD, new->rq);
 		blk_queue_max_discard_sectors(new->rq, UINT_MAX);
+		new->rq->limits.discard_granularity = tr->blksize;
 	}
 
 	gd->queue = new->rq;
-- 
2.31.1


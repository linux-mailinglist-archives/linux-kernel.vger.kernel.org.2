Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1D53A57F4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhFMLXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 07:23:16 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6347 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhFMLXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 07:23:16 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G2sVg6Mmtz6xBX;
        Sun, 13 Jun 2021 19:17:15 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 13 Jun 2021 19:21:11 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 13
 Jun 2021 19:21:11 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] mtd: ftl: Initialize rq.limits.discard_granularity
Date:   Sun, 13 Jun 2021 19:29:42 +0800
Message-ID: <20210613112942.2329192-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b35fd7422c2f8("block: check queue's limits.discard_granularity
in __blkdev_issue_discard()") checks rq.limits.discard_granularity in
__blkdev_issue_discard(), we may get following warnings while formating ftl:

  WARNING: CPU: 2 PID: 7313 at block/blk-lib.c:51
  __blkdev_issue_discard+0x2a7/0x390

Reproducer:
  1. ftl_format /dev/mtd0
  2. modprobe ftl
  3. mkfs.vfat /dev/ftla
  4. mount -odiscard /dev/ftla temp
  5. dd if=/dev/zero of=temp/tst bs=1M count=10 oflag=direct
  6. dd if=/dev/zero of=temp/tst bs=1M count=10 oflag=direct

Fix it by initializing rq.limits.discard_granularity in ftl_add_mtd().

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ftl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
index 9b33c082179d..fb31e33b8a77 100644
--- a/drivers/mtd/ftl.c
+++ b/drivers/mtd/ftl.c
@@ -70,6 +70,7 @@
 #include <linux/hdreg.h>
 #include <linux/vmalloc.h>
 #include <linux/blkpg.h>
+#include <linux/blkdev.h>
 #include <linux/uaccess.h>
 
 #include <linux/mtd/ftl.h>
@@ -1029,8 +1030,11 @@ static void ftl_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 
 		partition->mbd.tr = tr;
 		partition->mbd.devnum = -1;
-		if (!add_mtd_blktrans_dev((void *)partition))
+		if (!add_mtd_blktrans_dev((void *)partition)) {
+			partition->mbd.rq->limits.discard_granularity =
+								tr->blksize;
 			return;
+		}
 	}
 
 	kfree(partition);
-- 
2.31.1


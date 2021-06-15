Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7979B3A79C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFOJGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:06:31 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6373 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFOJGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:06:25 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G42Mn2QStz63VN;
        Tue, 15 Jun 2021 17:00:21 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 17:04:07 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 17:04:06 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <alexander.sverdlin@nokia.com>, <computersforpeace@gmail.com>,
        <maximlevitsky@gmail.com>, <David.Woodhouse@intel.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2] mtd: mtd_blkdevs: Get|Put mtd_device in add|del_mtd_blktrans
Date:   Tue, 15 Jun 2021 17:13:02 +0800
Message-ID: <20210615091302.3428611-1-chengzhihao1@huawei.com>
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

There are two reasons to move mtd_device get|put operations into mtd
blktrans adding/deleting:

* Solve an AA-deadlock problem while formating mtd device to generate
  a ftl device.
  [<0>] blktrans_open+0x47/0x340            LOCK(mtd_table_mutex)
  [<0>] __blkdev_get+0x5b/0x3e0
  [<0>] blkdev_get_by_dev+0x18f/0x370
  [<0>] __device_add_disk+0x2db/0x700
  [<0>] device_add_disk+0x17/0x20
  [<0>] add_mtd_blktrans_dev+0x39e/0x6d0
  [<0>] ftl_add_mtd+0x792/0x908 [ftl]
  [<0>] register_mtd_blktrans+0xfb/0x170    LOCK(mtd_table_mutex)
  [<0>] ftl_tr_init+0x18/0x1000 [ftl]
  [<0>] do_one_initcall+0x71/0x330
  [<0>] do_init_module+0xa6/0x350

* Hold refcount of mtd device's module if mtd blktrans still exists.
  Module                  Size  Used by
  mtdblock               20480  0
  mtdram                 20480  0
  $ lsblk
  mtdblock0  31:0    0  64M  0 disk
  $ rmmod mtdram
  # mtd device is removed unexpectedly when mtdblock exists!
  $ lsmod
  Module                  Size  Used by
  mtdblock               20480  0
  $ lsblk
  // No mtdblock found !

Patched:
  Module                  Size  Used by
  mtdblock               20480  0
  mtdram                 20480  1
  $ lsblk
  mtdblock0  31:0    0  64M  0 disk
  $ rmmod mtdram        # EBUSY, and /dev/mtdblock0 still exists

, which works just like ubi/mtd:
  Module                  Size  Used by
  ubi                   380928  0
  mtdram                 20480  1

Fixes: 073db4a51ee43c ("mtd: fix: avoid race condition when ...")
Fixes: 008c751ec78587 ("mtd: allow to unload the mtdtrans module if ...")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/mtd_blkdevs.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index fb8e12d590a1..19a2870a097a 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -209,7 +209,6 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 	if (!dev)
 		return -ERESTARTSYS; /* FIXME: busy loop! -arnd*/
 
-	mutex_lock(&mtd_table_mutex);
 	mutex_lock(&dev->lock);
 
 	if (dev->open)
@@ -227,26 +226,18 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 			goto error_put;
 	}
 
-	ret = __get_mtd_device(dev->mtd);
-	if (ret)
-		goto error_release;
 	dev->file_mode = mode;
 
 unlock:
 	dev->open++;
 	mutex_unlock(&dev->lock);
-	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 	return ret;
 
-error_release:
-	if (dev->tr->release)
-		dev->tr->release(dev);
 error_put:
 	module_put(dev->tr->owner);
 	kref_put(&dev->ref, blktrans_dev_release);
 	mutex_unlock(&dev->lock);
-	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 	return ret;
 }
@@ -258,7 +249,6 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 	if (!dev)
 		return;
 
-	mutex_lock(&mtd_table_mutex);
 	mutex_lock(&dev->lock);
 
 	if (--dev->open)
@@ -267,14 +257,10 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 	kref_put(&dev->ref, blktrans_dev_release);
 	module_put(dev->tr->owner);
 
-	if (dev->mtd) {
-		if (dev->tr->release)
-			dev->tr->release(dev);
-		__put_mtd_device(dev->mtd);
-	}
+	if (dev->mtd && dev->tr->release)
+		dev->tr->release(dev);
 unlock:
 	mutex_unlock(&dev->lock);
-	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 }
 
@@ -425,6 +411,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	}
 
 	gd->queue = new->rq;
+	__get_mtd_device(new->mtd);
 
 	if (new->readonly)
 		set_disk_ro(gd, 1);
@@ -474,15 +461,15 @@ int del_mtd_blktrans_dev(struct mtd_blktrans_dev *old)
 	blk_mq_unquiesce_queue(old->rq);
 	blk_mq_unfreeze_queue(old->rq);
 
-	/* If the device is currently open, tell trans driver to close it,
-		then put mtd device, and don't touch it again */
+	/* If the device is currently open, tell trans driver to close it */
 	mutex_lock(&old->lock);
 	if (old->open) {
 		if (old->tr->release)
 			old->tr->release(old);
-		__put_mtd_device(old->mtd);
 	}
+	__put_mtd_device(old->mtd);
 
+	/* At that point, we don't touch the mtd anymore */
 	old->mtd = NULL;
 
 	mutex_unlock(&old->lock);
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615C83A57FC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 13:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhFMLYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 07:24:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4431 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhFMLYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 07:24:17 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G2sXq2Yn0z6wKG;
        Sun, 13 Jun 2021 19:19:07 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 13 Jun 2021 19:22:14 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 13
 Jun 2021 19:22:13 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 6/6] Revert "mtd: allow to unload the mtdtrans module if its block devices aren't open"
Date:   Sun, 13 Jun 2021 19:30:35 +0800
Message-ID: <20210613113035.2329421-7-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210613113035.2329421-1-chengzhihao1@huawei.com>
References: <20210613113035.2329421-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 008c751ec78587dd9b48bb62d4b10d616554fea2.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/mtd_blkdevs.c | 49 ++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index e8a77f10ae24..4d386617fd8a 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -205,7 +205,7 @@ static blk_status_t mtd_queue_rq(struct blk_mq_hw_ctx *hctx,
 static int blktrans_open(struct block_device *bdev, fmode_t mode)
 {
 	struct mtd_blktrans_dev *dev = blktrans_dev_get(bdev->bd_disk);
-	int ret = 0;
+	int ret;
 
 	if (!dev)
 		return -ERESTARTSYS; /* FIXME: busy loop! -arnd*/
@@ -213,17 +213,17 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 	mutex_lock(&mtd_blkdevs_mutex);
 	mutex_lock(&dev->lock);
 
-	if (dev->open++)
+	if (!dev->mtd) {
+		ret = -ENXIO;
 		goto unlock;
-
-	kref_get(&dev->ref);
-	__module_get(dev->tr->owner);
-
-	if (dev->mtd) {
-		ret = dev->tr->open ? dev->tr->open(dev) : 0;
-		__get_mtd_device(dev->mtd);
 	}
 
+	ret = !dev->open++ && dev->tr->open ? dev->tr->open(dev) : 0;
+	/* Take another reference on the device so it won't go away till
+	 * last release */
+	if (!ret)
+		kref_get(&dev->ref);
+
 	dev->file_mode = mode;
 
 unlock:
@@ -243,17 +243,14 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 	mutex_lock(&mtd_blkdevs_mutex);
 	mutex_lock(&dev->lock);
 
-	if (--dev->open)
-		goto unlock;
-
+	/* Release one reference, we sure its not the last one here*/
 	kref_put(&dev->ref, blktrans_dev_release);
-	module_put(dev->tr->owner);
 
-	if (dev->mtd) {
-		if (dev->tr->release)
-			dev->tr->release(dev);
-		__put_mtd_device(dev->mtd);
-	}
+	if (!dev->mtd)
+		goto unlock;
+
+	if (!--dev->open && dev->tr->release)
+		dev->tr->release(dev);
 unlock:
 	mutex_unlock(&dev->lock);
 	blktrans_dev_put(dev);
@@ -408,6 +405,9 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 
 	gd->queue = new->rq;
 
+	__get_mtd_device(new->mtd);
+	__module_get(tr->owner);
+
 	if (new->readonly)
 		set_disk_ro(gd, 1);
 
@@ -456,15 +456,16 @@ int del_mtd_blktrans_dev(struct mtd_blktrans_dev *old)
 	blk_mq_unquiesce_queue(old->rq);
 	blk_mq_unfreeze_queue(old->rq);
 
-	/* If the device is currently open, tell trans driver to close it,
-		then put mtd device, and don't touch it again */
+	/* Ask trans driver for release to the mtd device */
 	mutex_lock(&old->lock);
-	if (old->open) {
-		if (old->tr->release)
-			old->tr->release(old);
-		__put_mtd_device(old->mtd);
+	if (old->open && old->tr->release) {
+		old->tr->release(old);
+		old->open = 0;
 	}
+	__put_mtd_device(old->mtd);
+	module_put(old->tr->owner);
 
+	/* At that point, we don't touch the mtd anymore */
 	old->mtd = NULL;
 
 	mutex_unlock(&old->lock);
-- 
2.31.1


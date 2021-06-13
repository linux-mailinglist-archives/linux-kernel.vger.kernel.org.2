Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D5E3A57F8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhFMLYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 07:24:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4059 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhFMLYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 07:24:15 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G2sVg2wSrzXfLW;
        Sun, 13 Jun 2021 19:17:15 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 13 Jun 2021 19:22:12 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 13
 Jun 2021 19:22:12 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 2/6] Revert "mtd: fix: avoid race condition when accessing mtd->usecount"
Date:   Sun, 13 Jun 2021 19:30:31 +0800
Message-ID: <20210613113035.2329421-3-chengzhihao1@huawei.com>
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

This reverts commit 073db4a51ee43ccb827f54a4261c0583b028d5ab.
---
 drivers/mtd/mtd_blkdevs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 16ccce3e7fdb..00b13f71ccf3 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -210,7 +210,6 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 		return -ERESTARTSYS; /* FIXME: busy loop! -arnd*/
 
 	mutex_lock(&dev->lock);
-	mutex_lock(&mtd_table_mutex);
 
 	if (dev->open)
 		goto unlock;
@@ -234,7 +233,6 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 
 unlock:
 	dev->open++;
-	mutex_unlock(&mtd_table_mutex);
 	mutex_unlock(&dev->lock);
 	blktrans_dev_put(dev);
 	return ret;
@@ -245,7 +243,6 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 error_put:
 	module_put(dev->tr->owner);
 	kref_put(&dev->ref, blktrans_dev_release);
-	mutex_unlock(&mtd_table_mutex);
 	mutex_unlock(&dev->lock);
 	blktrans_dev_put(dev);
 	return ret;
@@ -259,7 +256,6 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 		return;
 
 	mutex_lock(&dev->lock);
-	mutex_lock(&mtd_table_mutex);
 
 	if (--dev->open)
 		goto unlock;
@@ -273,7 +269,6 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 		__put_mtd_device(dev->mtd);
 	}
 unlock:
-	mutex_unlock(&mtd_table_mutex);
 	mutex_unlock(&dev->lock);
 	blktrans_dev_put(dev);
 }
-- 
2.31.1


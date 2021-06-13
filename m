Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25943A57FA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhFMLY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 07:24:29 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:6299 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhFMLYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 07:24:17 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G2sVh3GsKz1BLsp;
        Sun, 13 Jun 2021 19:17:16 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 13 Jun 2021 19:22:13 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 13
 Jun 2021 19:22:13 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 4/6] Revert "mtd: mtd_blkdevs: fix error path in blktrans_open"
Date:   Sun, 13 Jun 2021 19:30:33 +0800
Message-ID: <20210613113035.2329421-5-chengzhihao1@huawei.com>
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

This reverts commit 94735ec4044a6d318b83ad3c5794e931ed168d10.
---
 drivers/mtd/mtd_blkdevs.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 100a3c96760c..41dd3b955136 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -217,34 +217,17 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 	kref_get(&dev->ref);
 	__module_get(dev->tr->owner);
 
-	if (!dev->mtd)
-		goto unlock;
-
-	if (dev->tr->open) {
-		ret = dev->tr->open(dev);
-		if (ret)
-			goto error_put;
+	if (dev->mtd) {
+		ret = dev->tr->open ? dev->tr->open(dev) : 0;
+		__get_mtd_device(dev->mtd);
 	}
 
-	ret = __get_mtd_device(dev->mtd);
-	if (ret)
-		goto error_release;
 	dev->file_mode = mode;
 
 unlock:
 	mutex_unlock(&dev->lock);
 	blktrans_dev_put(dev);
 	return ret;
-
-error_release:
-	if (dev->tr->release)
-		dev->tr->release(dev);
-error_put:
-	module_put(dev->tr->owner);
-	kref_put(&dev->ref, blktrans_dev_release);
-	mutex_unlock(&dev->lock);
-	blktrans_dev_put(dev);
-	return ret;
 }
 
 static void blktrans_release(struct gendisk *disk, fmode_t mode)
-- 
2.31.1


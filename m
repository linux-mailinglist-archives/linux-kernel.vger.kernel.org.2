Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1863C3A57FB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 13:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhFMLYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 07:24:30 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9111 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhFMLYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 07:24:17 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G2sY50jW8zZcxP;
        Sun, 13 Jun 2021 19:19:21 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
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
Subject: [PATCH 5/6] Revert "mtd: Remove redundant mutex from mtd_blkdevs.c"
Date:   Sun, 13 Jun 2021 19:30:34 +0800
Message-ID: <20210613113035.2329421-6-chengzhihao1@huawei.com>
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

This reverts commit 8cc9de3ebdf654601db51a516267dff89c49acc3.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/mtd_blkdevs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 41dd3b955136..e8a77f10ae24 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -22,6 +22,7 @@
 
 #include "mtdcore.h"
 
+static DEFINE_MUTEX(mtd_blkdevs_mutex);
 static LIST_HEAD(blktrans_majors);
 static DEFINE_MUTEX(blktrans_ref_mutex);
 
@@ -209,6 +210,7 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 	if (!dev)
 		return -ERESTARTSYS; /* FIXME: busy loop! -arnd*/
 
+	mutex_lock(&mtd_blkdevs_mutex);
 	mutex_lock(&dev->lock);
 
 	if (dev->open++)
@@ -227,6 +229,7 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 unlock:
 	mutex_unlock(&dev->lock);
 	blktrans_dev_put(dev);
+	mutex_unlock(&mtd_blkdevs_mutex);
 	return ret;
 }
 
@@ -237,6 +240,7 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 	if (!dev)
 		return;
 
+	mutex_lock(&mtd_blkdevs_mutex);
 	mutex_lock(&dev->lock);
 
 	if (--dev->open)
@@ -253,6 +257,7 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 unlock:
 	mutex_unlock(&dev->lock);
 	blktrans_dev_put(dev);
+	mutex_unlock(&mtd_blkdevs_mutex);
 }
 
 static int blktrans_getgeo(struct block_device *bdev, struct hd_geometry *geo)
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798AC3A57F9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhFMLY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 07:24:27 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4060 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhFMLYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 07:24:15 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G2sVg5vjlzXfLX;
        Sun, 13 Jun 2021 19:17:15 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 13 Jun 2021 19:22:13 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 13
 Jun 2021 19:22:12 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 3/6] Revert "mtd: mtd_blkdevs: don't increase 'open' count on error path"
Date:   Sun, 13 Jun 2021 19:30:32 +0800
Message-ID: <20210613113035.2329421-4-chengzhihao1@huawei.com>
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

This reverts commit 342ff28f5a2e5aa3236617bd2bddf6c749677ef2.
---
 drivers/mtd/mtd_blkdevs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 00b13f71ccf3..100a3c96760c 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -211,7 +211,7 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 
 	mutex_lock(&dev->lock);
 
-	if (dev->open)
+	if (dev->open++)
 		goto unlock;
 
 	kref_get(&dev->ref);
@@ -232,7 +232,6 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 	dev->file_mode = mode;
 
 unlock:
-	dev->open++;
 	mutex_unlock(&dev->lock);
 	blktrans_dev_put(dev);
 	return ret;
-- 
2.31.1


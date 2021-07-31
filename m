Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920BE3DC2AD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 04:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbhGaCWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 22:22:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16030 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbhGaCWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 22:22:04 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gc7Gq1D3GzZqqc;
        Sat, 31 Jul 2021 10:18:27 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 31 Jul 2021 10:21:57 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 31
 Jul 2021 10:21:56 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <bbrezillon@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 2/2] mtd: mtdconcat: Remove concat_{read|write}_oob
Date:   Sat, 31 Jul 2021 10:32:43 +0800
Message-ID: <20210731023243.3977104-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731023243.3977104-1-chengzhihao1@huawei.com>
References: <20210731023243.3977104-1-chengzhihao1@huawei.com>
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

Since 2431c4f5b46c3("mtd: Implement mtd_{read,write}() as wrappers
around mtd_{read,write}_oob()") don't allow _write|_read and
_write_oob|_read_oob existing at the same time. We should stop these
two callback functions assigning, otherwise following warning occurs
while making concatenated device:

  WARNING: CPU: 2 PID: 6728 at drivers/mtd/mtdcore.c:595
  add_mtd_device+0x7f/0x7b0

Fixes: 2431c4f5b46c3("mtd: Implement mtd_{read,write}() around ...")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/mtdconcat.c | 113 +---------------------------------------
 1 file changed, 1 insertion(+), 112 deletions(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index ea130eeb54d5..98d1c79cf51d 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -256,110 +256,6 @@ concat_writev(struct mtd_info *mtd, const struct kvec *vecs,
 	return err;
 }
 
-static int
-concat_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
-{
-	struct mtd_concat *concat = CONCAT(mtd);
-	struct mtd_oob_ops devops = *ops;
-	int i, err, ret = 0;
-
-	ops->retlen = ops->oobretlen = 0;
-
-	for (i = 0; i < concat->num_subdev; i++) {
-		struct mtd_info *subdev = concat->subdev[i];
-
-		if (from >= subdev->size) {
-			from -= subdev->size;
-			continue;
-		}
-
-		/* partial read ? */
-		if (from + devops.len > subdev->size)
-			devops.len = subdev->size - from;
-
-		err = mtd_read_oob(subdev, from, &devops);
-		ops->retlen += devops.retlen;
-		ops->oobretlen += devops.oobretlen;
-
-		/* Save information about bitflips! */
-		if (unlikely(err)) {
-			if (mtd_is_eccerr(err)) {
-				mtd->ecc_stats.failed++;
-				ret = err;
-			} else if (mtd_is_bitflip(err)) {
-				mtd->ecc_stats.corrected++;
-				/* Do not overwrite -EBADMSG !! */
-				if (!ret)
-					ret = err;
-			} else
-				return err;
-		}
-
-		if (devops.datbuf) {
-			devops.len = ops->len - ops->retlen;
-			if (!devops.len)
-				return ret;
-			devops.datbuf += devops.retlen;
-		}
-		if (devops.oobbuf) {
-			devops.ooblen = ops->ooblen - ops->oobretlen;
-			if (!devops.ooblen)
-				return ret;
-			devops.oobbuf += ops->oobretlen;
-		}
-
-		from = 0;
-	}
-	return -EINVAL;
-}
-
-static int
-concat_write_oob(struct mtd_info *mtd, loff_t to, struct mtd_oob_ops *ops)
-{
-	struct mtd_concat *concat = CONCAT(mtd);
-	struct mtd_oob_ops devops = *ops;
-	int i, err;
-
-	if (!(mtd->flags & MTD_WRITEABLE))
-		return -EROFS;
-
-	ops->retlen = ops->oobretlen = 0;
-
-	for (i = 0; i < concat->num_subdev; i++) {
-		struct mtd_info *subdev = concat->subdev[i];
-
-		if (to >= subdev->size) {
-			to -= subdev->size;
-			continue;
-		}
-
-		/* partial write ? */
-		if (to + devops.len > subdev->size)
-			devops.len = subdev->size - to;
-
-		err = mtd_write_oob(subdev, to, &devops);
-		ops->retlen += devops.retlen;
-		ops->oobretlen += devops.oobretlen;
-		if (err)
-			return err;
-
-		if (devops.datbuf) {
-			devops.len = ops->len - ops->retlen;
-			if (!devops.len)
-				return 0;
-			devops.datbuf += devops.retlen;
-		}
-		if (devops.oobbuf) {
-			devops.ooblen = ops->ooblen - ops->oobretlen;
-			if (!devops.ooblen)
-				return 0;
-			devops.oobbuf += devops.oobretlen;
-		}
-		to = 0;
-	}
-	return -EINVAL;
-}
-
 static int concat_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
 	struct mtd_concat *concat = CONCAT(mtd);
@@ -684,10 +580,6 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 	subdev_master = mtd_get_master(subdev[0]);
 	if (subdev_master->_writev)
 		concat->mtd._writev = concat_writev;
-	if (subdev_master->_read_oob)
-		concat->mtd._read_oob = concat_read_oob;
-	if (subdev_master->_write_oob)
-		concat->mtd._write_oob = concat_write_oob;
 	if (subdev_master->_block_isbad)
 		concat->mtd._block_isbad = concat_block_isbad;
 	if (subdev_master->_block_markbad)
@@ -724,15 +616,12 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 				    subdev[i]->flags & MTD_WRITEABLE;
 		}
 
-		subdev_master = mtd_get_master(subdev[i]);
 		concat->mtd.size += subdev[i]->size;
 		concat->mtd.ecc_stats.badblocks +=
 			subdev[i]->ecc_stats.badblocks;
 		if (concat->mtd.writesize   !=  subdev[i]->writesize ||
 		    concat->mtd.subpage_sft != subdev[i]->subpage_sft ||
-		    concat->mtd.oobsize    !=  subdev[i]->oobsize ||
-		    !concat->mtd._read_oob  != !subdev_master->_read_oob ||
-		    !concat->mtd._write_oob != !subdev_master->_write_oob) {
+		    concat->mtd.oobsize    !=  subdev[i]->oobsize) {
 			kfree(concat);
 			printk("Incompatible OOB or ECC data on \"%s\"\n",
 			       subdev[i]->name);
-- 
2.31.1


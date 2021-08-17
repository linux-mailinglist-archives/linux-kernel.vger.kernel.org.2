Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8173EEBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbhHQLjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:39:04 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8432 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbhHQLjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:39:02 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GpppV2D1Kz88KT;
        Tue, 17 Aug 2021 19:34:26 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 19:38:28 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 17
 Aug 2021 19:38:27 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <bbrezillon@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 2/2] mtd: mtdconcat: Check _read,_write callbacks existence before assignment
Date:   Tue, 17 Aug 2021 19:48:57 +0800
Message-ID: <20210817114857.2784825-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210817114857.2784825-1-chengzhihao1@huawei.com>
References: <20210817114857.2784825-1-chengzhihao1@huawei.com>
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

Since 2431c4f5b46c3 ("mtd: Implement mtd_{read,write}() as wrappers
around mtd_{read,write}_oob()") don't allow _write|_read and
_write_oob|_read_oob existing at the same time, we should check the
existence of callbacks "_read and _write" from subdev's master device
(We can trust master device since it has been registered) before
assigning, otherwise following warning occurs while making
concatenated device:

  WARNING: CPU: 2 PID: 6728 at drivers/mtd/mtdcore.c:595
  add_mtd_device+0x7f/0x7b0

Fixes: 2431c4f5b46c3 ("mtd: Implement mtd_{read,write}() around ...")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/mtdconcat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index af51eee6b5e8..f685a581df48 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -694,6 +694,10 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 		concat->mtd._block_markbad = concat_block_markbad;
 	if (subdev_master->_panic_write)
 		concat->mtd._panic_write = concat_panic_write;
+	if (subdev_master->_read)
+		concat->mtd._read = concat_read;
+	if (subdev_master->_write)
+		concat->mtd._write = concat_write;
 
 	concat->mtd.ecc_stats.badblocks = subdev[0]->ecc_stats.badblocks;
 
@@ -755,8 +759,6 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 	concat->mtd.name = name;
 
 	concat->mtd._erase = concat_erase;
-	concat->mtd._read = concat_read;
-	concat->mtd._write = concat_write;
 	concat->mtd._sync = concat_sync;
 	concat->mtd._lock = concat_lock;
 	concat->mtd._unlock = concat_unlock;
-- 
2.31.1


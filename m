Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBD5443AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 02:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhKCBXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 21:23:06 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:27102 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhKCBW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 21:22:59 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HkTRW3tXcz1DJ6t;
        Wed,  3 Nov 2021 09:18:15 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 09:20:17 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 09:20:16 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <patchwork@huawei.com>, <libaokun1@huawei.com>,
        <yukuai3@huawei.com>, <chengzhihao1@huawei.com>
Subject: [PATCH -next V2 2/2] ubi: fix race between volume operations and uif_close
Date:   Wed, 3 Nov 2021 09:32:49 +0800
Message-ID: <20211103013249.498805-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211103013249.498805-1-libaokun1@huawei.com>
References: <20211103013249.498805-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reported a UAF about ubi:
 ==================================================================
 BUG: KASAN: use-after-free in kobject_get+0x44/0xd0
 Write of size 4 at addr ffff8881216e5038 by task ubirmvol/18988
 [...]
 Call Trace:
  kobject_get+0x44/0xd0
  get_device+0x25/0x40
  ubi_open_volume+0x22c/0x490 [ubi]
  ubi_cdev_ioctl+0x300/0x11a0 [ubi]

 Allocated by task 18850:
  ubi_read_volume_table+0x676/0x1330 [ubi]
  ubi_attach+0xd13/0x2460 [ubi]
  ubi_attach_mtd_dev+0xafa/0x17b0 [ubi]
  ctrl_cdev_ioctl+0x248/0x2b0 [ubi]

 Freed by task 18850:
  kfree+0xa2/0x490
  device_release+0x65/0x130
  kobject_put+0x17b/0x330
  device_unregister+0x39/0x90
  uif_close+0x61/0xc0 [ubi]
  ubi_attach_mtd_dev+0xdd2/0x17b0 [ubi]
  ctrl_cdev_ioctl+0x248/0x2b0 [ubi]
 [...]
 ==================================================================

The following race could cause the use-after-free problem:
           cpu1                   cpu2                  cpu3
_______________________|________________________|______________________
ctrl_cdev_ioctl
 ubi_attach_mtd_dev
  uif_init
                           ubi_cdev_ioctl
                            ubi_create_volume
                             cdev_device_add
  ubi_debugfs_init_dev
  //error goto out_uif;
  uif_close
   kill_volumes
                                                    ubi_cdev_ioctl
                                                     ubi_remove_volume
                                                      cdev_device_del
                                                       // first free
    ubi_free_volume
    // double free

To solve this problem, add spin_lock(&ubi->volumes_lock) in uif_close.

Fixes: 801c135ce73d ("UBI: Unsorted Block Images")
Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/mtd/ubi/build.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 708b1b96de01..5a11cdc6e076 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -501,7 +501,9 @@ static int uif_init(struct ubi_device *ubi)
  */
 static void uif_close(struct ubi_device *ubi)
 {
+	spin_lock(&ubi->volumes_lock);
 	kill_volumes(ubi);
+	spin_unlock(&ubi->volumes_lock);
 	cdev_device_del(&ubi->cdev, &ubi->dev);
 	unregister_chrdev_region(ubi->cdev.dev, ubi->vtbl_slots + 1);
 }
-- 
2.31.1


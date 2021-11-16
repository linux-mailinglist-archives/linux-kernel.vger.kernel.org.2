Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E19453068
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhKPL17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:27:59 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26317 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbhKPLZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:25:48 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Htk7Q00s4zbhc5;
        Tue, 16 Nov 2021 19:17:53 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Tue, 16
 Nov 2021 19:22:48 +0800
From:   Zheng Liang <zhengliang6@huawei.com>
To:     <phillip@squashfs.org.uk>, <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <houtao1@huawei.com>, <miaoxie@huawei.com>
Subject: [PATCH] squashfs: provides backing_dev_info in order to disable read-ahead
Date:   Tue, 16 Nov 2021 19:31:41 +0800
Message-ID: <20211116113141.1391026-1-zhengliang6@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the commit c1f6925e1091("mm: put readahead pages in cache earlier")
causes the read performance of squashfs to deteriorate.Through testing,
we find that the performance will be back by closing the readahead of
squashfs. So we want to learn the way of ubifs, provides backing_dev_info
and disable read-ahead.

--------------------------------------------------------------------
We tested the following data by fio.
squashfs image blocksize=128K
test command:
fio --name basic --bs=? --filename="/mnt/test_file" --rw=? --iodepth=1 --ioengine=psync --runtime=200 --time_based

turn on squashfs readahead in 5.10 kernel
bs(k)      read/randread           MB/s
4            randread              271
128          randread              231
1024         randread              246
4            read                  310
128          read                  245
1024         read                  247

turn off squashfs readahead in 5.10 kernel
bs(k)      read/randread           MB/s
4            randread              293
128          randread              330
1024         randread              363
4            read                  338
128          read                  360
1024         read                  365

turn on squashfs readahead and revert the
commit c1f6925e1091("mm: put readahead
pages in cache earlier") in 5.10 kernel
bs(k)      read/randread           MB/s
4           randread               289
128         randread               306
1024        randread               335
4           read                   337
128         read                   336
1024        read                   338

Signed-off-by: Zheng Liang <zhengliang6@huawei.com>
---
 fs/squashfs/super.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index bb44ff4c5cc6..7a4c865fc8e6 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/magic.h>
 #include <linux/xattr.h>
+#include <linux/backing-dev.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
@@ -112,6 +113,24 @@ static const struct squashfs_decompressor *supported_squashfs_filesystem(
 	return decompressor;
 }
 
+static int squashfs_bdi_init(struct super_block *sb)
+{
+	int err;
+	unsigned int major = MAJOR(sb->s_dev);
+	unsigned int minor = MINOR(sb->s_dev);
+
+	bdi_put(sb->s_bdi);
+	sb->s_bdi = &noop_backing_dev_info;
+
+	err = super_setup_bdi_name(sb, "squashfs_%u_%u", major, minor);
+	if (err)
+		return err;
+
+	sb->s_bdi->ra_pages = 0;
+	sb->s_bdi->io_pages = 0;
+
+	return 0;
+}
 
 static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
@@ -127,6 +146,20 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	TRACE("Entered squashfs_fill_superblock\n");
 
+	/*
+	 * squashfs provides 'backing_dev_info' in order to disable read-ahead. For
+	 * squashfs, I/O is not deferred, it is done immediately in readpage,
+	 * which means the user would always have to wait their own I/O. So the effect
+	 * of readahead is very weak for squashfs. squashfs_bdi_init will set 
+	 * sb->s_bdi->ra_pages and sb->s_bdi->io_pages to 0 and close readahead for
+	 * squashfs.
+	 */
+	err = squashfs_bdi_init(sb);
+	if (err) {
+		errorf(fc, "squashfs init bdi failed");
+		return err;
+	}
+
 	sb->s_fs_info = kzalloc(sizeof(*msblk), GFP_KERNEL);
 	if (sb->s_fs_info == NULL) {
 		ERROR("Failed to allocate squashfs_sb_info\n");
-- 
2.31.1


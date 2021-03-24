Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0153347017
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhCXDZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:25:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13673 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbhCXDYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:24:48 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4tnz0bMfznVqr;
        Wed, 24 Mar 2021 11:22:15 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 11:24:37 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to update last i_size if fallocate partially succeeds
Date:   Wed, 24 Mar 2021 11:24:33 +0800
Message-ID: <20210324032433.68886-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of expanding pinned file, map.m_lblk and map.m_len
will update in each round of section allocation, so in error
path, last i_size will be calculated with wrong m_lblk and m_len,
fix it.

Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bd5a77091d23..dc79694e512c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1619,9 +1619,10 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	struct f2fs_map_blocks map = { .m_next_pgofs = NULL,
 			.m_next_extent = NULL, .m_seg_type = NO_CHECK_TYPE,
 			.m_may_create = true };
-	pgoff_t pg_end;
+	pgoff_t pg_start, pg_end;
 	loff_t new_size = i_size_read(inode);
 	loff_t off_end;
+	block_t expanded = 0;
 	int err;
 
 	err = inode_newsize_ok(inode, (len + offset));
@@ -1634,11 +1635,12 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 
 	f2fs_balance_fs(sbi, true);
 
+	pg_start = ((unsigned long long)offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long)offset + len) >> PAGE_SHIFT;
 	off_end = (offset + len) & (PAGE_SIZE - 1);
 
-	map.m_lblk = ((unsigned long long)offset) >> PAGE_SHIFT;
-	map.m_len = pg_end - map.m_lblk;
+	map.m_lblk = pg_start;
+	map.m_len = pg_end - pg_start;
 	if (off_end)
 		map.m_len++;
 
@@ -1648,7 +1650,6 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	if (f2fs_is_pinned_file(inode)) {
 		block_t sec_blks = BLKS_PER_SEC(sbi);
 		block_t sec_len = roundup(map.m_len, sec_blks);
-		block_t done = 0;
 
 		map.m_len = sec_blks;
 next_alloc:
@@ -1656,10 +1657,8 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
 			down_write(&sbi->gc_lock);
 			err = f2fs_gc(sbi, true, false, false, NULL_SEGNO);
-			if (err && err != -ENODATA && err != -EAGAIN) {
-				map.m_len = done;
+			if (err && err != -ENODATA && err != -EAGAIN)
 				goto out_err;
-			}
 		}
 
 		down_write(&sbi->pin_sem);
@@ -1673,24 +1672,25 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 
 		up_write(&sbi->pin_sem);
 
-		done += map.m_len;
+		expanded += map.m_len;
 		sec_len -= map.m_len;
 		map.m_lblk += map.m_len;
 		if (!err && sec_len)
 			goto next_alloc;
 
-		map.m_len = done;
+		map.m_len = expanded;
 	} else {
 		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
+		expanded = map.m_len;
 	}
 out_err:
 	if (err) {
 		pgoff_t last_off;
 
-		if (!map.m_len)
+		if (!expanded)
 			return err;
 
-		last_off = map.m_lblk + map.m_len - 1;
+		last_off = pg_start + expanded - 1;
 
 		/* update new size to the failed position */
 		new_size = (last_off == pg_end) ? offset + len :
-- 
2.29.2


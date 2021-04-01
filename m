Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54537350CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhDADC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:02:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14983 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhDADCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:02:21 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9nwn3k1WzyNpJ;
        Thu,  1 Apr 2021 11:00:09 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 11:02:05 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid GC/mmap race with f2fs_truncate()
Date:   Thu, 1 Apr 2021 11:01:53 +0800
Message-ID: <20210401030153.39913-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It missed to hold i_gc_rwsem and i_map_sem around f2fs_truncate()
in f2fs_file_write_iter() to avoid racing with background GC and
mmap, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index dc79694e512c..f3ca63b55843 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4443,8 +4443,13 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		clear_inode_flag(inode, FI_NO_PREALLOC);
 
 		/* if we couldn't write data, we should deallocate blocks. */
-		if (preallocated && i_size_read(inode) < target_size)
+		if (preallocated && i_size_read(inode) < target_size) {
+			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+			down_write(&F2FS_I(inode)->i_mmap_sem);
 			f2fs_truncate(inode);
+			up_write(&F2FS_I(inode)->i_mmap_sem);
+			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+		}
 
 		if (ret > 0)
 			f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
-- 
2.29.2


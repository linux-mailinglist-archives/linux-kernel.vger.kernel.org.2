Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260F335BBE7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhDLIQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:16:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16899 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbhDLIQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:16:13 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FJhMw1t9czkhbB;
        Mon, 12 Apr 2021 16:14:04 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 16:15:44 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Yi Chen <chenyi77@huawei.com>
Subject: [PATCH v3] f2fs: fix to keep isolation of atomic write
Date:   Mon, 12 Apr 2021 16:15:12 +0800
Message-ID: <20210412081512.103592-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Yi Chen reported, there is a potential race case described as below:

Thread A			Thread B
- f2fs_ioc_start_atomic_write
				- mkwrite
				 - set_page_dirty
				  - f2fs_set_page_private(page, 0)
 - set_inode_flag(FI_ATOMIC_FILE)
				- mkwrite same page
				 - set_page_dirty
				  - f2fs_register_inmem_page
				   - f2fs_set_page_private(ATOMIC_WRITTEN_PAGE)
				     failed due to PagePrivate flag has been set
				   - list_add_tail
				- truncate_inode_pages
				 - f2fs_invalidate_page
				  - clear page private but w/o remove it from
				    inmem_list
				 - set page->mapping to NULL
- f2fs_ioc_commit_atomic_write
 - __f2fs_commit_inmem_pages
   - __revoke_inmem_pages
    - f2fs_put_page panic as page->mapping is NULL

The root cause is we missed to keep isolation of atomic write in the case
of start_atomic_write vs mkwrite, let start_atomic_write helds i_mmap_sem
lock to avoid this issue.

Reported-by: Yi Chen <chenyi77@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- rebase to last dev branch
- update commit message because this patch fixes a different racing issue
of atomic write
 fs/f2fs/file.c    | 3 +++
 fs/f2fs/segment.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d697c8900fa7..6284b2f4a60b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2054,6 +2054,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		goto out;
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 
 	/*
 	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
@@ -2064,6 +2065,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 			  inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret) {
+		up_write(&F2FS_I(inode)->i_mmap_sem);
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		goto out;
 	}
@@ -2077,6 +2079,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	/* add inode in inmem_list first and set atomic_file */
 	set_inode_flag(inode, FI_ATOMIC_FILE);
 	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0cb1ca88d4aa..78c8342f52fd 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -325,6 +325,7 @@ void f2fs_drop_inmem_pages(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	do {
+		down_write(&F2FS_I(inode)->i_mmap_sem);
 		mutex_lock(&fi->inmem_lock);
 		if (list_empty(&fi->inmem_pages)) {
 			fi->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
@@ -339,11 +340,13 @@ void f2fs_drop_inmem_pages(struct inode *inode)
 			spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 
 			mutex_unlock(&fi->inmem_lock);
+			up_write(&F2FS_I(inode)->i_mmap_sem);
 			break;
 		}
 		__revoke_inmem_pages(inode, &fi->inmem_pages,
 						true, false, true);
 		mutex_unlock(&fi->inmem_lock);
+		up_write(&F2FS_I(inode)->i_mmap_sem);
 	} while (1);
 }
 
@@ -468,6 +471,7 @@ int f2fs_commit_inmem_pages(struct inode *inode)
 	f2fs_balance_fs(sbi, true);
 
 	down_write(&fi->i_gc_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 
 	f2fs_lock_op(sbi);
 	set_inode_flag(inode, FI_ATOMIC_COMMIT);
@@ -479,6 +483,8 @@ int f2fs_commit_inmem_pages(struct inode *inode)
 	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
 
 	f2fs_unlock_op(sbi);
+
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 	up_write(&fi->i_gc_rwsem[WRITE]);
 
 	return err;
-- 
2.29.2


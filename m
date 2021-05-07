Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BBC376352
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhEGKMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:12:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17475 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbhEGKMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:12:00 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fc5kH1JVGzkWxx;
        Fri,  7 May 2021 18:08:23 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 18:10:49 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        <syzbot+9d90dad32dd9727ed084@syzkaller.appspotmail.com>
Subject: [PATCH] f2fs: fix to avoid racing on fsync_entry_slab by multi filesystem instances
Date:   Fri, 7 May 2021 18:10:38 +0800
Message-ID: <20210507101038.62085-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As syzbot reported, there is an use-after-free issue during f2fs recovery:

Use-after-free write at 0xffff88823bc16040 (in kfence-#10):
 kmem_cache_destroy+0x1f/0x120 mm/slab_common.c:486
 f2fs_recover_fsync_data+0x75b0/0x8380 fs/f2fs/recovery.c:869
 f2fs_fill_super+0x9393/0xa420 fs/f2fs/super.c:3945
 mount_bdev+0x26c/0x3a0 fs/super.c:1367
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x86/0x270 fs/super.c:1497
 do_new_mount fs/namespace.c:2905 [inline]
 path_mount+0x196f/0x2be0 fs/namespace.c:3235
 do_mount fs/namespace.c:3248 [inline]
 __do_sys_mount fs/namespace.c:3456 [inline]
 __se_sys_mount+0x2f9/0x3b0 fs/namespace.c:3433
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The root cause is multi f2fs filesystem instances can race on accessing
global fsync_entry_slab pointer, result in use-after-free issue of slab
cache, fixes to init/destroy this slab cache only once during module
init/destroy procedure to avoid this issue.

Reported-by: syzbot+9d90dad32dd9727ed084@syzkaller.appspotmail.com
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h     |  2 ++
 fs/f2fs/recovery.c | 23 ++++++++++++++---------
 fs/f2fs/super.c    |  8 +++++++-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b9af386f2b9d..769088dade93 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3661,6 +3661,8 @@ void f2fs_destroy_garbage_collection_cache(void);
  */
 int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only);
 bool f2fs_space_for_roll_forward(struct f2fs_sb_info *sbi);
+int __init f2fs_create_recovery_cache(void);
+void f2fs_destroy_recovery_cache(void);
 
 /*
  * debug.c
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 422146c6d866..4b2f7d1d5bf4 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -788,13 +788,6 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	quota_enabled = f2fs_enable_quota_files(sbi, s_flags & SB_RDONLY);
 #endif
 
-	fsync_entry_slab = f2fs_kmem_cache_create("f2fs_fsync_inode_entry",
-			sizeof(struct fsync_inode_entry));
-	if (!fsync_entry_slab) {
-		err = -ENOMEM;
-		goto out;
-	}
-
 	INIT_LIST_HEAD(&inode_list);
 	INIT_LIST_HEAD(&tmp_inode_list);
 	INIT_LIST_HEAD(&dir_list);
@@ -867,8 +860,6 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 		}
 	}
 
-	kmem_cache_destroy(fsync_entry_slab);
-out:
 #ifdef CONFIG_QUOTA
 	/* Turn quotas off */
 	if (quota_enabled)
@@ -878,3 +869,17 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 
 	return ret ? ret : err;
 }
+
+int __init f2fs_create_recovery_cache(void)
+{
+	fsync_entry_slab = f2fs_kmem_cache_create("f2fs_fsync_inode_entry",
+					sizeof(struct fsync_inode_entry));
+	if (!fsync_entry_slab)
+		return -ENOMEM;
+	return 0;
+}
+
+void f2fs_destroy_recovery_cache(void)
+{
+	kmem_cache_destroy(fsync_entry_slab);
+}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ee59ec15713e..0c9e1129424e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4255,9 +4255,12 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_create_checkpoint_caches();
 	if (err)
 		goto free_segment_manager_caches;
-	err = f2fs_create_extent_cache();
+	err = f2fs_create_recovery_cache();
 	if (err)
 		goto free_checkpoint_caches;
+	err = f2fs_create_extent_cache();
+	if (err)
+		goto free_recovery_cache;
 	err = f2fs_create_garbage_collection_cache();
 	if (err)
 		goto free_extent_cache;
@@ -4306,6 +4309,8 @@ static int __init init_f2fs_fs(void)
 	f2fs_destroy_garbage_collection_cache();
 free_extent_cache:
 	f2fs_destroy_extent_cache();
+free_recovery_cache:
+	f2fs_destroy_recovery_cache();
 free_checkpoint_caches:
 	f2fs_destroy_checkpoint_caches();
 free_segment_manager_caches:
@@ -4331,6 +4336,7 @@ static void __exit exit_f2fs_fs(void)
 	f2fs_exit_sysfs();
 	f2fs_destroy_garbage_collection_cache();
 	f2fs_destroy_extent_cache();
+	f2fs_destroy_recovery_cache();
 	f2fs_destroy_checkpoint_caches();
 	f2fs_destroy_segment_manager_caches();
 	f2fs_destroy_node_manager_caches();
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0006A3CCFFD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhGSIX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235865AbhGSIXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:23:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC18161205;
        Mon, 19 Jul 2021 08:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626684417;
        bh=daX8Yahq0WHsytcdNmcklqy9cMfNwPouHchyxbatIqk=;
        h=From:To:Cc:Subject:Date:From;
        b=fbhXbIYe3RLIcA2Fjxut4c4qG/Dr90fmT936dW2yYUqK5V0J9ZtwOUO9JYPbo+4CC
         9LcQVrrQiurES9hzqdkdzpZ9gC9PsZTH8H8RgvNyeCJxOr9Xjb5NiTIvw+ELwpYbEX
         ziEpEAkuu86WjUiA/UcMWHVWiRyBI9ZYXybcZJ9UIHv1NQ9jeZGmvdyQlo7EeKYN+G
         K6BXrCaxfX826tcppzNyEur+huMlTmtEEGrkjApgRDBmN24BtQ5SHsC4v1v/9scWUV
         2sJxHPkuTl897f6pMD0STky0zClnPRzpQUa36FT7/Zyh8aMQEodgeqyhPrlBYZs+ii
         HX/sGUOfa8Cyg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: quota: fix potential deadlock
Date:   Mon, 19 Jul 2021 16:46:47 +0800
Message-Id: <20210719084647.26027-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfstest generic/587 reports a deadlock issue as below:

======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc1 #69 Not tainted
------------------------------------------------------
repquota/8606 is trying to acquire lock:
ffff888022ac9320 (&sb->s_type->i_mutex_key#18){+.+.}-{3:3}, at: f2fs_quota_sync+0x207/0x300 [f2fs]

but task is already holding lock:
ffff8880084bcde8 (&sbi->quota_sem){.+.+}-{3:3}, at: f2fs_quota_sync+0x59/0x300 [f2fs]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&sbi->quota_sem){.+.+}-{3:3}:
       __lock_acquire+0x648/0x10b0
       lock_acquire+0x128/0x470
       down_read+0x3b/0x2a0
       f2fs_quota_sync+0x59/0x300 [f2fs]
       f2fs_quota_on+0x48/0x100 [f2fs]
       do_quotactl+0x5e3/0xb30
       __x64_sys_quotactl+0x23a/0x4e0
       do_syscall_64+0x3b/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&sbi->cp_rwsem){++++}-{3:3}:
       __lock_acquire+0x648/0x10b0
       lock_acquire+0x128/0x470
       down_read+0x3b/0x2a0
       f2fs_unlink+0x353/0x670 [f2fs]
       vfs_unlink+0x1c7/0x380
       do_unlinkat+0x413/0x4b0
       __x64_sys_unlinkat+0x50/0xb0
       do_syscall_64+0x3b/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&sb->s_type->i_mutex_key#18){+.+.}-{3:3}:
       check_prev_add+0xdc/0xb30
       validate_chain+0xa67/0xb20
       __lock_acquire+0x648/0x10b0
       lock_acquire+0x128/0x470
       down_write+0x39/0xc0
       f2fs_quota_sync+0x207/0x300 [f2fs]
       do_quotactl+0xaff/0xb30
       __x64_sys_quotactl+0x23a/0x4e0
       do_syscall_64+0x3b/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  &sb->s_type->i_mutex_key#18 --> &sbi->cp_rwsem --> &sbi->quota_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->quota_sem);
                               lock(&sbi->cp_rwsem);
                               lock(&sbi->quota_sem);
  lock(&sb->s_type->i_mutex_key#18);

 *** DEADLOCK ***

3 locks held by repquota/8606:
 #0: ffff88801efac0e0 (&type->s_umount_key#53){++++}-{3:3}, at: user_get_super+0xd9/0x190
 #1: ffff8880084bc380 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_quota_sync+0x3e/0x300 [f2fs]
 #2: ffff8880084bcde8 (&sbi->quota_sem){.+.+}-{3:3}, at: f2fs_quota_sync+0x59/0x300 [f2fs]

stack backtrace:
CPU: 6 PID: 8606 Comm: repquota Not tainted 5.14.0-rc1 #69
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Call Trace:
 dump_stack_lvl+0xce/0x134
 dump_stack+0x17/0x20
 print_circular_bug.isra.0.cold+0x239/0x253
 check_noncircular+0x1be/0x1f0
 check_prev_add+0xdc/0xb30
 validate_chain+0xa67/0xb20
 __lock_acquire+0x648/0x10b0
 lock_acquire+0x128/0x470
 down_write+0x39/0xc0
 f2fs_quota_sync+0x207/0x300 [f2fs]
 do_quotactl+0xaff/0xb30
 __x64_sys_quotactl+0x23a/0x4e0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f883b0b4efe

The root cause is ABBA deadlock of inode lock and cp_rwsem,
reorder locks in f2fs_quota_sync() as below to fix this issue:
- lock inode
- lock cp_rwsem
- lock quota_sem

Fixes: db6ec53b7e03 ("f2fs: add a rw_sem to cover quota flag changes")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 84 ++++++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8fecd3050ccd..72eb9d70969f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2518,6 +2518,33 @@ static int f2fs_enable_quotas(struct super_block *sb)
 	return 0;
 }
 
+static int f2fs_quota_sync_file(struct f2fs_sb_info *sbi, int type)
+{
+	struct quota_info *dqopt = sb_dqopt(sbi->sb);
+	struct address_space *mapping = dqopt->files[type]->i_mapping;
+	int ret = 0;
+
+	ret = dquot_writeback_dquots(sbi->sb, type);
+	if (ret)
+		goto out;
+
+	ret = filemap_fdatawrite(mapping);
+	if (ret)
+		goto out;
+
+	/* if we are using journalled quota */
+	if (is_journalled_quota(sbi))
+		goto out;
+
+	ret = filemap_fdatawait(mapping);
+
+	truncate_inode_pages(&dqopt->files[type]->i_data, 0);
+out:
+	if (ret)
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	return ret;
+}
+
 int f2fs_quota_sync(struct super_block *sb, int type)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -2525,57 +2552,42 @@ int f2fs_quota_sync(struct super_block *sb, int type)
 	int cnt;
 	int ret;
 
-	/*
-	 * do_quotactl
-	 *  f2fs_quota_sync
-	 *  down_read(quota_sem)
-	 *  dquot_writeback_dquots()
-	 *  f2fs_dquot_commit
-	 *                            block_operation
-	 *                            down_read(quota_sem)
-	 */
-	f2fs_lock_op(sbi);
-
-	down_read(&sbi->quota_sem);
-	ret = dquot_writeback_dquots(sb, type);
-	if (ret)
-		goto out;
-
 	/*
 	 * Now when everything is written we can discard the pagecache so
 	 * that userspace sees the changes.
 	 */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		struct address_space *mapping;
 
 		if (type != -1 && cnt != type)
 			continue;
-		if (!sb_has_quota_active(sb, cnt))
-			continue;
 
-		mapping = dqopt->files[cnt]->i_mapping;
+		if (!sb_has_quota_active(sb, type))
+			return 0;
 
-		ret = filemap_fdatawrite(mapping);
-		if (ret)
-			goto out;
+		inode_lock(dqopt->files[cnt]);
 
-		/* if we are using journalled quota */
-		if (is_journalled_quota(sbi))
-			continue;
+		/*
+		 * do_quotactl
+		 *  f2fs_quota_sync
+		 *  down_read(quota_sem)
+		 *  dquot_writeback_dquots()
+		 *  f2fs_dquot_commit
+		 *			      block_operation
+		 *			      down_read(quota_sem)
+		 */
+		f2fs_lock_op(sbi);
+		down_read(&sbi->quota_sem);
 
-		ret = filemap_fdatawait(mapping);
-		if (ret)
-			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
+		ret = f2fs_quota_sync_file(sbi, cnt);
+
+		up_read(&sbi->quota_sem);
+		f2fs_unlock_op(sbi);
 
-		inode_lock(dqopt->files[cnt]);
-		truncate_inode_pages(&dqopt->files[cnt]->i_data, 0);
 		inode_unlock(dqopt->files[cnt]);
+
+		if (ret)
+			break;
 	}
-out:
-	if (ret)
-		set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
-	up_read(&sbi->quota_sem);
-	f2fs_unlock_op(sbi);
 	return ret;
 }
 
-- 
2.22.1


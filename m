Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0821B402DD8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbhIGRpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236862AbhIGRpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:45:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F364B61100;
        Tue,  7 Sep 2021 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631036635;
        bh=1ooFZpKqsBvjIUgPnu7sNf+hGTvO8sAO4kCwQMRgOt8=;
        h=From:To:Cc:Subject:Date:From;
        b=FlAFCily+RzvE8/i45sreE7tux7+xYNJYLWFWPIZEF3Gi0416JMvSINnTzx22Tg7r
         uLYKHAxIl8NDxcE0AcfNHpk2GkV1tkIt9elgiOeWTO5Wx1xStLpIKVATrmQ9c9fO7A
         LKkvHaLMofqRwSVoRTwvwESrG6ZUkoX/8fqzIadJrpfp9CF9Y1jA3Q0AZHP5CCN96W
         /dBtOR6XWA2WDJp2z6quJ/D+1Ubj5dtPW+ce8VF44ukgIhYv97A3EeBzBZvn98QIeE
         Ia/iPSnMRiXoP3ZpOFDudNlgEKvarJkvry9oOTMP7JeYdNWPE1hel801a97f8XAuP/
         ghIYRrZHRHjeA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: should use GFP_NOFS for directory inodes
Date:   Tue,  7 Sep 2021 10:43:51 -0700
Message-Id: <20210907174351.1104857-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use inline_dentry which requires to allocate dentry page when adding a link.
If we allow to reclaim memory from filesystem, we do down_read(&sbi->cp_rwsem)
twice by f2fs_lock_op(). I think this should be okay, but how about stopping
the lockdep complaint [1]?

f2fs_create()
 - f2fs_lock_op()
 - f2fs_do_add_link()
  - __f2fs_find_entry
   - f2fs_get_read_data_page()
   -> kswapd
    - shrink_node
     - f2fs_evict_inode
      - f2fs_lock_op()

[1]

fs_reclaim
){+.+.}-{0:0}
:
kswapd0:        lock_acquire+0x114/0x394
kswapd0:        __fs_reclaim_acquire+0x40/0x50
kswapd0:        prepare_alloc_pages+0x94/0x1ec
kswapd0:        __alloc_pages_nodemask+0x78/0x1b0
kswapd0:        pagecache_get_page+0x2e0/0x57c
kswapd0:        f2fs_get_read_data_page+0xc0/0x394
kswapd0:        f2fs_find_data_page+0xa4/0x23c
kswapd0:        find_in_level+0x1a8/0x36c
kswapd0:        __f2fs_find_entry+0x70/0x100
kswapd0:        f2fs_do_add_link+0x84/0x1ec
kswapd0:        f2fs_mkdir+0xe4/0x1e4
kswapd0:        vfs_mkdir+0x110/0x1c0
kswapd0:        do_mkdirat+0xa4/0x160
kswapd0:        __arm64_sys_mkdirat+0x24/0x34
kswapd0:        el0_svc_common.llvm.17258447499513131576+0xc4/0x1e8
kswapd0:        do_el0_svc+0x28/0xa0
kswapd0:        el0_svc+0x24/0x38
kswapd0:        el0_sync_handler+0x88/0xec
kswapd0:        el0_sync+0x1c0/0x200
kswapd0:
-> #1
(
&sbi->cp_rwsem
){++++}-{3:3}
:
kswapd0:        lock_acquire+0x114/0x394
kswapd0:        down_read+0x7c/0x98
kswapd0:        f2fs_do_truncate_blocks+0x78/0x3dc
kswapd0:        f2fs_truncate+0xc8/0x128
kswapd0:        f2fs_evict_inode+0x2b8/0x8b8
kswapd0:        evict+0xd4/0x2f8
kswapd0:        iput+0x1c0/0x258
kswapd0:        do_unlinkat+0x170/0x2a0
kswapd0:        __arm64_sys_unlinkat+0x4c/0x68
kswapd0:        el0_svc_common.llvm.17258447499513131576+0xc4/0x1e8
kswapd0:        do_el0_svc+0x28/0xa0
kswapd0:        el0_svc+0x24/0x38
kswapd0:        el0_sync_handler+0x88/0xec
kswapd0:        el0_sync+0x1c0/0x200

Fixes: bdbc90fa55af ("f2fs: don't put dentry page in pagecache into highmem")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 2 +-
 fs/f2fs/namei.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9141147b5bb0..1213f15ffd68 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -527,7 +527,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		inode->i_op = &f2fs_dir_inode_operations;
 		inode->i_fop = &f2fs_dir_operations;
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
-		inode_nohighmem(inode);
+		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	} else if (S_ISLNK(inode->i_mode)) {
 		if (file_is_encrypt(inode))
 			inode->i_op = &f2fs_encrypted_symlink_inode_operations;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 9c528e583c9d..ae0838001480 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -757,7 +757,7 @@ static int f2fs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	inode->i_op = &f2fs_dir_inode_operations;
 	inode->i_fop = &f2fs_dir_operations;
 	inode->i_mapping->a_ops = &f2fs_dblock_aops;
-	inode_nohighmem(inode);
+	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 
 	set_inode_flag(inode, FI_INC_LINK);
 	f2fs_lock_op(sbi);
-- 
2.33.0.153.gba50c8fa24-goog


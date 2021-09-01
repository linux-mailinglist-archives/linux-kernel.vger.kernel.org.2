Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4E3FD4E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbhIAIHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242909AbhIAIH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:07:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C5C06103D;
        Wed,  1 Sep 2021 08:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630483589;
        bh=HFXW2CXUVuj9t9Ig1elcp8R+lAYqA68TQyV8IJQJvmA=;
        h=From:To:Cc:Subject:Date:From;
        b=PrGxvohdSMKpxmdJwW5SPfczCcjE5fL6gAUWGavIuNT7hu0PyUfwKybImG0WvaXn2
         z6nig86cxvCyPjpfz5yZUO20j9538S1kNeoDCyH/GkInabkNG0+Xz4WFvbgCUj+M23
         rlhVNBwclhRUhpt1ReCG9oiLeAClaia2Vp8yZ2RCgxmFi4kIGLfZkNO62TylLX0dFC
         Z03oFieXanxlH0WK1lRf5yvL/FvgayU4z2FOeY9BEgM8YKhHRMk0MgZnq1eFv8EHZm
         65B5ZtdSWg+hyWNPERdua/0Q9JNMx5TZU6Ule3BpLYY+Sl2lh57XqawNLMw7GDofPr
         LOin7K0sJnF4A==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2] f2fs: avoid attaching SB_ACTIVE flag during mount
Date:   Wed,  1 Sep 2021 16:06:21 +0800
Message-Id: <20210901080621.110319-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoted from [1]

"I do remember that I've added this code back then because otherwise
orphan cleanup was losing updates to quota files. But you're right
that now I don't see how that could be happening and it would be nice
if we could get rid of this hack"

[1] https://lore.kernel.org/linux-ext4/99cce8ca-e4a0-7301-840f-2ace67c551f3@huawei.com/T/#m04990cfbc4f44592421736b504afcc346b2a7c00

Related fix in ext4 by
commit 72ffb49a7b62 ("ext4: do not set SB_ACTIVE in ext4_orphan_cleanup()").

f2fs has the same hack implementation in
- f2fs_recover_orphan_inodes()
- f2fs_recover_fsync_data()

Let's get rid of this hack as well in f2fs.

Cc: Zhang Yi <yi.zhang@huawei.com>
Cc: Jan Kara <jack@suse.cz>
Acked-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- don't bother checkpoint disabling path
 fs/f2fs/checkpoint.c | 3 ---
 fs/f2fs/recovery.c   | 8 ++------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 83e9bc0f91ff..7d8803a4cbc2 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -705,9 +705,6 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	}
 
 #ifdef CONFIG_QUOTA
-	/* Needed for iput() to work correctly and not trash data */
-	sbi->sb->s_flags |= SB_ACTIVE;
-
 	/*
 	 * Turn on quotas which were not enabled for read-only mounts if
 	 * filesystem has quota feature, so that they are updated correctly.
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 04655511d7f5..706ddb3c95c0 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -787,8 +787,6 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	}
 
 #ifdef CONFIG_QUOTA
-	/* Needed for iput() to work correctly and not trash data */
-	sbi->sb->s_flags |= SB_ACTIVE;
 	/* Turn on quotas so that they are updated correctly */
 	quota_enabled = f2fs_enable_quota_files(sbi, s_flags & SB_RDONLY);
 #endif
@@ -816,10 +814,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	err = recover_data(sbi, &inode_list, &tmp_inode_list, &dir_list);
 	if (!err)
 		f2fs_bug_on(sbi, !list_empty(&inode_list));
-	else {
-		/* restore s_flags to let iput() trash data */
-		sbi->sb->s_flags = s_flags;
-	}
+	else
+		f2fs_bug_on(sbi, sbi->sb->s_flags & SB_ACTIVE);
 skip:
 	fix_curseg_write_pointer = !check_only || list_empty(&inode_list);
 
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA936A3DE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 03:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhDYBLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 21:11:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17815 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhDYBLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 21:11:46 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FSVK366lDz7vyN;
        Sun, 25 Apr 2021 09:08:39 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Sun, 25 Apr 2021 09:11:00 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@hihonor.com>
Subject: [PATCH v2] f2fs: reduce expensive checkpoint trigger frequency
Date:   Sun, 25 Apr 2021 09:10:53 +0800
Message-ID: <20210425011053.44436-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may trigger high frequent checkpoint for below case:
1. mkdir /mnt/dir1; set dir1 encrypted
2. touch /mnt/file1; fsync /mnt/file1
3. mkdir /mnt/dir2; set dir2 encrypted
4. touch /mnt/file2; fsync /mnt/file2
...

Although, newly created dir and file are not related, due to
commit bbf156f7afa7 ("f2fs: fix lost xattrs of directories"), we will
trigger checkpoint whenever fsync() comes after a new encrypted dir
created.

In order to avoid such condition, let's record an entry including
directory's ino into global cache when we initialize encryption policy
in a checkpointed directory, and then only trigger checkpoint() when
target file's parent has non-persisted encryption policy, for the case
its parent is not checkpointed, need_do_checkpoint() has cover that
by verifying it with f2fs_is_checkpointed_node().

Reported-by: Yunlei He <heyunlei@hihonor.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix to set ENC_DIR_INO only for encrypted directory
 fs/f2fs/f2fs.h              | 2 ++
 fs/f2fs/file.c              | 3 +++
 fs/f2fs/xattr.c             | 6 ++++--
 include/trace/events/f2fs.h | 3 ++-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b9d5317db0a7..0fe881309a20 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -246,6 +246,7 @@ enum {
 	APPEND_INO,		/* for append ino list */
 	UPDATE_INO,		/* for update ino list */
 	TRANS_DIR_INO,		/* for trasactions dir ino list */
+	ENC_DIR_INO,		/* for encrypted dir ino list */
 	FLUSH_INO,		/* for multiple device flushing */
 	MAX_INO_ENTRY,		/* max. list */
 };
@@ -1090,6 +1091,7 @@ enum cp_reason_type {
 	CP_FASTBOOT_MODE,
 	CP_SPEC_LOG_NUM,
 	CP_RECOVER_DIR,
+	CP_ENC_DIR,
 };
 
 enum iostat_type {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a595050c56d3..62af29ec0879 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -218,6 +218,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 		f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
 							TRANS_DIR_INO))
 		cp_reason = CP_RECOVER_DIR;
+	else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
+							ENC_DIR_INO))
+		cp_reason = CP_ENC_DIR;
 
 	return cp_reason;
 }
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index c8f34decbf8e..70615d504f7e 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -630,6 +630,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 			const char *name, const void *value, size_t size,
 			struct page *ipage, int flags)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_xattr_entry *here, *last;
 	void *base_addr, *last_base_addr;
 	int found, newsize;
@@ -745,8 +746,9 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
-	if (!error && S_ISDIR(inode->i_mode))
-		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
+	if (!error && S_ISDIR(inode->i_mode) && f2fs_encrypted_file(inode) &&
+			f2fs_is_checkpointed_node(sbi, inode->i_ino))
+		f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_INO);
 
 same:
 	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 56b113e3cd6a..ca0cf12226e9 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -145,7 +145,8 @@ TRACE_DEFINE_ENUM(CP_RESIZE);
 		{ CP_NODE_NEED_CP,	"node needs cp" },		\
 		{ CP_FASTBOOT_MODE,	"fastboot mode" },		\
 		{ CP_SPEC_LOG_NUM,	"log type is 2" },		\
-		{ CP_RECOVER_DIR,	"dir needs recovery" })
+		{ CP_RECOVER_DIR,	"dir needs recovery" },		\
+		{ CP_ENC_DIR,		"persist encryption policy" })
 
 #define show_shutdown_mode(type)					\
 	__print_symbolic(type,						\
-- 
2.29.2


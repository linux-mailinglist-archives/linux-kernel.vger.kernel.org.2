Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B573739EA17
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 01:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhFGX3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 19:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhFGX3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 19:29:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58DF8610E5;
        Mon,  7 Jun 2021 23:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623108442;
        bh=CaBkx+9oMJ65M16IDF3pIcnn6zlSPUYuaArsLbgHIuo=;
        h=From:To:Cc:Subject:Date:From;
        b=VziQE5VGw2SxCpW7HqLl7NvBit5fslFM7IxLU12VjlRBIy+7M+9w6zgBV+P4tcgAH
         0LksbGHVI6Ps8GUStotlzK8Rfd3vJgRuzW7a9SZixUDOKuQoF+Nb6VLU+jvGfX4NVl
         obnw9S7XcIeyPplitcYT5Cxi5IZMfEzIahyIJFCxvHvXl223zrSM07Pf//77Fx2SSi
         Bk2QwCOBGLvvTOtpTE++2fvAoLX3YYg1d7oxCqLR8XCaDpZP4S318YYtOO8kcTdCoF
         5EIb6d37zYnVNifO4rGF7ic0/q/XGE9jjCmc32JNvTESYZrsQ8xyh15CXoueR83j14
         DyIaidu/P4cwg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: introduce cf_name_slab cache
Date:   Tue,  8 Jun 2021 07:27:15 +0800
Message-Id: <20210607232715.3669-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Add a slab cache: "f2fs_casefold_name_entry" for memory allocation
of casefold name.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c      | 16 ++++++++++------
 fs/f2fs/recovery.c |  6 +++++-
 fs/f2fs/super.c    | 24 ++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 96dcc4aca639..ee400562157d 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -16,6 +16,10 @@
 #include "xattr.h"
 #include <trace/events/f2fs.h>
 
+#ifdef CONFIG_UNICODE
+extern struct kmem_cache *cf_name_slab;
+#endif
+
 static unsigned long dir_blocks(struct inode *inode)
 {
 	return ((unsigned long long) (i_size_read(inode) + PAGE_SIZE - 1))
@@ -77,11 +81,9 @@ int f2fs_init_casefolded_name(const struct inode *dir,
 {
 #ifdef CONFIG_UNICODE
 	struct super_block *sb = dir->i_sb;
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 
 	if (IS_CASEFOLDED(dir)) {
-		fname->cf_name.name = f2fs_kmalloc(sbi, F2FS_NAME_LEN,
-						   GFP_NOFS);
+		fname->cf_name.name = kmem_cache_alloc(cf_name_slab, GFP_NOFS);
 		if (!fname->cf_name.name)
 			return -ENOMEM;
 		fname->cf_name.len = utf8_casefold(sb->s_encoding,
@@ -89,7 +91,7 @@ int f2fs_init_casefolded_name(const struct inode *dir,
 						   fname->cf_name.name,
 						   F2FS_NAME_LEN);
 		if ((int)fname->cf_name.len <= 0) {
-			kfree(fname->cf_name.name);
+			kmem_cache_free(cf_name_slab, fname->cf_name.name);
 			fname->cf_name.name = NULL;
 			if (sb_has_strict_encoding(sb))
 				return -EINVAL;
@@ -172,8 +174,10 @@ void f2fs_free_filename(struct f2fs_filename *fname)
 	fname->crypto_buf.name = NULL;
 #endif
 #ifdef CONFIG_UNICODE
-	kfree(fname->cf_name.name);
-	fname->cf_name.name = NULL;
+	if (fname->cf_name.name) {
+		kmem_cache_free(cf_name_slab, fname->cf_name.name);
+		fname->cf_name.name = NULL;
+	}
 #endif
 }
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 4cfe36fa41be..3c198ab4f1db 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -45,6 +45,10 @@
 
 static struct kmem_cache *fsync_entry_slab;
 
+#ifdef CONFIG_UNICODE
+extern struct kmem_cache *cf_name_slab;
+#endif
+
 bool f2fs_space_for_roll_forward(struct f2fs_sb_info *sbi)
 {
 	s64 nalloc = percpu_counter_sum_positive(&sbi->alloc_valid_block_count);
@@ -145,7 +149,7 @@ static int init_recovered_filename(const struct inode *dir,
 		f2fs_hash_filename(dir, fname);
 #ifdef CONFIG_UNICODE
 		/* Case-sensitive match is fine for recovery */
-		kfree(fname->cf_name.name);
+		kmem_cache_free(cf_name_slab, fname->cf_name.name);
 		fname->cf_name.name = NULL;
 #endif
 	} else {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9089303f7f8c..194ccff9d59e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -277,6 +277,24 @@ static int f2fs_sb_read_encoding(const struct f2fs_super_block *sb,
 
 	return 0;
 }
+
+struct kmem_cache *cf_name_slab;
+static int __init f2fs_create_casefold_cache(void)
+{
+	cf_name_slab = f2fs_kmem_cache_create("f2fs_casefold_name_entry",
+							F2FS_NAME_LEN);
+	if (!cf_name_slab)
+		return -ENOMEM;
+	return 0;
+}
+
+static void f2fs_destroy_casefold_cache(void)
+{
+	kmem_cache_destroy(cf_name_slab);
+}
+#else
+static int __init f2fs_create_casefold_cache(void) { return 0; }
+static void f2fs_destroy_casefold_cache(void) { }
 #endif
 
 static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
@@ -4316,7 +4334,12 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_compress_cache();
 	if (err)
 		goto free_compress_mempool;
+	err = f2fs_create_casefold_cache();
+	if (err)
+		goto free_compress_cache;
 	return 0;
+free_compress_cache:
+	f2fs_destroy_compress_cache();
 free_compress_mempool:
 	f2fs_destroy_compress_mempool();
 free_bioset:
@@ -4352,6 +4375,7 @@ static int __init init_f2fs_fs(void)
 
 static void __exit exit_f2fs_fs(void)
 {
+	f2fs_destroy_casefold_cache();
 	f2fs_destroy_compress_cache();
 	f2fs_destroy_compress_mempool();
 	f2fs_destroy_bioset();
-- 
2.22.1


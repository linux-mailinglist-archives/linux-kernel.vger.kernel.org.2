Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE0239EA7D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 02:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFHACU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 20:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhFHACT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:02:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C176261182;
        Tue,  8 Jun 2021 00:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623110427;
        bh=hL0QyaHHiBQhCJvplDgOTxq80eyRVpxgcaTfNrFRZOU=;
        h=From:To:Cc:Subject:Date:From;
        b=Oqc2i2Z00BnCBbhA/znBJSn9n2XATSwEw32v7+IFcbFa05hugQiO0nDTTYMNZJvrz
         sW1yffJdnbm+fiZZW86LJyXGFDSI9RtdVGwIjMbEgEHQ2klWK8MIRNHdffvXJpSWZ7
         VsPioPeSeeRc/CpHS/fXtRzC6LdFPSx+8ApOOsvuGd0xrJ4ftsNxE7GI53FZsbU2s0
         lBdxL6ZwYx1iDTM28c5b+cN6aECUddMiW6pF1r8tQQNGrPS8TJGBzlX8mTfkPFxIvq
         yUWfGehAkWcVJeaGJNR++ca5ZeVqZjH5H8iNsXAcewaYnmtQE1q1hfAtHjjrOKCZxj
         O/5y8bUK5ed3g==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: introduce f2fs_casefold_name slab cache
Date:   Tue,  8 Jun 2021 08:00:22 +0800
Message-Id: <20210608000022.5509-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Add a slab cache: "f2fs_casefold_name" for memory allocation
of casefold name.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- change slab cache name to "f2fs_casefolded_name"
- add a "f2fs_" prefix for slab cache variable name
 fs/f2fs/dir.c      | 17 +++++++++++------
 fs/f2fs/recovery.c |  6 +++++-
 fs/f2fs/super.c    | 24 ++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 96dcc4aca639..456651682daf 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -16,6 +16,10 @@
 #include "xattr.h"
 #include <trace/events/f2fs.h>
 
+#ifdef CONFIG_UNICODE
+extern struct kmem_cache *f2fs_cf_name_slab;
+#endif
+
 static unsigned long dir_blocks(struct inode *inode)
 {
 	return ((unsigned long long) (i_size_read(inode) + PAGE_SIZE - 1))
@@ -77,11 +81,10 @@ int f2fs_init_casefolded_name(const struct inode *dir,
 {
 #ifdef CONFIG_UNICODE
 	struct super_block *sb = dir->i_sb;
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 
 	if (IS_CASEFOLDED(dir)) {
-		fname->cf_name.name = f2fs_kmalloc(sbi, F2FS_NAME_LEN,
-						   GFP_NOFS);
+		fname->cf_name.name = kmem_cache_alloc(f2fs_cf_name_slab,
+								GFP_NOFS);
 		if (!fname->cf_name.name)
 			return -ENOMEM;
 		fname->cf_name.len = utf8_casefold(sb->s_encoding,
@@ -89,7 +92,7 @@ int f2fs_init_casefolded_name(const struct inode *dir,
 						   fname->cf_name.name,
 						   F2FS_NAME_LEN);
 		if ((int)fname->cf_name.len <= 0) {
-			kfree(fname->cf_name.name);
+			kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
 			fname->cf_name.name = NULL;
 			if (sb_has_strict_encoding(sb))
 				return -EINVAL;
@@ -172,8 +175,10 @@ void f2fs_free_filename(struct f2fs_filename *fname)
 	fname->crypto_buf.name = NULL;
 #endif
 #ifdef CONFIG_UNICODE
-	kfree(fname->cf_name.name);
-	fname->cf_name.name = NULL;
+	if (fname->cf_name.name) {
+		kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
+		fname->cf_name.name = NULL;
+	}
 #endif
 }
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 4cfe36fa41be..76e62771433c 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -45,6 +45,10 @@
 
 static struct kmem_cache *fsync_entry_slab;
 
+#ifdef CONFIG_UNICODE
+extern struct kmem_cache *f2fs_cf_name_slab;
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
+		kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
 		fname->cf_name.name = NULL;
 #endif
 	} else {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9089303f7f8c..999fbe3a8d8f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -277,6 +277,24 @@ static int f2fs_sb_read_encoding(const struct f2fs_super_block *sb,
 
 	return 0;
 }
+
+struct kmem_cache *f2fs_cf_name_slab;
+static int __init f2fs_create_casefold_cache(void)
+{
+	f2fs_cf_name_slab = f2fs_kmem_cache_create("f2fs_casefolded_name",
+							F2FS_NAME_LEN);
+	if (!f2fs_cf_name_slab)
+		return -ENOMEM;
+	return 0;
+}
+
+static void f2fs_destroy_casefold_cache(void)
+{
+	kmem_cache_destroy(f2fs_cf_name_slab);
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


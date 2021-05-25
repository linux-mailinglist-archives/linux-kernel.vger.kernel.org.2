Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8C9390AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 22:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhEYUvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 16:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232229AbhEYUva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 16:51:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AABB86140E;
        Tue, 25 May 2021 20:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621975800;
        bh=WdrvbrkL97uxF12QDG+VFdSvWGh5V0sKoD7lYsbjdHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oirxlvASno54IUjoLBeq8eAr9cIJPE5mcSV/2WpqvG4t5+dKaSQWPcJCuK82YchlZ
         QkpMmcXsjoDir48UGaNcJyE5dwpOvVELMiNb34RfRVuVhcy6irVkV08tfN3xpce9tn
         +olchq9oClc/HHr7ZOJSBP0YK6DQaeFAag7wPhisdheK2SWEA3hRJHfgU+kQomaEbu
         jOc3eYnvee+RIh9rw/Cy2FWpH1hmZdyR35gXICsUKb/5+hQhNH5b2/Ph+Y20SeF6Ma
         nMOWYQfSETiKuDtSdxL1NnivObGL24ErQtlg3tiD1RYKDzAVcAupzFSW+i9CjUv3BQ
         fYiT8b/1YLgUw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: introduce FI_COMPRESS_RELEASED instead of using IMMUTABLE bit
Date:   Tue, 25 May 2021 13:49:55 -0700
Message-Id: <20210525204955.2512409-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
In-Reply-To: <20210525204955.2512409-1-jaegeuk@kernel.org>
References: <20210525204955.2512409-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we release compressed blocks, we used to set IMMUTABLE bit. But it turned
out it disallows every fs operations which we don't need for compression.

Let's just prevent writing data only.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c      |  3 ++-
 fs/f2fs/f2fs.h          |  6 ++++++
 fs/f2fs/file.c          | 18 ++++++++++++------
 include/linux/f2fs_fs.h |  1 +
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index bec92ff5ee7d..1c3e98085591 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -928,7 +928,8 @@ static int __f2fs_cluster_blocks(struct inode *inode,
 		}
 
 		f2fs_bug_on(F2FS_I_SB(inode),
-			!compr && ret != cluster_size && !IS_IMMUTABLE(inode));
+			!compr && ret != cluster_size &&
+			!is_inode_flag_set(inode, FI_COMPRESS_RELEASED));
 	}
 fail:
 	f2fs_put_dnode(&dn);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2c6913261586..9ad502f92529 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -707,6 +707,7 @@ enum {
 	FI_COMPRESS_CORRUPT,	/* indicate compressed cluster is corrupted */
 	FI_MMAP_FILE,		/* indicate file was mmapped */
 	FI_ENABLE_COMPRESS,	/* enable compression in "user" compression mode */
+	FI_COMPRESS_RELEASED,	/* compressed blocks were released */
 	FI_MAX,			/* max flag, never be used */
 };
 
@@ -2748,6 +2749,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	case FI_DATA_EXIST:
 	case FI_INLINE_DOTS:
 	case FI_PIN_FILE:
+	case FI_COMPRESS_RELEASED:
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 }
@@ -2869,6 +2871,8 @@ static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
 		set_bit(FI_EXTRA_ATTR, fi->flags);
 	if (ri->i_inline & F2FS_PIN_FILE)
 		set_bit(FI_PIN_FILE, fi->flags);
+	if (ri->i_inline & F2FS_COMPRESS_RELEASED)
+		set_bit(FI_COMPRESS_RELEASED, fi->flags);
 }
 
 static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
@@ -2889,6 +2893,8 @@ static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
 		ri->i_inline |= F2FS_EXTRA_ATTR;
 	if (is_inode_flag_set(inode, FI_PIN_FILE))
 		ri->i_inline |= F2FS_PIN_FILE;
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED))
+		ri->i_inline |= F2FS_COMPRESS_RELEASED;
 }
 
 static inline int f2fs_has_extra_attr(struct inode *inode)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4a8c3128b5a5..4714925e1974 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -63,6 +63,9 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	if (unlikely(IS_IMMUTABLE(inode)))
 		return VM_FAULT_SIGBUS;
 
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED))
+		return VM_FAULT_SIGBUS;
+
 	if (unlikely(f2fs_cp_error(sbi))) {
 		err = -EIO;
 		goto err;
@@ -3420,7 +3423,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (IS_IMMUTABLE(inode)) {
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3429,8 +3432,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		goto out;
 
-	F2FS_I(inode)->i_flags |= F2FS_IMMUTABLE_FL;
-	f2fs_set_inode_flags(inode);
+	set_inode_flag(inode, FI_COMPRESS_RELEASED);
 	inode->i_ctime = current_time(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 
@@ -3585,7 +3587,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
-	if (!IS_IMMUTABLE(inode)) {
+	if (!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto unlock_inode;
 	}
@@ -3630,8 +3632,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	up_write(&F2FS_I(inode)->i_mmap_sem);
 
 	if (ret >= 0) {
-		F2FS_I(inode)->i_flags &= ~F2FS_IMMUTABLE_FL;
-		f2fs_set_inode_flags(inode);
+		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
 		inode->i_ctime = current_time(inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
@@ -4249,6 +4250,11 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto unlock;
 	}
 
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0) {
 		bool preallocated = false;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 5487a80617a3..f93000c3a127 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -229,6 +229,7 @@ struct f2fs_extent {
 #define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
 #define F2FS_EXTRA_ATTR		0x20	/* file having extra attribute */
 #define F2FS_PIN_FILE		0x40	/* file should not be gced */
+#define F2FS_COMPRESS_RELEASED	0x80	/* file released compressed blocks */
 
 struct f2fs_inode {
 	__le16 i_mode;			/* file mode */
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog


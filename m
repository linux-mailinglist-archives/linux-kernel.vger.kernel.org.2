Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B705453BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhKPVsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:48:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhKPVsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:48:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCE5263223;
        Tue, 16 Nov 2021 21:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637099119;
        bh=G0xhnbWO+0WlA4XzuUY22qQyT/4Oct37q6Qk4qrlL3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+++ZzzgIqughHSH8UG6yEyqdHMnwr7hJ59i1RwAl+Vf1/7nmO8+2j1edEo/hpfEg
         F16fYtsXMHyQUgTRx4Jv1AukrfLIxEk0A6XbjjnZy8kuPYqXEd6M5duYO5TlOK2o2x
         flfURNCC8is7aB6T4AvQAqcpKIVNSf7Np9FwCfJZ/V954Zw8LznUszcV+YlK+SWfen
         amE22SXvnVYw9/MFL4+thegvQnR/pXYYWkWyEhq8cQgumNbV8KKWGmbzfEJ/bv/LUH
         Y/6aBHdQn0fqCHpcBWyC/rc7hoios1Tw2sKwvuUMfWMvEHT2T0S+CbhnheCDr3cjYk
         cFyaOAjjA3i1Q==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Eric Biggers <ebiggers@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] f2fs: reduce indentation in f2fs_file_write_iter()
Date:   Tue, 16 Nov 2021 13:45:07 -0800
Message-Id: <20211116214510.2934905-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211116214510.2934905-1-jaegeuk@kernel.org>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Replace 'if (ret > 0)' with 'if (ret <= 0) goto out_unlock;'.
No change in behavior.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 69 ++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ec8de0662437..fdc440d212c3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4355,48 +4355,51 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	ret = generic_write_checks(iocb, from);
-	if (ret > 0) {
-		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (!f2fs_overwrite_io(inode, iocb->ki_pos,
-						iov_iter_count(from)) ||
+	if (ret <= 0)
+		goto out_unlock;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!f2fs_overwrite_io(inode, iocb->ki_pos,
+					iov_iter_count(from)) ||
 				f2fs_has_inline_data(inode) ||
 				f2fs_force_buffered_io(inode, iocb, from)) {
-				ret = -EAGAIN;
-				goto out_unlock;
-			}
-		}
-		if (iocb->ki_flags & IOCB_DIRECT) {
-			ret = f2fs_convert_inline_inode(inode);
-			if (ret)
-				goto out_unlock;
-		}
-		/* Possibly preallocate the blocks for the write. */
-		target_size = iocb->ki_pos + iov_iter_count(from);
-		preallocated = f2fs_preallocate_blocks(iocb, from);
-		if (preallocated < 0) {
-			ret = preallocated;
+			ret = -EAGAIN;
 			goto out_unlock;
 		}
+	}
 
-		ret = __generic_file_write_iter(iocb, from);
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			goto out_unlock;
+	}
+	/* Possibly preallocate the blocks for the write. */
+	target_size = iocb->ki_pos + iov_iter_count(from);
+	preallocated = f2fs_preallocate_blocks(iocb, from);
+	if (preallocated < 0) {
+		ret = preallocated;
+		goto out_unlock;
+	}
 
-		/* Don't leave any preallocated blocks around past i_size. */
-		if (preallocated > 0 && i_size_read(inode) < target_size) {
-			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-			filemap_invalidate_lock(inode->i_mapping);
-			if (!f2fs_truncate(inode))
-				file_dont_truncate(inode);
-			filemap_invalidate_unlock(inode->i_mapping);
-			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-		} else {
+	ret = __generic_file_write_iter(iocb, from);
+
+	/* Don't leave any preallocated blocks around past i_size. */
+	if (preallocated > 0 && i_size_read(inode) < target_size) {
+		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+		filemap_invalidate_lock(inode->i_mapping);
+		if (!f2fs_truncate(inode))
 			file_dont_truncate(inode);
-		}
+		filemap_invalidate_unlock(inode->i_mapping);
+		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	} else {
+		file_dont_truncate(inode);
+	}
 
-		clear_inode_flag(inode, FI_PREALLOCATED_ALL);
+	clear_inode_flag(inode, FI_PREALLOCATED_ALL);
+
+	if (ret > 0)
+		f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
 
-		if (ret > 0)
-			f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
-	}
 out_unlock:
 	inode_unlock(inode);
 out:
-- 
2.34.0.rc1.387.gb447b232ab-goog


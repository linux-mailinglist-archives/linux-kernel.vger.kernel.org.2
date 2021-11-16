Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726CF453BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhKPVsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:48:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230492AbhKPVsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:48:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E36F76322D;
        Tue, 16 Nov 2021 21:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637099120;
        bh=eZWcKYxkCa8oij/qLUPoWTMsDGU6CU4uG/UMTp01tJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrrXSWhFp7t2q5s2eLV7wdLMLZYVqtNqOs+vFGhSm2MlScTc5pp2nx/BCK5KHz0zP
         +SspiQXWF5mNZA9hqFv8rrhEeOu8OM0HDoFikLo+V4yHxxBNc+D5CRVlJulqWdAagc
         4hnhwhxM2FEJChAj0hpO6SrOrPFhHmbTQEuhzmqHNfNVRPvE2Uo22KRAO14aLFNtVd
         Pm827ju5YYwg+Z8daoxZoCvu6kh2vTgqxuEJCI/tHErLNu+jkP9AsX3Neln7iebWNv
         7tUJt/ujj+nxE0wStELNMF14zmDy5+lbcvbbUcUqXnayF/kWbmikaFpacknbWuG8I2
         GidRYYthb/R4w==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Eric Biggers <ebiggers@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/6] f2fs: implement iomap operations
Date:   Tue, 16 Nov 2021 13:45:09 -0800
Message-Id: <20211116214510.2934905-5-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211116214510.2934905-1-jaegeuk@kernel.org>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Implement 'struct iomap_ops' for f2fs, in preparation for making f2fs
use iomap for direct I/O.

Note that this may be used for other things besides direct I/O in the
future; however, for now I've only tested it for direct I/O.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/Kconfig |  1 +
 fs/f2fs/data.c  | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h  |  1 +
 3 files changed, 60 insertions(+)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 7eea3cfd894d..f46a7339d6cf 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -7,6 +7,7 @@ config F2FS_FS
 	select CRYPTO_CRC32
 	select F2FS_FS_XATTR if FS_ENCRYPTION
 	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
+	select FS_IOMAP
 	select LZ4_COMPRESS if F2FS_FS_LZ4
 	select LZ4_DECOMPRESS if F2FS_FS_LZ4
 	select LZ4HC_COMPRESS if F2FS_FS_LZ4HC
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7ac1a39fcad2..43b3ca7cabe0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -21,6 +21,7 @@
 #include <linux/cleancache.h>
 #include <linux/sched/signal.h>
 #include <linux/fiemap.h>
+#include <linux/iomap.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -4236,3 +4237,60 @@ void f2fs_destroy_bio_entry_cache(void)
 {
 	kmem_cache_destroy(bio_entry_slab);
 }
+
+static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+			    unsigned int flags, struct iomap *iomap,
+			    struct iomap *srcmap)
+{
+	struct f2fs_map_blocks map = {};
+	pgoff_t next_pgofs = 0;
+	int err;
+
+	map.m_lblk = bytes_to_blks(inode, offset);
+	map.m_len = bytes_to_blks(inode, offset + length - 1) - map.m_lblk + 1;
+	map.m_next_pgofs = &next_pgofs;
+	map.m_seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
+	if (flags & IOMAP_WRITE)
+		map.m_may_create = true;
+
+	err = f2fs_map_blocks(inode, &map, flags & IOMAP_WRITE,
+			      F2FS_GET_BLOCK_DIO);
+	if (err)
+		return err;
+
+	iomap->offset = blks_to_bytes(inode, map.m_lblk);
+
+	if (map.m_flags & (F2FS_MAP_MAPPED | F2FS_MAP_UNWRITTEN)) {
+		iomap->length = blks_to_bytes(inode, map.m_len);
+		if (map.m_flags & F2FS_MAP_MAPPED) {
+			iomap->type = IOMAP_MAPPED;
+			iomap->flags |= IOMAP_F_MERGED;
+		} else {
+			iomap->type = IOMAP_UNWRITTEN;
+		}
+		if (WARN_ON_ONCE(!__is_valid_data_blkaddr(map.m_pblk)))
+			return -EINVAL;
+		iomap->addr = blks_to_bytes(inode, map.m_pblk);
+
+		if (WARN_ON_ONCE(f2fs_is_multi_device(F2FS_I_SB(inode))))
+			return -EINVAL;
+		iomap->bdev = inode->i_sb->s_bdev;
+	} else {
+		iomap->length = blks_to_bytes(inode, next_pgofs) -
+				iomap->offset;
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+	}
+
+	if (map.m_flags & F2FS_MAP_NEW)
+		iomap->flags |= IOMAP_F_NEW;
+	if ((inode->i_state & I_DIRTY_DATASYNC) ||
+	    offset + length > i_size_read(inode))
+		iomap->flags |= IOMAP_F_DIRTY;
+
+	return 0;
+}
+
+const struct iomap_ops f2fs_iomap_ops = {
+	.iomap_begin	= f2fs_iomap_begin,
+};
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 14bea669f87e..0d199e8f2c1d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3654,6 +3654,7 @@ int f2fs_init_post_read_processing(void);
 void f2fs_destroy_post_read_processing(void);
 int f2fs_init_post_read_wq(struct f2fs_sb_info *sbi);
 void f2fs_destroy_post_read_wq(struct f2fs_sb_info *sbi);
+extern const struct iomap_ops f2fs_iomap_ops;
 
 /*
  * gc.c
-- 
2.34.0.rc1.387.gb447b232ab-goog


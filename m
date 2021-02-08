Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19C5312B76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhBHIHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:07:33 -0500
Received: from outbound-gw.openxchange.ahost.me ([94.136.40.163]:43934 "EHLO
        outbound-gw.openxchange.ahost.me" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhBHIFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:05:16 -0500
Received: from localhost ([127.0.0.1] helo=outbound-gw.openxchange.ahost.me)
        by outbound-gw.openxchange.ahost.me with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1l915k-0007Tx-OD; Mon, 08 Feb 2021 07:36:16 +0000
Date:   Mon, 8 Feb 2021 07:36:16 +0000 (GMT)
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <1960034935.754571.1612769776665@webmail.123-reg.co.uk>
Subject: [PATCH V2 2/4] Squashfs: add more sanity checks in id lookup
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev30
X-Originating-IP: 82.69.79.175
X-Originating-Client: com.openexchange.ox.gui.dhtml
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sysbot has reported a number of "slab-out-of-bounds reads" and
"use-after-free read" errors which has been identified as being
caused by a corrupted index value read from the inode.  This
could be because the metadata block is uncompressed, or because
the "compression" bit has been corrupted (turning a compressed
block into an uncompressed block).

This patch adds additional sanity checks to detect this, and the
following corruption.

1. It checks against corruption of the ids count.  This can either
   lead to a larger table to be read, or a smaller than expected
   table to be read.

   In the case of a too large ids count, this would often have been
   trapped by the existing sanity checks, but this patch introduces
   a more exact check, which can identify too small values.

2. It checks the contents of the index table for corruption.

Reported-by: syzbot+b06d57ba83f604522af2@syzkaller.appspotmail.com
Reported-by: syzbot+c021ba012da41ee9807c@syzkaller.appspotmail.com
Reported-by: syzbot+5024636e8b5fd19f0f19@syzkaller.appspotmail.com
Reported-by: syzbot+bcbc661df46657d0fa4f@syzkaller.appspotmail.com
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Cc: stable@vger.kernel.org
---
 fs/squashfs/id.c             | 40 ++++++++++++++++++++++++++++--------
 fs/squashfs/squashfs_fs_sb.h |  1 +
 fs/squashfs/super.c          |  6 +++---
 fs/squashfs/xattr.h          | 10 ++++++++-
 4 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/fs/squashfs/id.c b/fs/squashfs/id.c
index 6be5afe7287d..11581bf31af4 100644
--- a/fs/squashfs/id.c
+++ b/fs/squashfs/id.c
@@ -35,10 +35,15 @@ int squashfs_get_id(struct super_block *sb, unsigned int index,
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
 	int block = SQUASHFS_ID_BLOCK(index);
 	int offset = SQUASHFS_ID_BLOCK_OFFSET(index);
-	u64 start_block = le64_to_cpu(msblk->id_table[block]);
+	u64 start_block;
 	__le32 disk_id;
 	int err;
 
+	if (index >= msblk->ids)
+		return -EINVAL;
+
+	start_block = le64_to_cpu(msblk->id_table[block]);
+
 	err = squashfs_read_metadata(sb, &disk_id, &start_block, &offset,
 							sizeof(disk_id));
 	if (err < 0)
@@ -56,7 +61,10 @@ __le64 *squashfs_read_id_index_table(struct super_block *sb,
 		u64 id_table_start, u64 next_table, unsigned short no_ids)
 {
 	unsigned int length = SQUASHFS_ID_BLOCK_BYTES(no_ids);
+	unsigned int indexes = SQUASHFS_ID_BLOCKS(no_ids);
+	int n;
 	__le64 *table;
+	u64 start, end;
 
 	TRACE("In read_id_index_table, length %d\n", length);
 
@@ -67,20 +75,36 @@ __le64 *squashfs_read_id_index_table(struct super_block *sb,
 		return ERR_PTR(-EINVAL);
 
 	/*
-	 * length bytes should not extend into the next table - this check
-	 * also traps instances where id_table_start is incorrectly larger
-	 * than the next table start
+	 * The computed size of the index table (length bytes) should exactly
+	 * match the table start and end points
 	 */
-	if (id_table_start + length > next_table)
+	if (length != (next_table - id_table_start))
 		return ERR_PTR(-EINVAL);
 
 	table = squashfs_read_table(sb, id_table_start, length);
+	if (IS_ERR(table))
+		return table;
 
 	/*
-	 * table[0] points to the first id lookup table metadata block, this
-	 * should be less than id_table_start
+	 * table[0], table[1], ... table[indexes - 1] store the locations
+	 * of the compressed id blocks.   Each entry should be less than
+	 * the next (i.e. table[0] < table[1]), and the difference between them
+	 * should be SQUASHFS_METADATA_SIZE or less.  table[indexes - 1]
+	 * should be less than id_table_start, and again the difference
+	 * should be SQUASHFS_METADATA_SIZE or less
 	 */
-	if (!IS_ERR(table) && le64_to_cpu(table[0]) >= id_table_start) {
+	for (n = 0; n < (indexes - 1); n++) {
+		start = le64_to_cpu(table[n]);
+		end = le64_to_cpu(table[n + 1]);
+
+		if (start >= end || (end - start) > SQUASHFS_METADATA_SIZE) {
+			kfree(table);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	start = le64_to_cpu(table[indexes - 1]);
+	if (start >= id_table_start || (id_table_start - start) > SQUASHFS_METADATA_SIZE) {
 		kfree(table);
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
index 34c21ffb6df3..166e98806265 100644
--- a/fs/squashfs/squashfs_fs_sb.h
+++ b/fs/squashfs/squashfs_fs_sb.h
@@ -64,5 +64,6 @@ struct squashfs_sb_info {
 	unsigned int				inodes;
 	unsigned int				fragments;
 	int					xattr_ids;
+	unsigned int				ids;
 };
 #endif
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index d6c6593ec169..88cc94be1076 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -166,6 +166,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	msblk->directory_table = le64_to_cpu(sblk->directory_table_start);
 	msblk->inodes = le32_to_cpu(sblk->inodes);
 	msblk->fragments = le32_to_cpu(sblk->fragments);
+	msblk->ids = le16_to_cpu(sblk->no_ids);
 	flags = le16_to_cpu(sblk->flags);
 
 	TRACE("Found valid superblock on %pg\n", sb->s_bdev);
@@ -177,7 +178,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	TRACE("Block size %d\n", msblk->block_size);
 	TRACE("Number of inodes %d\n", msblk->inodes);
 	TRACE("Number of fragments %d\n", msblk->fragments);
-	TRACE("Number of ids %d\n", le16_to_cpu(sblk->no_ids));
+	TRACE("Number of ids %d\n", msblk->ids);
 	TRACE("sblk->inode_table_start %llx\n", msblk->inode_table);
 	TRACE("sblk->directory_table_start %llx\n", msblk->directory_table);
 	TRACE("sblk->fragment_table_start %llx\n",
@@ -236,8 +237,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 allocate_id_index_table:
 	/* Allocate and read id index table */
 	msblk->id_table = squashfs_read_id_index_table(sb,
-		le64_to_cpu(sblk->id_table_start), next_table,
-		le16_to_cpu(sblk->no_ids));
+		le64_to_cpu(sblk->id_table_start), next_table, msblk->ids);
 	if (IS_ERR(msblk->id_table)) {
 		errorf(fc, "unable to read id index table");
 		err = PTR_ERR(msblk->id_table);
diff --git a/fs/squashfs/xattr.h b/fs/squashfs/xattr.h
index 184129afd456..d8a270d3ac4c 100644
--- a/fs/squashfs/xattr.h
+++ b/fs/squashfs/xattr.h
@@ -17,8 +17,16 @@ extern int squashfs_xattr_lookup(struct super_block *, unsigned int, int *,
 static inline __le64 *squashfs_read_xattr_id_table(struct super_block *sb,
 		u64 start, u64 *xattr_table_start, int *xattr_ids)
 {
+	struct squashfs_xattr_id_table *id_table;
+
+	id_table = squashfs_read_table(sb, start, sizeof(*id_table));
+	if (IS_ERR(id_table))
+		return (__le64 *) id_table;
+
+	*xattr_table_start = le64_to_cpu(id_table->xattr_table_start);
+	kfree(id_table);
+
 	ERROR("Xattrs in filesystem, these will be ignored\n");
-	*xattr_table_start = start;
 	return ERR_PTR(-ENOTSUPP);
 }
 
-- 
2.20.1

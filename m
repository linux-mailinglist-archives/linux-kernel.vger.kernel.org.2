Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A72C312B37
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 08:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhBHHmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 02:42:36 -0500
Received: from outbound-gw.openxchange.ahost.me ([94.136.40.163]:34318 "EHLO
        outbound-gw.openxchange.ahost.me" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229986AbhBHHm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 02:42:27 -0500
Received: from localhost ([127.0.0.1] helo=outbound-gw.openxchange.ahost.me)
        by outbound-gw.openxchange.ahost.me with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1l91Ag-0006kB-Nr; Mon, 08 Feb 2021 07:41:22 +0000
Date:   Mon, 8 Feb 2021 07:41:22 +0000 (GMT)
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <270245655.754655.1612770082682@webmail.123-reg.co.uk>
Subject: [PATCH V2 4/4] Squashfs: add more sanity checks in xattr id lookup
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

Sysbot has reported a warning where a kmalloc() attempt exceeds the
maximum limit.  This has been identified as corruption of the xattr_ids
count when reading the xattr id lookup table.

This patch adds a number of additional sanity checks to detect
this corruption and others.

1. It checks for a corrupted xattr index read from the inode.  This could
   be because the metadata block is uncompressed, or because the
   "compression" bit has been corrupted (turning a compressed block
   into an uncompressed block).  This would cause an out of bounds read.

2. It checks against corruption of the xattr_ids count.  This can either
   lead to the above kmalloc failure, or a smaller than expected
   table to be read.

3. It checks the contents of the index table for corruption.

Reported-by: syzbot+2ccea6339d368360800d@syzkaller.appspotmail.com
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Cc: stable@vger.kernel.org
---
 fs/squashfs/xattr_id.c | 66 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 9 deletions(-)

diff --git a/fs/squashfs/xattr_id.c b/fs/squashfs/xattr_id.c
index d99e08464554..52905ce2b6f7 100644
--- a/fs/squashfs/xattr_id.c
+++ b/fs/squashfs/xattr_id.c
@@ -31,10 +31,15 @@ int squashfs_xattr_lookup(struct super_block *sb, unsigned int index,
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
 	int block = SQUASHFS_XATTR_BLOCK(index);
 	int offset = SQUASHFS_XATTR_BLOCK_OFFSET(index);
-	u64 start_block = le64_to_cpu(msblk->xattr_id_table[block]);
+	u64 start_block;
 	struct squashfs_xattr_id id;
 	int err;
 
+	if (index >= msblk->xattr_ids)
+		return -EINVAL;
+
+	start_block = le64_to_cpu(msblk->xattr_id_table[block]);
+
 	err = squashfs_read_metadata(sb, &id, &start_block, &offset,
 							sizeof(id));
 	if (err < 0)
@@ -50,13 +55,17 @@ int squashfs_xattr_lookup(struct super_block *sb, unsigned int index,
 /*
  * Read uncompressed xattr id lookup table indexes from disk into memory
  */
-__le64 *squashfs_read_xattr_id_table(struct super_block *sb, u64 start,
+__le64 *squashfs_read_xattr_id_table(struct super_block *sb, u64 table_start,
 		u64 *xattr_table_start, int *xattr_ids)
 {
-	unsigned int len;
+	struct squashfs_sb_info *msblk = sb->s_fs_info;
+	unsigned int len, indexes;
 	struct squashfs_xattr_id_table *id_table;
+	__le64 *table;
+	u64 start, end;
+	int n;
 
-	id_table = squashfs_read_table(sb, start, sizeof(*id_table));
+	id_table = squashfs_read_table(sb, table_start, sizeof(*id_table));
 	if (IS_ERR(id_table))
 		return (__le64 *) id_table;
 
@@ -70,13 +79,52 @@ __le64 *squashfs_read_xattr_id_table(struct super_block *sb, u64 start,
 	if (*xattr_ids == 0)
 		return ERR_PTR(-EINVAL);
 
-	/* xattr_table should be less than start */
-	if (*xattr_table_start >= start)
+	len = SQUASHFS_XATTR_BLOCK_BYTES(*xattr_ids);
+	indexes = SQUASHFS_XATTR_BLOCKS(*xattr_ids);
+
+	/*
+	 * The computed size of the index table (len bytes) should exactly
+	 * match the table start and end points
+	 */
+	start = table_start + sizeof(*id_table);
+	end = msblk->bytes_used;
+
+	if (len != (end - start))
 		return ERR_PTR(-EINVAL);
 
-	len = SQUASHFS_XATTR_BLOCK_BYTES(*xattr_ids);
+	table = squashfs_read_table(sb, start, len);
+	if (IS_ERR(table))
+		return table;
+
+	/* table[0], table[1], ... table[indexes - 1] store the locations
+	 * of the compressed xattr id blocks.  Each entry should be less than
+	 * the next (i.e. table[0] < table[1]), and the difference between them
+	 * should be SQUASHFS_METADATA_SIZE or less.  table[indexes - 1]
+	 * should be less than table_start, and again the difference
+	 * shouls be SQUASHFS_METADATA_SIZE or less.
+	 *
+	 * Finally xattr_table_start should be less than table[0].
+	 */
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
+	if (start >= table_start || (table_start - start) > SQUASHFS_METADATA_SIZE) {
+		kfree(table);
+		return ERR_PTR(-EINVAL);
+	}
 
-	TRACE("In read_xattr_index_table, length %d\n", len);
+	if (*xattr_table_start >= le64_to_cpu(table[0])) {
+		kfree(table);
+		return ERR_PTR(-EINVAL);
+	}
 
-	return squashfs_read_table(sb, start + sizeof(*id_table), len);
+	return table;
 }
-- 
2.20.1

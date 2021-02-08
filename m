Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DD312B31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 08:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhBHHkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 02:40:17 -0500
Received: from outbound-gw.openxchange.ahost.me ([94.136.40.163]:41658 "EHLO
        outbound-gw.openxchange.ahost.me" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229621AbhBHHkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 02:40:12 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2021 02:40:11 EST
Received: from localhost ([127.0.0.1] helo=outbound-gw.openxchange.ahost.me)
        by outbound-gw.openxchange.ahost.me with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1l918W-0004MZ-LE; Mon, 08 Feb 2021 07:39:08 +0000
Date:   Mon, 8 Feb 2021 07:39:08 +0000 (GMT)
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <527909353.754618.1612769948607@webmail.123-reg.co.uk>
Subject: [PATCH V2 3/4] Squashfs: add more sanity checks in inode lookup
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

Sysbot has reported an "slab-out-of-bounds read" error which
has been identified as being caused by a corrupted "ino_num"
value read from the inode.  This could be because the metadata
block is uncompressed, or because the "compression" bit has been
corrupted (turning a compressed block into an uncompressed block).

This patch adds additional sanity checks to detect this, and the
following corruption.

1. It checks against corruption of the inodes count.  This can either
   lead to a larger table to be read, or a smaller than expected
   table to be read.

   In the case of a too large inodes count, this would often have been
   trapped by the existing sanity checks, but this patch introduces
   a more exact check, which can identify too small values.

2. It checks the contents of the index table for corruption.

Reported-by: syzbot+04419e3ff19d2970ea28@syzkaller.appspotmail.com
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Cc: stable@vger.kernel.org
---
 fs/squashfs/export.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/fs/squashfs/export.c b/fs/squashfs/export.c
index ae2c87bb0fbe..3f134ba86a45 100644
--- a/fs/squashfs/export.c
+++ b/fs/squashfs/export.c
@@ -41,12 +41,17 @@ static long long squashfs_inode_lookup(struct super_block *sb, int ino_num)
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
 	int blk = SQUASHFS_LOOKUP_BLOCK(ino_num - 1);
 	int offset = SQUASHFS_LOOKUP_BLOCK_OFFSET(ino_num - 1);
-	u64 start = le64_to_cpu(msblk->inode_lookup_table[blk]);
+	u64 start;
 	__le64 ino;
 	int err;
 
 	TRACE("Entered squashfs_inode_lookup, inode_number = %d\n", ino_num);
 
+	if (ino_num == 0 || (ino_num - 1) >= msblk->inodes)
+		return -EINVAL;
+
+	start = le64_to_cpu(msblk->inode_lookup_table[blk]);
+
 	err = squashfs_read_metadata(sb, &ino, &start, &offset, sizeof(ino));
 	if (err < 0)
 		return err;
@@ -111,7 +116,10 @@ __le64 *squashfs_read_inode_lookup_table(struct super_block *sb,
 		u64 lookup_table_start, u64 next_table, unsigned int inodes)
 {
 	unsigned int length = SQUASHFS_LOOKUP_BLOCK_BYTES(inodes);
+	unsigned int indexes = SQUASHFS_LOOKUP_BLOCKS(inodes);
+	int n;
 	__le64 *table;
+	u64 start, end;
 
 	TRACE("In read_inode_lookup_table, length %d\n", length);
 
@@ -121,20 +129,37 @@ __le64 *squashfs_read_inode_lookup_table(struct super_block *sb,
 	if (inodes == 0)
 		return ERR_PTR(-EINVAL);
 
-	/* length bytes should not extend into the next table - this check
-	 * also traps instances where lookup_table_start is incorrectly larger
-	 * than the next table start
+	/*
+	 * The computed size of the lookup table (length bytes) should exactly
+	 * match the table start and end points
 	 */
-	if (lookup_table_start + length > next_table)
+	if (length != (next_table - lookup_table_start))
 		return ERR_PTR(-EINVAL);
 
 	table = squashfs_read_table(sb, lookup_table_start, length);
+	if (IS_ERR(table))
+		return table;
 
 	/*
-	 * table[0] points to the first inode lookup table metadata block,
-	 * this should be less than lookup_table_start
+	 * table0], table[1], ... table[indexes - 1] store the locations
+	 * of the compressed inode lookup blocks.  Each entry should be
+	 * less than the next (i.e. table[0] < table[1]), and the difference
+	 * between them should be SQUASHFS_METADATA_SIZE or less.
+	 * table[indexes - 1] should  be less than lookup_table_start, and
+	 * again the difference should be SQUASHFS_METADATA_SIZE or less
 	 */
-	if (!IS_ERR(table) && le64_to_cpu(table[0]) >= lookup_table_start) {
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
+	if (start >= lookup_table_start || (lookup_table_start - start) > SQUASHFS_METADATA_SIZE) {
 		kfree(table);
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.20.1

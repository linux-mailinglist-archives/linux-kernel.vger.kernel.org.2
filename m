Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B42345216
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCVVxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhCVVxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:53:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B87DF619A8;
        Mon, 22 Mar 2021 21:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616449988;
        bh=9EB5coP7VFcGqcHofvoSERdKRUOCASZkoAH5aL0DYFw=;
        h=From:To:Cc:Subject:Date:From;
        b=Edu2/1in/gYMDShsgHUhAHCDs2GsWwfwjcOlaZRHnSq4sDfFSjdIvnrvuUpOQympp
         XB3SquFdxOPVqiD/wGGOSrbd+VItvulTk+1QdF/Jyqs9Vadh2oZ7KmUOQ5puIqQllD
         /KYOO7qKJViiLybRmwHDbG86gArZ93wAP5a7LV9Q+T/n7Iz5Bh/WzA3XQFku3fJtd4
         QGjrjD/kwEtbcp6JSvg1JJuaTSJ+LyfXE8BtS6w1sKFYCgJFllvkNBeZgJwoniSoH1
         zVJAtS0u/mMgEJNhZkIXexrxS64C+j+iWBLZ92GBJYmyD7mODNX1G0Z9MeczHnU654
         3pn45V5oQVfdg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bob Copeland <me@bobcopeland.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Yu <chao@kernel.org>, Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] omfs: avoid gcc-10 stringop-overflow warning
Date:   Mon, 22 Mar 2021 22:52:47 +0100
Message-Id: <20210322215304.1124998-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc-10 correctly points out a memcpy beyond the end of the structure
it gets copied into:

fs/omfs/file.c: In function 'omfs_grow_extent':
cc1: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
In file included from fs/omfs/omfs.h:8,
                 from fs/omfs/file.c:11:
fs/omfs/omfs_fs.h:80:27: note: at offset 0 to object 'e_entry' with size 16 declared here
   80 |  struct omfs_extent_entry e_entry; /* start of extent entries */
      |                           ^~~~~~~

This is not a bug however, as the file system layout contains an array
of extent entries instead of just a single one that was part of the
structure definition.

Changing the definition to use a c99 flexible array member makes
makes the code match the actual layout, which avoids the warning and
an odd '+1' in the calculation of the number of extent entries.

Fixes: 8f09e98768c1 ("omfs: add file routines")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/omfs/file.c    | 12 ++++++------
 fs/omfs/omfs_fs.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index d1304acf3ff8..4bd9d0c140e1 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -14,7 +14,7 @@ static u32 omfs_max_extents(struct omfs_sb_info *sbi, int offset)
 {
 	return (sbi->s_sys_blocksize - offset -
 		sizeof(struct omfs_extent)) /
-		sizeof(struct omfs_extent_entry) + 1;
+		sizeof(struct omfs_extent_entry);
 }
 
 void omfs_make_empty_table(struct buffer_head *bh, int offset)
@@ -24,8 +24,8 @@ void omfs_make_empty_table(struct buffer_head *bh, int offset)
 	oe->e_next = ~cpu_to_be64(0ULL);
 	oe->e_extent_count = cpu_to_be32(1),
 	oe->e_fill = cpu_to_be32(0x22),
-	oe->e_entry.e_cluster = ~cpu_to_be64(0ULL);
-	oe->e_entry.e_blocks = ~cpu_to_be64(0ULL);
+	oe->e_entry[0].e_cluster = ~cpu_to_be64(0ULL);
+	oe->e_entry[0].e_blocks = ~cpu_to_be64(0ULL);
 }
 
 int omfs_shrink_inode(struct inode *inode)
@@ -68,7 +68,7 @@ int omfs_shrink_inode(struct inode *inode)
 
 		last = next;
 		next = be64_to_cpu(oe->e_next);
-		entry = &oe->e_entry;
+		entry = oe->e_entry;
 
 		/* ignore last entry as it is the terminator */
 		for (; extent_count > 1; extent_count--) {
@@ -117,7 +117,7 @@ static int omfs_grow_extent(struct inode *inode, struct omfs_extent *oe,
 			u64 *ret_block)
 {
 	struct omfs_extent_entry *terminator;
-	struct omfs_extent_entry *entry = &oe->e_entry;
+	struct omfs_extent_entry *entry = oe->e_entry;
 	struct omfs_sb_info *sbi = OMFS_SB(inode->i_sb);
 	u32 extent_count = be32_to_cpu(oe->e_extent_count);
 	u64 new_block = 0;
@@ -245,7 +245,7 @@ static int omfs_get_block(struct inode *inode, sector_t block,
 
 		extent_count = be32_to_cpu(oe->e_extent_count);
 		next = be64_to_cpu(oe->e_next);
-		entry = &oe->e_entry;
+		entry = oe->e_entry;
 
 		if (extent_count > max_extents)
 			goto out_brelse;
diff --git a/fs/omfs/omfs_fs.h b/fs/omfs/omfs_fs.h
index caecb3d5a344..1ff6b9e41297 100644
--- a/fs/omfs/omfs_fs.h
+++ b/fs/omfs/omfs_fs.h
@@ -77,7 +77,7 @@ struct omfs_extent {
 	__be64 e_next;			/* next extent table location */
 	__be32 e_extent_count;		/* total # extents in this table */
 	__be32 e_fill;
-	struct omfs_extent_entry e_entry;	/* start of extent entries */
+	struct omfs_extent_entry e_entry[];	/* start of extent entries */
 };
 
 #endif
-- 
2.29.2


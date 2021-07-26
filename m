Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA3C3D5250
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 06:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhGZDh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 23:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhGZDhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 23:37:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91309C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:18:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso12490282pjs.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2thOxj6ctqmCSeGKTO0PklZgYjLXVrYMprKtsyIwFdQ=;
        b=E6YnqwG/l7j6GsLDG5sI85c1f8k6puuOIXFTKw6dDIyNb62iLh9Z33ha1+QyWqGuP/
         kKX4DRToWTQLcXCA2vST3jgzUTJe1lfUTYduJzTCKGokXH9RmW0LVG8Weaz4FO3zBE5B
         3gxFQ/Zuv0Ig8h4hcKdqNEnZgMIEX6ytdTPEXIZC2ysnIcjzbMn/Jl1X+IZYgNB3ZOMZ
         LOokuS9jPRZ+8bCGwQhxeeCMpn93OqBherjNZgmwWXuK6MoauqGmVICkZmqSR+4lc1Xd
         AbF+hglHjbEwEtf5rI8/6KuKK5lCOTifjKVjSM7E3YxOwc92kqzDqEhOPG6igezBArQG
         IczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2thOxj6ctqmCSeGKTO0PklZgYjLXVrYMprKtsyIwFdQ=;
        b=s5AgtEFyvAo1l96eNk2U1Vnzvsucc2b1hDFaFyFdfyaDmpSp4CB1CzZ6aB1M2exFCP
         Hs7iGM0Bek5SwgrssqcFpeGA7sluvc1NvdcoWnDDaWVHJXKQ+Ik+85dQjEMV/EivoIix
         egL/5wLBn1vi2NFvchEBytq7Wm4z3oJMN4F77Oz5b157Fc6coNx156C6Iz0VJKS+x2/I
         8SHoEkzPqH4Lgtgg/pGVIi5Psv21gawVbi19OprVNcjFgClOc/OL6O0QDGZOUZzZOEY1
         C8xs9GeCWQiHEqidffNDl59entu2Qn5d2V9b3BDXaooI6PUZDPMh4Qji8eUTZi7Vvy8w
         GDGg==
X-Gm-Message-State: AOAM531t+D5Xxa/pEyuCFBtwH18jg51LnuES/AhVSTyEtJn3Dmld6cPp
        ygld4P5BFm9OmTgGph1DH+QSRy47InY=
X-Google-Smtp-Source: ABdhPJyVj60F7grBg+B2l5aaIJhEeGR0fJFaQCZV0mjDO8r2qBHGpC67A0/P31g3pOyL6B4ETeAtEA==
X-Received: by 2002:a17:90b:1194:: with SMTP id gk20mr24693980pjb.181.1627273103758;
        Sun, 25 Jul 2021 21:18:23 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:cb45:e631:40f9:6a6])
        by smtp.gmail.com with ESMTPSA id d2sm12147861pjd.24.2021.07.25.21.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 21:18:23 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v4] f2fs: change fiemap way in printing compression chunk
Date:   Sun, 25 Jul 2021 21:18:19 -0700
Message-Id: <20210726041819.2059593-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

When we print out a discontinuous compression chunk, it shows like a
continuous chunk now. To show it more correctly, I've changed the way of
printing fiemap info like below. Plus, eliminated NEW_ADDR(-1) in fiemap
info, since it is not in fiemap user api manual.

Let's assume 16KB compression cluster.

<before>
   Logical          Physical         Length           Flags
0:  0000000000000000 00000002c091f000 0000000000004000 1008
1:  0000000000004000 00000002c0920000 0000000000004000 1008
  ...
9:  0000000000034000 0000000f8c623000 0000000000004000 1008
10: 0000000000038000 000000101a6eb000 0000000000004000 1008

<after>
0:  0000000000000000 00000002c091f000 0000000000004000 1008
1:  0000000000004000 00000002c0920000 0000000000004000 1008
  ...
9:  0000000000034000 0000000f8c623000 0000000000001000 1008
10: 0000000000035000 000000101a6ea000 0000000000003000 1008
11: 0000000000038000 000000101a6eb000 0000000000002000 1008
12: 000000000003a000 00000002c3544000 0000000000002000 1008

Flags
0x1000 => FIEMAP_EXTENT_MERGED
0x0008 => FIEMAP_EXTENT_ENCODED

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Tested-by: Eric Biggers <ebiggers@google.com>

---
v4: initialized count_in_cluster
v3: fix the missing last extent flag issue
v2: changed the print format
---
 fs/f2fs/data.c | 75 ++++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3a01a1b50104..1a716c3b5457 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1843,8 +1843,9 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	u64 logical = 0, phys = 0, size = 0;
 	u32 flags = 0;
 	int ret = 0;
-	bool compr_cluster = false;
+	bool compr_cluster = false, compr_appended;
 	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
+	unsigned int count_in_cluster = 0;
 	loff_t maxbytes;
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
@@ -1892,15 +1893,17 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	map.m_next_pgofs = &next_pgofs;
 	map.m_seg_type = NO_CHECK_TYPE;
 
-	if (compr_cluster)
-		map.m_len = cluster_size - 1;
+	if (compr_cluster) {
+		map.m_lblk += 1;
+		map.m_len = cluster_size - count_in_cluster;
+	}
 
 	ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
 	if (ret)
 		goto out;
 
 	/* HOLE */
-	if (!(map.m_flags & F2FS_MAP_FLAGS)) {
+	if (!compr_cluster && !(map.m_flags & F2FS_MAP_FLAGS)) {
 		start_blk = next_pgofs;
 
 		if (blks_to_bytes(inode, start_blk) < blks_to_bytes(inode,
@@ -1910,6 +1913,14 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		flags |= FIEMAP_EXTENT_LAST;
 	}
 
+	compr_appended = false;
+	/* In a case of compressed cluster, append this to the last extent */
+	if (compr_cluster && ((map.m_flags & F2FS_MAP_UNWRITTEN) ||
+			!(map.m_flags & F2FS_MAP_FLAGS))) {
+		compr_appended = true;
+		goto skip_fill;
+	}
+
 	if (size) {
 		flags |= FIEMAP_EXTENT_MERGED;
 		if (IS_ENCRYPTED(inode))
@@ -1926,38 +1937,36 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (start_blk > last_blk)
 		goto out;
 
-	if (compr_cluster) {
-		compr_cluster = false;
-
-
-		logical = blks_to_bytes(inode, start_blk - 1);
-		phys = blks_to_bytes(inode, map.m_pblk);
-		size = blks_to_bytes(inode, cluster_size);
-
-		flags |= FIEMAP_EXTENT_ENCODED;
-
-		start_blk += cluster_size - 1;
-
-		if (start_blk > last_blk)
-			goto out;
-
-		goto prep_next;
-	}
-
+skip_fill:
 	if (map.m_pblk == COMPRESS_ADDR) {
 		compr_cluster = true;
-		start_blk++;
-		goto prep_next;
-	}
-
-	logical = blks_to_bytes(inode, start_blk);
-	phys = blks_to_bytes(inode, map.m_pblk);
-	size = blks_to_bytes(inode, map.m_len);
-	flags = 0;
-	if (map.m_flags & F2FS_MAP_UNWRITTEN)
-		flags = FIEMAP_EXTENT_UNWRITTEN;
+		count_in_cluster = 1;
+	} else if (compr_appended) {
+		unsigned int appended_blks = cluster_size -
+						count_in_cluster + 1;
+		size += blks_to_bytes(inode, appended_blks);
+		start_blk += appended_blks;
+		compr_cluster = false;
+	} else {
+		logical = blks_to_bytes(inode, start_blk);
+		phys = __is_valid_data_blkaddr(map.m_pblk) ?
+			blks_to_bytes(inode, map.m_pblk) : 0;
+		size = blks_to_bytes(inode, map.m_len);
+		flags = 0;
+
+		if (compr_cluster) {
+			flags = FIEMAP_EXTENT_ENCODED;
+			count_in_cluster += map.m_len;
+			if (count_in_cluster == cluster_size) {
+				compr_cluster = false;
+				size += blks_to_bytes(inode, 1);
+			}
+		} else if (map.m_flags & F2FS_MAP_UNWRITTEN) {
+			flags = FIEMAP_EXTENT_UNWRITTEN;
+		}
 
-	start_blk += bytes_to_blks(inode, size);
+		start_blk += bytes_to_blks(inode, size);
+	}
 
 prep_next:
 	cond_resched();
-- 
2.32.0.432.gabb21c7263-goog


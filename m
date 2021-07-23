Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767663D35B4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhGWHJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 03:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbhGWHJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:09:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D474DC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:49:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k4-20020a17090a5144b02901731c776526so7785971pjm.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEkO8gO6Y372IlYBK3JguJ1jBTlnwMBiXGhnUtq9/P0=;
        b=tHVMYjeTgXnLbuliKbZR98nOPSUuT14Wr448SkZPlHED05aXCsN6a6ienQbza85BIW
         hpaEMQEDm4oX4qrNGYGOthE0tY9Yl5dIkZLMrVUUzoosI3dasaYdfGdClNlZsuSABk18
         qDAzhfivMAH4EDedjnwEQA0Jadsc/R5+lMHBZBXQMHBlrwwPFJVPIp2UCZ4j+kWFTwpg
         9og8W7eqQZKe39bpF3nX30uk4tadDbd3tIkSlKQvvn++CD8OsXXBirBoivMsJwiWpOSb
         ZI6kOBnseXPPyE32irK/EgCghfCcDlc/0LlOlZzypqPD0mxcaSpeOancfnDpJeon+pzc
         8HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEkO8gO6Y372IlYBK3JguJ1jBTlnwMBiXGhnUtq9/P0=;
        b=HfOGfR7D1weVfW+s/ib3X7vuyRl4la9ZSTkezArcH9yyjsBsnUXzGsGJ6v5WzWFcrB
         j1DeAlEQuhEdvcKmVD5m7gMiDfEhw9PCUjUovw52Svs3s2QnNoSyhVO744QUGbWc+Rqa
         JNGzy1aOHUHWhqP+QdBSlmxWi+eXXcU1Rp95AVQSiDXvZhZmxs7zUxvLxirZrKemij6+
         IsK8WsRlNsK7JHF9g+eAm99O9a2BhSukaGMvbErS6p5K0HbokKmrtIVMrYetmDfGsf51
         5U6IUpupIA3xHff8dwC8ngIkeA3drL1C1x29o1yWiGN6IjUHzRUC1HgHpVAb9iWCaH4c
         Jdyw==
X-Gm-Message-State: AOAM532OD5M9AbnFtIIryAk0LHXrcH6XDSUI5uwZvWUCA+xHFw3S/Iwn
        Zu3zhM7VWO8UHg+/5CM6PLFAOSpJWhs=
X-Google-Smtp-Source: ABdhPJwNP57FHef6iXOx5uq5Ix7GZqt1vwuT7xj1c7b08fQA61B2FqZYNM1SirpD1K/0kg5PpalAgA==
X-Received: by 2002:a05:6a00:180d:b029:331:bcb5:1589 with SMTP id y13-20020a056a00180db0290331bcb51589mr3413182pfa.27.1627026572916;
        Fri, 23 Jul 2021 00:49:32 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:4610:babe:3aeb:2b63])
        by smtp.gmail.com with ESMTPSA id c24sm14873204pfp.129.2021.07.23.00.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 00:49:32 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: change fiemap way in printing compression chunk
Date:   Fri, 23 Jul 2021 00:49:28 -0700
Message-Id: <20210723074928.1659385-1-daeho43@gmail.com>
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

---
v3: fix the missing last extent flag issue
v2: changed the print format
---
 fs/f2fs/data.c | 75 ++++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3a01a1b50104..29b09a74cdc9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1843,8 +1843,9 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	u64 logical = 0, phys = 0, size = 0;
 	u32 flags = 0;
 	int ret = 0;
-	bool compr_cluster = false;
+	bool compr_cluster = false, compr_appended;
 	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
+	unsigned int count_in_cluster;
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


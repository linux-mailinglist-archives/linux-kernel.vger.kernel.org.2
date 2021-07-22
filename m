Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF33D2F02
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 23:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhGVUiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 16:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhGVUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 16:38:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD91CC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 14:19:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k1so632406plt.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MtB0Pe+HpTTnpOXUl0i7ZYxuksvA1VGHCZTzux/Ivfg=;
        b=UXwwYtj2Rm1+R18AqC/evMp6rEzaA+7UNZLMn8pdAlQg6NKkkO9xURhifbhi0FWXa7
         gSh85TvDKY2CYR+TvliJTFSaXJDPdQzYvL0YbsRfYs2RpaQ/7tNh/XLHM8wRNipWiyEf
         mm7F+RKjnDRebiWp6mLW7NB9K0nZNHQX6R6gH1HnZT5BotoNxFmkUjIRmmaT9RoA+uwJ
         LVqXne2rLT8QrJz+pO3d1cmawMpmT3FWnyLfVupx5CU7BdpsckAJg0UInDwPlnd1AHlr
         U2kALZunJcGPXX1rtvMAlCfit5+CjTUZBNaTXVA9tqvoVwVpVPT0dzGBbGB2vVLagvGY
         U7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MtB0Pe+HpTTnpOXUl0i7ZYxuksvA1VGHCZTzux/Ivfg=;
        b=J1ysRvnVawvmFr6v1wLCcmrFlkLBOUUuv8MfnOhp5HeNndbxtQL78FcYg/nHD/YU+S
         rBiVeIE/HBZgPYYTYNQ0fhF50CLLQOWLR0IVyp3a5kb2tH/qGS/evidhjhDYZSUP78hJ
         Sf0YN/002dL0C1Hn/KI2P0Z9yRNynANi13HiVhTWDyU91gJOjkAeEw54g+Yw2LFPXV9S
         8m/+PGbr0CoxwsTwZ1gu6nqV3qxTlD/jqeudSB5MgAYdZlXk75ICGAlOXH4LCnx30u8Y
         59QmKZyZPVdcCzNcpDQ/vzrVTPyW+iDVYjcR1rOBMaiId2DFd8y2E8HNKfy1aNBjLhpo
         3+rA==
X-Gm-Message-State: AOAM531nF1VgHkxKrelq5pDEPRN9/+u0TpjsVfaI9sWhzpcHATgsZrLg
        EFGwhXPfyEItXUj/1ux9JBMmSdAnWuA=
X-Google-Smtp-Source: ABdhPJwsvXCwP/KZNqFOpPbQyGno5OlH3c/2TTMgc96WP5XWHCEjoicbXCSpFWIVhS7A6S01L/ch7w==
X-Received: by 2002:a05:6a00:1307:b029:308:1e2b:a24b with SMTP id j7-20020a056a001307b02903081e2ba24bmr1601407pfu.57.1626988766870;
        Thu, 22 Jul 2021 14:19:26 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:4610:babe:3aeb:2b63])
        by smtp.gmail.com with ESMTPSA id s21sm6984489pfw.69.2021.07.22.14.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:19:26 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: change fiemap way in printing compression chunk
Date:   Thu, 22 Jul 2021 14:19:21 -0700
Message-Id: <20210722211921.3791312-1-daeho43@gmail.com>
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

   Logical          Physical         Length           Flags
0: 0000000000000000 0000000fdf692000 0000000000004000 1008
1: 0000000000004000 0000000fdf693000 0000000000004000 1008
2: 0000000000008000 0000000fdf694000 0000000000004000 1008
3: 000000000000c000 0000000fdf695000 0000000000004000 1008
4: 0000000000010000 0000000fdf696000 000000000000c000 1000
5: 000000000001c000 0000000f8c60d000 0000000000010000 1000
6: 000000000002c000 0000000f8c61d000 0000000000004000 1008
7: 0000000000030000 0000000f8c620000 0000000000004000 1008
8: 0000000000034000 0000000f8c623000 0000000000001000 1008
9: 0000000000035000 0000000fc7af4000 0000000000003000 1008

Flags
0x1000 => FIEMAP_EXTENT_MERGED
0x0008 => FIEMAP_EXTENT_ENCODED

Signed-off-by: Daeho Jeong <daehojeong@google.com>

---
v2: changed the print format
---
 fs/f2fs/data.c | 76 ++++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 34 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3a01a1b50104..058dc751e3a6 100644
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
@@ -1892,8 +1893,10 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
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
@@ -1903,11 +1906,23 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!(map.m_flags & F2FS_MAP_FLAGS)) {
 		start_blk = next_pgofs;
 
-		if (blks_to_bytes(inode, start_blk) < blks_to_bytes(inode,
+		if (blks_to_bytes(inode, start_blk) >= blks_to_bytes(inode,
 						max_inode_blocks(inode)))
+			flags |= FIEMAP_EXTENT_LAST;
+		else if (!compr_cluster)
 			goto prep_next;
+	}
+
+	compr_appended = false;
+	/* In a case of compressed cluster, append this to the last extent */
+	if (compr_cluster && ((map.m_flags & F2FS_MAP_UNWRITTEN) ||
+			!(map.m_flags & F2FS_MAP_FLAGS))) {
+		unsigned int appended_blks = cluster_size - count_in_cluster + 1;
 
-		flags |= FIEMAP_EXTENT_LAST;
+		size += blks_to_bytes(inode, appended_blks);
+		if (map.m_flags & F2FS_MAP_UNWRITTEN)
+			start_blk += appended_blks;
+		compr_appended = true;
 	}
 
 	if (size) {
@@ -1926,38 +1941,31 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
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


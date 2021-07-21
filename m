Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38363D099F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 09:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhGUGoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 02:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbhGUGk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 02:40:26 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0ECC061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 00:20:53 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d12so1579529pfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 00:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iqz1gu8smtI/WSbcMLkLO4VdATGiffJbqsfYXKHNGZ4=;
        b=lu21NlGOcPgTFAe8GYzyxI0JPTo893eCPZfjPHKvbuOUL78zT/6uxzpBW8K8DQfPgK
         rXodmhLdtJqiHXazrdKFPM2jLe0z/CwruZhC7NiO5grBSv7AzX8cTonRiGJjgyAZIMQV
         qFmghawdnsr19Hn2LC11Pzl1rFsrXVOTfcZTG+hbxApzKZCWC+YP5CUzJcIXPfWPt9Sr
         apRL2YmXPpteNZZnvtJerEk1TWASVNdhyweixpXXNUpO96OEjwwgR6fd6NS8AEIy34Hv
         /0myKPg5ylL9WVrjghH66qUeILikLrJ48wnSsQij1mCCH9QFuG96i9W1iHgyX6RkNajA
         wFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iqz1gu8smtI/WSbcMLkLO4VdATGiffJbqsfYXKHNGZ4=;
        b=pUdyaNnZ9wgGLzaDKOVIkody+oQkY/T64K130qsOwYO9Ra5v0Mlz2OAdcSHQ40IA6r
         86bMjLgyf4E7bG4Owf5OjvzqinOmhEKSRtMSJnAUT2TxOwaZwDD5dEQaS4QsPuCv1aPb
         CgZIZAevBfjjp6KTq8M27SoW6k3EuvDcYbTH2fNkLlSnsUYb02xTM6bLGj7XP5RN8giy
         iGo/qo2L+abRIds1jJ2FJ2S646sbASI+GnAnJhKu3ijHc2jRCCAlPhNHf8gQKQRdE6CS
         XJw5TtSOV7h76xy/qJ3f6g4rqBqx43xG6r4DTwZxOPniDlEhetiXptNwK+x44tfdCAxC
         ZEDA==
X-Gm-Message-State: AOAM530LjJCIJMlyRc4rD0zJO6fytUa8U6+8tWc6fX9Gjo2RAxExnOmA
        Qq2AxAW0OOF6A7VOH76nOyIj2UtJo5U=
X-Google-Smtp-Source: ABdhPJyfgcP/8dOuJ8qlI13D8FBpGEZzSI3ulQmZyFMe72jWqZiqN1TjaTZeKmQ/ZXQk8yV5RALavg==
X-Received: by 2002:a63:a1c:: with SMTP id 28mr6955182pgk.445.1626852052504;
        Wed, 21 Jul 2021 00:20:52 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:ceb8:c22e:42fc:5db])
        by smtp.gmail.com with ESMTPSA id 20sm26651156pfi.170.2021.07.21.00.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 00:20:52 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: change fiemap way in printing compression chunk
Date:   Wed, 21 Jul 2021 00:20:48 -0700
Message-Id: <20210721072048.3035928-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
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

0: 0000000000000000 0000000000000000 0000000000001000 1008 (M/E)
1: 0000000000001000 0000000f15c0f000 0000000000001000 1008 (M/E)
2: 0000000000002000 0000000000000000 0000000000002000 1808 (M/U/E)
3: 0000000000004000 0000000000000000 0000000000001000 1008 (M/E)
4: 0000000000005000 0000000f15c10000 0000000000001000 1008 (M/E)
5: 0000000000006000 0000000000000000 0000000000002000 1808 (M/U/E)
6: 0000000000008000 0000000000000000 0000000000001000 1008 (M/E)
M => FIEMAP_EXTENT_MERGED
E => FIEMAP_EXTENT_ENCODED
U => FIEMAP_EXTENT_UNWRITTEN

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3a01a1b50104..6e1be876d96b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1845,6 +1845,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	int ret = 0;
 	bool compr_cluster = false;
 	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
+	unsigned int count_in_cluster;
 	loff_t maxbytes;
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
@@ -1893,7 +1894,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	map.m_seg_type = NO_CHECK_TYPE;
 
 	if (compr_cluster)
-		map.m_len = cluster_size - 1;
+		map.m_len = cluster_size - count_in_cluster;
 
 	ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
 	if (ret)
@@ -1926,37 +1927,26 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
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
-	if (map.m_pblk == COMPRESS_ADDR) {
-		compr_cluster = true;
-		start_blk++;
-		goto prep_next;
-	}
-
 	logical = blks_to_bytes(inode, start_blk);
-	phys = blks_to_bytes(inode, map.m_pblk);
+	phys = __is_valid_data_blkaddr(map.m_pblk) ?
+		blks_to_bytes(inode, map.m_pblk) : 0;
 	size = blks_to_bytes(inode, map.m_len);
 	flags = 0;
 	if (map.m_flags & F2FS_MAP_UNWRITTEN)
 		flags = FIEMAP_EXTENT_UNWRITTEN;
 
+	if (map.m_pblk == COMPRESS_ADDR) {
+		flags |= FIEMAP_EXTENT_ENCODED;
+		compr_cluster = true;
+		count_in_cluster = 1;
+	} else if (compr_cluster) {
+		flags |= FIEMAP_EXTENT_ENCODED;
+		if (map.m_len > 0)
+			count_in_cluster += map.m_len;
+		if (count_in_cluster == cluster_size)
+			compr_cluster = false;
+	}
+
 	start_blk += bytes_to_blks(inode, size);
 
 prep_next:
-- 
2.32.0.402.g57bb445576-goog


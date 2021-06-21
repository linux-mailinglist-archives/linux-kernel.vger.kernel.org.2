Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696683AE1B2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 04:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFUCmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 22:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229899AbhFUCmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 22:42:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A9506117A;
        Mon, 21 Jun 2021 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624243229;
        bh=kvA/863X51D5uuCExsqTAZJw9OimySqMMSVIU2Op2YE=;
        h=From:To:Cc:Subject:Date:From;
        b=CZv9pbMWPrzni0vevDUjAs3JnoDYWodl76e62ay6jo0FyyVcun5R/YRxyneOIAngX
         zKRoNdMairPxKeihcsJa7McHeMdVuEHPzjQ/Wywt/afdKsyZg9HglfxXvDnY04oHUm
         OHyqeWq3uG1P4GXh9djNKNsOYYD2FXdxYlPoYviW6utjMIoxWvQ2EaTGe+zRGCuHHV
         KZXGnYw4FfgD3tCq/vd4pXmV1KIL3vjEAcwRXZzjLOX9CjwSBzazEIJMgh8CGhgj1q
         sHLoTnmChbrJrROcL8OmY/XEHSMnkeENN+h90537IrgNw7XognJLWTGCmH2QMhUyca
         aBk07OdNgHKyA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Daeho Jeong <daehojeong@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: enable extent cache for compression files in read-only
Date:   Sun, 20 Jun 2021 19:40:27 -0700
Message-Id: <20210621024027.1511092-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Let's allow extent cache for RO partition.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d84e78dabdbe..16ce1ade9fa6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3148,25 +3148,6 @@ static inline bool is_dot_dotdot(const u8 *name, size_t len)
 	return false;
 }
 
-static inline bool f2fs_may_extent_tree(struct inode *inode)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-
-	if (!test_opt(sbi, EXTENT_CACHE) ||
-			is_inode_flag_set(inode, FI_NO_EXTENT) ||
-			is_inode_flag_set(inode, FI_COMPRESSED_FILE))
-		return false;
-
-	/*
-	 * for recovered files during mount do not create extents
-	 * if shrinker is not registered.
-	 */
-	if (list_empty(&sbi->s_list))
-		return false;
-
-	return S_ISREG(inode->i_mode);
-}
-
 static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
 					size_t size, gfp_t flags)
 {
@@ -4201,6 +4182,26 @@ F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
 F2FS_FEATURE_FUNCS(compression, COMPRESSION);
 F2FS_FEATURE_FUNCS(readonly, RO);
 
+static inline bool f2fs_may_extent_tree(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	if (!test_opt(sbi, EXTENT_CACHE) ||
+			is_inode_flag_set(inode, FI_NO_EXTENT) ||
+			(is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
+			 !f2fs_sb_has_readonly(sbi)))
+		return false;
+
+	/*
+	 * for recovered files during mount do not create extents
+	 * if shrinker is not registered.
+	 */
+	if (list_empty(&sbi->s_list))
+		return false;
+
+	return S_ISREG(inode->i_mode);
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
 				    block_t blkaddr)
-- 
2.32.0.288.g62a8d224e6-goog


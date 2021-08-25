Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FBD3F7467
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbhHYLfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239099AbhHYLfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:35:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEBA46113C;
        Wed, 25 Aug 2021 11:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629891270;
        bh=6hoWY3WQkLX2sswImTRTA9ZnKWT/Ne5C9i57x+tLmDU=;
        h=From:To:Cc:Subject:Date:From;
        b=WK5mZjfeNnEPTo8w+meCKT8nmz+qK/b4a1XySxdnsAQrDSh0NABTzFKtUrjMM55hj
         9KkUVnlOCoXKkSKF5dlTTfZ0kzys0fxAvY+AXkmywnYrUplagsnVug42VQ3MYyMy1i
         YsNSeQk6kVQJbhCfavIOtNiHlwLrZ77seoWseiRzrFaxEIfh6QQPHFkv8PJa0zoeuG
         X16MrgRPEMWpl3uVEnoiK3+VNj1iMl3+EyG9K+H5XCOMbBugBAnDjiIWXV5Sor9xaJ
         AjbDotUDyb/rWb5TCH0bqgHWPjwAlyngM3RIQi0HYMsytvzIlXp6mbmLaEvQxFl+pu
         0SP9utR/6F9cw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to unmap pages from userspace process in punch_hole()
Date:   Wed, 25 Aug 2021 19:34:19 +0800
Message-Id: <20210825113419.8645-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to unmap pages from userspace process before removing pagecache
in punch_hole() like we did in f2fs_setattr().

Similar change:
commit 5e44f8c374dc ("ext4: hole-punch use truncate_pagecache_range")

Fixes: fbfa2cc58d53 ("f2fs: add file operations")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3330efb41f22..f30b841d4e5a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1106,7 +1106,6 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		}
 
 		if (pg_start < pg_end) {
-			struct address_space *mapping = inode->i_mapping;
 			loff_t blk_start, blk_end;
 			struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
@@ -1118,8 +1117,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 			down_write(&F2FS_I(inode)->i_mmap_sem);
 
-			truncate_inode_pages_range(mapping, blk_start,
-					blk_end - 1);
+			truncate_pagecache_range(inode, blk_start, blk_end - 1);
 
 			f2fs_lock_op(sbi);
 			ret = f2fs_truncate_hole(inode, pg_start, pg_end);
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168723EE080
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 01:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhHPXnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 19:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232726AbhHPXnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 19:43:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2182760EE0;
        Mon, 16 Aug 2021 23:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629157398;
        bh=NrRsJNff5j+swFa8HAxh+3BW3YLAq/RCrLszGjLzw9k=;
        h=From:To:Cc:Subject:Date:From;
        b=uTWVsbUtGlZ8JfRT3RHEsJWL0fhLyk3snGshZLfgNl52/DOVnTzVof8jh41BRQOQ6
         zRhTqzxmyHopbF2jvBa5INLeDwj4o3z7iElodM6sc6P9yVf6grdkDKAe/lHso2nqPC
         TwNw2uMWzVDJeb31dvEsNESuk0tAeVDC6Xm5ZzW7eJH0+BEGsqkftGgwbTXiGZ3KRr
         lLF3i/ykew6s777lGAfitw9HWx42oKHr0jEL/XrfE8Bnd12xHiHGXnHvwHdp2avQqF
         oT7u0gfe/kp8i0vQR2U3vTj6xTxMorZwPqmG6xyXLIj2LE8DQIiE6A4kQNChbgJ1Jo
         Mw+UItSjmIeNw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] f2fs: Add missing inline to f2fs_sanity_check_cluster() stub
Date:   Mon, 16 Aug 2021 16:42:47 -0700
Message-Id: <20210816234247.139528-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, there is a warning in nearly every fs/f2fs/ file when
F2FS_FS_COMPRESSION is not set:

In file included from fs/f2fs/super.c:31:
fs/f2fs/f2fs.h:4251:13: warning: unused function 'f2fs_sanity_check_cluster' [-Wunused-function]
static bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
            ^
1 warning generated.

Fixes: 1495870233e7 ("f2fs: compress: do sanity check on cluster")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0c978f934dcc..fe1097e678da 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4248,7 +4248,7 @@ static inline void f2fs_put_page_dic(struct page *page)
 	WARN_ON_ONCE(1);
 }
 static inline unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn) { return 0; }
-static bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
+static inline bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
 static inline int f2fs_init_compress_inode(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi) { }
 static inline int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi) { return 0; }

base-commit: f4b05791dda93edb03ebb6b48f1be104b2e64274
-- 
2.33.0.rc2


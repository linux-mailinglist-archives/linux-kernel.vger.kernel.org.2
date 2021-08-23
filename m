Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D3E3F4EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhHWRCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhHWRCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:02:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43C9861371;
        Mon, 23 Aug 2021 17:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629738113;
        bh=l1QzhnmDx6j5Mo9ionHtqp1z0YofUbL+bbew5Dj9YYo=;
        h=From:To:Cc:Subject:Date:From;
        b=jwyEKZa2USyHYPNvzjfM3aZudsMZ7aBP8c5ive48y1YkK/4Pc8R/0BHplqrNiOrVM
         BVhnYPAmRZkxaOep6YKhh67gkszdDpwIe8LrRZCTUvJAY8SidJlBEWNO4U3EaSWqjS
         tbPwsvI2Hrm8N66gj48BaZth7Mn9OnGXqzROfQu1jYFJ3g503bd804avPg2+YGMiyI
         ouVVl3BIyViT/kNkFiAOlmGya5G+Ke5KHFMkIL5BXGyyhgYGcTlHeLQpYCVu3aAoHb
         CeHXRLojCWJA3DvmW0/WFjV+66LOQSCtLNtIAiztUWvxaTbq2UpiiUJlygeflYH6fM
         vEjaH5BrcrXJQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: don't ignore writing pages on fsync during checkpoint=disable
Date:   Mon, 23 Aug 2021 10:01:51 -0700
Message-Id: <20210823170151.1434772-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must flush dirty pages when calling fsync() during checkpoint=disable.
Returning zero makes inode being clear, which fails to flush them when
enabling checkpoint back even by sync_inodes_sb().

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d4fc5e0d2ffe..45c54332358b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -262,8 +262,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	};
 	unsigned int seq_id = 0;
 
-	if (unlikely(f2fs_readonly(inode->i_sb) ||
-				is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
+	if (unlikely(f2fs_readonly(inode->i_sb)))
 		return 0;
 
 	trace_f2fs_sync_file_enter(inode);
@@ -277,7 +276,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	ret = file_write_and_wait_range(file, start, end);
 	clear_inode_flag(inode, FI_NEED_IPU);
 
-	if (ret) {
+	if (ret || is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
 		trace_f2fs_sync_file_exit(inode, cp_reason, datasync, ret);
 		return ret;
 	}
-- 
2.33.0.rc2.250.ged5fa647cd-goog


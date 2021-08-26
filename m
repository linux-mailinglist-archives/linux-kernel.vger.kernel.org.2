Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F7A3F8C80
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 18:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243140AbhHZQxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 12:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243074AbhHZQxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E4B560F6F;
        Thu, 26 Aug 2021 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629996737;
        bh=guErEWGgIDqVdyfI48N0DvYQV67NWP3/SnLf44qfyPE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=TWyi+FVi1qU8QTruMGbCChcl56G2e9GzyTo2mCeFA7wsMRPleNRV+awoOyDlLZZLG
         N95jEpV1PbA7PxYp5JvewfhZTAvAbVwCRETXysbtZhrJhpjCWIXg7cEIadmrJlaydv
         VkEMg7sfIX28Kp99UVA8dCUI5m0NuHIVtGtg6+t59neNK4ZmBt3Z3SNB6VPp3/lA/1
         +lkrDk2yzCpCT/CTpSlYJkYAu5IIyJ3X/9N3LxEGll16F4puyRidWghvcm2aIY8n8O
         XTJtdlR9WWwvrzlqps9asL7TnJrLlV53Yvn8Bpt77Bw6F+GkLeIN/0K1M4imY8s92a
         6AFm9sPIyIw6Q==
Date:   Thu, 26 Aug 2021 09:52:16 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: don't ignore writing pages on fsync
 during checkpoint=disable
Message-ID: <YSfGwKtGhutsTJ8x@google.com>
References: <20210823170151.1434772-1-jaegeuk@kernel.org>
 <YSa3DPBIFZ5P17vt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSa3DPBIFZ5P17vt@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 64fe93a7f9c35c2b5a34cfa3cf84158852c201be Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 19 Aug 2021 14:00:57 -0700
Subject: [PATCH] f2fs: guarantee to write dirty data when enabling checkpoint
 back

We must flush all the dirty data when enabling checkpoint back. Let's guarantee
that first by adding a retry logic on sync_inodes_sb(). In addition to that,
this patch adds to flush data in fsync when checkpoint is disabled, which can
mitigate the sync_inodes_sb() failures in advance.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Change log from v2:
- repharse the patch description a bit
- fix retry condition check

 fs/f2fs/file.c  |  5 ++---
 fs/f2fs/super.c | 11 ++++++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cc2080866c54..3330efb41f22 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -263,8 +263,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	};
 	unsigned int seq_id = 0;
 
-	if (unlikely(f2fs_readonly(inode->i_sb) ||
-				is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
+	if (unlikely(f2fs_readonly(inode->i_sb)))
 		return 0;
 
 	trace_f2fs_sync_file_enter(inode);
@@ -278,7 +277,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	ret = file_write_and_wait_range(file, start, end);
 	clear_inode_flag(inode, FI_NEED_IPU);
 
-	if (ret) {
+	if (ret || is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
 		trace_f2fs_sync_file_exit(inode, cp_reason, datasync, ret);
 		return ret;
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 49e153fd8183..b8fecf4f37e0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2088,8 +2088,17 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
+	int retry = DEFAULT_RETRY_IO_COUNT;
+
 	/* we should flush all the data to keep data consistency */
-	sync_inodes_sb(sbi->sb);
+	do {
+		sync_inodes_sb(sbi->sb);
+		cond_resched();
+		congestion_wait(BLK_RW_ASYNC, DEFAULT_IO_TIMEOUT);
+	} while (get_pages(sbi, F2FS_DIRTY_DATA) && retry--);
+
+	if (unlikely(retry < 0))
+		f2fs_warn(sbi, "checkpoint=enable has some unwritten data.");
 
 	down_write(&sbi->gc_lock);
 	f2fs_dirty_to_prefree(sbi);
-- 
2.33.0.rc2.250.ged5fa647cd-goog


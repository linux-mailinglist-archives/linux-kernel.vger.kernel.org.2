Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDBE3F7DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 23:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhHYVdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 17:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhHYVds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 17:33:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAAD8610C7;
        Wed, 25 Aug 2021 21:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629927182;
        bh=D8iK6G3Bb7hdOrp7isR46w/hrxdUS2CD53SAelcnhxg=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=lTb1ngu/UMRiIKK9CndtSGS0JuGl2Utt1PvlqBUqRaGtv4NTbljUD0dd22Alw1iWA
         Lwd9gBG1eXLOx8o3WH1Oc0p6r7BHQkIiLedPBYuCSdZVZ5qrpxSuRvlyNBKNg0owdd
         dXe5RVPPQ+JRSBYzrcJ4K9K7zBOpav6t/trCWSThnPaoeLHLtDsEq3WfxOvIRtJeFJ
         3ohCG6dRrz1LryyfdcaEAAOCtoE0MhUBZ0l6FWQCAeYf1ga7YIfr7ZW6idm80Q96eY
         lN5LUCFWhK1FKj8hSB5v629I3vdiGftJ4sGzBO6GAWdaF9e0VPfFl2pYhN20SC+0+x
         +PpGdYGWvA6lA==
Date:   Wed, 25 Aug 2021 14:33:00 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: don't ignore writing pages on fsync during
 checkpoint=disable
Message-ID: <YSa3DPBIFZ5P17vt@google.com>
References: <20210823170151.1434772-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823170151.1434772-1-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must flush all the dirty data when enabling checkpoint back. Let's guarantee
that first. In order to mitigate any failure, let's flush data in fsync as well
during checkpoint=disable.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2 from v1:
 - handle sync_inodes_sb() failure

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
index 49e153fd8183..d2f97dfb17af 100644
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
+	if (unlikely(!retry))
+		f2fs_warn(sbi, "checkpoint=enable has some unwritten data.");
 
 	down_write(&sbi->gc_lock);
 	f2fs_dirty_to_prefree(sbi);
-- 
2.33.0.rc2.250.ged5fa647cd-goog


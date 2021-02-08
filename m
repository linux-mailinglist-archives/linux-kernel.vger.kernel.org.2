Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DEF314268
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhBHV5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:57:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhBHV5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:57:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A62A64E6E;
        Mon,  8 Feb 2021 21:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612821387;
        bh=wvU6F8HGbdOxGv1rqDFb603k8QhQouYpvvt3l81tbCY=;
        h=From:To:Cc:Subject:Date:From;
        b=Ix0lsBVuwu0OUTwUz71OxPjn/ALiOBKLO9N9uXNCV7HsvmIkeOlW4tu93T+rUsucN
         qot8Fb5uNY+xcOUaKAczqJQO1dV2YmCJJVhS9AAWYWWWrhLGpK5+zjUVPf+uoV78kx
         ZQW5yEfPvedHz+T7KGIDc9wW1yDOf6QI4Nln7T/Xee/AeiMimIaAMitrDRqZQx52Kn
         HcgVdD6l4RYckB0fMchJkF04U0wnyoGPCFDRK/miewb1Cxhrv4eQkoKEXAhOwS33kp
         aRLxNFYE1vBX8gySpaMH61nRCF6hWGppHe6VMlneom0Lo9LFb5UIjJzCvfr+htGRyy
         h0E4t1Z2xIoJg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: don't grab superblock freeze for flush/ckpt thread
Date:   Mon,  8 Feb 2021 13:56:16 -0800
Message-Id: <20210208215616.1606535-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are controlled by f2fs_freeze().

This fixes xfstests/generic/068 which is stuck at

 task:f2fs_ckpt-252:3 state:D stack:    0 pid: 5761 ppid:     2 flags:0x00004000
 Call Trace:
  __schedule+0x44c/0x8a0
  schedule+0x4f/0xc0
  percpu_rwsem_wait+0xd8/0x140
  ? percpu_down_write+0xf0/0xf0
  __percpu_down_read+0x56/0x70
  issue_checkpoint_thread+0x12c/0x160 [f2fs]
  ? wait_woken+0x80/0x80
  kthread+0x114/0x150
  ? __checkpoint_and_complete_reqs+0x110/0x110 [f2fs]
  ? kthread_park+0x90/0x90
  ret_from_fork+0x22/0x30

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 4 ----
 fs/f2fs/segment.c    | 4 ----
 fs/f2fs/super.c      | 4 ++++
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 579b9c3603cc..174a0819ad96 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1763,13 +1763,9 @@ static int issue_checkpoint_thread(void *data)
 	if (kthread_should_stop())
 		return 0;
 
-	sb_start_intwrite(sbi->sb);
-
 	if (!llist_empty(&cprc->issue_list))
 		__checkpoint_and_complete_reqs(sbi);
 
-	sb_end_intwrite(sbi->sb);
-
 	wait_event_interruptible(*q,
 		kthread_should_stop() || !llist_empty(&cprc->issue_list));
 	goto repeat;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7d34f1cacdee..440634dfaa56 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -607,8 +607,6 @@ static int issue_flush_thread(void *data)
 	if (kthread_should_stop())
 		return 0;
 
-	sb_start_intwrite(sbi->sb);
-
 	if (!llist_empty(&fcc->issue_list)) {
 		struct flush_cmd *cmd, *next;
 		int ret;
@@ -629,8 +627,6 @@ static int issue_flush_thread(void *data)
 		fcc->dispatch_list = NULL;
 	}
 
-	sb_end_intwrite(sbi->sb);
-
 	wait_event_interruptible(*q,
 		kthread_should_stop() || !llist_empty(&fcc->issue_list));
 	goto repeat;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1000d21120ca..4aa533cb4340 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1472,6 +1472,10 @@ static int f2fs_freeze(struct super_block *sb)
 	/* must be clean, since sync_filesystem() was already called */
 	if (is_sbi_flag_set(F2FS_SB(sb), SBI_IS_DIRTY))
 		return -EINVAL;
+
+	/* ensure no checkpoint required */
+	if (!llist_empty(&F2FS_SB(sb)->cprc_info.issue_list))
+		return -EINVAL;
 	return 0;
 }
 
-- 
2.30.0.478.g8a0d178c01-goog


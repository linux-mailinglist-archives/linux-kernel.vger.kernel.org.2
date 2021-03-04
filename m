Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6244D32CFD2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbhCDJiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:38:08 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:58324 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237719AbhCDJiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:38:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UQMzC4w_1614850643;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UQMzC4w_1614850643)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Mar 2021 17:37:23 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rpeterso@redhat.com
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] gfs2: make function gfs2_make_fs_ro() to void type
Date:   Thu,  4 Mar 2021 17:37:20 +0800
Message-Id: <1614850640-63803-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It fixes the following warning detected by coccinelle:
./fs/gfs2/super.c:592:5-10: Unneeded variable: "error". Return "0" on
line 628

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/gfs2/ops_fstype.c | 4 +---
 fs/gfs2/super.c      | 9 +++------
 fs/gfs2/super.h      | 2 +-
 fs/gfs2/util.c       | 2 +-
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 74c7d01..aa41360 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1539,9 +1539,7 @@ static int gfs2_reconfigure(struct fs_context *fc)
 			return -EINVAL;
 
 		if (fc->sb_flags & SB_RDONLY) {
-			error = gfs2_make_fs_ro(sdp);
-			if (error)
-				errorfc(fc, "unable to remount read-only");
+			gfs2_make_fs_ro(sdp);
 		} else {
 			error = gfs2_make_fs_rw(sdp);
 			if (error)
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 861ed5f..6e2588f 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -587,9 +587,8 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
  * Returns: errno
  */
 
-int gfs2_make_fs_ro(struct gfs2_sbd *sdp)
+void gfs2_make_fs_ro(struct gfs2_sbd *sdp)
 {
-	int error = 0;
 	int log_write_allowed = test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
 
 	gfs2_flush_delete_work(sdp);
@@ -625,7 +624,7 @@ int gfs2_make_fs_ro(struct gfs2_sbd *sdp)
 	if (!log_write_allowed)
 		sdp->sd_vfs->s_flags |= SB_RDONLY;
 
-	return error;
+	return;
 }
 
 /**
@@ -658,9 +657,7 @@ static void gfs2_put_super(struct super_block *sb)
 	spin_unlock(&sdp->sd_jindex_spin);
 
 	if (!sb_rdonly(sb)) {
-		error = gfs2_make_fs_ro(sdp);
-		if (error)
-			gfs2_io_error(sdp);
+		gfs2_make_fs_ro(sdp);
 	}
 	WARN_ON(gfs2_withdrawing(sdp));
 
diff --git a/fs/gfs2/super.h b/fs/gfs2/super.h
index 08e502d..ec4affb3 100644
--- a/fs/gfs2/super.h
+++ b/fs/gfs2/super.h
@@ -34,7 +34,7 @@ extern int gfs2_lookup_in_master_dir(struct gfs2_sbd *sdp, char *filename,
 				     struct gfs2_inode **ipp);
 
 extern int gfs2_make_fs_rw(struct gfs2_sbd *sdp);
-extern int gfs2_make_fs_ro(struct gfs2_sbd *sdp);
+extern void gfs2_make_fs_ro(struct gfs2_sbd *sdp);
 extern void gfs2_online_uevent(struct gfs2_sbd *sdp);
 extern int gfs2_statfs_init(struct gfs2_sbd *sdp);
 extern void gfs2_statfs_change(struct gfs2_sbd *sdp, s64 total, s64 free,
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 8d3c670..5874331 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -156,7 +156,7 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 				ret = 0;
 		}
 		if (!ret)
-			ret = gfs2_make_fs_ro(sdp);
+			gfs2_make_fs_ro(sdp);
 		gfs2_freeze_unlock(&freeze_gh);
 	}
 
-- 
1.8.3.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D98A3DF8F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 02:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhHDAi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 20:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhHDAi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 20:38:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9517A60187;
        Wed,  4 Aug 2021 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628037524;
        bh=xSY+GAshPQV+RFL1RiNbZo4ejBBkBBXoMgB7zAVULyc=;
        h=From:To:Cc:Subject:Date:From;
        b=bSYbK53RP6MDVI88LeTswj+AChEFQ3hZoa7VbDajkYKxYmgiouPA2s9fNgErdRRvM
         pQFx2UtdQ5HEeLKkOccPXEO1PlnQ4SwVFiM8UNdWGchq8pQuSDQYvizfQyLJtfvqJP
         AD06vzDn2kZwopx2q6lOcEVs/okS3qy1ZWKEE79e0tfJs9mILgHPOCLhbHvbCfwWAL
         3OR4zEl/NOwBPkmkPmetq8tbnvKqS/XVCKg7nGeWhihC99Ia4RK9fevG8LMAan4Kqx
         q+vY01aBXGWNnCDnlbACeGcaccS9bQhNalKfsdmw1hO6Lb5k59609ON7yQ8iDmbrAu
         iT1FtUYKYJUSg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v4] f2fs: fix to stop filesystem update once CP failed
Date:   Wed,  4 Aug 2021 08:38:38 +0800
Message-Id: <20210804003838.1411425-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During f2fs_write_checkpoint(), once we failed in
f2fs_flush_nat_entries() or do_checkpoint(), metadata of filesystem
such as prefree bitmap, nat/sit version bitmap won't be recovered,
it may cause f2fs image to be inconsistent, let's just set CP error
flag to avoid further updates until we figure out a scheme to rollback
all metadatas in such condition.

Reported-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
- add congestion_wait() and f2fs_stop_checkpoint() in
f2fs_flush_device_cache
- use DEFAULT_RETRY_IO_COUNT
 fs/f2fs/checkpoint.c | 12 +++++++++---
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/segment.c    | 15 +++++++++++++--
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 6c208108d69c..7f6745f4630e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1639,8 +1639,11 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* write cached NAT/SIT entries to NAT/SIT area */
 	err = f2fs_flush_nat_entries(sbi, cpc);
-	if (err)
+	if (err) {
+		f2fs_err(sbi, "f2fs_flush_nat_entries failed err:%d, stop checkpoint", err);
+		f2fs_bug_on(sbi, !f2fs_cp_error(sbi));
 		goto stop;
+	}
 
 	f2fs_flush_sit_entries(sbi, cpc);
 
@@ -1648,10 +1651,13 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	f2fs_save_inmem_curseg(sbi);
 
 	err = do_checkpoint(sbi, cpc);
-	if (err)
+	if (err) {
+		f2fs_err(sbi, "do_checkpoint failed err:%d, stop checkpoint", err);
+		f2fs_bug_on(sbi, !f2fs_cp_error(sbi));
 		f2fs_release_discard_addrs(sbi);
-	else
+	} else {
 		f2fs_clear_prefree_segments(sbi, cpc);
+	}
 
 	f2fs_restore_inmem_curseg(sbi);
 stop:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c44fdad8495e..299ed8cb1bd3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -547,7 +547,7 @@ enum {
 					 */
 };
 
-#define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO count */
+#define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO or flush count */
 
 /* congestion wait timeout value, default: 20ms */
 #define	DEFAULT_IO_TIMEOUT	(msecs_to_jiffies(20))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 80f26158e304..ca9876a6d396 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -776,11 +776,22 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 		return 0;
 
 	for (i = 1; i < sbi->s_ndevs; i++) {
+		int count = DEFAULT_RETRY_IO_COUNT;
+
 		if (!f2fs_test_bit(i, (char *)&sbi->dirty_device))
 			continue;
-		ret = __submit_flush_wait(sbi, FDEV(i).bdev);
-		if (ret)
+
+		do {
+			ret = __submit_flush_wait(sbi, FDEV(i).bdev);
+			if (ret)
+				congestion_wait(BLK_RW_ASYNC,
+						DEFAULT_IO_TIMEOUT);
+		} while (ret && --count);
+
+		if (ret) {
+			f2fs_stop_checkpoint(sbi, false);
 			break;
+		}
 
 		spin_lock(&sbi->dev_lock);
 		f2fs_clear_bit(i, (char *)&sbi->dirty_device);
-- 
2.22.1


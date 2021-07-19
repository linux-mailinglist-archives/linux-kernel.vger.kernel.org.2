Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0A3CCFFC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhGSIXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235811AbhGSIXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:23:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B112611CC;
        Mon, 19 Jul 2021 08:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626684353;
        bh=TNFD7nvB5rMFEOYLBIiExOBM7/f5QTYMUplrVLlFeDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=hYQweFO2oU4T7aQTOoLVFDPC1Xncdn00kd2JESAVOfrbKUu4gRwWoOHX9kDd0GPw4
         JHRk1/9sufD4KY2cKkvVfDkPWQiWCPhNv1Wzkus5E2tjuElKnzrglzfpN8i8uBEPIZ
         XO21c7mP756eq8LMzHpfw1b5NYVTP4+F0WbbyPeItA6JD1TG1R8f6f1sZDDnYFXv3H
         AcOnQ+Orn2Tynx/GJmLdSeB4p147khbnwF7p54ZwtpmN6Afzi2K7bnF6xyLmbuBaem
         gbjzfbhVDB9h1lLO4oiz+wmHoxA+32sFkFeUKrTjr61vxpnXPf5Z9IZ9p7ujq2cRHL
         oX5Ny6kPLQCvw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: fix wrong inflight page stats for directIO
Date:   Mon, 19 Jul 2021 16:45:48 +0800
Message-Id: <20210719084548.25895-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we use sbi->nr_pages[] to account direct IO, the count should
be based on page granularity rather than bio granularity, fix it.

Fixes: 02b16d0a34a1 ("f2fs: add to account direct IO")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- There is one missing line when I reorder in development patches,
so just resend the patch as v2, sorry.
 fs/f2fs/data.c | 11 +++++++----
 fs/f2fs/f2fs.h | 13 +++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e6f107de4c92..095350ccf80d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3494,8 +3494,9 @@ static void f2fs_dio_end_io(struct bio *bio)
 {
 	struct f2fs_private_dio *dio = bio->bi_private;
 
-	dec_page_count(F2FS_I_SB(dio->inode),
-			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
+	dec_page_counts(F2FS_I_SB(dio->inode),
+			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ,
+			dio->blkcnt);
 
 	bio->bi_private = dio->orig_private;
 	bio->bi_end_io = dio->orig_end_io;
@@ -3510,6 +3511,7 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
 {
 	struct f2fs_private_dio *dio;
 	bool write = (bio_op(bio) == REQ_OP_WRITE);
+	unsigned int blkcnt = bio_sectors(bio) >> F2FS_LOG_SECTORS_PER_BLOCK;
 
 	dio = f2fs_kzalloc(F2FS_I_SB(inode),
 			sizeof(struct f2fs_private_dio), GFP_NOFS);
@@ -3519,13 +3521,14 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
 	dio->inode = inode;
 	dio->orig_end_io = bio->bi_end_io;
 	dio->orig_private = bio->bi_private;
+	dio->blkcnt = blkcnt;
 	dio->write = write;
 
 	bio->bi_end_io = f2fs_dio_end_io;
 	bio->bi_private = dio;
 
-	inc_page_count(F2FS_I_SB(inode),
-			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
+	inc_page_counts(F2FS_I_SB(inode),
+			write ? F2FS_DIO_WRITE : F2FS_DIO_READ, dio->blkcnt);
 
 	submit_bio(bio);
 	return;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 867f2c5d9559..7369f8087f64 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1759,6 +1759,7 @@ struct f2fs_private_dio {
 	struct inode *inode;
 	void *orig_private;
 	bio_end_io_t *orig_end_io;
+	unsigned int blkcnt;
 	bool write;
 };
 
@@ -2267,6 +2268,12 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
 }
 
+static inline void inc_page_counts(struct f2fs_sb_info *sbi, int count_type,
+							unsigned int count)
+{
+	atomic_add(count, &sbi->nr_pages[count_type]);
+}
+
 static inline void inode_inc_dirty_pages(struct inode *inode)
 {
 	atomic_inc(&F2FS_I(inode)->dirty_pages);
@@ -2281,6 +2288,12 @@ static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
 	atomic_dec(&sbi->nr_pages[count_type]);
 }
 
+static inline void dec_page_counts(struct f2fs_sb_info *sbi, int count_type,
+							unsigned int count)
+{
+	atomic_sub(count, &sbi->nr_pages[count_type]);
+}
+
 static inline void inode_dec_dirty_pages(struct inode *inode)
 {
 	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
-- 
2.22.1


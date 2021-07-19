Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BB93CCFFB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbhGSIXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235813AbhGSIXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:23:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5BFC611CD;
        Mon, 19 Jul 2021 08:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626683132;
        bh=uph86ebcBQVwv9v5F9MQ8H//nKzarMFLSL6XNec3dHc=;
        h=From:To:Cc:Subject:Date:From;
        b=CWhO5XrgDKAVI/Mfs4i+PZTgWj0COIJ7KLXywdD2xm2INXNTxn3JpQp+F2fRebnBF
         pyXFZ9ZN20gnZ12gyo8Ge5m7PLprXTuyF1VBLN0o5zATztjODES3HdkqtdI9yrb9/5
         Fb4W6V9KuqEfDU/XlFPJzMSkDpXI4hum4saVqINUJ1GLdzwfMvuSaK6rzSFlubWMQu
         ztSydaTcVqiQ+jlOJjmAT9+AED8w1SnuMpwmcvNWa15QmRcU3/yyAFGAvRPpOlqu5f
         ys3m9/f3tI4bag3Gkv8y/9DYvwp2Ja41hWw3YoojU/7EA/z/PIv6NZ9LIEcdvuKY7J
         rGc0928sOKAAg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix wrong inflight page stats for directIO
Date:   Mon, 19 Jul 2021 16:25:29 +0800
Message-Id: <20210719082529.17948-1-chao@kernel.org>
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
 fs/f2fs/data.c | 10 ++++++----
 fs/f2fs/f2fs.h | 13 +++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e6f107de4c92..1198d6cb4811 100644
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
@@ -3519,13 +3520,14 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
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


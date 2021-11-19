Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B845E457806
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 22:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhKSVPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 16:15:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhKSVPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 16:15:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB3A361B1B;
        Fri, 19 Nov 2021 21:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637356346;
        bh=LT+lqR3AQkrtDrRSXeYsgAM9P7hk53heimIWAO7p44g=;
        h=From:To:Cc:Subject:Date:From;
        b=Hkli9/J+HHM5FZ1ph8baMZyAT5cf1WKfAag3gVQVJXHFQRbQuXa/8x2iVrYegoqzA
         nLAzz3/hz4bE5Gsz/5CbcMKhwNKiuKeWYskZJ7dDJdso8/wUQZXSHLEA4FGkSjAxsz
         DohCOdsN60B4GIQnovw9X5M34qf9gMvFUU/lhhBK3l20EFeGsnUsw+apM3yVyCOzxg
         f0z9DIGkuFVP0YldG10IP19PNgmVM0Te9OfVA1y1feHmhsGydQwF6S4INFWyZPB20e
         VMIg6iOTWVuPAXdePwjAX85pfrxFZyJ75Y4fmo3rmASKJwBqk9N+imDeWuHf34wOUJ
         JpKXWVBhpoIaQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: show more DIO information in tracepoint
Date:   Fri, 19 Nov 2021 13:12:22 -0800
Message-Id: <20211119211222.3114368-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prints more information of DIO in tracepoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c              |  4 ++--
 include/trace/events/f2fs.h | 15 +++++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 32c0bd545c5c..a0d605db6b96 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4295,7 +4295,7 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (count == 0)
 		return 0; /* skip atime update */
 
-	trace_f2fs_direct_IO_enter(inode, pos, count, READ);
+	trace_f2fs_direct_IO_enter(inode, iocb, count, READ);
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		if (!down_read_trylock(&fi->i_gc_rwsem[READ])) {
@@ -4494,7 +4494,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct iomap_dio *dio;
 	ssize_t ret;
 
-	trace_f2fs_direct_IO_enter(inode, pos, count, WRITE);
+	trace_f2fs_direct_IO_enter(inode, iocb, count, WRITE);
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		/* f2fs_convert_inline_inode() and block allocation can block */
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index dcb94d740e12..f701bb23f83c 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -936,14 +936,14 @@ TRACE_EVENT(f2fs_fallocate,
 
 TRACE_EVENT(f2fs_direct_IO_enter,
 
-	TP_PROTO(struct inode *inode, loff_t offset, unsigned long len, int rw),
+	TP_PROTO(struct inode *inode, struct kiocb *iocb, long len, int rw),
 
-	TP_ARGS(inode, offset, len, rw),
+	TP_ARGS(inode, iocb, len, rw),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
-		__field(loff_t,	pos)
+		__field(struct kiocb *,	iocb)
 		__field(unsigned long,	len)
 		__field(int,	rw)
 	),
@@ -951,15 +951,18 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
-		__entry->pos	= offset;
+		__entry->iocb	= iocb;
 		__entry->len	= len;
 		__entry->rw	= rw;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu rw = %d",
+	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_hint = %x ki_ioprio = %x rw = %d",
 		show_dev_ino(__entry),
-		__entry->pos,
+		__entry->iocb->ki_pos,
 		__entry->len,
+		__entry->iocb->ki_flags,
+		__entry->iocb->ki_hint,
+		__entry->iocb->ki_ioprio,
 		__entry->rw)
 );
 
-- 
2.34.0.rc2.393.gf8c9666880-goog


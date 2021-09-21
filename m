Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CAE41357A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhIUOjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:39:07 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:43762 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233059AbhIUOjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:39:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Up9-D6K_1632235054;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Up9-D6K_1632235054)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Sep 2021 22:37:35 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] f2fs: fix up f2fs_lookup tracepoints
Date:   Tue, 21 Sep 2021 22:37:30 +0800
Message-Id: <20210921143730.82649-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up a misuse that the filename pointer isn't always valid in
the ring buffer, and we should copy the content instead.

Fixes: 0c5e36db17f5 ("f2fs: trace f2fs_lookup")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/trace/events/f2fs.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 4e881d9..4cb055a 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -807,20 +807,20 @@
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
-		__field(const char *,	name)
+		__string(name,	dentry->d_name.name)
 		__field(unsigned int, flags)
 	),
 
 	TP_fast_assign(
 		__entry->dev	= dir->i_sb->s_dev;
 		__entry->ino	= dir->i_ino;
-		__entry->name	= dentry->d_name.name;
+		__assign_str(name, dentry->d_name.name);
 		__entry->flags	= flags;
 	),
 
 	TP_printk("dev = (%d,%d), pino = %lu, name:%s, flags:%u",
 		show_dev_ino(__entry),
-		__entry->name,
+		__get_str(name),
 		__entry->flags)
 );
 
@@ -834,7 +834,7 @@
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
-		__field(const char *,	name)
+		__string(name,	dentry->d_name.name)
 		__field(nid_t,	cino)
 		__field(int,	err)
 	),
@@ -842,14 +842,14 @@
 	TP_fast_assign(
 		__entry->dev	= dir->i_sb->s_dev;
 		__entry->ino	= dir->i_ino;
-		__entry->name	= dentry->d_name.name;
+		__assign_str(name, dentry->d_name.name);
 		__entry->cino	= ino;
 		__entry->err	= err;
 	),
 
 	TP_printk("dev = (%d,%d), pino = %lu, name:%s, ino:%u, err:%d",
 		show_dev_ino(__entry),
-		__entry->name,
+		__get_str(name),
 		__entry->cino,
 		__entry->err)
 );
-- 
1.8.3.1


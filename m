Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413F336A68C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 12:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhDYKQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 06:16:41 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:50146 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhDYKQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 06:16:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UWgfJID_1619345757;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UWgfJID_1619345757)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 25 Apr 2021 18:15:58 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     anton@tuxera.com
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] fs/ntfs: drop unneeded assignment in ntfs_perform_write()
Date:   Sun, 25 Apr 2021 18:15:54 +0800
Message-Id: <1619345754-32875-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not required to initialize the local variable idx in
ntfs_perform_write(), the value is never actually read from
it.

make clang-analyzer on x86_64 allyesconfig reports:

fs/ntfs/file.c:1781:15: warning: Although the value stored to 'idx' is
used in the enclosing expression, the value is never actually read from
'idx'

Simplify the code and remove unneeded assignment to make clang-analyzer
happy.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ntfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index e5aab26..e39a26f 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1774,11 +1774,11 @@ static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
 	last_vcn = -1;
 	do {
 		VCN vcn;
-		pgoff_t idx, start_idx;
+		pgoff_t start_idx;
 		unsigned ofs, do_pages, u;
 		size_t copied;
 
-		start_idx = idx = pos >> PAGE_SHIFT;
+		start_idx = pos >> PAGE_SHIFT;
 		ofs = pos & ~PAGE_MASK;
 		bytes = PAGE_SIZE - ofs;
 		do_pages = 1;
-- 
1.8.3.1


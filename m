Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE0536E885
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbhD2KTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:19:08 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:60899 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240022AbhD2KTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:19:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UX9cxET_1619691493;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UX9cxET_1619691493)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Apr 2021 18:18:19 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     dhowells@redhat.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] afs: Remove redundant assignment to ret
Date:   Thu, 29 Apr 2021 18:18:12 +0800
Message-Id: <1619691492-83866-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable ret is set to -ENOENT and -ENOMEM but this value is never
read as it is overwritten or not used later on, hence it is a
redundant assignment and can be removed.

Cleans up the following clang-analyzer warning:

fs/afs/dir.c:2014:4: warning: Value stored to 'ret' is never read
[clang-analyzer-deadcode.DeadStores].

fs/afs/dir.c:659:2: warning: Value stored to 'ret' is never read
[clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/afs/dir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 117df15e..023fc24 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -656,7 +656,6 @@ static int afs_do_lookup_one(struct inode *dir, struct dentry *dentry,
 		return ret;
 	}
 
-	ret = -ENOENT;
 	if (!cookie.found) {
 		_leave(" = -ENOENT [not found]");
 		return -ENOENT;
@@ -2011,7 +2010,6 @@ static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 		if (d_count(new_dentry) > 2) {
 			/* copy the target dentry's name */
-			ret = -ENOMEM;
 			op->rename.tmp = d_alloc(new_dentry->d_parent,
 						 &new_dentry->d_name);
 			if (!op->rename.tmp)
-- 
1.8.3.1


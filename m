Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF930716A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhA1I0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:26:54 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47590 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231698AbhA1I0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:26:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UN77uxA_1611822335;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UN77uxA_1611822335)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Jan 2021 16:25:38 +0800
From:   Abaci Team <abaci-bugfix@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org,
        Abaci Team <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] kernfs: Remove redundant code
Date:   Thu, 28 Jan 2021 16:25:32 +0800
Message-Id: <1611822332-124549-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./fs/kernfs/file.c:647:1-3: WARNING: possible condition with no effect
(if == else).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Suggested-by: Jiapeng Zhong <oswb@linux.alibaba.com>
Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>
---
 fs/kernfs/file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index c757193..9a74c9d 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -644,11 +644,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	 * Both paths of the branch look the same.  They're supposed to
 	 * look that way and give @of->mutex different static lockdep keys.
 	 */
-	if (has_mmap)
-		mutex_init(&of->mutex);
-	else
-		mutex_init(&of->mutex);
-
+	mutex_init(&of->mutex);
 	of->kn = kn;
 	of->file = file;
 
-- 
1.8.3.1


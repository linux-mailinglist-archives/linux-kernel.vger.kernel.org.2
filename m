Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5548937B8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhELJTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:19:24 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:46676 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229968AbhELJTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:19:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UYdurAx_1620811081;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UYdurAx_1620811081)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 May 2021 17:18:02 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jlbec@evilplan.org
Cc:     hch@lst.de, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] configfs: Remove redundant initialization of 'len'
Date:   Wed, 12 May 2021 17:17:59 +0800
Message-Id: <1620811079-105280-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable 'len' is being initialized however
this value is never read as 'len' is assigned a new
value in if statement. Remove the redundant assignment.
At the same time, adjust the declarations order of
variables to keep the "upside-down x-mas tree" look of them.

Cleans up clang warning:
fs/configfs/file.c:147:10: warning: Value stored to 'len' during its
initialization is never read [clang-analyzer-deadcode.DeadStores]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 'commit fa60ce2cb450 ("treewide: remove editor modelines and cruft")'
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/configfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index e26060d..1551b3d 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -141,10 +141,10 @@ static int fill_read_buffer(struct file *file, struct configfs_buffer *buffer)
 configfs_read_bin_file(struct file *file, char __user *buf,
 		       size_t count, loff_t *ppos)
 {
-	struct configfs_fragment *frag = to_frag(file);
 	struct configfs_buffer *buffer = file->private_data;
+	struct configfs_fragment *frag = to_frag(file);
 	ssize_t retval = 0;
-	ssize_t len = min_t(size_t, count, PAGE_SIZE);
+	ssize_t len;
 
 	mutex_lock(&buffer->mutex);
 
-- 
1.8.3.1


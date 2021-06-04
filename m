Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EAB39B6D3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhFDKNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:13:50 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60867 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229612AbhFDKNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:13:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UbFI391_1622801520;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UbFI391_1622801520)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Jun 2021 18:12:01 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] ubifs: Fix an error code in ubifs_jnl_write_inode()
Date:   Fri,  4 Jun 2021 18:11:54 +0800
Message-Id: <1622801514-38016-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the code executes if (ui->xattr_cnt > ubifs_xattr_max_cnt(c)),
the value of err is 0. However, we can see from the ubifs_err log
that the value of err should be -EPERM.

Clean up smatch warning:
fs/ubifs/journal.c:886 ubifs_jnl_write_inode() warn: missing error code
'err'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 9ca2d7326444 ("ubifs: Limit number of xattrs per inode")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ubifs/journal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 2857e64..2307173 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -882,6 +882,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 		struct ubifs_dent_node *xent, *pxent = NULL;
 
 		if (ui->xattr_cnt > ubifs_xattr_max_cnt(c)) {
+			err = -EPERM;
 			ubifs_err(c, "Cannot delete inode, it has too much xattrs!");
 			goto out_release;
 		}
-- 
1.8.3.1


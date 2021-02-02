Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED03330B5AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 04:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhBBDLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 22:11:22 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51997 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230115AbhBBDLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 22:11:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UNdnZbK_1612235426;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNdnZbK_1612235426)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 11:10:38 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mark@fasheh.com
Cc:     jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ocfs2: Simplify the calculation of variables
Date:   Tue,  2 Feb 2021 11:10:24 +0800
Message-Id: <1612235424-80367-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./fs/ocfs2/refcounttree.c:981:16-18: WARNING !A || A && B is equivalent
to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/ocfs2/refcounttree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 3b397fa..115365e85 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -978,7 +978,7 @@ static int ocfs2_get_refcount_cpos_end(struct ocfs2_caching_info *ci,
 		return 0;
 	}
 
-	if (!eb || (eb && !eb->h_next_leaf_blk)) {
+	if (!eb || !eb->h_next_leaf_blk) {
 		/*
 		 * We are the last extent rec, so any high cpos should
 		 * be stored in this leaf refcount block.
-- 
1.8.3.1


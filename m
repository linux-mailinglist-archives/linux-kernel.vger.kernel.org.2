Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1CE30EABB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 04:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhBDDMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 22:12:50 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:49013 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229601AbhBDDMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:12:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UNolUB6_1612408324;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNolUB6_1612408324)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Feb 2021 11:12:04 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mark@fasheh.com
Cc:     jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] ocfs2: Remove unneeded return variable
Date:   Thu,  4 Feb 2021 11:12:03 +0800
Message-Id: <1612408323-23579-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unneeded return variables, using only
'0' instead.
It fixes the following warning detected by coccinelle:
./fs/ocfs2/stack_o2cb.c:69:5-16: Unneeded variable: "o2dlm_flags".
Return "0" on line 84

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ocfs2/stack_o2cb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ocfs2/stack_o2cb.c b/fs/ocfs2/stack_o2cb.c
index dbf8b57..2da9633 100644
--- a/fs/ocfs2/stack_o2cb.c
+++ b/fs/ocfs2/stack_o2cb.c
@@ -66,8 +66,6 @@ static inline int mode_to_o2dlm(int mode)
 	}
 static int flags_to_o2dlm(u32 flags)
 {
-	int o2dlm_flags = 0;
-
 	map_flag(DLM_LKF_NOQUEUE, LKM_NOQUEUE);
 	map_flag(DLM_LKF_CANCEL, LKM_CANCEL);
 	map_flag(DLM_LKF_CONVERT, LKM_CONVERT);
@@ -81,7 +79,7 @@ static int flags_to_o2dlm(u32 flags)
 	/* map_flag() should have cleared every flag passed in */
 	BUG_ON(flags != 0);
 
-	return o2dlm_flags;
+	return 0;
 }
 #undef map_flag
 
-- 
1.8.3.1


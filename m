Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821533783BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhEJKrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:47:16 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48254 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231727AbhEJKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:39:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UYOWhGt_1620643067;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UYOWhGt_1620643067)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 May 2021 18:38:00 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mark@fasheh.com
Cc:     jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v2] ocfs2: Reomve err less than zero check
Date:   Mon, 10 May 2021 18:37:42 +0800
Message-Id: <1620643062-124920-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because enum dlm_status starts from 0, the check for err < 0 is always
false.

Clean up the following coccicheck warning:

fs/ocfs2/dlm/dlmdebug.c:222 dlm_errname() warn: unsigned 'err' is never
less than zero.

fs/ocfs2/dlm/dlmdebug.c:214 dlm_errmsg() warn: unsigned 'err' is never
less than zero.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Update commit log.

 fs/ocfs2/dlm/dlmdebug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index d442cf5..817914d 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -211,7 +211,7 @@ void dlm_print_one_lock(struct dlm_lock *lockid)
 
 const char *dlm_errmsg(enum dlm_status err)
 {
-	if (err >= DLM_MAXSTATS || err < 0)
+	if (err >= DLM_MAXSTATS)
 		return dlm_errmsgs[DLM_MAXSTATS];
 	return dlm_errmsgs[err];
 }
@@ -219,7 +219,7 @@ const char *dlm_errmsg(enum dlm_status err)
 
 const char *dlm_errname(enum dlm_status err)
 {
-	if (err >= DLM_MAXSTATS || err < 0)
+	if (err >= DLM_MAXSTATS)
 		return dlm_errnames[DLM_MAXSTATS];
 	return dlm_errnames[err];
 }
-- 
1.8.3.1


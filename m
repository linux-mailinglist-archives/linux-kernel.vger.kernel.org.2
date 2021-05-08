Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C472377143
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 12:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhEHKmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 06:42:33 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49006 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230234AbhEHKmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 06:42:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UY8aVeP_1620470483;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UY8aVeP_1620470483)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 08 May 2021 18:41:28 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mark@fasheh.com
Cc:     jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ocfs2: Reomve err less than zero check
Date:   Sat,  8 May 2021 18:41:21 +0800
Message-Id: <1620470481-31597-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for err < 0 is always false because err is an enum and can
never be less than zero.

Clean up the following coccicheck warning:

fs/ocfs2/dlm/dlmdebug.c:222 dlm_errname() warn: unsigned 'err' is never
less than zero.

fs/ocfs2/dlm/dlmdebug.c:214 dlm_errmsg() warn: unsigned 'err' is never
less than zero.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
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


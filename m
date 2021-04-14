Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2222F35ED77
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349312AbhDNGqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:46:37 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33172 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349297AbhDNGqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:46:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UVWI-Bn_1618382763;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVWI-Bn_1618382763)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Apr 2021 14:46:08 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mark@fasheh.com
Cc:     jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ocfs2/dlm: remove unused function
Date:   Wed, 14 Apr 2021 14:46:01 +0800
Message-Id: <1618382761-5784-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following clang warning:

fs/ocfs2/dlm/dlmrecovery.c:129:20: warning: unused function
'dlm_reset_recovery' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/ocfs2/dlm/dlmrecovery.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 4b566e8..afc5173 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -126,13 +126,6 @@ static inline void __dlm_reset_recovery(struct dlm_ctxt *dlm)
 	dlm_set_reco_master(dlm, O2NM_INVALID_NODE_NUM);
 }
 
-static inline void dlm_reset_recovery(struct dlm_ctxt *dlm)
-{
-	spin_lock(&dlm->spinlock);
-	__dlm_reset_recovery(dlm);
-	spin_unlock(&dlm->spinlock);
-}
-
 /* Worker function used during recovery. */
 void dlm_dispatch_work(struct work_struct *work)
 {
-- 
1.8.3.1


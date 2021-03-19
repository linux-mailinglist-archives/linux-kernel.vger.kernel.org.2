Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA7F34173B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhCSIUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:20:06 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49425 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234076AbhCSITk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:19:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0USZ52Gl_1616141975;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0USZ52Gl_1616141975)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Mar 2021 16:19:38 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     agk@redhat.com
Cc:     snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] dm persistent data: Remove unused variable ret
Date:   Fri, 19 Mar 2021 16:19:30 +0800
Message-Id: <1616141970-123042-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/md/persistent-data/dm-btree-spine.c:188:5-6: Unneeded
variable: "r". Return "0" on line 194.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/md/persistent-data/dm-btree-internal.h | 2 +-
 drivers/md/persistent-data/dm-btree-spine.c    | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/md/persistent-data/dm-btree-internal.h b/drivers/md/persistent-data/dm-btree-internal.h
index fe073d9..d0c5591 100644
--- a/drivers/md/persistent-data/dm-btree-internal.h
+++ b/drivers/md/persistent-data/dm-btree-internal.h
@@ -83,7 +83,7 @@ struct shadow_spine {
 };
 
 void init_shadow_spine(struct shadow_spine *s, struct dm_btree_info *info);
-int exit_shadow_spine(struct shadow_spine *s);
+void exit_shadow_spine(struct shadow_spine *s);
 
 int shadow_step(struct shadow_spine *s, dm_block_t b,
 		struct dm_btree_value_type *vt);
diff --git a/drivers/md/persistent-data/dm-btree-spine.c b/drivers/md/persistent-data/dm-btree-spine.c
index 8a2bfbf..dd2ff3c 100644
--- a/drivers/md/persistent-data/dm-btree-spine.c
+++ b/drivers/md/persistent-data/dm-btree-spine.c
@@ -183,15 +183,13 @@ void init_shadow_spine(struct shadow_spine *s, struct dm_btree_info *info)
 	s->count = 0;
 }
 
-int exit_shadow_spine(struct shadow_spine *s)
+void exit_shadow_spine(struct shadow_spine *s)
 {
-	int r = 0, i;
+	int i;
 
 	for (i = 0; i < s->count; i++) {
 		unlock_block(s->info, s->nodes[i]);
 	}
-
-	return r;
 }
 
 int shadow_step(struct shadow_spine *s, dm_block_t b,
-- 
1.8.3.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EA335ED3F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347959AbhDNGde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:33:34 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:57540 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231831AbhDNGd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:33:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UVWtpYf_1618381977;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVWtpYf_1618381977)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Apr 2021 14:33:06 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     agk@redhat.com
Cc:     snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] dm clone metadata: remove unused function
Date:   Wed, 14 Apr 2021 14:32:56 +0800
Message-Id: <1618381976-127456-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following clang warning:

drivers/md/dm-clone-metadata.c:279:19: warning: unused function
'superblock_write_lock' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/md/dm-clone-metadata.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/md/dm-clone-metadata.c b/drivers/md/dm-clone-metadata.c
index 1771245..c43d556 100644
--- a/drivers/md/dm-clone-metadata.c
+++ b/drivers/md/dm-clone-metadata.c
@@ -276,12 +276,6 @@ static inline int superblock_read_lock(struct dm_clone_metadata *cmd,
 	return dm_bm_read_lock(cmd->bm, SUPERBLOCK_LOCATION, &sb_validator, sblock);
 }
 
-static inline int superblock_write_lock(struct dm_clone_metadata *cmd,
-					struct dm_block **sblock)
-{
-	return dm_bm_write_lock(cmd->bm, SUPERBLOCK_LOCATION, &sb_validator, sblock);
-}
-
 static inline int superblock_write_lock_zero(struct dm_clone_metadata *cmd,
 					     struct dm_block **sblock)
 {
-- 
1.8.3.1


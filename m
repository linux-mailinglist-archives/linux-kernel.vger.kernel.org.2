Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D2030570E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbhA0JgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:36:01 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:43153 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235240AbhA0JdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:33:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UN2J2GL_1611739923;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UN2J2GL_1611739923)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Jan 2021 17:32:10 +0800
From:   Abaci Team <abaci-bugfix@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Abaci Team <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] zram: remove redundant NULL check
Date:   Wed, 27 Jan 2021 17:32:02 +0800
Message-Id: <1611739922-3365-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warnings reported by coccicheck:
./drivers/block/zram/zram_drv.c:534:2-8: WARNING: NULL check before some
freeing functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Suggested-by: Yang Li <oswb@linux.alibaba.com>
Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e2933cb..92739b9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -530,8 +530,7 @@ static ssize_t backing_dev_store(struct device *dev,
 
 	return len;
 out:
-	if (bitmap)
-		kvfree(bitmap);
+	kvfree(bitmap);
 
 	if (bdev)
 		blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
-- 
1.8.3.1


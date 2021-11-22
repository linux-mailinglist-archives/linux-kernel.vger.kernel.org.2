Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C084587F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 03:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhKVCYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 21:24:02 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54326 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233769AbhKVCYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 21:24:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UxaO6TO_1637547652;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UxaO6TO_1637547652)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Nov 2021 10:20:54 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jens.wiklander@linaro.org
Cc:     sumit.garg@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next v2] optee: Fix NULL but dereferenced coccicheck error
Date:   Mon, 22 Nov 2021 10:20:50 +0800
Message-Id: <1637547650-4205-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/tee/optee/smc_abi.c:1508:12-15: ERROR: optee is NULL but
dereferenced.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 'commit 6749e69c4dad ("optee: add asynchronous notifications")'
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

change in v2:
--According to Jens's suggestion
fixed as:
        if (memremaped_shm)
                memunmap(memremaped_shm);

 drivers/tee/optee/smc_abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 92759d7..d7c8235 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1505,8 +1505,8 @@ static int optee_probe(struct platform_device *pdev)
 	kfree(optee);
 err_free_pool:
 	tee_shm_pool_free(pool);
-	if (optee->smc.memremaped_shm)
-		memunmap(optee->smc.memremaped_shm);
+	if (memremaped_shm)
+		memunmap(memremaped_shm);
 	return rc;
 }
 
-- 
1.8.3.1


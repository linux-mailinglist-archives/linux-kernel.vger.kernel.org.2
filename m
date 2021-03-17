Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9AB33EA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCQHLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:11:45 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40045 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhCQHLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:11:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0USEIX7F_1615965097;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0USEIX7F_1615965097)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Mar 2021 15:11:37 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jdike@addtoit.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] um: replace if (cond) BUG() with BUG_ON()
Date:   Wed, 17 Mar 2021 15:11:36 +0800
Message-Id: <1615965096-122733-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccinelle reports:
./arch/um/kernel/mem.c:77:3-6: WARNING: Use BUG_ON instead of if
condition followed by BUG.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/um/kernel/mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 9242dc9..22e28bf 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -73,8 +73,7 @@ static void __init one_page_table_init(pmd_t *pmd)
 
 		set_pmd(pmd, __pmd(_KERNPG_TABLE +
 					   (unsigned long) __pa(pte)));
-		if (pte != pte_offset_kernel(pmd, 0))
-			BUG();
+		BUG_ON(pte != pte_offset_kernel(pmd, 0));
 	}
 }
 
-- 
1.8.3.1


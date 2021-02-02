Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82430B774
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 06:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhBBFwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 00:52:50 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33934 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231546AbhBBFws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 00:52:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UNeTSgy_1612245120;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNeTSgy_1612245120)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 13:52:00 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     aryabinin@virtuozzo.com
Cc:     glider@google.com, dvyukov@google.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] riscv: kasan: remove unneeded semicolon
Date:   Tue,  2 Feb 2021 13:51:59 +0800
Message-Id: <1612245119-116845-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./arch/riscv/mm/kasan_init.c:103:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/riscv/mm/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index a8a2ffd..fac437a 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -100,7 +100,7 @@ void __init kasan_init(void)
 			break;
 
 		populate(kasan_mem_to_shadow(start), kasan_mem_to_shadow(end));
-	};
+	}
 
 	for (i = 0; i < PTRS_PER_PTE; i++)
 		set_pte(&kasan_early_shadow_pte[i],
-- 
1.8.3.1


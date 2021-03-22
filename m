Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB6F343BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhCVIjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:39:08 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34034 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhCVIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:38:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0USuiDZ6_1616402317;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0USuiDZ6_1616402317)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Mar 2021 16:38:38 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     ryabinin.a.a@gmail.com
Cc:     glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, kasan-dev@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] riscv: remove unneeded semicolon
Date:   Mon, 22 Mar 2021 16:38:36 +0800
Message-Id: <1616402316-19705-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./arch/riscv/mm/kasan_init.c:219:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/riscv/mm/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 4f85c6d..937d13c 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -216,7 +216,7 @@ void __init kasan_init(void)
 			break;
 
 		kasan_populate(kasan_mem_to_shadow(start), kasan_mem_to_shadow(end));
-	};
+	}
 
 	for (i = 0; i < PTRS_PER_PTE; i++)
 		set_pte(&kasan_early_shadow_pte[i],
-- 
1.8.3.1


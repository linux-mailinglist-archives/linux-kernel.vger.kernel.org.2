Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710A345DF5E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhKYRLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:11:20 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57660 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232392AbhKYRJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:09:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UyHRKKp_1637859960;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UyHRKKp_1637859960)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Nov 2021 01:06:03 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        james.morse@arm.com, ardb@kernel.org, tabba@google.com,
        akpm@linux-foundation.org, rppt@kernel.org,
        anshuman.khandual@arm.com, pasha.tatashin@soleen.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: trans_pgd: unify the use of pmd_populate_kernel
Date:   Fri, 26 Nov 2021 01:05:59 +0800
Message-Id: <20211125170600.1608-2-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211125170600.1608-1-rongwei.wang@linux.alibaba.com>
References: <20211030183200.51295-1-rongwei.wang@linux.alibaba.com>
 <20211125170600.1608-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 5de59884ac0e ("arm64: trans_pgd: pass NULL instead
of init_mm to *_populate functions"), simply replace init_mm
with NULL for pmd_populate_kernel. But in commit 59511cfd08f3
("arm64: mm: use XN table mapping attributes for user/kernel
mappings"), adding the check of mm context in
'pmd_populate_kernel'. And 'pmd_populate_kernel' always
called with init_mm under arm64, nice to unify its use.

This patch make a simple change, just restoring init_mm for
'pmd_populate_kernel' in 'copy_pte'.

Suggested-by: Abaci <abaci@linux.alibaba.com>
Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 arch/arm64/mm/trans_pgd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index d7da8ca..5275ca3 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -67,7 +67,7 @@ static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
 	dst_ptep = trans_alloc(info);
 	if (!dst_ptep)
 		return -ENOMEM;
-	pmd_populate_kernel(NULL, dst_pmdp, dst_ptep);
+	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
 	dst_ptep = pte_offset_kernel(dst_pmdp, start);
 
 	src_ptep = pte_offset_kernel(src_pmdp, start);
-- 
1.8.3.1


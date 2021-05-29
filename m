Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287A7394B09
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 10:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhE2IJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 04:09:36 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2527 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2IJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 04:09:35 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FsYy36qqHzYqsK;
        Sat, 29 May 2021 16:05:15 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 16:07:57 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 29 May
 2021 16:07:56 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <vincent.chen@sifive.com>, <sunnanyong@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bixuan Cui <cuibixuan@huawei.com>
Subject: [PATCH -next v3] riscv: fix build error when CONFIG_SMP is disabled
Date:   Sat, 29 May 2021 16:06:57 +0800
Message-ID: <20210529080657.18997-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when disable CONFIG_SMP:
mm/pgtable-generic.o: In function `.L19':
pgtable-generic.c:(.text+0x42): undefined reference to `flush_pmd_tlb_range'
mm/pgtable-generic.o: In function `pmdp_huge_clear_flush':
pgtable-generic.c:(.text+0x6c): undefined reference to `flush_pmd_tlb_range'
mm/pgtable-generic.o: In function `pmdp_invalidate':
pgtable-generic.c:(.text+0x162): undefined reference to `flush_pmd_tlb_range'

Fixes: e88b333142e4 ("riscv: mm: add THP support on 64-bit")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
Acked-by: Nanyong Sun <sunnanyong@huawei.com>
---
Changes in v3:
Deleted the declaration of the flush_pmd_tlb_range() in the patch

Changes in v2:
Move the declaration of flush_pmd_tlb_rang to tlbflush.h

 arch/riscv/include/asm/pgtable.h  | 5 -----
 arch/riscv/include/asm/tlbflush.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 29e2c836848d..eda31002c4b1 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -622,11 +622,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 {
 	return __pmd(atomic_long_xchg((atomic_long_t *)pmdp, pmd_val(pmd)));
 }
-
-#define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
-void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			unsigned long end);
-
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /*
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index c84218ad7afc..801019381dea 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -33,6 +33,11 @@ void flush_tlb_mm(struct mm_struct *mm);
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
+void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end);
+#endif
 #else /* CONFIG_SMP && CONFIG_MMU */
 
 #define flush_tlb_all() local_flush_tlb_all()
-- 
2.17.1


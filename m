Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE053AAFA9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhFQJ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:28:52 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11051 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhFQJ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:28:49 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5Gnq1TlXzZfmx;
        Thu, 17 Jun 2021 17:23:43 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 17:26:38 +0800
Received: from huawei.com (10.175.113.32) by dggpemm000001.china.huawei.com
 (7.185.36.245) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 17 Jun
 2021 17:26:37 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH v2 -next] riscv: mm: fix build errors caused by mk_pmd()
Date:   Thu, 17 Jun 2021 17:58:31 +0800
Message-ID: <20210617095831.2398438-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With "riscv: mm: add THP support on 64-bit", mk_pmd() function
introduce build errors,
1.build with CONFIG_ARCH_RV32I=y:
arch/riscv/include/asm/pgtable.h: In function 'mk_pmd':
arch/riscv/include/asm/pgtable.h:513:9: error: implicit declaration of function 'pfn_pmd';
 did you mean 'pfn_pgd'? [-Werror=implicit-function-declaration]

2.build with CONFIG_SPARSEMEM=y && CONFIG_SPARSEMEM_VMEMMAP=n
arch/riscv/include/asm/pgtable.h: In function 'mk_pmd':
include/asm-generic/memory_model.h:64:14: error: implicit declaration of function 'page_to_section';
 did you mean 'present_section'? [-Werror=implicit-function-declaration]

Move the definition of mk_pmd to pgtable-64.h to fix the first error.
Use macro definition instead of inline function for mk_pmd
to fix the second problem. It is similar to the mk_pte macro.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
Changes in v2:
- Move mk_pmd to pgtable-64.h
---
 arch/riscv/include/asm/pgtable-64.h | 2 ++
 arch/riscv/include/asm/pgtable.h    | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 1439017b16f8..228261aa9628 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -79,6 +79,8 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 	return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
 }
 
+#define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
+
 #define pmd_ERROR(e) \
 	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 5ae51e6bd5ab..6bc2582f82e9 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -516,11 +516,6 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
 	return ((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT);
 }
 
-static inline pmd_t mk_pmd(struct page *page, pgprot_t prot)
-{
-	return pfn_pmd(page_to_pfn(page), prot);
-}
-
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
 	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
-- 
2.18.0.huawei.25


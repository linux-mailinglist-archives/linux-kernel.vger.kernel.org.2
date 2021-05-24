Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BE138E0FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 08:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhEXGbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 02:31:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3919 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhEXGbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 02:31:08 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FpS0l6NlLz80vB;
        Mon, 24 May 2021 14:26:47 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 14:29:38 +0800
Received: from huawei.com (10.175.113.32) by dggpemm000001.china.huawei.com
 (7.185.36.245) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 24 May
 2021 14:29:37 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH -next] riscv: mm: fix build errors caused by mk_pmd()
Date:   Mon, 24 May 2021 15:02:20 +0800
Message-ID: <20210524070220.793082-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Use macro definition instead of inline function for mk_pmd
to fix the above problems.It is similar to the mk_pte macro.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 arch/riscv/include/asm/pgtable.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4b708ae08910..f35d9c90d4cb 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -508,10 +508,7 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
 	return ((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT);
 }
 
-static inline pmd_t mk_pmd(struct page *page, pgprot_t prot)
-{
-	return pfn_pmd(page_to_pfn(page), prot);
-}
+#define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
-- 
2.18.0.huawei.25


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143F536F6C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhD3H53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:57:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17829 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhD3H5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:57:21 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FWl4T0sKbzBtKK;
        Fri, 30 Apr 2021 15:54:01 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 30 Apr 2021
 15:56:21 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH -next 1/4] riscv: mm: add _PAGE_LEAF macro
Date:   Fri, 30 Apr 2021 16:28:47 +0800
Message-ID: <20210430082850.462609-2-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210430082850.462609-1-sunnanyong@huawei.com>
References: <20210430082850.462609-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In riscv, a page table entry is leaf when any bit of read, write,
or execute bit is set. So add a macro:_PAGE_LEAF instead of
(_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC), which is frequently used
to determine if it is a leaf page. This make code easier to read,
without any functional change.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 arch/riscv/include/asm/pgtable-64.h   | 3 +--
 arch/riscv/include/asm/pgtable-bits.h | 5 +++++
 arch/riscv/include/asm/pgtable.h      | 6 ++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index f3b0da64c..e3b7c5dd6 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -46,8 +46,7 @@ static inline int pud_bad(pud_t pud)
 #define pud_leaf	pud_leaf
 static inline int pud_leaf(pud_t pud)
 {
-	return pud_present(pud) &&
-	       (pud_val(pud) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
+	return pud_present(pud) && (pud_val(pud) & _PAGE_LEAF);
 }
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index bbaeb5d35..2ee413912 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -39,5 +39,10 @@
 #define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
 					  _PAGE_WRITE | _PAGE_EXEC |	\
 					  _PAGE_USER | _PAGE_GLOBAL))
+/*
+ * when all of R/W/X are zero, the PTE is a pointer to the next level
+ * of the page table; otherwise, it is a leaf PTE.
+ */
+#define _PAGE_LEAF (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)
 
 #endif /* _ASM_RISCV_PGTABLE_BITS_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 80e63a93e..f489e412f 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -166,8 +166,7 @@ static inline int pmd_bad(pmd_t pmd)
 #define pmd_leaf	pmd_leaf
 static inline int pmd_leaf(pmd_t pmd)
 {
-	return pmd_present(pmd) &&
-	       (pmd_val(pmd) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
+	return pmd_present(pmd) && (pmd_val(pmd) & _PAGE_LEAF);
 }
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
@@ -243,8 +242,7 @@ static inline int pte_exec(pte_t pte)
 
 static inline int pte_huge(pte_t pte)
 {
-	return pte_present(pte)
-		&& (pte_val(pte) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
+	return pte_present(pte) && (pte_val(pte) & _PAGE_LEAF);
 }
 
 static inline int pte_dirty(pte_t pte)
-- 
2.25.1


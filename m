Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C07459F01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbhKWJQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhKWJQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:16:14 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 01:13:06 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so1582796pjc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 01:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=IhjIetNetT6qmB9LARJqE5v76doIVBs8Q7TKsq/HG8Q=;
        b=AkLzGfw4+F8CJ9fF/abn/I0PrLIsdLLboA+t+s140Uugrlyzqz8q9cRu/MZ/tX+UKF
         6bhvWojmP0reYDdcAKGO5+RteAxWrd/zwZ8O4dgIw045cq80plKwPiRTokHz+AUH5abh
         OWDRrGe5QtBkq3I2vJxqwbpCfEmApgcRNn0t/CPScotyi0POocQqtqih59xl2xEbBK/K
         p98VQBRm3L8JfbdWGtNAtrbYEtCY1gYPgVBD1LwB5zYCjbjAo8QaUpL5fChGERHSOIE5
         dxOlIIplbWr6Tz4VO7JVm2xMQup6IATsVemElgm+0K89Np72gU4Hdi0BmKucu4mGnMCQ
         oN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=IhjIetNetT6qmB9LARJqE5v76doIVBs8Q7TKsq/HG8Q=;
        b=dMGTyi/9OqmKOXWVQH23f4FjnwiidwPn1MPHs/xPRb6iXpIGjQX/yPDl8p6sgRsc8T
         2yjvf23pLsRBaEJqnl5xVeVoWjTWIw1uqnWIl04vsHzqSaw2U81aWzCNIrTikcWxhoKd
         gientVs01OLc1eZ+3k9hm5jm5PvskucqtYpj5IV9dd+5Xn2JX8CGo281V4TSxzefe+dm
         O8clj3HcqK53f/Bh29BbawGbElnmg1Yo8UhfUk/hv8vgjF5iewPsud1Horf/YTtVXcfv
         AxcsGFFoH/1uXlgww4ZHgoQ1stAajCZ5jr5x8ZqcLxb2irLWYhmwWdqNlaUagnhm1k5e
         woSQ==
X-Gm-Message-State: AOAM530SzVcHTp2mONqOEnMywz2GKiCJvQaNRkGePIn+aGjaNoz84PLg
        L+GXBL6E5k/Kg4qiEsw4SE0a/BiCVc0ijg==
X-Google-Smtp-Source: ABdhPJyo8n3nygHcG82M1fw75T5wAf5eIa+B0GHui15YxgyXgAVaxZZUMgo1hUmjftlPBrZaMCLSLA==
X-Received: by 2002:a17:90a:d684:: with SMTP id x4mr1050157pju.244.1637658786119;
        Tue, 23 Nov 2021 01:13:06 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id ls14sm637665pjb.49.2021.11.23.01.13.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 01:13:05 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Marek <jonathan@marek.ca>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: introduce alloc hook to apply PTE_CONT
Date:   Tue, 23 Nov 2021 17:12:40 +0800
Message-Id: <1637658760-5813-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Since there is no PTE_CONT when rodata_full in ARM64, introducing a
hook function to apply PTE_CONT on the proper page blocks.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 arch/arm64/include/asm/page.h |  5 +++++
 arch/arm64/mm/pageattr.c      | 45 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index f98c91b..53cdd09 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -46,6 +46,11 @@ struct page *alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
 
 #include <asm/memory.h>
 
+#define HAVE_ARCH_ALLOC_PAGE
+#define HAVE_ARCH_FREE_PAGE
+
+extern void arch_alloc_page(struct page *page, int order);
+extern void arch_free_page(struct page *page, int order);
 #endif /* !__ASSEMBLY__ */
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_DATA_FLAGS_TSK_EXEC | VM_MTE_ALLOWED)
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index a3bacd7..815a06d 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -239,3 +239,48 @@ bool kernel_page_present(struct page *page)
 	ptep = pte_offset_kernel(pmdp, addr);
 	return pte_valid(READ_ONCE(*ptep));
 }
+
+void arch_alloc_page(struct page *page, int order)
+{
+	unsigned long addr;
+	unsigned long cont_pte_low_bound;
+
+	if (!rodata_full)
+		return;
+
+	addr = (u64)page_address(page);
+	if ((order >= 4) && (addr & ~CONT_PTE_MASK) == 0) {
+		order -= 4;
+		do {
+			cont_pte_low_bound = addr & CONT_PTE_MASK;
+			__change_memory_common(cont_pte_low_bound,
+					(~CONT_PTE_MASK + 1), __pgprot(PTE_CONT), __pgprot(0));
+			addr = (u64)page_address(page);
+			page += 4;
+			order--;
+		}while (order >= 0);
+	}
+}
+
+void arch_free_page(struct page *page, int order)
+{
+	unsigned long addr;
+	unsigned long cont_pte_low_bound;
+
+	if (!rodata_full)
+		return;
+
+	addr = (u64)page_address(page);
+	if ((order >= 4) && (addr & ~CONT_PTE_MASK) == 0) {
+		order -= 4;
+		do {
+			cont_pte_low_bound = addr & CONT_PTE_MASK;
+			__change_memory_common(cont_pte_low_bound,
+					(~CONT_PTE_MASK + 1), __pgprot(0), __pgprot(PTE_CONT));
+			addr = (u64)page_address(page);
+			page += 4;
+			order--;
+		}while (order >= 0);
+	}
+}
+
-- 
1.9.1


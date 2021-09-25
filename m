Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4148418647
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 06:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhIZE1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 00:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhIZE1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 00:27:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4A2C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 21:25:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n2so9327160plk.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 21:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vPTWY6ZhEwxKm2bRo4H/RgEPre3036ELut4KiHyBxNs=;
        b=j93tBAwKR6PU+Tf2RAq5LpM+xsVlcTolYB+z48FLtTHG1Qaae5hnNp28s8O2AIo/fH
         f5h53AFXFLlBUK7HJsu0br/zkYEPcmLLFx0HXImh6rG6a82RYAPzOpyq26uaISQZovlS
         Y/w37pgqobsu0P7FNbP2L5cDVAfAgLSDjiW8sw1uoGtkrU09Zmw0kI0UpqvbAilqJjzR
         YYqhYkAaZJSE0qi21YUu1Lwy4kFkhCoJ41quaBQ1fKa99nbshybzo6aEnuTPMwWh6TQX
         LH/WLZWuFSzZgO0Rx7mwZrqu3ED/z0dccLkco7MnXk89h5iCunIpo/pq5debKqCWrk/Y
         f+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPTWY6ZhEwxKm2bRo4H/RgEPre3036ELut4KiHyBxNs=;
        b=rGLfIam7pSex4ni0BF9H9acvdbw8WuH2x94MaZfC3dLcZUNLSt9K5NPGQdNJ5I4fnY
         5Wnu6v1Q1ntnqnXl9yEQrfRFRhYq+3mDQgdYdf9xCf/7FficJvCAQT2GX2ZzNKg9SA5N
         WZD6BiBBRUI+fqwcVWqB4Tw1SRMVRQjFhxjmlzGjkR+hScztlyA62wFjtzNBgmsWX4l2
         a2p0bBP/lknO4dlYUJ8njI0W7C2+GgRLabUIwFKekx1d9LZZInXOl6ifDIE0O4o00et0
         F7omDOt8KWxr/v2YTz4Zxh+ox7BPRUINZ/iQ0yxrirDp7JsTUEAXixAcUjDhctLqEARg
         t+tw==
X-Gm-Message-State: AOAM531ub+7XKUpN6jll1uVVZn3eQmzaQUp4F4RoDeH00GHY630Zdeuu
        ef+ZSdkDNS9jhOm87ZtlhzLqg3oeoVs=
X-Google-Smtp-Source: ABdhPJza7Jkvcd4LMXrUFhOx0lek5OgkoePvKdQ+XxiNS+0296z+pucET+h/3L++oB+zNdy2RX5vYw==
X-Received: by 2002:a17:90a:1d6:: with SMTP id 22mr11541249pjd.39.1632630345392;
        Sat, 25 Sep 2021 21:25:45 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q11sm12406154pjf.14.2021.09.25.21.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 21:25:44 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [PATCH 1/2] mm/mprotect: use mmu_gather
Date:   Sat, 25 Sep 2021 13:54:22 -0700
Message-Id: <20210925205423.168858-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925205423.168858-1-namit@vmware.com>
References: <20210925205423.168858-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

change_pXX_range() currently does not use mmu_gather, but instead
implements its own deferred TLB flushes scheme. This both complicates
the code, as developers need to be aware of different invalidation
schemes, and prevents opportunities to avoid TLB flushes or perform them
in finer granularity.

Use mmu_gather in change_pXX_range(). As the pages are not released,
only record the flushed range using tlb_flush_pXX_range().

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/mprotect.c | 50 ++++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 883e2cc85cad..075ff94aa51c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -32,12 +32,13 @@
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
+#include <asm/tlb.h>
 
 #include "internal.h"
 
-static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, unsigned long end, pgprot_t newprot,
-		unsigned long cp_flags)
+static unsigned long change_pte_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
@@ -138,6 +139,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				ptent = pte_mkwrite(ptent);
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
+			tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
 			pages++;
 		} else if (is_swap_pte(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
@@ -219,9 +221,9 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 	return 0;
 }
 
-static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
-		pud_t *pud, unsigned long addr, unsigned long end,
-		pgprot_t newprot, unsigned long cp_flags)
+static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, pud_t *pud, unsigned long addr,
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -261,6 +263,10 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			if (next - addr != HPAGE_PMD_SIZE) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
+				/*
+				 * change_huge_pmd() does not defer TLB flushes,
+				 * so no need to propagate the tlb argument.
+				 */
 				int nr_ptes = change_huge_pmd(vma, pmd, addr,
 							      newprot, cp_flags);
 
@@ -276,8 +282,8 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
-		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
-					      cp_flags);
+		this_pages = change_pte_range(tlb, vma, pmd, addr, next,
+					      newprot, cp_flags);
 		pages += this_pages;
 next:
 		cond_resched();
@@ -291,9 +297,9 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static inline unsigned long change_pud_range(struct vm_area_struct *vma,
-		p4d_t *p4d, unsigned long addr, unsigned long end,
-		pgprot_t newprot, unsigned long cp_flags)
+static inline unsigned long change_pud_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, p4d_t *p4d, unsigned long addr,
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -304,16 +310,16 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		pages += change_pmd_range(vma, pud, addr, next, newprot,
+		pages += change_pmd_range(tlb, vma, pud, addr, next, newprot,
 					  cp_flags);
 	} while (pud++, addr = next, addr != end);
 
 	return pages;
 }
 
-static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
-		pgd_t *pgd, unsigned long addr, unsigned long end,
-		pgprot_t newprot, unsigned long cp_flags)
+static inline unsigned long change_p4d_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, pgd_t *pgd, unsigned long addr,
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -324,7 +330,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
-		pages += change_pud_range(vma, p4d, addr, next, newprot,
+		pages += change_pud_range(tlb, vma, p4d, addr, next, newprot,
 					  cp_flags);
 	} while (p4d++, addr = next, addr != end);
 
@@ -338,25 +344,25 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	unsigned long next;
-	unsigned long start = addr;
 	unsigned long pages = 0;
+	struct mmu_gather tlb;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
 	flush_cache_range(vma, addr, end);
 	inc_tlb_flush_pending(mm);
+	tlb_gather_mmu(&tlb, mm);
+	tlb_start_vma(&tlb, vma);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		pages += change_p4d_range(vma, pgd, addr, next, newprot,
+		pages += change_p4d_range(&tlb, vma, pgd, addr, next, newprot,
 					  cp_flags);
 	} while (pgd++, addr = next, addr != end);
 
-	/* Only flush the TLB if we actually modified any entries: */
-	if (pages)
-		flush_tlb_range(vma, start, end);
-	dec_tlb_flush_pending(mm);
+	tlb_end_vma(&tlb, vma);
+	tlb_finish_mmu(&tlb);
 
 	return pages;
 }
-- 
2.25.1


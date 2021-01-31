Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C97A309952
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhAaARV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbhAaAQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:16:29 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0ADC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:03 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q131so9057649pfq.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M4Q7ZjV588LKdkSbAzgnMot3DVim5ZSVz69bh4M0k3g=;
        b=nMmhg68SZfVRe7l5tfC35c3vDqI1usRnjleTjJTDokkkhrVHdWjbNMu6dAeQwpRdjK
         Pq8f/o+jsR/DDpO6jCSFcucZhH2mvIrXN27Hpivi9KQP659S1mi56y4F/SRNSWHQbzIh
         eFB/QmMLmnVRtymTl8Y68SRNEaiHinOFiNzX0VX2nbY2tlkXohLxUarfxjgHf3Gpvdp1
         m0+7o/8PYOc3r6u8TwZMW9sSrynOmMSmrohx7KESPK+xoJe+7jf6ldV2izYZ00M3qyL/
         8Sc5/gzNrkcjOjCQMNqIexWHNljfavI8opIEfGFQDHSwaO8w31vedSzsnmTiWsvxs+8w
         Y1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4Q7ZjV588LKdkSbAzgnMot3DVim5ZSVz69bh4M0k3g=;
        b=DIdlpD9BfC+7OQUwBgobErCZjTX5vwogzOR2ZPeKL64hnSK2BDewJAF+Lz5Sduod7u
         Me1ZgkaIKQhLoEqrTFWOH4dQteBfSbIuyb9kLkDoK6BX45ZBe6YRtQbHiwNbiULxyjew
         gJXmTxKUl60pqNhL+xBLyiJTvSBv+wcT8L1aosQzCHsdX0V+kUo4veWJec9CPoiUYSCM
         YNZjZLkC6ONmL/WY1S9RZ9msUgMiJJX7yfThQhg1ItH3FITr0+U6YTm8xsLa2fabCGD9
         MdOiGeANa47T447fg3XDxaANxfcB/V/cpl3GqyVXVbVXgb2kNR0z0fgI655hlkmSzp/b
         0BCw==
X-Gm-Message-State: AOAM532F2EknQLhOH0AlGvWxTJDRlUGtIpJasc2UIb7+erNdMJU35xqU
        aOh6YdQkQMlgznb8SN+hVyo=
X-Google-Smtp-Source: ABdhPJxg0qtiRLhUaMKCvHqNchv1j0FmjCLXzVSaQO3+WkMK6v7l6XetS39BLFVhZx/xyxt2SvTa6Q==
X-Received: by 2002:a63:505d:: with SMTP id q29mr10737187pgl.89.1612052163402;
        Sat, 30 Jan 2021 16:16:03 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:02 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [RFC 02/20] mm/mprotect: use mmu_gather
Date:   Sat, 30 Jan 2021 16:11:14 -0800
Message-Id: <20210131001132.3368247-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

change_pXX_range() currently does not use mmu_gather, but instead
implements its own deferred TLB flushes scheme. This both complicates
the code, as developers need to be aware of different invalidation
schemes, and prevents.

Use mmu_gather in change_pXX_range(). As the pages are not released,
only record the flushed range using tlb_flush_pXX_range().

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
---
 include/linux/huge_mm.h |  3 ++-
 mm/huge_memory.c        |  4 +++-
 mm/mprotect.c           | 51 ++++++++++++++++++++---------------------
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 6a19f35f836b..6eff7f59a778 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -37,7 +37,8 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma, pud_t *pud,
 bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		   unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd);
 int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
-		    pgprot_t newprot, unsigned long cp_flags);
+		    pgprot_t newprot, unsigned long cp_flags,
+		    struct mmu_gather *tlb);
 vm_fault_t vmf_insert_pfn_pmd_prot(struct vm_fault *vmf, pfn_t pfn,
 				   pgprot_t pgprot, bool write);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9237976abe72..c345b8b06183 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1797,7 +1797,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
  *  - HPAGE_PMD_NR is protections changed and TLB flush necessary
  */
 int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, pgprot_t newprot, unsigned long cp_flags)
+		unsigned long addr, pgprot_t newprot, unsigned long cp_flags,
+		struct mmu_gather *tlb)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *ptl;
@@ -1885,6 +1886,7 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		entry = pmd_clear_uffd_wp(entry);
 	}
 	ret = HPAGE_PMD_NR;
+	tlb_flush_pmd_range(tlb, addr, HPAGE_PMD_SIZE);
 	set_pmd_at(mm, addr, pmd, entry);
 	BUG_ON(vma_is_anonymous(vma) && !preserve_write && pmd_write(entry));
 unlock:
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ab709023e9aa..632d5a677d3f 100644
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
@@ -209,9 +211,9 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
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
@@ -252,7 +254,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
 				int nr_ptes = change_huge_pmd(vma, pmd, addr,
-							      newprot, cp_flags);
+							      newprot, cp_flags, tlb);
 
 				if (nr_ptes) {
 					if (nr_ptes == HPAGE_PMD_NR) {
@@ -266,8 +268,8 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
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
@@ -281,9 +283,9 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
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
@@ -294,16 +296,16 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
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
@@ -314,7 +316,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
-		pages += change_pud_range(vma, p4d, addr, next, newprot,
+		pages += change_pud_range(tlb, vma, p4d, addr, next, newprot,
 					  cp_flags);
 	} while (p4d++, addr = next, addr != end);
 
@@ -328,25 +330,22 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	unsigned long next;
-	unsigned long start = addr;
 	unsigned long pages = 0;
+	struct mmu_gather tlb;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
-	flush_cache_range(vma, addr, end);
-	inc_tlb_flush_pending(mm);
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
-
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CFD30995E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhAaAUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhAaAQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:16:57 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A317CC06178B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:15 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id g3so7932670plp.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXtsqL7OnePQSIl7PBrxGJpBqi17FMqIVecv4DEE9Io=;
        b=HWnMEPQTPZY8rmZlWoMLQUShrGKYPxiPXEDmXrKPxu0sd2fkt7QDryKz1vR9o9gy2L
         PzAGCR8eDGwEDrfJKTPwoPwYUerFd9mdQMZkfb9KWChY2xRYnDe0zwJPq3olbLm8UYuk
         SnwakZEKJflQiP9eOWgb4DoMzl+rgODt6VoYGsCXZymnrPrp14Gcb2SLe7+CVI7GCBkC
         e0iUy5+UeO1HcMiYxfaUn1bnFcooMMFDTmgn+nSKfXfweXwrvURkKEUAdfQCtSC/f2lv
         13x3QazIzNf5V5d1S1ORV+z599hdqREURm5m/8pM8JAQRm5QrJacIB62AzP3Iysen/7H
         FOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXtsqL7OnePQSIl7PBrxGJpBqi17FMqIVecv4DEE9Io=;
        b=Et34xGmNOBCF+BNDlNXdisONf3S/o7eTRMvnUGFEWxZSdldzjyZSD05Kkvco9WVycd
         GMPbf6fcacGkLH2w3KdkuQVS36iQSqR6cDbhyPZqc3n7dc7Awr7GfzE56SlcDV3CjUDR
         qGYvKZk/jlJAnREhMQMo6gDQe9uJS2Har1DQ1mGPIC7aJGIxNsjpGkX0cmlXuJPOg2cO
         SQJ0APJ1jg7Zl7mo5rDpitaS5hsgWCUIEUlixaQr9Weqku63A1D94JTbSTFELh2Btu0E
         Xro7DyaLJArjTaG8QE0zZEWoY4PLEjBQnkEisO3/gp9/cCK/HrmBTEsEOYHMWmvTIArB
         d0Ww==
X-Gm-Message-State: AOAM532zpGbb0F/qBSf6LcETkDllHnJ35ervdWF7Tt3zdEGzuN7T1PNn
        0ighY2bEcjEi/PoTZ4BZC70=
X-Google-Smtp-Source: ABdhPJy0UgFXnVAqlHfJHtpa7PxNh6RointC74k3ZkIMdLDA/33nXTOgUee/DDeu4NstAPwAedTUvA==
X-Received: by 2002:a17:90a:7e94:: with SMTP id j20mr11015456pjl.218.1612052175121;
        Sat, 30 Jan 2021 16:16:15 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:14 -0800 (PST)
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
Subject: [RFC 09/20] mm: create pte/pmd_tlb_flush_pending()
Date:   Sat, 30 Jan 2021 16:11:21 -0800
Message-Id: <20210131001132.3368247-10-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

In preparation for fine(r) granularity, introduce
pte_tlb_flush_pending() and pmd_tlb_flush_pending(). Right now the
function directs to mm_tlb_flush_pending().

Change pte_accessible() to provide the vma as well.

No functional change. Next patches will use this information on
architectures that use per-table deferred TLB tracking.

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
 arch/arm/include/asm/pgtable.h      |  4 +++-
 arch/arm64/include/asm/pgtable.h    |  4 ++--
 arch/sparc/include/asm/pgtable_64.h |  9 ++++++---
 arch/sparc/mm/init_64.c             |  2 +-
 arch/x86/include/asm/pgtable.h      |  7 +++----
 include/linux/mm_types.h            | 10 ++++++++++
 include/linux/pgtable.h             |  2 +-
 mm/huge_memory.c                    |  2 +-
 mm/ksm.c                            |  2 +-
 mm/pgtable-generic.c                |  2 +-
 10 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index c02f24400369..59bcacc14dc3 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -190,7 +190,9 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_none(pte)		(!pte_val(pte))
 #define pte_present(pte)	(pte_isset((pte), L_PTE_PRESENT))
 #define pte_valid(pte)		(pte_isset((pte), L_PTE_VALID))
-#define pte_accessible(mm, pte)	(mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid(pte))
+#define pte_accessible(vma, pte)					\
+				(pte_tlb_flush_pending(vma, pte) ?	\
+				 pte_present(*pte) : pte_valid(*pte))
 #define pte_write(pte)		(pte_isclear((pte), L_PTE_RDONLY))
 #define pte_dirty(pte)		(pte_isset((pte), L_PTE_DIRTY))
 #define pte_young(pte)		(pte_isset((pte), L_PTE_YOUNG))
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 501562793ce2..f14f1e9dbc3e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -126,8 +126,8 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
  * flag, since ptep_clear_flush_young() elides a DSB when invalidating the
  * TLB.
  */
-#define pte_accessible(mm, pte)	\
-	(mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid(pte))
+#define pte_accessible(vma, pte)	\
+	(pte_tlb_flush_pending(vma, pte) ? pte_present(*pte) : pte_valid(*pte))
 
 /*
  * p??_access_permitted() is true for valid user mappings (subject to the
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 550d3904de65..749efd9c49c9 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -673,9 +673,9 @@ static inline unsigned long pte_present(pte_t pte)
 }
 
 #define pte_accessible pte_accessible
-static inline unsigned long pte_accessible(struct mm_struct *mm, pte_t a)
+static inline unsigned long pte_accessible(struct vm_area_struct *vma, pte_t *a)
 {
-	return pte_val(a) & _PAGE_VALID;
+	return pte_val(*a) & _PAGE_VALID;
 }
 
 static inline unsigned long pte_special(pte_t pte)
@@ -906,8 +906,11 @@ static void maybe_tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
 	 *
 	 * SUN4V NOTE: _PAGE_VALID is the same value in both the SUN4U
 	 *             and SUN4V pte layout, so this inline test is fine.
+	 *
+	 * The vma is not propagated to this point, but it is not used by
+	 * sparc's pte_accessible(). We therefore provide NULL.
 	 */
-	if (likely(mm != &init_mm) && pte_accessible(mm, orig))
+	if (likely(mm != &init_mm) && pte_accessible(NULL, ptep))
 		tlb_batch_add(mm, vaddr, ptep, orig, fullmm, hugepage_shift);
 }
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 182bb7bdaa0a..bda397aa9709 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -404,7 +404,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
 	mm = vma->vm_mm;
 
 	/* Don't insert a non-valid PTE into the TSB, we'll deadlock.  */
-	if (!pte_accessible(mm, pte))
+	if (!pte_accessible(vma, ptep))
 		return;
 
 	spin_lock_irqsave(&mm->context.lock, flags);
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a02c67291cfc..a0e069c15dbc 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -775,13 +775,12 @@ static inline int pte_devmap(pte_t a)
 #endif
 
 #define pte_accessible pte_accessible
-static inline bool pte_accessible(struct mm_struct *mm, pte_t a)
+static inline bool pte_accessible(struct vm_area_struct *vma, pte_t *a)
 {
-	if (pte_flags(a) & _PAGE_PRESENT)
+	if (pte_flags(*a) & _PAGE_PRESENT)
 		return true;
 
-	if ((pte_flags(a) & _PAGE_PROTNONE) &&
-			mm_tlb_flush_pending(mm))
+	if ((pte_flags(*a) & _PAGE_PROTNONE) && pte_tlb_flush_pending(vma, a))
 		return true;
 
 	return false;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8a5eb4bfac59..812ee0fd4c35 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -682,6 +682,16 @@ static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
 	return atomic_read(&mm->tlb_flush_pending);
 }
 
+static inline bool pte_tlb_flush_pending(struct vm_area_struct *vma, pte_t *pte)
+{
+	return mm_tlb_flush_pending(vma->vm_mm);
+}
+
+static inline bool pmd_tlb_flush_pending(struct vm_area_struct *vma, pmd_t *pmd)
+{
+	return mm_tlb_flush_pending(vma->vm_mm);
+}
+
 static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
 {
 	/*
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8fcdfa52eb4b..e8bce53ca3e8 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -725,7 +725,7 @@ static inline void arch_swap_restore(swp_entry_t entry, struct page *page)
 #endif
 
 #ifndef pte_accessible
-# define pte_accessible(mm, pte)	((void)(pte), 1)
+# define pte_accessible(vma, pte)	((void)(pte), 1)
 #endif
 
 #ifndef flush_tlb_fix_spurious_fault
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c345b8b06183..c4b7c00cc69c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1514,7 +1514,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	 * We are not sure a pending tlb flush here is for a huge page
 	 * mapping or not. Hence use the tlb range variant
 	 */
-	if (mm_tlb_flush_pending(vma->vm_mm)) {
+	if (pmd_tlb_flush_pending(vma, vmf->pmd)) {
 		flush_tlb_range(vma, haddr, haddr + HPAGE_PMD_SIZE);
 		/*
 		 * change_huge_pmd() released the pmd lock before
diff --git a/mm/ksm.c b/mm/ksm.c
index 9694ee2c71de..515acbffc283 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1060,7 +1060,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 
 	if (pte_write(*pvmw.pte) || pte_dirty(*pvmw.pte) ||
 	    (pte_protnone(*pvmw.pte) && pte_savedwrite(*pvmw.pte)) ||
-						mm_tlb_flush_pending(mm)) {
+					pte_tlb_flush_pending(vma, pvmw.pte)) {
 		pte_t entry;
 
 		swapped = PageSwapCache(page);
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 9578db83e312..2ca66e269d33 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -93,7 +93,7 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
 	struct mm_struct *mm = (vma)->vm_mm;
 	pte_t pte;
 	pte = ptep_get_and_clear(mm, address, ptep);
-	if (pte_accessible(mm, pte))
+	if (pte_accessible(vma, ptep))
 		flush_tlb_page(vma, address);
 	return pte;
 }
-- 
2.25.1


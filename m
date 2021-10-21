Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F433436B90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhJUTzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhJUTzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:55:11 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2544DC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:52:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id o133so1585757pfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xAPUfxWmK2pbXk4NEqW3WWyCxNsLR7Fe6Gbqejxq7W8=;
        b=ATG9UfjwmnYi5q2/fzhTWXxRsr9/eHWuvWM7Og0nOg7+2bUxnVmIAKZWQN+Fw2U4c2
         IrpXqcLnOTipIMfLVvmRJAkfDOWD1DKjGBB+frOZtSVYlSbEJyIejLcFuHTNU3NfCrEo
         N4hNJZomGpaBo5w9T1waObJCqp5+DQHdNyXq30ocPj94Bt1PKgdO+zMoMlkZ5wqTF6u0
         IyKbvDozfvUqPsPBp1pYO8nQZzvDhR7AyQt4bQBsrvp/fBnM/n+O9nfcA6aS65E9mfF/
         HkbeclAn3KKBdp8H4KONs0yvPVqKCn6b4gI5vBw+sgjz0dO35Ze7fnNSDG+m9FYLO4uD
         lmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xAPUfxWmK2pbXk4NEqW3WWyCxNsLR7Fe6Gbqejxq7W8=;
        b=0SHAMsddqmskgH2Uo9Tl7nBtUF/v4ckJqaJ/nLEsEGr7hCF0igyaRlIK6SAXlhyDMw
         MvhMqm4S9mwL5StVYTUhOuHiYX3gE/Jx/LuTN0ad2y9dGLTR0JUP/OH231Rj9n/EOC9+
         9YwbG1B2asdmMFWQkMbGv5jNht5G+xjyISJ4P1jIs/FwESLR3nJ0HqNaboJkj+pfxu9J
         j3c5G62xb4mxAOyFujG1g7zPkHAEjcPEWkQ8UT2SuJlXEeNWlMKer11hvpFoS8A/3jEl
         Y58t46mlAdXYrccGQJW7OU2B2+bGpcI8v0VdLGC7QX0cc5JZoqcT7ffVad9c+k7lWNL+
         vdmw==
X-Gm-Message-State: AOAM5323Vc68bkkqP1p9FEe1FlgsbyOGdH60a4eW+Ah6wTlOq8shCENI
        Zu8utP81Ju3HeQ2ZDewU6GU=
X-Google-Smtp-Source: ABdhPJywvKbor/Q3RJAA85stKkFeJlmUYm3yWNeunU3Ykbxr+eKhf9jeD1rL0QOy1zIeVdijqyJBAw==
X-Received: by 2002:a05:6a00:2388:b0:44d:4b5d:d5e with SMTP id f8-20020a056a00238800b0044d4b5d0d5emr7700377pfc.80.1634845974547;
        Thu, 21 Oct 2021 12:52:54 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n202sm7098078pfd.160.2021.10.21.12.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:52:53 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [PATCH v2 5/5] mm/mprotect: do not flush on permission promotion
Date:   Thu, 21 Oct 2021 05:21:12 -0700
Message-Id: <20211021122112.592634-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021122112.592634-1-namit@vmware.com>
References: <20211021122112.592634-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Currently, using mprotect() to unprotect a memory region or uffd to
unprotect a memory region causes a TLB flush. At least on x86, as
protection is promoted, no TLB flush is needed.

Add an arch-specific pte_may_need_flush() which tells whether a TLB
flush is needed based on the old PTE and the new one. Implement an x86
pte_may_need_flush().

For x86, besides the simple logic that PTE protection promotion or
changes of software bits does require a flush, also add logic that
considers the dirty-bit. If the dirty-bit is clear and write-protect is
set, no TLB flush is needed, as x86 updates the dirty-bit atomically
on write, and if the bit is clear, the PTE is reread.

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
---
 arch/x86/include/asm/pgtable_types.h |  2 +
 arch/x86/include/asm/tlbflush.h      | 80 ++++++++++++++++++++++++++++
 include/asm-generic/tlb.h            | 14 +++++
 mm/huge_memory.c                     |  9 ++--
 mm/mprotect.c                        |  3 +-
 5 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 40497a9020c6..8668bc661026 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -110,9 +110,11 @@
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 #define _PAGE_NX	(_AT(pteval_t, 1) << _PAGE_BIT_NX)
 #define _PAGE_DEVMAP	(_AT(u64, 1) << _PAGE_BIT_DEVMAP)
+#define _PAGE_SOFTW4	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW4)
 #else
 #define _PAGE_NX	(_AT(pteval_t, 0))
 #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
+#define _PAGE_SOFTW4	(_AT(pteval_t, 0))
 #endif
 
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index b587a9ee9cb2..a782adde3d62 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -259,6 +259,86 @@ static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
+/*
+ * The enabled_mask tells which bits that were present and gets cleared require
+ * flush.
+ *
+ * The disabled_mask tells which bits that were missing and gets set require
+ * flush.
+ *
+ * All the other bits except the ignored bits will require a flush no matter if
+ * they gets set or cleared.
+ *
+ * Note that we ignore the accessed bit, since anyhow the kernel does not flush
+ * after clearing it in other situations. We also ignore the global bit, as it
+ * is used for protnone.
+ */
+static inline bool pte_flags_may_need_flush(unsigned long oldflags,
+					    unsigned long newflags)
+{
+	const pteval_t ignore_mask = _PAGE_SOFTW1 | _PAGE_SOFTW2 |
+		_PAGE_SOFTW3 | _PAGE_SOFTW4 | _PAGE_ACCESSED | _PAGE_GLOBAL;
+	const pteval_t enable_mask = _PAGE_RW | _PAGE_DIRTY | _PAGE_PRESENT;
+	const pteval_t disable_mask = _PAGE_NX;
+	unsigned long diff = oldflags ^ newflags;
+
+	return diff & ((oldflags & enable_mask) |
+		       (newflags & disable_mask) |
+		       ~(enable_mask | disable_mask | ignore_mask));
+}
+
+/*
+ * pte_may_need_flush() checks whether permissions were demoted and require a
+ * flush. It should only be used for userspace PTEs.
+ */
+static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte)
+{
+	/* new is non-present: need only if old is present */
+	if (!pte_present(newpte))
+		return pte_present(oldpte);
+
+	/* old is not present: no need for flush */
+	if (!pte_present(oldpte))
+		return false;
+
+	/*
+	 * Avoid open-coding to account for protnone_mask() and perform
+	 * comparison of the PTEs.
+	 */
+	if (pte_pfn(oldpte) != pte_pfn(newpte))
+		return true;
+
+	return pte_flags_may_need_flush(pte_flags(oldpte),
+					pte_flags(newpte));
+}
+#define pte_may_need_flush pte_may_need_flush
+
+/*
+ * huge_pmd_may_need_flush() checks whether permissions were demoted and
+ * require a flush. It should only be used for userspace huge PMDs.
+ */
+static inline bool huge_pmd_may_need_flush(pmd_t oldpmd, pmd_t newpmd)
+{
+	/* new is non-present: need only if old is present */
+	if (!pmd_present(newpmd))
+		return pmd_present(oldpmd);
+
+	/* old is not present: no need for flush */
+	if (!pmd_present(oldpmd))
+		return false;
+
+	/*
+	 * Avoid open-coding to account for protnone_mask() and perform
+	 * comparison of the PTEs.
+	 */
+	if (pmd_pfn(oldpmd) != pmd_pfn(newpmd))
+		return true;
+
+	return pte_flags_may_need_flush(pmd_flags(oldpmd),
+					pmd_flags(newpmd));
+}
+#define huge_pmd_may_need_flush huge_pmd_may_need_flush
+
 #endif /* !MODULE */
 
 #endif /* _ASM_X86_TLBFLUSH_H */
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 2c68a545ffa7..2d3736c62602 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -654,6 +654,20 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 	} while (0)
 #endif
 
+#ifndef pte_may_need_flush
+static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte)
+{
+	return true;
+}
+#endif
+
+#ifndef huge_pmd_may_need_flush
+static inline bool huge_pmd_may_need_flush(pmd_t oldpmd, pmd_t newpmd)
+{
+	return true;
+}
+#endif
+
 #endif /* CONFIG_MMU */
 
 #endif /* _ASM_GENERIC__TLB_H */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f5d0357a25ce..f80936324e6a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1726,7 +1726,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *ptl;
-	pmd_t entry;
+	pmd_t oldpmd, entry;
 	bool preserve_write;
 	int ret;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
@@ -1802,9 +1802,9 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * dirty/young flags (which are also known as access/dirty) cannot be
 	 * further modifeid by the hardware.
 	 */
-	entry = pmdp_invalidate_ad(vma, addr, pmd);
+	oldpmd = pmdp_invalidate_ad(vma, addr, pmd);
 
-	entry = pmd_modify(entry, newprot);
+	entry = pmd_modify(oldpmd, newprot);
 	if (preserve_write)
 		entry = pmd_mk_savedwrite(entry);
 	if (uffd_wp) {
@@ -1821,7 +1821,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	ret = HPAGE_PMD_NR;
 	set_pmd_at(mm, addr, pmd, entry);
 
-	tlb_flush_pmd_range(tlb, addr, HPAGE_PMD_SIZE);
+	if (huge_pmd_may_need_flush(oldpmd, entry))
+		tlb_flush_pmd_range(tlb, addr, HPAGE_PMD_SIZE);
 
 	BUG_ON(vma_is_anonymous(vma) && !preserve_write && pmd_write(entry));
 unlock:
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0f5c87af5c60..6179c82ea72d 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -141,7 +141,8 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 				ptent = pte_mkwrite(ptent);
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
-			tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
+			if (pte_may_need_flush(oldpte, ptent))
+				tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
 			pages++;
 		} else if (is_swap_pte(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
-- 
2.25.1


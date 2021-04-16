Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F01362456
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhDPPn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:43:57 -0400
Received: from foss.arm.com ([217.140.110.172]:44538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231449AbhDPPnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:43:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5113612FC;
        Fri, 16 Apr 2021 08:43:25 -0700 (PDT)
Received: from e112269-lin.arm.com (autoplooker.cambridge.arm.com [10.1.194.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 854F53F99C;
        Fri, 16 Apr 2021 08:43:22 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: [PATCH v11 1/6] arm64: mte: Sync tags for pages where PTE is untagged
Date:   Fri, 16 Apr 2021 16:43:04 +0100
Message-Id: <20210416154309.22129-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416154309.22129-1-steven.price@arm.com>
References: <20210416154309.22129-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A KVM guest could store tags in a page even if the VMM hasn't mapped
the page with PROT_MTE. So when restoring pages from swap we will
need to check to see if there are any saved tags even if !pte_tagged().

However don't check pages which are !pte_valid_user() as these will
not have been swapped out.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/pgtable.h |  2 +-
 arch/arm64/kernel/mte.c          | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e17b96d0e4b5..cf4b52a33b3c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -312,7 +312,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 		__sync_icache_dcache(pte);
 
 	if (system_supports_mte() &&
-	    pte_present(pte) && pte_tagged(pte) && !pte_special(pte))
+	    pte_present(pte) && (pte_val(pte) & PTE_USER) && !pte_special(pte))
 		mte_sync_tags(ptep, pte);
 
 	__check_racy_pte_update(mm, ptep, pte);
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index b3c70a612c7a..e016ab57ea36 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -26,17 +26,23 @@ u64 gcr_kernel_excl __ro_after_init;
 
 static bool report_fault_once = true;
 
-static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
+static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap,
+			       bool pte_is_tagged)
 {
 	pte_t old_pte = READ_ONCE(*ptep);
 
 	if (check_swap && is_swap_pte(old_pte)) {
 		swp_entry_t entry = pte_to_swp_entry(old_pte);
 
-		if (!non_swap_entry(entry) && mte_restore_tags(entry, page))
+		if (!non_swap_entry(entry) && mte_restore_tags(entry, page)) {
+			set_bit(PG_mte_tagged, &page->flags);
 			return;
+		}
 	}
 
+	if (!pte_is_tagged || test_and_set_bit(PG_mte_tagged, &page->flags))
+		return;
+
 	page_kasan_tag_reset(page);
 	/*
 	 * We need smp_wmb() in between setting the flags and clearing the
@@ -54,11 +60,13 @@ void mte_sync_tags(pte_t *ptep, pte_t pte)
 	struct page *page = pte_page(pte);
 	long i, nr_pages = compound_nr(page);
 	bool check_swap = nr_pages == 1;
+	bool pte_is_tagged = pte_tagged(pte);
 
 	/* if PG_mte_tagged is set, tags have already been initialised */
 	for (i = 0; i < nr_pages; i++, page++) {
-		if (!test_and_set_bit(PG_mte_tagged, &page->flags))
-			mte_sync_page_tags(page, ptep, check_swap);
+		if (!test_bit(PG_mte_tagged, &page->flags))
+			mte_sync_page_tags(page, ptep, check_swap,
+					   pte_is_tagged);
 	}
 }
 
-- 
2.20.1


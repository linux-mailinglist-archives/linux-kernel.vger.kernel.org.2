Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C49838E472
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhEXKrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:47:11 -0400
Received: from foss.arm.com ([217.140.110.172]:40798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232724AbhEXKq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58E51139F;
        Mon, 24 May 2021 03:45:31 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 941653F719;
        Mon, 24 May 2021 03:45:28 -0700 (PDT)
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
Subject: [PATCH v13 3/8] arm64: mte: Sync tags for pages where PTE is untagged
Date:   Mon, 24 May 2021 11:45:08 +0100
Message-Id: <20210524104513.13258-4-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524104513.13258-1-steven.price@arm.com>
References: <20210524104513.13258-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A KVM guest could store tags in a page even if the VMM hasn't mapped
the page with PROT_MTE. So when restoring pages from swap we will
need to check to see if there are any saved tags even if !pte_tagged().

However don't check pages for which pte_access_permitted() returns false
as these will not have been swapped out.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/mte.h     |  4 ++--
 arch/arm64/include/asm/pgtable.h | 22 +++++++++++++++++++---
 arch/arm64/kernel/mte.c          | 16 ++++++++++++----
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index bc88a1ced0d7..347ef38a35f7 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -37,7 +37,7 @@ void mte_free_tag_storage(char *storage);
 /* track which pages have valid allocation tags */
 #define PG_mte_tagged	PG_arch_2
 
-void mte_sync_tags(pte_t *ptep, pte_t pte);
+void mte_sync_tags(pte_t old_pte, pte_t pte);
 void mte_copy_page_tags(void *kto, const void *kfrom);
 void mte_thread_init_user(void);
 void mte_thread_switch(struct task_struct *next);
@@ -53,7 +53,7 @@ int mte_ptrace_copy_tags(struct task_struct *child, long request,
 /* unused if !CONFIG_ARM64_MTE, silence the compiler */
 #define PG_mte_tagged	0
 
-static inline void mte_sync_tags(pte_t *ptep, pte_t pte)
+static inline void mte_sync_tags(pte_t old_pte, pte_t pte)
 {
 }
 static inline void mte_copy_page_tags(void *kto, const void *kfrom)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b10204e72fc..db5402168841 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -314,9 +314,25 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
 		__sync_icache_dcache(pte);
 
-	if (system_supports_mte() &&
-	    pte_present(pte) && pte_tagged(pte) && !pte_special(pte))
-		mte_sync_tags(ptep, pte);
+	/*
+	 * If the PTE would provide user space access to the tags associated
+	 * with it then ensure that the MTE tags are synchronised.  Although
+	 * pte_access_permitted() returns false for exec only mappings, they
+	 * don't expose tags (instruction fetches don't check tags).
+	 */
+	if (system_supports_mte() && pte_access_permitted(pte, false) &&
+	    !pte_special(pte)) {
+		pte_t old_pte = READ_ONCE(*ptep);
+		/*
+		 * We only need to synchronise if the new PTE has tags enabled
+		 * or if swapping in (in which case another mapping may have
+		 * set tags in the past even if this PTE isn't tagged).
+		 * (!pte_none() && !pte_present()) is an open coded version of
+		 * is_swap_pte()
+		 */
+		if (pte_tagged(pte) || (!pte_none(old_pte) && !pte_present(old_pte)))
+			mte_sync_tags(old_pte, pte);
+	}
 
 	__check_racy_pte_update(mm, ptep, pte);
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 45fac0e9c323..ae0a3c68fece 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -33,10 +33,10 @@ DEFINE_STATIC_KEY_FALSE(mte_async_mode);
 EXPORT_SYMBOL_GPL(mte_async_mode);
 #endif
 
-static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
+static void mte_sync_page_tags(struct page *page, pte_t old_pte,
+			       bool check_swap, bool pte_is_tagged)
 {
 	unsigned long flags;
-	pte_t old_pte = READ_ONCE(*ptep);
 
 	spin_lock_irqsave(&tag_sync_lock, flags);
 
@@ -53,6 +53,9 @@ static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 		}
 	}
 
+	if (!pte_is_tagged)
+		goto out;
+
 	page_kasan_tag_reset(page);
 	/*
 	 * We need smp_wmb() in between setting the flags and clearing the
@@ -69,17 +72,22 @@ static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 	spin_unlock_irqrestore(&tag_sync_lock, flags);
 }
 
-void mte_sync_tags(pte_t *ptep, pte_t pte)
+void mte_sync_tags(pte_t old_pte, pte_t pte)
 {
 	struct page *page = pte_page(pte);
 	long i, nr_pages = compound_nr(page);
 	bool check_swap = nr_pages == 1;
 	bool pte_is_tagged = pte_tagged(pte);
 
+	/* Early out if there's nothing to do */
+	if (!check_swap && !pte_is_tagged)
+		return;
+
 	/* if PG_mte_tagged is set, tags have already been initialised */
 	for (i = 0; i < nr_pages; i++, page++) {
 		if (!test_bit(PG_mte_tagged, &page->flags))
-			mte_sync_page_tags(page, ptep, check_swap);
+			mte_sync_page_tags(page, old_pte, check_swap,
+					   pte_is_tagged);
 	}
 }
 
-- 
2.20.1


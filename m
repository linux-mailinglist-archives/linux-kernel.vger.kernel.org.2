Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF144382C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhEQMeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:34:36 -0400
Received: from foss.arm.com ([217.140.110.172]:50102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229776AbhEQMef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:34:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 346A1113E;
        Mon, 17 May 2021 05:33:19 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CBBB3F73B;
        Mon, 17 May 2021 05:33:16 -0700 (PDT)
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
Subject: [PATCH v12 3/8] arm64: mte: Sync tags for pages where PTE is untagged
Date:   Mon, 17 May 2021 13:32:34 +0100
Message-Id: <20210517123239.8025-4-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517123239.8025-1-steven.price@arm.com>
References: <20210517123239.8025-1-steven.price@arm.com>
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
 arch/arm64/include/asm/pgtable.h |  9 +++++++--
 arch/arm64/kernel/mte.c          | 16 ++++++++++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b10204e72fc..275178a810c1 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -314,8 +314,13 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
 		__sync_icache_dcache(pte);
 
-	if (system_supports_mte() &&
-	    pte_present(pte) && pte_tagged(pte) && !pte_special(pte))
+	/*
+	 * If the PTE would provide user space access to the tags associated
+	 * with it then ensure that the MTE tags are synchronised.  Exec-only
+	 * mappings don't expose tags (instruction fetches don't check tags).
+	 */
+	if (system_supports_mte() && pte_present(pte) &&
+	    pte_access_permitted(pte, false) && !pte_special(pte))
 		mte_sync_tags(ptep, pte);
 
 	__check_racy_pte_update(mm, ptep, pte);
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index c88e778c2fa9..a604818c52c1 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -33,11 +33,15 @@ DEFINE_STATIC_KEY_FALSE(mte_async_mode);
 EXPORT_SYMBOL_GPL(mte_async_mode);
 #endif
 
-static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
+static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap,
+			       bool pte_is_tagged)
 {
 	unsigned long flags;
 	pte_t old_pte = READ_ONCE(*ptep);
 
+	if (!is_swap_pte(old_pte) && !pte_is_tagged)
+		return;
+
 	spin_lock_irqsave(&tag_sync_lock, flags);
 
 	/* Recheck with the lock held */
@@ -53,6 +57,9 @@ static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 		}
 	}
 
+	if (!pte_is_tagged)
+		goto out;
+
 	page_kasan_tag_reset(page);
 	/*
 	 * We need smp_wmb() in between setting the flags and clearing the
@@ -76,10 +83,15 @@ void mte_sync_tags(pte_t *ptep, pte_t pte)
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
+			mte_sync_page_tags(page, ptep, check_swap,
+					   pte_is_tagged);
 	}
 }
 
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F7A38E46F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhEXKrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:47:06 -0400
Received: from foss.arm.com ([217.140.110.172]:40760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232397AbhEXKqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:46:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64F9E113E;
        Mon, 24 May 2021 03:45:25 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7FA23F719;
        Mon, 24 May 2021 03:45:22 -0700 (PDT)
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
Subject: [PATCH v13 1/8] arm64: mte: Handle race when synchronising tags
Date:   Mon, 24 May 2021 11:45:06 +0100
Message-Id: <20210524104513.13258-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524104513.13258-1-steven.price@arm.com>
References: <20210524104513.13258-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mte_sync_tags() used test_and_set_bit() to set the PG_mte_tagged flag
before restoring/zeroing the MTE tags. However if another thread were to
race and attempt to sync the tags on the same page before the first
thread had completed restoring/zeroing then it would see the flag is
already set and continue without waiting. This would potentially expose
the previous contents of the tags to user space, and cause any updates
that user space makes before the restoring/zeroing has completed to
potentially be lost.

Since this code is run from atomic contexts we can't just lock the page
during the process. Instead implement a new (global) spinlock to protect
the mte_sync_page_tags() function.

Fixes: 34bfeea4a9e9 ("arm64: mte: Clear the tags when a page is mapped in user-space with PROT_MTE")
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
---
 arch/arm64/kernel/mte.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 125a10e413e9..45fac0e9c323 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -25,6 +25,7 @@
 u64 gcr_kernel_excl __ro_after_init;
 
 static bool report_fault_once = true;
+static DEFINE_SPINLOCK(tag_sync_lock);
 
 #ifdef CONFIG_KASAN_HW_TAGS
 /* Whether the MTE asynchronous mode is enabled. */
@@ -34,13 +35,22 @@ EXPORT_SYMBOL_GPL(mte_async_mode);
 
 static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 {
+	unsigned long flags;
 	pte_t old_pte = READ_ONCE(*ptep);
 
+	spin_lock_irqsave(&tag_sync_lock, flags);
+
+	/* Recheck with the lock held */
+	if (test_bit(PG_mte_tagged, &page->flags))
+		goto out;
+
 	if (check_swap && is_swap_pte(old_pte)) {
 		swp_entry_t entry = pte_to_swp_entry(old_pte);
 
-		if (!non_swap_entry(entry) && mte_restore_tags(entry, page))
-			return;
+		if (!non_swap_entry(entry) && mte_restore_tags(entry, page)) {
+			set_bit(PG_mte_tagged, &page->flags);
+			goto out;
+		}
 	}
 
 	page_kasan_tag_reset(page);
@@ -53,6 +63,10 @@ static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 	 */
 	smp_wmb();
 	mte_clear_page_tags(page_address(page));
+	set_bit(PG_mte_tagged, &page->flags);
+
+out:
+	spin_unlock_irqrestore(&tag_sync_lock, flags);
 }
 
 void mte_sync_tags(pte_t *ptep, pte_t pte)
@@ -60,10 +74,11 @@ void mte_sync_tags(pte_t *ptep, pte_t pte)
 	struct page *page = pte_page(pte);
 	long i, nr_pages = compound_nr(page);
 	bool check_swap = nr_pages == 1;
+	bool pte_is_tagged = pte_tagged(pte);
 
 	/* if PG_mte_tagged is set, tags have already been initialised */
 	for (i = 0; i < nr_pages; i++, page++) {
-		if (!test_and_set_bit(PG_mte_tagged, &page->flags))
+		if (!test_bit(PG_mte_tagged, &page->flags))
 			mte_sync_page_tags(page, ptep, check_swap);
 	}
 }
-- 
2.20.1


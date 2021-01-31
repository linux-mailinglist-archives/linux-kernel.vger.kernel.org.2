Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7441030994F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhAaARB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhAaAQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:16:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8BFC061756
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id e9so8806314pjj.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DNxo16iCNNEqpRi0tVt5da0M9RdBAEB3Mfjbxme6ACQ=;
        b=Yr95/MAa90ahbQ9SGbcNuoIm7byeFbJgjA9qtcNbqcRUs8stZ62X6TP0sb6ijhCM4u
         UqPIQ6NM8f8yf33mQgiOmMuVBSAt9LDz/lBdJivbFlXqZajnoA1NCOt+CU9xHdgx3QUi
         To//nUdTJRhpoUbmS8RibLZ11gh7dQDbowtXmLcvx9xVwgdAD//UwpjJRjnf6LY4skue
         GxZQIqWNESsTJBgDQ8STQLM7AS73T+ccluPy8jOij6Hq8ugtyl0Vmo6RgBMFg/iolsYa
         I5fekBGetsDGdcsIdj3sl6IHqyWxXvAW8HdmrtqyWKtD3LHfwl4bLwTXq21MZydYJOQR
         DnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DNxo16iCNNEqpRi0tVt5da0M9RdBAEB3Mfjbxme6ACQ=;
        b=D0Ka5mRK8JY+dctXsWQ0O8NH6Hx8GBSPnXnf4Q3outRyhMocYWP4M+sEkAl73G+HiF
         pikcIvj+O+3ih4u7eivAP+d7OFg2uSop81ej9L0WILIpvacwwAnrKq8Brn31QDeuERcY
         r2JrVYAAa/OBhW7tAW/vIE5MYhUdqd2nQ5GmAoCVKGTKTrp+WzEC/W29ipUAVKWH/AUF
         iA92cLJfw7Ehx+L7Ya+H06hxANITQ6fLKnYPaDb35il8QcBLhfIeOCPTmw+rZKf3n3Ux
         15SS6cxjpqT/W+jufZrs6O753kTt+IKeBqKWWsMjGlEnKp7ehZIWgNCdVDTAp7Zu6K4q
         u1HQ==
X-Gm-Message-State: AOAM532ljhakPtWpLdQsqtA+cwZS6ClpyNUmrYj2a5m8VNinB0ibIZs+
        AVLSHqVgcONZr69+fVlPWgw=
X-Google-Smtp-Source: ABdhPJzqJLhgd8JRSQewC2Nzlo9p9h1NzX9V2S7FLf7k6KbsLBVCMC9Lm4EPN9txdmdVTtWwr62UDA==
X-Received: by 2002:a17:90b:180d:: with SMTP id lw13mr10626232pjb.94.1612052165042;
        Sat, 30 Jan 2021 16:16:05 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:04 -0800 (PST)
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
Subject: [RFC 03/20] mm/mprotect: do not flush on permission promotion
Date:   Sat, 30 Jan 2021 16:11:15 -0800
Message-Id: <20210131001132.3368247-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
---
 arch/x86/include/asm/tlbflush.h | 44 +++++++++++++++++++++++++++++++++
 include/asm-generic/tlb.h       |  4 +++
 mm/mprotect.c                   |  3 ++-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 8c87a2e0b660..a617dc0a9b06 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -255,6 +255,50 @@ static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
+static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte)
+{
+	const pteval_t ignore_mask = _PAGE_SOFTW1 | _PAGE_SOFTW2 |
+				     _PAGE_SOFTW3 | _PAGE_ACCESSED;
+	const pteval_t enable_mask = _PAGE_RW | _PAGE_DIRTY | _PAGE_GLOBAL;
+	pteval_t oldval = pte_val(oldpte);
+	pteval_t newval = pte_val(newpte);
+	pteval_t diff = oldval ^ newval;
+	pteval_t disable_mask = 0;
+
+	if (IS_ENABLED(CONFIG_X86_64) || IS_ENABLED(CONFIG_X86_PAE))
+		disable_mask = _PAGE_NX;
+
+	/* new is non-present: need only if old is present */
+	if (pte_none(newpte))
+		return !pte_none(oldpte);
+
+	/*
+	 * If, excluding the ignored bits, only RW and dirty are cleared and the
+	 * old PTE does not have the dirty-bit set, we can avoid a flush. This
+	 * is possible since x86 architecture set the dirty bit atomically while
+	 * it caches the PTE in the TLB.
+	 *
+	 * The condition considers any change to RW and dirty as not requiring
+	 * flush if the old PTE is not dirty or not writable for simplification
+	 * of the code and to consider (unlikely) cases of changing dirty-bit of
+	 * write-protected PTE.
+	 */
+	if (!(diff & ~(_PAGE_RW | _PAGE_DIRTY | ignore_mask)) &&
+	    (!(pte_dirty(oldpte) || !pte_write(oldpte))))
+		return false;
+
+	/*
+	 * Any change of PFN and any flag other than those that we consider
+	 * requires a flush (e.g., PAT, protection keys). To save flushes we do
+	 * not consider the access bit as it is considered by the kernel as
+	 * best-effort.
+	 */
+	return diff & ((oldval & enable_mask) |
+		       (newval & disable_mask) |
+		       ~(enable_mask | disable_mask | ignore_mask));
+}
+#define pte_may_need_flush pte_may_need_flush
+
 #endif /* !MODULE */
 
 #endif /* _ASM_X86_TLBFLUSH_H */
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index eea113323468..c2deec0b6919 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -654,6 +654,10 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 	} while (0)
 #endif
 
+#ifndef pte_may_need_flush
+static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte) { return true; }
+#endif
+
 #endif /* CONFIG_MMU */
 
 #endif /* _ASM_GENERIC__TLB_H */
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 632d5a677d3f..b7473d2c9a1f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -139,7 +139,8 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
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


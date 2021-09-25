Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1D9418648
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 06:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhIZE1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 00:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhIZE1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 00:27:23 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9BCC061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 21:25:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v19so9882165pjh.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 21:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38X15zXo+/Y1pmE94+biXA74I0XZ/m9EP9lkXOHRlBI=;
        b=B217FJUV7D0NkEiadrzSyMA9XRT/EK7NqAYZYYhlQpfEqpnzbOA4K1gd8qMEiZBbxv
         JJANulJyWob1QHSStd6EY0YY2iKA61nKRVvdE6D/gw5/jj4XWa4W+EPOsrfViRpB1vev
         Ckzh98tfj1x1enZcLqRAZkbDUmz7zv+kHgHfsVwyAfSKy21qvx/bOmblN0yuUq5mOrhA
         4qRT+wjUlhQkcbG9fYJzLwx8BNOG1s9pXu7EoSIKicAb+Q2cIDBk+XemIWUYgq+k6YrO
         Bdi6QHVxHCiI9T27FUfqjiZSjCC27b/etvSGsyGTAChMiaDGVogCEm3035fdUimeEP2V
         /IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38X15zXo+/Y1pmE94+biXA74I0XZ/m9EP9lkXOHRlBI=;
        b=3PCtWvaotNGY864/JOQQKO3pVHcq6ZkJfTIJwb3z+7mvu0TMg1duYrUhK+QHZZ8mou
         RPbBQchH04c1s75L3D8MXn9s9Rp08yD4bebMLgw4FYhfWpQYIQg7eOCYDNIS1wvlUnyK
         5voUzpjmng/srIqV/nVimThtop3bI2uilyBMyzd929ZQjOFHo+KPARyVqYb51iNqOY25
         GgueWc+Ect/wpYvZTzsP1mlLdSSQCQ2Ns7MHFQDBN224mGOv0zQ6M/82kPzWvR+ajJ10
         zVAx+TbYPYIoBiCcizyI2jPimk3euFqowGl94gM/OqAOtO06TLlNAaegB6Cmlxye6Ph0
         kAjQ==
X-Gm-Message-State: AOAM531dpRkUxeXE1b0NouiTvZyHzi0BwCV1GB64SPW7/5vzy6We2if4
        Trrt16VxwqvvwCuJ1DXBLxQ=
X-Google-Smtp-Source: ABdhPJyowsR26GW3IybxXUytPWUnH8GvlF0Qxvy1Y52O08GFhCfT6DO6GA1K4z8Qt2T0oAyx63Eyag==
X-Received: by 2002:a17:90a:7d11:: with SMTP id g17mr11731048pjl.19.1632630347189;
        Sat, 25 Sep 2021 21:25:47 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q11sm12406154pjf.14.2021.09.25.21.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 21:25:46 -0700 (PDT)
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
Subject: [PATCH 2/2] mm/mprotect: do not flush on permission promotion
Date:   Sat, 25 Sep 2021 13:54:23 -0700
Message-Id: <20210925205423.168858-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925205423.168858-1-namit@vmware.com>
References: <20210925205423.168858-1-namit@vmware.com>
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

For x86, PTE protection promotion or changes of software bits does
require a flush, also add logic that considers the dirty-bit. Changes to
the access-bit do not trigger a TLB flush, although architecturally they
should, as Linux considers the access-bit as a hint.

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
 arch/x86/include/asm/tlbflush.h | 40 +++++++++++++++++++++++++++++++++
 include/asm-generic/tlb.h       |  4 ++++
 mm/mprotect.c                   |  3 ++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index b587a9ee9cb2..e74d13d174d1 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -259,6 +259,46 @@ static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
+/*
+ * pte_may_need_flush() checks whether a TLB flush is necessary according to x86
+ * architectural definition. Mere promotion of permissions does not require a
+ * TLB flush. Changes of software bits does not require a TLB flush. Demotion
+ * of the access-bit also does not trigger a TLB flush (although it is required
+ * architecturally) - see the comment in ptep_clear_flush_young().
+ *
+ * Further optimizations may be possible, such as avoiding a flush when clearing
+ * the write-bit on non-dirty entries. As those do not explicitly follow the
+ * specifications, they are not implemented (at least for now).
+ */
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
index 2c68a545ffa7..5ca49f44bc38 100644
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
index 075ff94aa51c..ae79df59a7a8 100644
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


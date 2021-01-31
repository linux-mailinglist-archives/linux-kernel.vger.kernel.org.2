Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3325309955
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhAaASK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhAaAQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:16:55 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D50C06178A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:14 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id b21so9425500pgk.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B1n9KuHbkwDteeyX+EGvgbidSs5/e5CI67AfWMUmp8s=;
        b=SKZEOydA0mMWkDa5c+uNDDq0+qMOl+Zb6dqieV/jCTFS++mV7yMbTyfUAEFSfwFcL2
         ya1tZMpINcor6UQYYqa5YSPVwsgJwmtDtXjfoVUxQhTlq3wC7rn7uhgnvpiTAijnzQ5J
         DOjVqicU91j+tmfyiWaGWEcL9Kj/vkOFJdbPV/ZE8hP51yiruPoTE9yTgfFXptPlh9ok
         Iahtt+cLVVjWY3zHdcUenrf4+tyHlaNTzuZ36PebMzYas0Xz1Pr4A/ILg/aDGBYou02R
         vR0q3WWSXwG2iv4f3C53S0tpyjBf3PsMIYTG7KBudtFNHH6ySwoMHXUKRczItmaUieXX
         IFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1n9KuHbkwDteeyX+EGvgbidSs5/e5CI67AfWMUmp8s=;
        b=dX4JiKv3eaitjOyWmsyAm3CGTmU1mlAMX5EaXulNCrq6GwmaF+m3n4Vc+mUIxVhSqa
         Uy2cEMASZIJhxrTX+w3UQ/GyUfiJmAyeRIdSS4bigkXklhS4oUSa1WzR+wybFwFzeEA1
         fpbRPCfuwcKuIbRBYlGcTCqjK1IkykHM+P5Xh6LuyPwsUbdkSDGL61CqKYeBsXtNheAB
         BYyAmv6qdQF0Z35+BqO7NCA9mkz9dNPzss5vw3eWzxL8sL7jYmPS4eoGVnZ6JNUfn4Jq
         LIFkTwpSGJWtprxN9POuhgq+OqMoGl7O5qWFV588lo9Ew1ZuKSCQ8aCJCl1OY+s8kg0t
         YXrg==
X-Gm-Message-State: AOAM530O626JTT5/9GvzrCo9105oNlJD0ZwnU1vNDCwifCJgMude0spG
        BlfZlzRtrEH2RHg+imhAOiE=
X-Google-Smtp-Source: ABdhPJxF8xo5w6K8Nn+HFQfi/CPEUbKsBx5EUV2igQkFgijrTJKmcZ10by10k68OT6k9qdD59CoIoQ==
X-Received: by 2002:a63:1261:: with SMTP id 33mr10809432pgs.213.1612052173517;
        Sat, 30 Jan 2021 16:16:13 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:12 -0800 (PST)
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
Subject: [RFC 08/20] mm: store completed TLB generation
Date:   Sat, 30 Jan 2021 16:11:20 -0800
Message-Id: <20210131001132.3368247-9-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

To detect deferred TLB flushes in fine granularity, we need to keep
track on the completed TLB flush generation for each mm.

Add logic to track for each mm the tlb_gen_completed, which tracks the
completed TLB generation. It is the arch responsibility to call
mark_mm_tlb_gen_done() whenever a TLB flush is completed.

Start the generation numbers from 1 instead of 0. This would allow later
to detect whether flushes of a certain generation were completed.

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
 arch/x86/mm/tlb.c         | 10 ++++++++++
 include/asm-generic/tlb.h | 33 +++++++++++++++++++++++++++++++++
 include/linux/mm_types.h  | 15 ++++++++++++++-
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 7ab21430be41..d17b5575531e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -14,6 +14,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/cache.h>
 #include <asm/apic.h>
+#include <asm/tlb.h>
 
 #include "mm_internal.h"
 
@@ -915,6 +916,9 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
 		flush_tlb_others(mm_cpumask(mm), info);
 
+	/* Update the completed generation */
+	mark_mm_tlb_gen_done(mm, new_tlb_gen);
+
 	put_flush_tlb_info();
 	put_cpu();
 }
@@ -1147,6 +1151,12 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 
 	cpumask_clear(&batch->cpumask);
 
+	/*
+	 * We cannot call mark_mm_tlb_gen_done() since we do not know which
+	 * mm's should be flushed. This may lead to some unwarranted TLB
+	 * flushes, but not to correction problems.
+	 */
+
 	put_cpu();
 }
 
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 517c89398c83..427bfcc6cdec 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -513,6 +513,39 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 }
 #endif
 
+#ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
+
+/*
+ * Helper function to update a generation to have a new value, as long as new
+ * value is greater or equal to gen.
+ */
+static inline void tlb_update_generation(atomic64_t *gen, u64 new_gen)
+{
+	u64 cur_gen = atomic64_read(gen);
+
+	while (cur_gen < new_gen) {
+		u64 old_gen = atomic64_cmpxchg(gen, cur_gen, new_gen);
+
+		/* Check if we succeeded in the cmpxchg */
+		if (likely(cur_gen == old_gen))
+			break;
+
+		cur_gen = old_gen;
+	};
+}
+
+
+static inline void mark_mm_tlb_gen_done(struct mm_struct *mm, u64 gen)
+{
+	/*
+	 * Update the completed generation to the new generation if the new
+	 * generation is greater than the previous one.
+	 */
+	tlb_update_generation(&mm->tlb_gen_completed, gen);
+}
+
+#endif /* CONFIG_ARCH_HAS_TLB_GENERATIONS */
+
 /*
  * tlb_flush_{pte|pmd|pud|p4d}_range() adjust the tlb->start and tlb->end,
  * and set corresponding cleared_*.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2035ac319c2b..8a5eb4bfac59 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -571,6 +571,13 @@ struct mm_struct {
 		 * This is not used on Xen PV.
 		 */
 		atomic64_t tlb_gen;
+
+		/*
+		 * TLB generation which is guarnateed to be flushed, including
+		 * all the PTE changes that were performed before tlb_gen was
+		 * incremented.
+		 */
+		atomic64_t tlb_gen_completed;
 #endif
 	} __randomize_layout;
 
@@ -690,7 +697,13 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
 #ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
 static inline void init_mm_tlb_gen(struct mm_struct *mm)
 {
-	atomic64_set(&mm->tlb_gen, 0);
+	/*
+	 * Start from generation of 1, so default generation 0 will be
+	 * considered as flushed and would not be regarded as an outstanding
+	 * deferred invalidation.
+	 */
+	atomic64_set(&mm->tlb_gen, 1);
+	atomic64_set(&mm->tlb_gen_completed, 1);
 }
 
 static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26E8309953
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhAaAR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbhAaAQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:16:52 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4995C0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:08 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b145so2281493pfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzlVqewRXAg3OMvze9ev5t9d0DHfKiwF7Fd8unaArI0=;
        b=a/vzewfyyogHVl7oec30+NCJAuiKllkXhkf/E92lZlob0Juz6BSXZ4LybGQOgTD7Pb
         qjPdbwodVyGr1gRxpvoQourmMUu56/daQ1UKeXadpoz/CvQF+35+maIzvYKdg1KoioKy
         RXitPbiy/dwIzfqN1x9Hmvde8fUl1GSNtVNBpNSuHEYMZoRb1mSel32bn+kr9VkA0HgL
         nm/iPrmaqNVze6dgkSwUtdAQ44AmH7KMf2GtcLJBOEZfwKTrInGZv0jj5akCHUyRdiKE
         OJVWaziglwMV7bGvkUnuTE6n3KG+yR7DE+AB0ky8D4VB7VLvSbJZq+pKZ7HwauIlvYxR
         QYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzlVqewRXAg3OMvze9ev5t9d0DHfKiwF7Fd8unaArI0=;
        b=HEylRlw61+PzaZQ05G1xv0RqYIznpN4ZC92gBOyIlC/sZHhJJ+fa9DnFp22n2EbEjj
         qxXVajUbGZOqyQ2rr7SWbUgiPiHb6FoYuuoCcGB90tXg5Lt3cBETkrDbygRifjJ5qGNM
         4LXQZtjqaGEyASGGEmlH2TNezy6+kyrL6OPwN3R+y2xRQUuuDBNkhg+RddCQJRmXFzsS
         Gp4888blynyW7qZEQGU0rl2sOjAC5ohFOz+FmKnbv0OtZx94by5ObZZ2iYdTYnXhbjaz
         fvNGwyHm/fjHgUl02oMBuHrYka4ABkbh4H1OaklTLqHu+mN0svLmm1ysz3kmy1ZmsIQq
         KuLg==
X-Gm-Message-State: AOAM533BHcGzzAdwshD57k5r4HyvyJGwUQhpDlUGWI0E7VyKdR97wxoP
        3ws4dXrclEfw6g2NjbJ7a78=
X-Google-Smtp-Source: ABdhPJyhSETixc5AJsaHNKoGQJPd6srN/UgKTvNi1vnesRUTToIiDJ/7t8Kfp5f0pZIshkCllVGq+w==
X-Received: by 2002:a63:f19:: with SMTP id e25mr10533814pgl.220.1612052168283;
        Sat, 30 Jan 2021 16:16:08 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:07 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        x86@kernel.org
Subject: [RFC 05/20] mm/tlb: move BATCHED_UNMAP_TLB_FLUSH to tlb.h
Date:   Sat, 30 Jan 2021 16:11:17 -0800
Message-Id: <20210131001132.3368247-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Arguably, tlb.h is the natural place for TLB related code. In addition,
task_mmu needs to be able to call to flush_tlb_batched_pending() and
therefore cannot (or should not) use mm/internal.h.

Move all the functions that are controlled by
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH to tlb.h.

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: x86@kernel.org
---
 include/asm-generic/tlb.h | 17 +++++++++++++++++
 mm/internal.h             | 16 ----------------
 mm/mremap.c               |  2 +-
 mm/vmscan.c               |  1 +
 4 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index c2deec0b6919..517c89398c83 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -658,6 +658,23 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte) { return true; }
 #endif
 
+#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+void try_to_unmap_flush(void);
+void try_to_unmap_flush_dirty(void);
+void flush_tlb_batched_pending(struct mm_struct *mm);
+#else
+static inline void try_to_unmap_flush(void)
+{
+}
+static inline void try_to_unmap_flush_dirty(void)
+{
+}
+static inline void flush_tlb_batched_pending(struct mm_struct *mm)
+{
+}
+static inline void tlb_batch_init(void) { }
+#endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
+
 #endif /* CONFIG_MMU */
 
 #endif /* _ASM_GENERIC__TLB_H */
diff --git a/mm/internal.h b/mm/internal.h
index 25d2b2439f19..d3860f9fbb83 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -585,22 +585,6 @@ struct tlbflush_unmap_batch;
  */
 extern struct workqueue_struct *mm_percpu_wq;
 
-#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
-void try_to_unmap_flush(void);
-void try_to_unmap_flush_dirty(void);
-void flush_tlb_batched_pending(struct mm_struct *mm);
-#else
-static inline void try_to_unmap_flush(void)
-{
-}
-static inline void try_to_unmap_flush_dirty(void)
-{
-}
-static inline void flush_tlb_batched_pending(struct mm_struct *mm)
-{
-}
-#endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
-
 extern const struct trace_print_flags pageflag_names[];
 extern const struct trace_print_flags vmaflag_names[];
 extern const struct trace_print_flags gfpflag_names[];
diff --git a/mm/mremap.c b/mm/mremap.c
index f554320281cc..57655d1b1031 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -26,7 +26,7 @@
 #include <linux/userfaultfd_k.h>
 
 #include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
+#include <asm/tlb.h>
 
 #include "internal.h"
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b1b574ad199d..ee144c359b41 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -52,6 +52,7 @@
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
+#include <asm/tlb.h>
 
 #include <linux/swapops.h>
 #include <linux/balloon_compaction.h>
-- 
2.25.1


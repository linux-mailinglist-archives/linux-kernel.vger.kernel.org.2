Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA030995C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhAaATL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbhAaAQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:16:58 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C5BC0617A7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:23 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o63so9418009pgo.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6DfXOdul3BLGU90QLFVs7+YmYGOmb4ShgTcRCfB8SKk=;
        b=rzXYCCMt7lIoTbm1AX0NaK4JcpYl3mpYPtPPWccGVcYlicf90HqGe490fUvOVbLaq9
         12W0/fh3QMZkRC77RVtEgkJeKfLWcQ5YxEg9HY9nrswO0onKA//7P1lgQwosWV2utIHO
         Xbijz+GGPfiAOV5rU95L/2S/PNnrGTYvKt8oE8m1V+VadGx3M99K26DAn0rtzFNQb6HV
         S7UzQ7r2hcEVdE8mdIGcS2ZQnc5ixnSi3g+R9Pg7Jf6oVqOLlqNM5nr3Nb2JeFL0Qpaq
         Jwh2IrMY6IH3aQo+FmuayEYLKT6MpJvyJKM6/U3ZvMadrbLjhsLefq26XwYQYoDopQ0S
         RiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DfXOdul3BLGU90QLFVs7+YmYGOmb4ShgTcRCfB8SKk=;
        b=X6Jl7s2OJVnY7EYgwPva4pR7bj2XlW5+ans7rzTm6VKucfTooG2UTjAH96L4lVzZW0
         zCZYZKEEdfaYYLcPp5jQ6GXEilmiwgvtRVfTabB1pdXNk6OWX3PjDcNfJfN0Uc5hXo7i
         Widiyzu24GTFWtpfTmcf1FpvOUzparXjWfhlRQXAWJdYuyT2nYtei/N5oL4wP4jNCg+S
         KfQUpqAINvfvn4EqlUdUeIKC34wHLgmROHK9EFhhm6P0F0d9nuKY9Hnl1NUYYi3IVSx6
         tqKfW3VecBVZUW5O/KNC4CKnq7G7uGhbQqr7n56DdEwmwDGcrCdbryqilHIt67vjl6Vw
         x+9Q==
X-Gm-Message-State: AOAM530gEFo4cMIIVwF7itFwrDXsQborh7CEnseCS8B9d8oyGGFyKm7R
        VSy9fxHTNWa2B+lp1GZ0DTg=
X-Google-Smtp-Source: ABdhPJzymehCQkc1AiOy4wnRhxKaB0Uby6rJCyGv65YnWd4ayACsGKdDOPYrtfb5ztEQ5gLeaTxgVA==
X-Received: by 2002:a63:cc05:: with SMTP id x5mr10497845pgf.254.1612052183332;
        Sat, 30 Jan 2021 16:16:23 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:22 -0800 (PST)
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
Subject: [RFC 14/20] mm: move inc/dec_tlb_flush_pending() to mmu_gather.c
Date:   Sat, 30 Jan 2021 16:11:26 -0800
Message-Id: <20210131001132.3368247-15-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Reduce the chances that inc/dec_tlb_flush_pending() will be abused by
moving them into mmu_gather.c, which is more of their natural place.
This also allows to reduce the clutter on mm_types.h.

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
 include/linux/mm_types.h | 54 ----------------------------------------
 mm/mmu_gather.c          | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 812ee0fd4c35..676795dfd5d4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -615,60 +615,6 @@ static inline void init_tlb_flush_pending(struct mm_struct *mm)
 	atomic_set(&mm->tlb_flush_pending, 0);
 }
 
-static inline void inc_tlb_flush_pending(struct mm_struct *mm)
-{
-	atomic_inc(&mm->tlb_flush_pending);
-	/*
-	 * The only time this value is relevant is when there are indeed pages
-	 * to flush. And we'll only flush pages after changing them, which
-	 * requires the PTL.
-	 *
-	 * So the ordering here is:
-	 *
-	 *	atomic_inc(&mm->tlb_flush_pending);
-	 *	spin_lock(&ptl);
-	 *	...
-	 *	set_pte_at();
-	 *	spin_unlock(&ptl);
-	 *
-	 *				spin_lock(&ptl)
-	 *				mm_tlb_flush_pending();
-	 *				....
-	 *				spin_unlock(&ptl);
-	 *
-	 *	flush_tlb_range();
-	 *	atomic_dec(&mm->tlb_flush_pending);
-	 *
-	 * Where the increment if constrained by the PTL unlock, it thus
-	 * ensures that the increment is visible if the PTE modification is
-	 * visible. After all, if there is no PTE modification, nobody cares
-	 * about TLB flushes either.
-	 *
-	 * This very much relies on users (mm_tlb_flush_pending() and
-	 * mm_tlb_flush_nested()) only caring about _specific_ PTEs (and
-	 * therefore specific PTLs), because with SPLIT_PTE_PTLOCKS and RCpc
-	 * locks (PPC) the unlock of one doesn't order against the lock of
-	 * another PTL.
-	 *
-	 * The decrement is ordered by the flush_tlb_range(), such that
-	 * mm_tlb_flush_pending() will not return false unless all flushes have
-	 * completed.
-	 */
-}
-
-static inline void dec_tlb_flush_pending(struct mm_struct *mm)
-{
-	/*
-	 * See inc_tlb_flush_pending().
-	 *
-	 * This cannot be smp_mb__before_atomic() because smp_mb() simply does
-	 * not order against TLB invalidate completion, which is what we need.
-	 *
-	 * Therefore we must rely on tlb_flush_*() to guarantee order.
-	 */
-	atomic_dec(&mm->tlb_flush_pending);
-}
-
 static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
 {
 	/*
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 5a659d4e59eb..13338c096cc6 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -249,6 +249,60 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
 	tlb_flush_mmu_free(tlb);
 }
 
+static inline void inc_tlb_flush_pending(struct mm_struct *mm)
+{
+	atomic_inc(&mm->tlb_flush_pending);
+	/*
+	 * The only time this value is relevant is when there are indeed pages
+	 * to flush. And we'll only flush pages after changing them, which
+	 * requires the PTL.
+	 *
+	 * So the ordering here is:
+	 *
+	 *	atomic_inc(&mm->tlb_flush_pending);
+	 *	spin_lock(&ptl);
+	 *	...
+	 *	set_pte_at();
+	 *	spin_unlock(&ptl);
+	 *
+	 *				spin_lock(&ptl)
+	 *				mm_tlb_flush_pending();
+	 *				....
+	 *				spin_unlock(&ptl);
+	 *
+	 *	flush_tlb_range();
+	 *	atomic_dec(&mm->tlb_flush_pending);
+	 *
+	 * Where the increment if constrained by the PTL unlock, it thus
+	 * ensures that the increment is visible if the PTE modification is
+	 * visible. After all, if there is no PTE modification, nobody cares
+	 * about TLB flushes either.
+	 *
+	 * This very much relies on users (mm_tlb_flush_pending() and
+	 * mm_tlb_flush_nested()) only caring about _specific_ PTEs (and
+	 * therefore specific PTLs), because with SPLIT_PTE_PTLOCKS and RCpc
+	 * locks (PPC) the unlock of one doesn't order against the lock of
+	 * another PTL.
+	 *
+	 * The decrement is ordered by the flush_tlb_range(), such that
+	 * mm_tlb_flush_pending() will not return false unless all flushes have
+	 * completed.
+	 */
+}
+
+static inline void dec_tlb_flush_pending(struct mm_struct *mm)
+{
+	/*
+	 * See inc_tlb_flush_pending().
+	 *
+	 * This cannot be smp_mb__before_atomic() because smp_mb() simply does
+	 * not order against TLB invalidate completion, which is what we need.
+	 *
+	 * Therefore we must rely on tlb_flush_*() to guarantee order.
+	 */
+	atomic_dec(&mm->tlb_flush_pending);
+}
+
 /**
  * tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
  * @tlb: the mmu_gather structure to initialize
-- 
2.25.1


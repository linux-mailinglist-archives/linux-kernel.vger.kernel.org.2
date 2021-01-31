Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B93309960
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhAaAUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhAaARD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:17:03 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB9EC061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:28 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id o20so9091227pfu.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kt89wMExxB9mDZA9vWtyDT+tDBx3/YIxqezv1vec+68=;
        b=Z5HJbKiNov3/1MqP6XXO23ukd068I8ix9I99unM52IccOHfT9Hj9BoH9R8X1vm2fgE
         JDk7hr2hNN3oxblJMNiZ7K2IeCvHh3mrtboU70WDcxA03xXVGv8TUwLYbq5mMCt73Zoq
         UytzF2crzPOyu4jT7ytbq3xuthDJcdJN8rX5OGFqu7jjNON5BLB/sM+j8twhIoxIcXIZ
         JHGjQvRX4asWSyEQVvYHDQG7hQpLHmn+TanLbrdt7oQzw5S2SZKtooN6t/r1jQV7bKQ0
         OljxSOcmcQy6UXIx0Ig5hMgRaFKhhkVwWb9Me2tokcWFccRzJJDsJjNUnLC1cCclYDAs
         pEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kt89wMExxB9mDZA9vWtyDT+tDBx3/YIxqezv1vec+68=;
        b=Qo+5sOjSSpbhXSBQAQaMerh5U3rZCKFq4vZQHkAvlmo2U0iGzVXWbH39NNRVqXxF+1
         914CG+7jktuGCtAP5m095CbMdl62njVaznFOFzKENFLEH/0K3IIYTnjbhQqPOi8Np2iB
         ZRdcWN0m/oQUl6P1Usr5QeaycOQn0FPin16gEUeK8CGnn5s24PIKLs5tvPPHgUE7PT2J
         17W7vw2lvFcxHfKNyrG3A4/W7FXiolKFmyJWasFT2zvHwaflB36uCD3Pq0m3h2fQU0/g
         By0jI9mSHOVTJu4VoCRvNii07b4EUkE/xL1z8RAMTYHtVpBxjtCE116Y8T47dPRZn52z
         au6A==
X-Gm-Message-State: AOAM5317C3bMi7v7brRjQGfC/DUxI0Qr4nx4y+LU5YkbqdEaHZdO/Cvu
        MWQXcm/Ajxyer5bEhGS/hX8zByuu9mk=
X-Google-Smtp-Source: ABdhPJz+SyTFVAhW+P9pLT3RRUrcjfybFvt58ygJGhoPJwFKwTcLrwg+PMGlshJUUkIYq9kJ0kl6Sw==
X-Received: by 2002:a65:68ce:: with SMTP id k14mr9338963pgt.401.1612052188222;
        Sat, 30 Jan 2021 16:16:28 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:27 -0800 (PST)
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
        x86@kernel.org
Subject: [RFC 17/20] mm/tlb: updated completed deferred TLB flush conditionally
Date:   Sat, 30 Jan 2021 16:11:29 -0800
Message-Id: <20210131001132.3368247-18-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

If all the deferred TLB flushes were completed, there is no need to
update the completed TLB flush. This update requires an atomic cmpxchg,
so we would like to skip it.

To do so, save for each mm the last TLB generation in which TLB flushes
were deferred. While saving this information requires another atomic
cmpxchg, assume that deferred TLB flushes are less frequent than TLB
flushes.

Signed-off-by: Nadav Amit <namit@vmware.com>
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
 include/asm-generic/tlb.h | 23 ++++++++++++++++++-----
 include/linux/mm_types.h  |  5 +++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 74dbb56d816d..a41af03fbede 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -536,6 +536,14 @@ static inline void tlb_update_generation(atomic64_t *gen, u64 new_gen)
 
 static inline void mark_mm_tlb_gen_done(struct mm_struct *mm, u64 gen)
 {
+	/*
+	 * If we all the deferred TLB generations were completed, we can skip
+	 * the update of tlb_gen_completed and save a few cycles on cmpxchg.
+	 */
+	if (atomic64_read(&mm->tlb_gen_deferred) ==
+	    atomic64_read(&mm->tlb_gen_completed))
+		return;
+
 	/*
 	 * Update the completed generation to the new generation if the new
 	 * generation is greater than the previous one.
@@ -546,7 +554,7 @@ static inline void mark_mm_tlb_gen_done(struct mm_struct *mm, u64 gen)
 static inline void read_defer_tlb_flush_gen(struct mmu_gather *tlb)
 {
 	struct mm_struct *mm = tlb->mm;
-	u64 mm_gen;
+	u64 mm_gen, new_gen;
 
 	/*
 	 * Any change of PTE before calling __track_deferred_tlb_flush() must be
@@ -567,11 +575,16 @@ static inline void read_defer_tlb_flush_gen(struct mmu_gather *tlb)
 	 * correctness issues, and should not induce overheads, since anyhow in
 	 * TLB storms it is better to perform full TLB flush.
 	 */
-	if (mm_gen != tlb->defer_gen) {
-		VM_BUG_ON(mm_gen < tlb->defer_gen);
+	if (mm_gen == tlb->defer_gen)
+		return;
 
-		tlb->defer_gen = inc_mm_tlb_gen(mm);
-	}
+	VM_BUG_ON(mm_gen < tlb->defer_gen);
+
+	new_gen = inc_mm_tlb_gen(mm);
+	tlb->defer_gen = new_gen;
+
+	/* Update mm->tlb_gen_deferred */
+	tlb_update_generation(&mm->tlb_gen_deferred, new_gen);
 }
 
 #ifndef CONFIG_PER_TABLE_DEFERRED_FLUSHES
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index cae9e8bbf8e6..4122a9b8b56f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -578,6 +578,11 @@ struct mm_struct {
 		 */
 		atomic64_t tlb_gen;
 
+		/*
+		 * The last TLB generation which was deferred.
+		 */
+		atomic64_t tlb_gen_deferred;
+
 		/*
 		 * TLB generation which is guarnateed to be flushed, including
 		 * all the PTE changes that were performed before tlb_gen was
-- 
2.25.1


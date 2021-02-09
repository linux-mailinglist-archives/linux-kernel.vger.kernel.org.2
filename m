Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BCC315BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhBJBCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbhBIWVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:21:46 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B74C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 14:21:18 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id lw17so1991302pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 14:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w3dquYqjy1xaDtn2H8fjB2EN1gbFMjXQuNyBoarAWH8=;
        b=fwz7Cf3yoxmE/T3oJGifXOHSMK8A38mNhJrzbnMmpNRWKOQAPanWcVVgqOzgsvo+hY
         f2sEN4Wvg0H0QksEUDa9DWcYSbEkI/JD//rn91XxJDyYw5T+YKvFc1G1asYnA0zKr0wk
         cQAj0v5A8PwzYs2Wiyw2XFHy6AWZu2Rt4ub+I1rco7GdxzPc5YVmgz2fThRsQHmYF/qv
         ak/lPkoUWw1m7/YHJpQFzemdtVIPXACLbZetfBZ+Q+thqz0Tkasd1dHKgIucQxUKhzqe
         kavEc2vDEB5RqUUmhx6oS40mKFmEUppgzY7pglBQ/TrJashx7vCpwOscwNu4YoyVbxsI
         7YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3dquYqjy1xaDtn2H8fjB2EN1gbFMjXQuNyBoarAWH8=;
        b=Xo/mS9rYvvCaS1IYwtNeb9zPLdajN3YM+dEHEMfW7y/vzWAwv3YWJGhM9iLVDXs1tm
         Lv/06a+yMuTPT4qydZhgzmjj01LzJ4UCA1gVuPPwk1u3cwdoyzxYelPjXa8pssnttYwt
         3jxgwWYtPcS1iWqIvPN/Ali7G82e8mc67U4v9iptdMYGQ8bRi7imFrd0XXanIwhqoqPu
         G8eiFVwgM0Tj113W70zGgQzgkkkKDH0elOBYB4Hna1Q5Uiwsu0XvsaxXipJpscarig1m
         PgSiS5yTN2/ssmewx6yeizYaXgi+MStQQA+J3DhEh3HsozugV6o05QpAKrNN7PtNWW2O
         tdaA==
X-Gm-Message-State: AOAM533FiqqQ1SGg3o/8NvRV6N8MSdp2WiZ/iJKIxztaAIptKvPxT6Rr
        t95XLCz1MiPMyVqm0Yd8B9w=
X-Google-Smtp-Source: ABdhPJzXBlOtcrQrDFBTfzYf49Jml4bcUyqPoKmkHGococWyh0d7qPPNofCeEq+TOAhDUn9FkiFzuQ==
X-Received: by 2002:a17:903:2292:b029:de:45c0:7005 with SMTP id b18-20020a1709032292b02900de45c07005mr149186plh.75.1612909278027;
        Tue, 09 Feb 2021 14:21:18 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id v9sm58601pju.33.2021.02.09.14.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:21:17 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v5 2/8] x86/mm/tlb: Unify flush_tlb_func_local() and flush_tlb_func_remote()
Date:   Tue,  9 Feb 2021 14:16:47 -0800
Message-Id: <20210209221653.614098-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209221653.614098-1-namit@vmware.com>
References: <20210209221653.614098-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

The unification of these two functions allows to use them in the updated
SMP infrastrucutre.

To do so, remove the reason argument from flush_tlb_func_local(), add
a member to struct tlb_flush_info that says which CPU initiated the
flush and act accordingly. Optimize the size of flush_tlb_info while we
are at it.

Unfortunately, this prevents us from using a constant tlb_flush_info for
arch_tlbbatch_flush(), but in a later stage we may be able to inline
tlb_flush_info into the IPI data, so it should not have an impact
eventually.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/tlbflush.h |  5 +-
 arch/x86/mm/tlb.c               | 81 +++++++++++++++------------------
 2 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 8c87a2e0b660..a7a598af116d 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -201,8 +201,9 @@ struct flush_tlb_info {
 	unsigned long		start;
 	unsigned long		end;
 	u64			new_tlb_gen;
-	unsigned int		stride_shift;
-	bool			freed_tables;
+	unsigned int		initiating_cpu;
+	u8			stride_shift;
+	u8			freed_tables;
 };
 
 void flush_tlb_local(void);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 569ac1d57f55..bf12371db6c4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -439,7 +439,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * NB: leave_mm() calls us with prev == NULL and tsk == NULL.
 	 */
 
-	/* We don't want flush_tlb_func_* to run concurrently with us. */
+	/* We don't want flush_tlb_func() to run concurrently with us. */
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(!irqs_disabled());
 
@@ -647,14 +647,13 @@ void initialize_tlbstate_and_flush(void)
 }
 
 /*
- * flush_tlb_func_common()'s memory ordering requirement is that any
+ * flush_tlb_func()'s memory ordering requirement is that any
  * TLB fills that happen after we flush the TLB are ordered after we
  * read active_mm's tlb_gen.  We don't need any explicit barriers
  * because all x86 flush operations are serializing and the
  * atomic64_read operation won't be reordered by the compiler.
  */
-static void flush_tlb_func_common(const struct flush_tlb_info *f,
-				  bool local, enum tlb_flush_reason reason)
+static void flush_tlb_func(void *info)
 {
 	/*
 	 * We have three different tlb_gen values in here.  They are:
@@ -665,14 +664,26 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	 * - f->new_tlb_gen: the generation that the requester of the flush
 	 *                   wants us to catch up to.
 	 */
+	const struct flush_tlb_info *f = info;
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
 	u64 mm_tlb_gen = atomic64_read(&loaded_mm->context.tlb_gen);
 	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+	bool local = smp_processor_id() == f->initiating_cpu;
+	unsigned long nr_invalidate = 0;
 
 	/* This code cannot presently handle being reentered. */
 	VM_WARN_ON(!irqs_disabled());
 
+	if (!local) {
+		inc_irq_stat(irq_tlb_count);
+		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
+
+		/* Can only happen on remote CPUs */
+		if (f->mm && f->mm != loaded_mm)
+			return;
+	}
+
 	if (unlikely(loaded_mm == &init_mm))
 		return;
 
@@ -700,8 +711,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		 * be handled can catch us all the way up, leaving no work for
 		 * the second flush.
 		 */
-		trace_tlb_flush(reason, 0);
-		return;
+		goto done;
 	}
 
 	WARN_ON_ONCE(local_tlb_gen > mm_tlb_gen);
@@ -748,46 +758,34 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	    f->new_tlb_gen == local_tlb_gen + 1 &&
 	    f->new_tlb_gen == mm_tlb_gen) {
 		/* Partial flush */
-		unsigned long nr_invalidate = (f->end - f->start) >> f->stride_shift;
 		unsigned long addr = f->start;
 
+		nr_invalidate = (f->end - f->start) >> f->stride_shift;
+
 		while (addr < f->end) {
 			flush_tlb_one_user(addr);
 			addr += 1UL << f->stride_shift;
 		}
 		if (local)
 			count_vm_tlb_events(NR_TLB_LOCAL_FLUSH_ONE, nr_invalidate);
-		trace_tlb_flush(reason, nr_invalidate);
 	} else {
 		/* Full flush. */
+		nr_invalidate = TLB_FLUSH_ALL;
+
 		flush_tlb_local();
 		if (local)
 			count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
-		trace_tlb_flush(reason, TLB_FLUSH_ALL);
 	}
 
 	/* Both paths above update our state to mm_tlb_gen. */
 	this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
-}
-
-static void flush_tlb_func_local(const void *info, enum tlb_flush_reason reason)
-{
-	const struct flush_tlb_info *f = info;
-
-	flush_tlb_func_common(f, true, reason);
-}
 
-static void flush_tlb_func_remote(void *info)
-{
-	const struct flush_tlb_info *f = info;
-
-	inc_irq_stat(irq_tlb_count);
-
-	if (f->mm && f->mm != this_cpu_read(cpu_tlbstate.loaded_mm))
-		return;
-
-	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
-	flush_tlb_func_common(f, false, TLB_REMOTE_SHOOTDOWN);
+	/* Tracing is done in a unified manner to reduce the code size */
+done:
+	trace_tlb_flush(!local ? TLB_REMOTE_SHOOTDOWN :
+				(f->mm == NULL) ? TLB_LOCAL_SHOOTDOWN :
+						  TLB_LOCAL_MM_SHOOTDOWN,
+			nr_invalidate);
 }
 
 static bool tlb_is_not_lazy(int cpu, void *data)
@@ -816,10 +814,10 @@ STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
 	 * doing a speculative memory access.
 	 */
 	if (info->freed_tables)
-		smp_call_function_many(cpumask, flush_tlb_func_remote,
+		smp_call_function_many(cpumask, flush_tlb_func,
 			       (void *)info, 1);
 	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func_remote,
+		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
 				(void *)info, 1, cpumask);
 }
 
@@ -869,6 +867,7 @@ static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	info->stride_shift	= stride_shift;
 	info->freed_tables	= freed_tables;
 	info->new_tlb_gen	= new_tlb_gen;
+	info->initiating_cpu	= smp_processor_id();
 
 	return info;
 }
@@ -908,7 +907,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
+		flush_tlb_func(info);
 		local_irq_enable();
 	}
 
@@ -1119,34 +1118,26 @@ void __flush_tlb_all(void)
 }
 EXPORT_SYMBOL_GPL(__flush_tlb_all);
 
-/*
- * arch_tlbbatch_flush() performs a full TLB flush regardless of the active mm.
- * This means that the 'struct flush_tlb_info' that describes which mappings to
- * flush is actually fixed. We therefore set a single fixed struct and use it in
- * arch_tlbbatch_flush().
- */
-static const struct flush_tlb_info full_flush_tlb_info = {
-	.mm = NULL,
-	.start = 0,
-	.end = TLB_FLUSH_ALL,
-};
-
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
+	struct flush_tlb_info *info;
+
 	int cpu = get_cpu();
 
+	info = get_flush_tlb_info(NULL, 0, TLB_FLUSH_ALL, 0, false, 0);
 	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-		flush_tlb_func_local(&full_flush_tlb_info, TLB_LOCAL_SHOOTDOWN);
+		flush_tlb_func(info);
 		local_irq_enable();
 	}
 
 	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids)
-		flush_tlb_others(&batch->cpumask, &full_flush_tlb_info);
+		flush_tlb_others(&batch->cpumask, info);
 
 	cpumask_clear(&batch->cpumask);
 
+	put_flush_tlb_info();
 	put_cpu();
 }
 
-- 
2.25.1


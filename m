Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510093207AC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 00:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBTX10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 18:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhBTXXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 18:23:17 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C806C061793
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:30 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g20so5432993plo.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Xb5PuV4x9v2uuJPPxMJnmB3xgwfadlB1BQfG3bVsU0=;
        b=NwTQFVGWRTz4CW8c7vqn6wzPmd5TbaV56h9/Z5FQ+ZxKFAhZK/tGR6I4P1aVbVRFnK
         PZ1MCt7hm4irpBYoUv4L36/rhxLGu0fS7im5RvgFyFyOujSt+zikht7ZN832DsExjtzp
         qEHRRtv1YyaN9QDOwFSO0Z5l9+3lGbFGdJ2uxQ3cuFyV8MMnw9UM7XMhiczddwPs5Twq
         4bV7RzDI2A8WmBCNkCY7yYIgY3TdAuJsv3F3iLJmR7Nwzqp7oBLBCJ1g0m5uXkrH2xFd
         AwQ4BrZ6qIIue9Hn6keKp59724oxnpNiZglHe0aLVqJVnV/PbVby3CreQzNXlelZciut
         Dckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Xb5PuV4x9v2uuJPPxMJnmB3xgwfadlB1BQfG3bVsU0=;
        b=peJawssRqT8FrUlSac9CBGr+HtcAMvR9ZyKaOwSNayJWHTI+/WUIuM6u3Yk1sTI3Gq
         N7Pjq7K8Zg3L5Rywdid2VgA+T7AMIz6PAic48IizMVi4mR7HMKWnlv8d9FGOaFy1uW8O
         e6XChHzSIm/GvqqodoAUlUXjI/sw9NwbiiEWmflHit8IJ4we5iHlK7GAuHI8p51BEQEt
         0IYJPA2ggyYUGVcaRDQQU+dX8V2ZNfLEOUV0t7fS3xUbv5ImrG7LMxbFzjnbSxHl2jP9
         H5M+3QTa4DPIsz8Jyu4oF4l3b1kqmi/Tm4TENqh6U40VPSUx/JLqI7AWhSqIN45KwQy3
         OPGw==
X-Gm-Message-State: AOAM533s3V6BbNmHn2H8qOISQChGcaMQfZpbpte+09GVOMJwkcDagq4m
        COY3gkQ5xmEj8dNyKTWATzJN4wrKOJNC9Q==
X-Google-Smtp-Source: ABdhPJxS3KDZwWhOPVBBnt9Eo4OkEHQO2Tf4b4AqTalnNnlYiHHqP7y+pwy91iv8WHWSHyx690Oa6Q==
X-Received: by 2002:a17:902:cecc:b029:e1:268e:2286 with SMTP id d12-20020a170902ceccb02900e1268e2286mr16039849plg.62.1613863349402;
        Sat, 20 Feb 2021 15:22:29 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 4sm13171538pjc.23.2021.02.20.15.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 15:22:28 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v6 5/9] x86/mm/tlb: Privatize cpu_tlbstate
Date:   Sat, 20 Feb 2021 15:17:08 -0800
Message-Id: <20210220231712.2475218-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220231712.2475218-1-namit@vmware.com>
References: <20210220231712.2475218-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

cpu_tlbstate is mostly private and only the variable is_lazy is shared.
This causes some false-sharing when TLB flushes are performed.

Break cpu_tlbstate intro cpu_tlbstate and cpu_tlbstate_shared, and mark
each one accordingly.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>

---
v5 -> v6:
* Fixed warning due to mismatch in
  {DEFINE|DECLARE}_PER_CPU_{SHARED_}ALIGNED
---
 arch/x86/include/asm/tlbflush.h | 39 ++++++++++++++++++---------------
 arch/x86/kernel/alternative.c   |  2 +-
 arch/x86/mm/init.c              |  2 +-
 arch/x86/mm/tlb.c               | 17 ++++++++------
 4 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 3c6681def912..fa952eadbc2e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -89,23 +89,6 @@ struct tlb_state {
 	u16 loaded_mm_asid;
 	u16 next_asid;
 
-	/*
-	 * We can be in one of several states:
-	 *
-	 *  - Actively using an mm.  Our CPU's bit will be set in
-	 *    mm_cpumask(loaded_mm) and is_lazy == false;
-	 *
-	 *  - Not using a real mm.  loaded_mm == &init_mm.  Our CPU's bit
-	 *    will not be set in mm_cpumask(&init_mm) and is_lazy == false.
-	 *
-	 *  - Lazily using a real mm.  loaded_mm != &init_mm, our bit
-	 *    is set in mm_cpumask(loaded_mm), but is_lazy == true.
-	 *    We're heuristically guessing that the CR3 load we
-	 *    skipped more than makes up for the overhead added by
-	 *    lazy mode.
-	 */
-	bool is_lazy;
-
 	/*
 	 * If set we changed the page tables in such a way that we
 	 * needed an invalidation of all contexts (aka. PCIDs / ASIDs).
@@ -151,7 +134,27 @@ struct tlb_state {
 	 */
 	struct tlb_context ctxs[TLB_NR_DYN_ASIDS];
 };
-DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate);
+DECLARE_PER_CPU_ALIGNED(struct tlb_state, cpu_tlbstate);
+
+struct tlb_state_shared {
+	/*
+	 * We can be in one of several states:
+	 *
+	 *  - Actively using an mm.  Our CPU's bit will be set in
+	 *    mm_cpumask(loaded_mm) and is_lazy == false;
+	 *
+	 *  - Not using a real mm.  loaded_mm == &init_mm.  Our CPU's bit
+	 *    will not be set in mm_cpumask(&init_mm) and is_lazy == false.
+	 *
+	 *  - Lazily using a real mm.  loaded_mm != &init_mm, our bit
+	 *    is set in mm_cpumask(loaded_mm), but is_lazy == true.
+	 *    We're heuristically guessing that the CR3 load we
+	 *    skipped more than makes up for the overhead added by
+	 *    lazy mode.
+	 */
+	bool is_lazy;
+};
+DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
 
 bool nmi_uaccess_okay(void);
 #define nmi_uaccess_okay nmi_uaccess_okay
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8d778e46725d..94649f86d653 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -813,7 +813,7 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	 * with a stale address space WITHOUT being in lazy mode after
 	 * restoring the previous mm.
 	 */
-	if (this_cpu_read(cpu_tlbstate.is_lazy))
+	if (this_cpu_read(cpu_tlbstate_shared.is_lazy))
 		leave_mm(smp_processor_id());
 
 	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index dd694fb93916..ed2e36748758 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1017,7 +1017,7 @@ void __init zone_sizes_init(void)
 	free_area_init(max_zone_pfns);
 }
 
-__visible DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate) = {
+__visible DEFINE_PER_CPU_ALIGNED(struct tlb_state, cpu_tlbstate) = {
 	.loaded_mm = &init_mm,
 	.next_asid = 1,
 	.cr4 = ~0UL,	/* fail hard if we screw up cr4 shadow initialization */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 8db87cd92e6b..345a0aff5de4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -300,7 +300,7 @@ void leave_mm(int cpu)
 		return;
 
 	/* Warn if we're not lazy. */
-	WARN_ON(!this_cpu_read(cpu_tlbstate.is_lazy));
+	WARN_ON(!this_cpu_read(cpu_tlbstate_shared.is_lazy));
 
 	switch_mm(NULL, &init_mm, NULL);
 }
@@ -424,7 +424,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	bool was_lazy = this_cpu_read(cpu_tlbstate.is_lazy);
+	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
 	bool need_flush;
@@ -469,7 +469,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		__flush_tlb_all();
 	}
 #endif
-	this_cpu_write(cpu_tlbstate.is_lazy, false);
+	this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
 
 	/*
 	 * The membarrier system call requires a full memory barrier and
@@ -490,7 +490,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		/*
 		 * Even in lazy TLB mode, the CPU should stay set in the
 		 * mm_cpumask. The TLB shootdown code can figure out from
-		 * cpu_tlbstate.is_lazy whether or not to send an IPI.
+		 * cpu_tlbstate_shared.is_lazy whether or not to send an IPI.
 		 */
 		if (WARN_ON_ONCE(real_prev != &init_mm &&
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
@@ -598,7 +598,7 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
 		return;
 
-	this_cpu_write(cpu_tlbstate.is_lazy, true);
+	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
 }
 
 /*
@@ -690,7 +690,7 @@ static void flush_tlb_func(void *info)
 	VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].ctx_id) !=
 		   loaded_mm->context.ctx_id);
 
-	if (this_cpu_read(cpu_tlbstate.is_lazy)) {
+	if (this_cpu_read(cpu_tlbstate_shared.is_lazy)) {
 		/*
 		 * We're in lazy mode.  We need to at least flush our
 		 * paging-structure cache to avoid speculatively reading
@@ -790,11 +790,14 @@ static void flush_tlb_func(void *info)
 
 static bool tlb_is_not_lazy(int cpu)
 {
-	return !per_cpu(cpu_tlbstate.is_lazy, cpu);
+	return !per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
 }
 
 static DEFINE_PER_CPU(cpumask_t, flush_tlb_mask);
 
+DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
+EXPORT_PER_CPU_SYMBOL(cpu_tlbstate_shared);
+
 STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 					 const struct flush_tlb_info *info)
 {
-- 
2.25.1


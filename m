Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA4C35F250
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349029AbhDNLZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:25:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16457 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348996AbhDNLZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:25:11 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FL0SS0dntztW9W;
        Wed, 14 Apr 2021 19:22:32 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.32) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 19:24:39 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <julien@xen.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 04/16] arm64/mm: Move the variable lock and tlb_flush_pending to asid_info
Date:   Wed, 14 Apr 2021 12:23:00 +0100
Message-ID: <20210414112312.13704-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210414112312.13704-1-shameerali.kolothum.thodi@huawei.com>
References: <20210414112312.13704-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.82.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Grall <julien.grall@arm.com>

The variables lock and tlb_flush_pending holds information for a given
ASID allocator. So move them to the asid_info structure.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/mm/context.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 1fd40a42955c..139ebc161acb 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -17,8 +17,6 @@
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 
-static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
-
 static struct asid_info
 {
 	atomic64_t	generation;
@@ -27,6 +25,9 @@ static struct asid_info
 	atomic64_t __percpu	*active;
 	u64 __percpu		*reserved;
 	u32			bits;
+	raw_spinlock_t		lock;
+	/* Which CPU requires context flush on next call */
+	cpumask_t		flush_pending;
 } asid_info;
 
 #define active_asid(info, cpu)	 (*per_cpu_ptr((info)->active, cpu))
@@ -34,7 +35,6 @@ static struct asid_info
 
 static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
-static cpumask_t tlb_flush_pending;
 
 static unsigned long max_pinned_asids;
 static unsigned long nr_pinned_asids;
@@ -137,7 +137,7 @@ static void flush_context(struct asid_info *info)
 	 * Queue a TLB invalidation for each CPU to perform on next
 	 * context-switch
 	 */
-	cpumask_setall(&tlb_flush_pending);
+	cpumask_setall(&info->flush_pending);
 }
 
 static bool check_update_reserved_asid(struct asid_info *info, u64 asid,
@@ -253,7 +253,7 @@ void check_and_switch_context(struct mm_struct *mm)
 				     old_active_asid, asid))
 		goto switch_mm_fastpath;
 
-	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+	raw_spin_lock_irqsave(&info->lock, flags);
 	/* Check that our ASID belongs to the current generation. */
 	asid = atomic64_read(&mm->context.id);
 	if (!asid_gen_match(asid, info)) {
@@ -262,11 +262,11 @@ void check_and_switch_context(struct mm_struct *mm)
 	}
 
 	cpu = smp_processor_id();
-	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
+	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
 		local_flush_tlb_all();
 
 	atomic64_set(&active_asid(info, cpu), asid);
-	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+	raw_spin_unlock_irqrestore(&info->lock, flags);
 
 switch_mm_fastpath:
 
@@ -289,7 +289,7 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
 	if (!pinned_asid_map)
 		return 0;
 
-	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+	raw_spin_lock_irqsave(&info->lock, flags);
 
 	asid = atomic64_read(&mm->context.id);
 
@@ -315,7 +315,7 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
 	refcount_set(&mm->context.pinned, 1);
 
 out_unlock:
-	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+	raw_spin_unlock_irqrestore(&info->lock, flags);
 
 	asid &= ~ASID_MASK(info);
 
@@ -336,14 +336,14 @@ void arm64_mm_context_put(struct mm_struct *mm)
 	if (!pinned_asid_map)
 		return;
 
-	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+	raw_spin_lock_irqsave(&info->lock, flags);
 
 	if (refcount_dec_and_test(&mm->context.pinned)) {
 		__clear_bit(asid2idx(info, asid), pinned_asid_map);
 		nr_pinned_asids--;
 	}
 
-	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+	raw_spin_unlock_irqrestore(&info->lock, flags);
 }
 EXPORT_SYMBOL_GPL(arm64_mm_context_put);
 
@@ -426,6 +426,7 @@ static int asids_init(void)
 	info->map_idx = 1;
 	info->active = &active_asids;
 	info->reserved = &reserved_asids;
+	raw_spin_lock_init(&info->lock);
 
 	pinned_asid_map = kcalloc(BITS_TO_LONGS(NUM_USER_ASIDS(info)),
 				  sizeof(*pinned_asid_map), GFP_KERNEL);
-- 
2.17.1


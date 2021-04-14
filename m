Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA0B35F259
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhDNL0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:26:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16997 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350480AbhDNLZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:25:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FL0S74W29zNtWp;
        Wed, 14 Apr 2021 19:22:15 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.32) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 19:25:00 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <julien@xen.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 09/16] arm64/mm: Split the function check_and_switch_context in 3 parts
Date:   Wed, 14 Apr 2021 12:23:05 +0100
Message-ID: <20210414112312.13704-10-shameerali.kolothum.thodi@huawei.com>
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

The function check_and_switch_context is used to:
    1) Check whether the ASID is still valid
    2) Generate a new one if it is not valid
    3) Switch the context

While the latter is specific to the MM subsystem, the rest could be part
of the generic ASID allocator.

After this patch, the function is now split in 3 parts which corresponds
to the use of the functions:
    1) asid_check_context: Check if the ASID is still valid
    2) asid_new_context: Generate a new ASID for the context
    3) check_and_switch_context: Call 1) and 2) and switch the context

1) and 2) have not been merged in a single function because we want to
avoid to add a branch in when the ASID is still valid. This will matter
when the code will be moved in separate file later on as 1) will reside
in the header as a static inline function.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
v3 comment:
    Will wants to avoid to add a branch when the ASID is still valid. So
    1) and 2) are in separates function. The former will move to a new
    header and make static inline.
---
 arch/arm64/mm/context.c | 70 ++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 041c3c5e0216..40ef013c90c3 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -222,17 +222,49 @@ static u64 new_context(struct asid_info *info, atomic64_t *pasid,
 	return idx2asid(info, asid) | generation;
 }
 
-void check_and_switch_context(struct mm_struct *mm)
+/*
+ * Generate a new ASID for the context.
+ *
+ * @pasid: Pointer to the current ASID batch allocated. It will be updated
+ * with the new ASID batch.
+ * @pinned: refcount if asid is pinned.
+ * Caller needs to make sure preempt is disabled before calling this function.
+ */
+static void asid_new_context(struct asid_info *info, atomic64_t *pasid,
+			     refcount_t *pinned)
 {
 	unsigned long flags;
-	unsigned int cpu;
-	u64 asid, old_active_asid;
-	struct asid_info *info = &asid_info;
+	u64 asid;
+	unsigned int cpu = smp_processor_id();
 
-	if (system_supports_cnp())
-		cpu_set_reserved_ttbr0();
+	raw_spin_lock_irqsave(&info->lock, flags);
+	/* Check that our ASID belongs to the current generation. */
+	asid = atomic64_read(pasid);
+	if (!asid_gen_match(asid, info)) {
+		asid = new_context(info, pasid, pinned);
+		atomic64_set(pasid, asid);
+	}
 
-	asid = atomic64_read(&mm->context.id);
+	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
+		local_flush_tlb_all();
+
+	atomic64_set(&active_asid(info, cpu), asid);
+	raw_spin_unlock_irqrestore(&info->lock, flags);
+}
+
+/*
+ * Check the ASID is still valid for the context. If not generate a new ASID.
+ *
+ * @pasid: Pointer to the current ASID batch
+ * @pinned: refcount if asid is pinned
+ * Caller needs to make sure preempt is disabled before calling this function.
+ */
+static void asid_check_context(struct asid_info *info, atomic64_t *pasid,
+			       refcount_t *pinned)
+{
+	u64 asid, old_active_asid;
+
+	asid = atomic64_read(pasid);
 
 	/*
 	 * The memory ordering here is subtle.
@@ -252,24 +284,18 @@ void check_and_switch_context(struct mm_struct *mm)
 	if (old_active_asid && asid_gen_match(asid, info) &&
 	    atomic64_cmpxchg_relaxed(this_cpu_ptr(info->active),
 				     old_active_asid, asid))
-		goto switch_mm_fastpath;
-
-	raw_spin_lock_irqsave(&info->lock, flags);
-	/* Check that our ASID belongs to the current generation. */
-	asid = atomic64_read(&mm->context.id);
-	if (!asid_gen_match(asid, info)) {
-		asid = new_context(info, &mm->context.id, &mm->context.pinned);
-		atomic64_set(&mm->context.id, asid);
-	}
+		return;
 
-	cpu = smp_processor_id();
-	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
-		local_flush_tlb_all();
+	asid_new_context(info, pasid, pinned);
+}
 
-	atomic64_set(&active_asid(info, cpu), asid);
-	raw_spin_unlock_irqrestore(&info->lock, flags);
+void check_and_switch_context(struct mm_struct *mm)
+{
+	if (system_supports_cnp())
+		cpu_set_reserved_ttbr0();
 
-switch_mm_fastpath:
+	asid_check_context(&asid_info, &mm->context.id,
+			   &mm->context.pinned);
 
 	arm64_apply_bp_hardening();
 
-- 
2.17.1


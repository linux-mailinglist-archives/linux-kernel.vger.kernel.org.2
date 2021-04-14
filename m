Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72B935F25A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350509AbhDNL0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:26:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16912 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349023AbhDNLZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:25:37 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FL0TQ3NHCzkjcG;
        Wed, 14 Apr 2021 19:23:22 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.32) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 19:25:04 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <julien@xen.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 10/16] arm64/mm: Split the arm64_mm_context_get/put
Date:   Wed, 14 Apr 2021 12:23:06 +0100
Message-ID: <20210414112312.13704-11-shameerali.kolothum.thodi@huawei.com>
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

Keep only the mm specific part in arm64_mm_context_get/put
and move the rest to generic functions.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/mm/context.c | 53 +++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 40ef013c90c3..901472a57b5d 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -307,20 +307,21 @@ void check_and_switch_context(struct mm_struct *mm)
 		cpu_switch_mm(mm->pgd, mm);
 }
 
-unsigned long arm64_mm_context_get(struct mm_struct *mm)
+static unsigned long asid_context_pinned_get(struct asid_info *info,
+					     atomic64_t *pasid,
+					     refcount_t *pinned)
 {
 	unsigned long flags;
 	u64 asid;
-	struct asid_info *info = &asid_info;
 
 	if (!info->pinned_map)
 		return 0;
 
 	raw_spin_lock_irqsave(&info->lock, flags);
 
-	asid = atomic64_read(&mm->context.id);
+	asid = atomic64_read(pasid);
 
-	if (refcount_inc_not_zero(&mm->context.pinned))
+	if (refcount_inc_not_zero(pinned))
 		goto out_unlock;
 
 	if (info->nr_pinned_asids >= info->max_pinned_asids) {
@@ -333,45 +334,61 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
 		 * We went through one or more rollover since that ASID was
 		 * used. Ensure that it is still valid, or generate a new one.
 		 */
-		asid = new_context(info, &mm->context.id, &mm->context.pinned);
-		atomic64_set(&mm->context.id, asid);
+		asid = new_context(info, pasid, pinned);
+		atomic64_set(pasid, asid);
 	}
 
 	info->nr_pinned_asids++;
 	__set_bit(asid2idx(info, asid), info->pinned_map);
-	refcount_set(&mm->context.pinned, 1);
+	refcount_set(pinned, 1);
 
 out_unlock:
 	raw_spin_unlock_irqrestore(&info->lock, flags);
-
 	asid &= ~ASID_MASK(info);
-
-	/* Set the equivalent of USER_ASID_BIT */
-	if (asid && arm64_kernel_unmapped_at_el0())
-		asid |= 1;
-
 	return asid;
 }
-EXPORT_SYMBOL_GPL(arm64_mm_context_get);
 
-void arm64_mm_context_put(struct mm_struct *mm)
+static void asid_context_pinned_put(struct asid_info *info, atomic64_t *pasid,
+				    refcount_t *pinned)
 {
 	unsigned long flags;
-	struct asid_info *info = &asid_info;
-	u64 asid = atomic64_read(&mm->context.id);
+	u64 asid = atomic64_read(pasid);
 
 	if (!info->pinned_map)
 		return;
 
 	raw_spin_lock_irqsave(&info->lock, flags);
 
-	if (refcount_dec_and_test(&mm->context.pinned)) {
+	if (refcount_dec_and_test(pinned)) {
 		__clear_bit(asid2idx(info, asid), info->pinned_map);
 		info->nr_pinned_asids--;
 	}
 
 	raw_spin_unlock_irqrestore(&info->lock, flags);
 }
+
+unsigned long arm64_mm_context_get(struct mm_struct *mm)
+{
+	u64 asid;
+	struct asid_info *info = &asid_info;
+
+	asid = asid_context_pinned_get(info, &mm->context.id,
+				       &mm->context.pinned);
+
+	/* Set the equivalent of USER_ASID_BIT */
+	if (asid && arm64_kernel_unmapped_at_el0())
+		asid |= 1;
+
+	return asid;
+}
+EXPORT_SYMBOL_GPL(arm64_mm_context_get);
+
+void arm64_mm_context_put(struct mm_struct *mm)
+{
+	struct asid_info *info = &asid_info;
+
+	asid_context_pinned_put(info, &mm->context.id, &mm->context.pinned);
+}
 EXPORT_SYMBOL_GPL(arm64_mm_context_put);
 
 /* Errata workaround post TTBRx_EL1 update. */
-- 
2.17.1


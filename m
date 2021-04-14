Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2735F24D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhDNLZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:25:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17333 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349016AbhDNLYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:24:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FL0Ry0MWVzB0mp;
        Wed, 14 Apr 2021 19:22:06 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.32) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 19:24:13 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <julien@xen.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 01/16] arm64/mm: Introduce asid_info structure and move asid_generation/asid_map to it
Date:   Wed, 14 Apr 2021 12:22:57 +0100
Message-ID: <20210414112312.13704-2-shameerali.kolothum.thodi@huawei.com>
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

In an attempt to make the ASID allocator generic, create a new structure
asid_info to store all the information necessary for the allocator.

For now, move the variables asid_generation, asid_map, cur_idx to the
new structure asid_info. Follow-up patches will move more variables.

Note to avoid more renaming aftwards, a local variable 'info' has been
created and is a pointer to the ASID allocator structure.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
v3-->v4:
  Move cur_idx into asid_info.
---
 arch/arm64/mm/context.c | 71 +++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 001737a8f309..783f8bdb91ee 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -20,8 +20,12 @@
 static u32 asid_bits;
 static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
 
-static atomic64_t asid_generation;
-static unsigned long *asid_map;
+static struct asid_info
+{
+	atomic64_t	generation;
+	unsigned long	*map;
+	unsigned int	map_idx;
+} asid_info;
 
 static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
@@ -88,26 +92,26 @@ static void set_kpti_asid_bits(unsigned long *map)
 	memset(map, 0xaa, len);
 }
 
-static void set_reserved_asid_bits(void)
+static void set_reserved_asid_bits(struct asid_info *info)
 {
 	if (pinned_asid_map)
-		bitmap_copy(asid_map, pinned_asid_map, NUM_USER_ASIDS);
+		bitmap_copy(info->map, pinned_asid_map, NUM_USER_ASIDS);
 	else if (arm64_kernel_unmapped_at_el0())
-		set_kpti_asid_bits(asid_map);
+		set_kpti_asid_bits(info->map);
 	else
-		bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
+		bitmap_clear(info->map, 0, NUM_USER_ASIDS);
 }
 
-#define asid_gen_match(asid) \
-	(!(((asid) ^ atomic64_read(&asid_generation)) >> asid_bits))
+#define asid_gen_match(asid, info) \
+	(!(((asid) ^ atomic64_read(&(info)->generation)) >> asid_bits))
 
-static void flush_context(void)
+static void flush_context(struct asid_info *info)
 {
 	int i;
 	u64 asid;
 
 	/* Update the list of reserved ASIDs and the ASID bitmap. */
-	set_reserved_asid_bits();
+	set_reserved_asid_bits(info);
 
 	for_each_possible_cpu(i) {
 		asid = atomic64_xchg_relaxed(&per_cpu(active_asids, i), 0);
@@ -120,7 +124,7 @@ static void flush_context(void)
 		 */
 		if (asid == 0)
 			asid = per_cpu(reserved_asids, i);
-		__set_bit(asid2idx(asid), asid_map);
+		__set_bit(asid2idx(asid), info->map);
 		per_cpu(reserved_asids, i) = asid;
 	}
 
@@ -155,11 +159,10 @@ static bool check_update_reserved_asid(u64 asid, u64 newasid)
 	return hit;
 }
 
-static u64 new_context(struct mm_struct *mm)
+static u64 new_context(struct asid_info *info, struct mm_struct *mm)
 {
-	static u32 cur_idx = 1;
 	u64 asid = atomic64_read(&mm->context.id);
-	u64 generation = atomic64_read(&asid_generation);
+	u64 generation = atomic64_read(&info->generation);
 
 	if (asid != 0) {
 		u64 newasid = generation | (asid & ~ASID_MASK);
@@ -183,7 +186,7 @@ static u64 new_context(struct mm_struct *mm)
 		 * We had a valid ASID in a previous life, so try to re-use
 		 * it if possible.
 		 */
-		if (!__test_and_set_bit(asid2idx(asid), asid_map))
+		if (!__test_and_set_bit(asid2idx(asid), info->map))
 			return newasid;
 	}
 
@@ -194,21 +197,21 @@ static u64 new_context(struct mm_struct *mm)
 	 * a reserved TTBR0 for the init_mm and we allocate ASIDs in even/odd
 	 * pairs.
 	 */
-	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, cur_idx);
+	asid = find_next_zero_bit(info->map, NUM_USER_ASIDS, info->map_idx);
 	if (asid != NUM_USER_ASIDS)
 		goto set_asid;
 
 	/* We're out of ASIDs, so increment the global generation count */
 	generation = atomic64_add_return_relaxed(ASID_FIRST_VERSION,
-						 &asid_generation);
-	flush_context();
+						 &info->generation);
+	flush_context(info);
 
 	/* We have more ASIDs than CPUs, so this will always succeed */
-	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
+	asid = find_next_zero_bit(info->map, NUM_USER_ASIDS, 1);
 
 set_asid:
-	__set_bit(asid, asid_map);
-	cur_idx = asid;
+	__set_bit(asid, info->map);
+	info->map_idx = asid;
 	return idx2asid(asid) | generation;
 }
 
@@ -217,6 +220,7 @@ void check_and_switch_context(struct mm_struct *mm)
 	unsigned long flags;
 	unsigned int cpu;
 	u64 asid, old_active_asid;
+	struct asid_info *info = &asid_info;
 
 	if (system_supports_cnp())
 		cpu_set_reserved_ttbr0();
@@ -238,7 +242,7 @@ void check_and_switch_context(struct mm_struct *mm)
 	 *   because atomic RmWs are totally ordered for a given location.
 	 */
 	old_active_asid = atomic64_read(this_cpu_ptr(&active_asids));
-	if (old_active_asid && asid_gen_match(asid) &&
+	if (old_active_asid && asid_gen_match(asid, info) &&
 	    atomic64_cmpxchg_relaxed(this_cpu_ptr(&active_asids),
 				     old_active_asid, asid))
 		goto switch_mm_fastpath;
@@ -246,8 +250,8 @@ void check_and_switch_context(struct mm_struct *mm)
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
 	/* Check that our ASID belongs to the current generation. */
 	asid = atomic64_read(&mm->context.id);
-	if (!asid_gen_match(asid)) {
-		asid = new_context(mm);
+	if (!asid_gen_match(asid, info)) {
+		asid = new_context(info, mm);
 		atomic64_set(&mm->context.id, asid);
 	}
 
@@ -274,6 +278,7 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
 {
 	unsigned long flags;
 	u64 asid;
+	struct asid_info *info = &asid_info;
 
 	if (!pinned_asid_map)
 		return 0;
@@ -290,12 +295,12 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
 		goto out_unlock;
 	}
 
-	if (!asid_gen_match(asid)) {
+	if (!asid_gen_match(asid, info)) {
 		/*
 		 * We went through one or more rollover since that ASID was
 		 * used. Ensure that it is still valid, or generate a new one.
 		 */
-		asid = new_context(mm);
+		asid = new_context(info, mm);
 		atomic64_set(&mm->context.id, asid);
 	}
 
@@ -400,14 +405,18 @@ arch_initcall(asids_update_limit);
 
 static int asids_init(void)
 {
+	struct asid_info *info = &asid_info;
+
 	asid_bits = get_cpu_asid_bits();
-	atomic64_set(&asid_generation, ASID_FIRST_VERSION);
-	asid_map = kcalloc(BITS_TO_LONGS(NUM_USER_ASIDS), sizeof(*asid_map),
-			   GFP_KERNEL);
-	if (!asid_map)
+	atomic64_set(&info->generation, ASID_FIRST_VERSION);
+	info->map = kcalloc(BITS_TO_LONGS(NUM_USER_ASIDS), sizeof(*info->map),
+			    GFP_KERNEL);
+	if (!info->map)
 		panic("Failed to allocate bitmap for %lu ASIDs\n",
 		      NUM_USER_ASIDS);
 
+	info->map_idx = 1;
+
 	pinned_asid_map = kcalloc(BITS_TO_LONGS(NUM_USER_ASIDS),
 				  sizeof(*pinned_asid_map), GFP_KERNEL);
 	nr_pinned_asids = 0;
@@ -418,7 +427,7 @@ static int asids_init(void)
 	 * and reserve kernel ASID's from beginning.
 	 */
 	if (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
-		set_kpti_asid_bits(asid_map);
+		set_kpti_asid_bits(info->map);
 	return 0;
 }
 early_initcall(asids_init);
-- 
2.17.1


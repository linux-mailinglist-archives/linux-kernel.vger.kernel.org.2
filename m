Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB0A35F255
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhDNL0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:26:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16459 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350205AbhDNLZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:25:21 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FL0Sf33jKztW1h;
        Wed, 14 Apr 2021 19:22:42 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.32) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 19:24:47 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <julien@xen.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 06/16] arm64/mm: Introduce NUM_CTXT_ASIDS
Date:   Wed, 14 Apr 2021 12:23:02 +0100
Message-ID: <20210414112312.13704-7-shameerali.kolothum.thodi@huawei.com>
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

At the moment ASID_FIRST_VERSION is used to know the number of ASIDs
supported. As we are going to move the ASID allocator to a separate file,
it would be better to use a different name for external users.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
v3-->v4
 -Dropped patch #6, but retained the name NUM_CTXT_ASIDS.

---
 arch/arm64/mm/context.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 628304e0d3b1..0f11d7c7f6a3 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -41,9 +41,9 @@ static unsigned long nr_pinned_asids;
 static unsigned long *pinned_asid_map;
 
 #define ASID_MASK(info)			(~GENMASK((info)->bits - 1, 0))
-#define ASID_FIRST_VERSION(info)	(1UL << (info)->bits)
+#define NUM_CTXT_ASIDS(info)		(1UL << ((info)->bits))
+#define ASID_FIRST_VERSION(info)        NUM_CTXT_ASIDS(info)
 
-#define NUM_USER_ASIDS(info)		ASID_FIRST_VERSION(info)
 #define asid2idx(info, asid)		((asid) & ~ASID_MASK(info))
 #define idx2asid(info, idx)		asid2idx(info, idx)
 
@@ -87,7 +87,7 @@ void verify_cpu_asid_bits(void)
 
 static void set_kpti_asid_bits(struct asid_info *info, unsigned long *map)
 {
-	unsigned int len = BITS_TO_LONGS(NUM_USER_ASIDS(info)) * sizeof(unsigned long);
+	unsigned int len = BITS_TO_LONGS(NUM_CTXT_ASIDS(info)) * sizeof(unsigned long);
 	/*
 	 * In case of KPTI kernel/user ASIDs are allocated in
 	 * pairs, the bottom bit distinguishes the two: if it
@@ -100,11 +100,11 @@ static void set_kpti_asid_bits(struct asid_info *info, unsigned long *map)
 static void set_reserved_asid_bits(struct asid_info *info)
 {
 	if (pinned_asid_map)
-		bitmap_copy(info->map, pinned_asid_map, NUM_USER_ASIDS(info));
+		bitmap_copy(info->map, pinned_asid_map, NUM_CTXT_ASIDS(info));
 	else if (arm64_kernel_unmapped_at_el0())
 		set_kpti_asid_bits(info, info->map);
 	else
-		bitmap_clear(info->map, 0, NUM_USER_ASIDS(info));
+		bitmap_clear(info->map, 0, NUM_CTXT_ASIDS(info));
 }
 
 #define asid_gen_match(asid, info) \
@@ -204,8 +204,8 @@ static u64 new_context(struct asid_info *info, atomic64_t *pasid,
 	 * a reserved TTBR0 for the init_mm and we allocate ASIDs in even/odd
 	 * pairs.
 	 */
-	asid = find_next_zero_bit(info->map, NUM_USER_ASIDS(info), info->map_idx);
-	if (asid != NUM_USER_ASIDS(info))
+	asid = find_next_zero_bit(info->map, NUM_CTXT_ASIDS(info), info->map_idx);
+	if (asid != NUM_CTXT_ASIDS(info))
 		goto set_asid;
 
 	/* We're out of ASIDs, so increment the global generation count */
@@ -214,7 +214,7 @@ static u64 new_context(struct asid_info *info, atomic64_t *pasid,
 	flush_context(info);
 
 	/* We have more ASIDs than CPUs, so this will always succeed */
-	asid = find_next_zero_bit(info->map, NUM_USER_ASIDS(info), 1);
+	asid = find_next_zero_bit(info->map, NUM_CTXT_ASIDS(info), 1);
 
 set_asid:
 	__set_bit(asid, info->map);
@@ -387,7 +387,7 @@ void cpu_do_switch_mm(phys_addr_t pgd_phys, struct mm_struct *mm)
 static int asids_update_limit(void)
 {
 	struct asid_info *info = &asid_info;
-	unsigned long num_available_asids = NUM_USER_ASIDS(info);
+	unsigned long num_available_asids = NUM_CTXT_ASIDS(info);
 
 	if (arm64_kernel_unmapped_at_el0()) {
 		num_available_asids /= 2;
@@ -418,18 +418,18 @@ static int asids_init(void)
 
 	info->bits = get_cpu_asid_bits();
 	atomic64_set(&info->generation, ASID_FIRST_VERSION(info));
-	info->map = kcalloc(BITS_TO_LONGS(NUM_USER_ASIDS(info)),
+	info->map = kcalloc(BITS_TO_LONGS(NUM_CTXT_ASIDS(info)),
 			    sizeof(*info->map), GFP_KERNEL);
 	if (!info->map)
 		panic("Failed to allocate bitmap for %lu ASIDs\n",
-		      NUM_USER_ASIDS(info));
+		      NUM_CTXT_ASIDS(info));
 
 	info->map_idx = 1;
 	info->active = &active_asids;
 	info->reserved = &reserved_asids;
 	raw_spin_lock_init(&info->lock);
 
-	pinned_asid_map = kcalloc(BITS_TO_LONGS(NUM_USER_ASIDS(info)),
+	pinned_asid_map = kcalloc(BITS_TO_LONGS(NUM_CTXT_ASIDS(info)),
 				  sizeof(*pinned_asid_map), GFP_KERNEL);
 	nr_pinned_asids = 0;
 
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5A735F258
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350275AbhDNL0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:26:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17334 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350478AbhDNLZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:25:26 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FL0Sk5KsszB0mp;
        Wed, 14 Apr 2021 19:22:46 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.32) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 19:24:56 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <julien@xen.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 08/16] arm64/mm: Split asid_inits in 2 parts
Date:   Wed, 14 Apr 2021 12:23:04 +0100
Message-ID: <20210414112312.13704-9-shameerali.kolothum.thodi@huawei.com>
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

Move out the common initialization of the ASID allocator in a separate
function.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
v3-->v4
  -dropped asid_per_ctxt and added pinned asid map init.
---
 arch/arm64/mm/context.c | 44 +++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 8af54e06f5bc..041c3c5e0216 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -412,26 +412,50 @@ static int asids_update_limit(void)
 }
 arch_initcall(asids_update_limit);
 
-static int asids_init(void)
+/*
+ * Initialize the ASID allocator
+ *
+ * @info: Pointer to the asid allocator structure
+ * @bits: Number of ASIDs available
+ * @pinned: Support for Pinned ASIDs
+ */
+static int asid_allocator_init(struct asid_info *info, u32 bits, bool pinned)
 {
-	struct asid_info *info = &asid_info;
+	info->bits = bits;
 
-	info->bits = get_cpu_asid_bits();
+	/*
+	 * Expect allocation after rollover to fail if we don't have at least
+	 * one more ASID than CPUs. ASID #0 is always reserved.
+	 */
+	WARN_ON(NUM_CTXT_ASIDS(info) - 1 <= num_possible_cpus());
 	atomic64_set(&info->generation, ASID_FIRST_VERSION(info));
 	info->map = kcalloc(BITS_TO_LONGS(NUM_CTXT_ASIDS(info)),
 			    sizeof(*info->map), GFP_KERNEL);
 	if (!info->map)
-		panic("Failed to allocate bitmap for %lu ASIDs\n",
-		      NUM_CTXT_ASIDS(info));
+		return -ENOMEM;
 
 	info->map_idx = 1;
-	info->active = &active_asids;
-	info->reserved = &reserved_asids;
 	raw_spin_lock_init(&info->lock);
 
-	info->pinned_map = kcalloc(BITS_TO_LONGS(NUM_CTXT_ASIDS(info)),
-				   sizeof(*info->pinned_map), GFP_KERNEL);
-	info->nr_pinned_asids = 0;
+	if (pinned) {
+		info->pinned_map = kcalloc(BITS_TO_LONGS(NUM_CTXT_ASIDS(info)),
+					   sizeof(*info->pinned_map), GFP_KERNEL);
+		info->nr_pinned_asids = 0;
+	}
+
+	return 0;
+}
+
+static int asids_init(void)
+{
+	struct asid_info *info = &asid_info;
+
+	if (asid_allocator_init(info, get_cpu_asid_bits(), true))
+		panic("Unable to initialize ASID allocator for %lu ASIDs\n",
+		      NUM_CTXT_ASIDS(info));
+
+	info->active = &active_asids;
+	info->reserved = &reserved_asids;
 
 	/*
 	 * We cannot call set_reserved_asid_bits() here because CPU
-- 
2.17.1


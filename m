Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5439E35F25B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350515AbhDNL0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:26:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16461 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbhDNLZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:25:41 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FL0T259cvztWGR;
        Wed, 14 Apr 2021 19:23:02 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.32) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 19:25:08 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <julien@xen.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 11/16] arm64/mm: Introduce a callback to flush the local context
Date:   Wed, 14 Apr 2021 12:23:07 +0100
Message-ID: <20210414112312.13704-12-shameerali.kolothum.thodi@huawei.com>
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

Flushing the local context will vary depending on the actual user
of the ASID allocator. Introduce a new callback to flush the local
context and move the call to flush local TLB in it.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/mm/context.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 901472a57b5d..ee446f7535a3 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -32,6 +32,8 @@ static struct asid_info
 	unsigned long		*pinned_map;
 	unsigned long		max_pinned_asids;
 	unsigned long		nr_pinned_asids;
+	/* Callback to locally flush the context. */
+	void			(*flush_cpu_ctxt_cb)(void);
 } asid_info;
 
 #define active_asid(info, cpu)	 (*per_cpu_ptr((info)->active, cpu))
@@ -245,8 +247,9 @@ static void asid_new_context(struct asid_info *info, atomic64_t *pasid,
 		atomic64_set(pasid, asid);
 	}
 
-	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
-		local_flush_tlb_all();
+	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending) &&
+	    info->flush_cpu_ctxt_cb)
+		info->flush_cpu_ctxt_cb();
 
 	atomic64_set(&active_asid(info, cpu), asid);
 	raw_spin_unlock_irqrestore(&info->lock, flags);
@@ -427,6 +430,11 @@ void cpu_do_switch_mm(phys_addr_t pgd_phys, struct mm_struct *mm)
 	post_ttbr_update_workaround();
 }
 
+static void asid_flush_cpu_ctxt(void)
+{
+	local_flush_tlb_all();
+}
+
 static int asids_update_limit(void)
 {
 	struct asid_info *info = &asid_info;
@@ -499,6 +507,7 @@ static int asids_init(void)
 
 	info->active = &active_asids;
 	info->reserved = &reserved_asids;
+	info->flush_cpu_ctxt_cb = asid_flush_cpu_ctxt;
 
 	/*
 	 * We cannot call set_reserved_asid_bits() here because CPU
-- 
2.17.1


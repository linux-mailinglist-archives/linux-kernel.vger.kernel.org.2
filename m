Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481C035F25D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350495AbhDNL0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:26:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16460 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbhDNLZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:25:41 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FL0T24mrTztWFY;
        Wed, 14 Apr 2021 19:23:02 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.32) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 19:25:12 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <julien@xen.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 12/16] arm64/mm: Introduce a callback to set reserved bits
Date:   Wed, 14 Apr 2021 12:23:08 +0100
Message-ID: <20210414112312.13704-13-shameerali.kolothum.thodi@huawei.com>
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

Setting the reserved asid bits will vary depending on the actual
user of the ASID allocator. Introduce a new callback.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/mm/context.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index ee446f7535a3..e9049d14f54a 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -34,6 +34,8 @@ static struct asid_info
 	unsigned long		nr_pinned_asids;
 	/* Callback to locally flush the context. */
 	void			(*flush_cpu_ctxt_cb)(void);
+	/* Callback to set the list of reserved ASIDs */
+	void			(*set_reserved_bits)(struct asid_info *info);
 } asid_info;
 
 #define active_asid(info, cpu)	 (*per_cpu_ptr((info)->active, cpu))
@@ -118,7 +120,8 @@ static void flush_context(struct asid_info *info)
 	u64 asid;
 
 	/* Update the list of reserved ASIDs and the ASID bitmap. */
-	set_reserved_asid_bits(info);
+	if (info->set_reserved_bits)
+		info->set_reserved_bits(info);
 
 	for_each_possible_cpu(i) {
 		asid = atomic64_xchg_relaxed(&active_asid(info, i), 0);
@@ -508,6 +511,7 @@ static int asids_init(void)
 	info->active = &active_asids;
 	info->reserved = &reserved_asids;
 	info->flush_cpu_ctxt_cb = asid_flush_cpu_ctxt;
+	info->set_reserved_bits = set_reserved_asid_bits;
 
 	/*
 	 * We cannot call set_reserved_asid_bits() here because CPU
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61B435F251
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhDNLZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:25:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16586 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350475AbhDNLZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:25:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FL0SY0Cxlz18Hlm;
        Wed, 14 Apr 2021 19:22:37 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.32) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 19:24:43 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <julien@xen.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 05/16] arm64/mm: Remove dependency on MM in new_context
Date:   Wed, 14 Apr 2021 12:23:01 +0100
Message-ID: <20210414112312.13704-6-shameerali.kolothum.thodi@huawei.com>
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

The function new_context will be part of a generic ASID allocator. At
the moment, the MM structure is currently used to fetch the ASID and
pinned refcount.

To remove the dependency on MM, it is possible to just pass a pointer to
the current ASID and pinned refcount. Also please note that 'pinned' may
be NULL if the user doesn't require the pinned asid support.


Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
v3-->v4:
  Changes related to Pinned ASID refcount.

---
 arch/arm64/mm/context.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 139ebc161acb..628304e0d3b1 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -165,9 +165,10 @@ static bool check_update_reserved_asid(struct asid_info *info, u64 asid,
 	return hit;
 }
 
-static u64 new_context(struct asid_info *info, struct mm_struct *mm)
+static u64 new_context(struct asid_info *info, atomic64_t *pasid,
+		       refcount_t *pinned)
 {
-	u64 asid = atomic64_read(&mm->context.id);
+	u64 asid = atomic64_read(pasid);
 	u64 generation = atomic64_read(&info->generation);
 
 	if (asid != 0) {
@@ -185,7 +186,7 @@ static u64 new_context(struct asid_info *info, struct mm_struct *mm)
 		 * takes priority, because even if it is also pinned, we need to
 		 * update the generation into the reserved_asids.
 		 */
-		if (refcount_read(&mm->context.pinned))
+		if (pinned && refcount_read(pinned))
 			return newasid;
 
 		/*
@@ -257,7 +258,7 @@ void check_and_switch_context(struct mm_struct *mm)
 	/* Check that our ASID belongs to the current generation. */
 	asid = atomic64_read(&mm->context.id);
 	if (!asid_gen_match(asid, info)) {
-		asid = new_context(info, mm);
+		asid = new_context(info, &mm->context.id, &mm->context.pinned);
 		atomic64_set(&mm->context.id, asid);
 	}
 
@@ -306,7 +307,7 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
 		 * We went through one or more rollover since that ASID was
 		 * used. Ensure that it is still valid, or generate a new one.
 		 */
-		asid = new_context(info, mm);
+		asid = new_context(info, &mm->context.id, &mm->context.pinned);
 		atomic64_set(&mm->context.id, asid);
 	}
 
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6803A7BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhFOKX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:23:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6376 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhFOKX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:23:26 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G444f0V6Rz63bM;
        Tue, 15 Jun 2021 18:17:22 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 18:21:13 +0800
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 18:21:13 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <yuzenghui@huawei.com>, <wanghaibin.wang@huawei.com>,
        Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v2] KVM: arm64: Fix inconsistency from function comment of __unmap_stage2_range
Date:   Tue, 15 Jun 2021 18:21:11 +0800
Message-ID: <20210615102111.34128-1-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 'b5331379bc626'
(KVM: arm64: Only reschedule if MMU_NOTIFIER_RANGE_BLOCKABLE is not set)
has converted the original function name 'unmap_stage2_range' to
'__unmap_stage2_range', but leaving the corresponding function comment
unadjusted. So fix it for code readability.

Incidentally, we also tewak some comment identation by using tabs instead
of spaces to be consistent with the other functions.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/kvm/mmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 5742ba765ff9..293779790d16 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -151,11 +151,11 @@ static void *kvm_host_va(phys_addr_t phys)
  * does.
  */
 /**
- * unmap_stage2_range -- Clear stage2 page table entries to unmap a range
- * @mmu:   The KVM stage-2 MMU pointer
- * @start: The intermediate physical base address of the range to unmap
- * @size:  The size of the area to unmap
- * @may_block: Whether or not we are permitted to block
+ * __unmap_stage2_range -- Clear stage2 page table entries to unmap a range
+ * @mmu:	The KVM stage-2 MMU pointer
+ * @start:	The intermediate physical base address of the range to unmap
+ * @size:	The size of the area to unmap
+ * @may_block:	Whether or not we are permitted to block
  *
  * Clear a range of stage-2 mappings, lowering the various ref-counts.  Must
  * be called while holding mmu_lock (unless for freeing the stage2 pgd before
-- 
2.23.0


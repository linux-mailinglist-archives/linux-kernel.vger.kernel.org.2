Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091B13E8F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhHKLLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:11:03 -0400
Received: from foss.arm.com ([217.140.110.172]:47748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237154AbhHKLK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:10:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C950E106F;
        Wed, 11 Aug 2021 04:10:33 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DC533F70D;
        Wed, 11 Aug 2021 04:10:29 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] KVM: arm64: Restrict IPA size to maximum 48 bits on 4K and 16K page size
Date:   Wed, 11 Aug 2021 16:41:15 +0530
Message-Id: <1628680275-16578-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though ID_AA64MMFR0.PARANGE reports 52 bit PA size support, it cannot
be enabled as guest IPA size on 4K or 16K page size configurations. Hence
kvm_ipa_limit must be restricted to 48 bits. This change achieves required
IPA capping.

Before the commit c9b69a0cf0b4 ("KVM: arm64: Don't constrain maximum IPA
size based on host configuration"), the problem here would have been just
latent via PHYS_MASK_SHIFT (which earlier in turn capped kvm_ipa_limit),
which remains capped at 48 bits on 4K and 16K configs.

Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Fixes: c9b69a0cf0b4 ("KVM: arm64: Don't constrain maximum IPA size based on host configuration")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.14-rc5

Changes in V2:

- Replaced IS_ENABLED() based check with PAGE_SIZE based one per Marc
- Moved the conditional code block near parange assignment per Marc

Changes in V1:

https://lore.kernel.org/lkml/1628657549-27584-1-git-send-email-anshuman.khandual@arm.com/

 arch/arm64/kvm/reset.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index cba7872..78d4bd8 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -317,6 +317,14 @@ int kvm_set_ipa_limit(void)
 	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 	parange = cpuid_feature_extract_unsigned_field(mmfr0,
 				ID_AA64MMFR0_PARANGE_SHIFT);
+	/*
+	 * IPA size beyond 48 bits could not be supported
+	 * on either 4K or 16K page size. Hence let's cap
+	 * it to 48 bits, in case it's reported as larger
+	 * on the system.
+	 */
+	if (PAGE_SIZE != SZ_64K)
+		parange = min(parange, (unsigned int)ID_AA64MMFR0_PARANGE_48);
 
 	/*
 	 * Check with ARMv8.5-GTG that our PAGE_SIZE is supported at
-- 
2.7.4


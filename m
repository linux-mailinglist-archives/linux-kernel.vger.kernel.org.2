Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430D33E540E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbhHJHCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:02:50 -0400
Received: from foss.arm.com ([217.140.110.172]:48946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237609AbhHJHCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:02:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A78BD6E;
        Tue, 10 Aug 2021 00:02:23 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB8463F718;
        Tue, 10 Aug 2021 00:02:19 -0700 (PDT)
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
Subject: [PATCH 5/5] KVM: arm64: Define KVM_PHYS_SHIFT_MIN
Date:   Tue, 10 Aug 2021 12:32:41 +0530
Message-Id: <1628578961-29097-6-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the hard coded value for the minimum IPA range i.e 32 bit. Instead
define a macro KVM_PHYS_SHIFT_MIN which improves the code readability.

Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 3 ++-
 arch/arm64/kvm/reset.c           | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index b52c5c4b9a3d..716f999818d9 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -141,7 +141,8 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
  * We currently support using a VM-specified IPA size. For backward
  * compatibility, the default IPA size is fixed to 40bits.
  */
-#define KVM_PHYS_SHIFT	(40)
+#define KVM_PHYS_SHIFT		(40)
+#define KVM_PHYS_SHIFT_MIN	(32)
 
 #define kvm_phys_shift(kvm)		VTCR_EL2_IPA(kvm->arch.vtcr)
 #define kvm_phys_size(kvm)		(_AC(1, ULL) << kvm_phys_shift(kvm))
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index cba7872d69a8..8dc8b4b9de37 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -369,7 +369,7 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 	phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(type);
 	if (phys_shift) {
 		if (phys_shift > kvm_ipa_limit ||
-		    phys_shift < 32)
+		    phys_shift < KVM_PHYS_SHIFT_MIN)
 			return -EINVAL;
 	} else {
 		phys_shift = KVM_PHYS_SHIFT;
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9B33E5406
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbhHJHCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:02:32 -0400
Received: from foss.arm.com ([217.140.110.172]:48894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237242AbhHJHCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:02:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D39AB1042;
        Tue, 10 Aug 2021 00:02:06 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 76C913F718;
        Tue, 10 Aug 2021 00:02:03 -0700 (PDT)
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
Subject: [PATCH 1/5] KVM: arm64: Drop direct PAGE_[SHIFT|SIZE] usage as page size
Date:   Tue, 10 Aug 2021 12:32:37 +0530
Message-Id: <1628578961-29097-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All instances here could just directly test against CONFIG_ARM64_XXK_PAGES
instead of evaluating via PAGE_SHIFT or PAGE_SIZE. With this change, there
will be no such usage left.

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
 arch/arm64/kvm/hyp/pgtable.c | 6 +++---
 arch/arm64/mm/mmu.c          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 05321f4165e3..a6112b6d6ef6 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -85,7 +85,7 @@ static bool kvm_level_supports_block_mapping(u32 level)
 	 * Reject invalid block mappings and don't bother with 4TB mappings for
 	 * 52-bit PAs.
 	 */
-	return !(level == 0 || (PAGE_SIZE != SZ_4K && level == 1));
+	return !(level == 0 || (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) && level == 1));
 }
 
 static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
@@ -155,7 +155,7 @@ static u64 kvm_pte_to_phys(kvm_pte_t pte)
 {
 	u64 pa = pte & KVM_PTE_ADDR_MASK;
 
-	if (PAGE_SHIFT == 16)
+	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
 		pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
 
 	return pa;
@@ -165,7 +165,7 @@ static kvm_pte_t kvm_phys_to_pte(u64 pa)
 {
 	kvm_pte_t pte = pa & KVM_PTE_ADDR_MASK;
 
-	if (PAGE_SHIFT == 16)
+	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
 		pte |= FIELD_PREP(KVM_PTE_ADDR_51_48, pa >> 48);
 
 	return pte;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9ff0de1b2b93..8fdfca179815 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -296,7 +296,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 static inline bool use_1G_block(unsigned long addr, unsigned long next,
 			unsigned long phys)
 {
-	if (PAGE_SHIFT != 12)
+	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
 		return false;
 
 	if (((addr | next | phys) & ~PUD_MASK) != 0)
-- 
2.20.1


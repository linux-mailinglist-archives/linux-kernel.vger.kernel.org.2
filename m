Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBC241D7E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350119AbhI3Kgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:36:55 -0400
Received: from foss.arm.com ([217.140.110.172]:52150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350109AbhI3Kgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:36:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE623106F;
        Thu, 30 Sep 2021 03:35:04 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C7C43F793;
        Thu, 30 Sep 2021 03:35:01 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        steven.price@arm.com, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V3 13/13] KVM: arm64: Enable FEAT_LPA2 based 52 bits IPA size on 4K and 16K
Date:   Thu, 30 Sep 2021 16:05:16 +0530
Message-Id: <1632998116-11552-14-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
References: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stage-2 FEAT_LPA2 support is independent and also orthogonal to FEAT_LPA2
support either in Stage-1 or in the host kernel. Stage-2 IPA range support
is evaluated from the platform via ID_AA64MMFR0_TGRAN_2_SUPPORTED_LPA2 and
gets enabled regardless of Stage-1 translation.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 10 +++++++++-
 arch/arm64/kvm/hyp/pgtable.c         | 25 +++++++++++++++++++++++--
 arch/arm64/kvm/reset.c               | 14 ++++++++++----
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 0277838..78a9d12 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -29,18 +29,26 @@ typedef u64 kvm_pte_t;
 
 #define KVM_PTE_ADDR_MASK		GENMASK(47, PAGE_SHIFT)
 #define KVM_PTE_ADDR_51_48		GENMASK(15, 12)
+#define KVM_PTE_ADDR_51_50		GENMASK(9, 8)
 
 static inline bool kvm_pte_valid(kvm_pte_t pte)
 {
 	return pte & KVM_PTE_VALID;
 }
 
+void set_kvm_lpa2_enabled(void);
+bool get_kvm_lpa2_enabled(void);
+
 static inline u64 kvm_pte_to_phys(kvm_pte_t pte)
 {
 	u64 pa = pte & KVM_PTE_ADDR_MASK;
 
-	if (PAGE_SHIFT == 16)
+	if (PAGE_SHIFT == 16) {
 		pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
+	} else {
+		if (get_kvm_lpa2_enabled())
+			pa |= FIELD_GET(KVM_PTE_ADDR_51_50, pte) << 50;
+	}
 
 	return pa;
 }
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index f8ceebe..58141bf 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -49,6 +49,18 @@
 #define KVM_INVALID_PTE_OWNER_MASK	GENMASK(9, 2)
 #define KVM_MAX_OWNER_ID		1
 
+static bool kvm_lpa2_enabled;
+
+bool get_kvm_lpa2_enabled(void)
+{
+	return kvm_lpa2_enabled;
+}
+
+void set_kvm_lpa2_enabled(void)
+{
+	kvm_lpa2_enabled = true;
+}
+
 struct kvm_pgtable_walk_data {
 	struct kvm_pgtable		*pgt;
 	struct kvm_pgtable_walker	*walker;
@@ -126,8 +138,12 @@ static kvm_pte_t kvm_phys_to_pte(u64 pa)
 {
 	kvm_pte_t pte = pa & KVM_PTE_ADDR_MASK;
 
-	if (PAGE_SHIFT == 16)
+	if (PAGE_SHIFT == 16) {
 		pte |= FIELD_PREP(KVM_PTE_ADDR_51_48, pa >> 48);
+	} else {
+		if (get_kvm_lpa2_enabled())
+			pte |= FIELD_PREP(KVM_PTE_ADDR_51_50, pa >> 50);
+	}
 
 	return pte;
 }
@@ -540,6 +556,9 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
 	 */
 	vtcr |= VTCR_EL2_HA;
 
+	if (get_kvm_lpa2_enabled())
+		vtcr |= VTCR_EL2_DS;
+
 	/* Set the vmid bits */
 	vtcr |= (get_vmid_bits(mmfr1) == 16) ?
 		VTCR_EL2_VS_16BIT :
@@ -577,7 +596,9 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
 	if (prot & KVM_PGTABLE_PROT_W)
 		attr |= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W;
 
-	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
+	if (!get_kvm_lpa2_enabled())
+		attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
+
 	attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
 	attr |= prot & KVM_PTE_LEAF_ATTR_HI_SW;
 	*ptep = attr;
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 5ce36b0..97ec387 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -315,26 +315,32 @@ u32 get_kvm_ipa_limit(void)
 
 int kvm_set_ipa_limit(void)
 {
-	unsigned int parange;
+	unsigned int parange, tgran;
 	u64 mmfr0;
 
 	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 	parange = cpuid_feature_extract_unsigned_field(mmfr0,
 				ID_AA64MMFR0_PARANGE_SHIFT);
+	tgran = cpuid_feature_extract_unsigned_field(mmfr0,
+				ID_AA64MMFR0_TGRAN_2_SHIFT);
 	/*
 	 * IPA size beyond 48 bits could not be supported
 	 * on either 4K or 16K page size. Hence let's cap
 	 * it to 48 bits, in case it's reported as larger
 	 * on the system.
 	 */
-	if (PAGE_SIZE != SZ_64K)
-		parange = min(parange, (unsigned int)ID_AA64MMFR0_PARANGE_48);
+	if (PAGE_SIZE != SZ_64K) {
+		if (tgran == ID_AA64MMFR0_TGRAN_2_SUPPORTED_LPA2)
+			set_kvm_lpa2_enabled();
+		else
+			parange = min(parange, (unsigned int)ID_AA64MMFR0_PARANGE_48);
+	}
 
 	/*
 	 * Check with ARMv8.5-GTG that our PAGE_SIZE is supported at
 	 * Stage-2. If not, things will stop very quickly.
 	 */
-	switch (cpuid_feature_extract_unsigned_field(mmfr0, ID_AA64MMFR0_TGRAN_2_SHIFT)) {
+	switch (tgran) {
 	case ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE:
 		kvm_err("PAGE_SIZE not supported at Stage-2, giving up\n");
 		return -EINVAL;
-- 
2.7.4


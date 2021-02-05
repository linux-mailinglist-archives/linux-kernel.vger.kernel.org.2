Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055CB310D68
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 16:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhBEOJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:09:52 -0500
Received: from foss.arm.com ([217.140.110.172]:60388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231480AbhBEN7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:59:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CB7411B3;
        Fri,  5 Feb 2021 05:58:28 -0800 (PST)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2301E3F719;
        Fri,  5 Feb 2021 05:58:25 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: [PATCH v8 2/5] arm64: kvm: Introduce MTE VM feature
Date:   Fri,  5 Feb 2021 13:58:00 +0000
Message-Id: <20210205135803.48321-3-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210205135803.48321-1-steven.price@arm.com>
References: <20210205135803.48321-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new VM feature 'KVM_ARM_CAP_MTE' which enables memory tagging
for a VM. This will expose the feature to the guest and automatically
tag memory pages touched by the VM as PG_mte_tagged (and clear the tag
storage) to ensure that the guest cannot see stale tags, and so that
the tags are correctly saved/restored across swap.

Actually exposing the new capability to user space happens in a later
patch.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  3 +++
 arch/arm64/include/asm/kvm_host.h    |  3 +++
 arch/arm64/kvm/hyp/exception.c       |  3 ++-
 arch/arm64/kvm/mmu.c                 | 16 ++++++++++++++++
 arch/arm64/kvm/sys_regs.c            |  3 ++-
 include/uapi/linux/kvm.h             |  1 +
 6 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index f612c090f2e4..6bf776c2399c 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -84,6 +84,9 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
 	    vcpu_el1_is_32bit(vcpu))
 		vcpu->arch.hcr_el2 |= HCR_TID2;
+
+	if (kvm_has_mte(vcpu->kvm))
+		vcpu->arch.hcr_el2 |= HCR_ATA;
 }
 
 static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 11beda85ee7e..302ebc61d8ac 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -132,6 +132,8 @@ struct kvm_arch {
 
 	u8 pfr0_csv2;
 	u8 pfr0_csv3;
+	/* Memory Tagging Extension enabled for the guest */
+	bool mte_enabled;
 };
 
 struct kvm_vcpu_fault_info {
@@ -745,6 +747,7 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 #define kvm_arm_vcpu_sve_finalized(vcpu) \
 	((vcpu)->arch.flags & KVM_ARM64_VCPU_SVE_FINALIZED)
 
+#define kvm_has_mte(kvm) (system_supports_mte() && (kvm)->arch.mte_enabled)
 #define kvm_vcpu_has_pmu(vcpu)					\
 	(test_bit(KVM_ARM_VCPU_PMU_V3, (vcpu)->arch.features))
 
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index 73629094f903..56426565600c 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -112,7 +112,8 @@ static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long target_mode,
 	new |= (old & PSR_C_BIT);
 	new |= (old & PSR_V_BIT);
 
-	// TODO: TCO (if/when ARMv8.5-MemTag is exposed to guests)
+	if (kvm_has_mte(vcpu->kvm))
+		new |= PSR_TCO_BIT;
 
 	new |= (old & PSR_DIT_BIT);
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 7d2257cc5438..6076a1ab41d9 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -879,6 +879,22 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (vma_pagesize == PAGE_SIZE && !force_pte)
 		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
 							   &pfn, &fault_ipa);
+
+	if (kvm_has_mte(kvm) && pfn_valid(pfn)) {
+		/*
+		 * VM will be able to see the page's tags, so we must ensure
+		 * they have been initialised. if PG_mte_tagged is set, tags
+		 * have already been initialised.
+		 */
+		struct page *page = pfn_to_page(pfn);
+		unsigned long i, nr_pages = vma_pagesize >> PAGE_SHIFT;
+
+		for (i = 0; i < nr_pages; i++, page++) {
+			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
+				mte_clear_page_tags(page_address(page));
+		}
+	}
+
 	if (writable) {
 		prot |= KVM_PGTABLE_PROT_W;
 		kvm_set_pfn_dirty(pfn);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 3313dedfa505..bb5525bbf1ca 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1029,7 +1029,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 		val &= ~(0xfUL << ID_AA64PFR0_CSV3_SHIFT);
 		val |= ((u64)vcpu->kvm->arch.pfr0_csv3 << ID_AA64PFR0_CSV3_SHIFT);
 	} else if (id == SYS_ID_AA64PFR1_EL1) {
-		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
+		if (!kvm_has_mte(vcpu->kvm))
+			val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
 	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
 		val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
 			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 886802b8ffba..de737d5102ca 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1056,6 +1056,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ENFORCE_PV_FEATURE_CPUID 190
 #define KVM_CAP_SYS_HYPERV_CPUID 191
 #define KVM_CAP_DIRTY_LOG_RING 192
+#define KVM_CAP_ARM_MTE 193
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.20.1


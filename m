Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609E0341957
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCSKDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhCSKCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:34 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D79BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:33 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id i14so12664555wmq.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q749KFSlxhI4VCSiQH1slVzGHfGqH+QjEF4T/jfNWVY=;
        b=hNSKmGsVSywebewepY40RtqmV2qb/zYxefM6ad1P5/nHOptnJuLk+iUHxY/FzU5WSz
         G3TEA0iLYSdCy4hkLy6hwCK8zG7rCNGdNKRGyCvA74SErAz1RrE7OA8U5gcgJM0cnYpD
         tbtu7uVxqq0QyZOS381v7XRYiZYjv4nXltrpHZVXwpceorQUn3Ix/l4nK5RsEcDcR0co
         Scg9wNGIB9bykMV5XqpVGKAVtCcMm7OrfToEgMgCXI5mxI2NGxlE2dJQIRlwOjbtCBxd
         ei+HyKgDULEa+Vg3BRdyoO4pnCVRL+/RP84WoaAr4mDNn/Wz5Rw7712n1GZ7pTTaML8o
         Lweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q749KFSlxhI4VCSiQH1slVzGHfGqH+QjEF4T/jfNWVY=;
        b=IkxRoQv6lmKA7d1p/Om1HDO996qjv9t7ZIBj5B8e2p69w0BJ3IpE3py/4p4JUu9EG8
         /9wF2admen7HDMLgwwZuyi1YP/AII+Q0KfWlyplm9Tqw8V4Sk9KOKkjzBGfmlHQrIsds
         0i7MvdTYjLatQRnA26/Q9Q3QutKi9+HrWJT4QcjYMP8CFTUvkcruW2e6x8Fe5+bnNPJn
         kmqzFq8iBkkN6vQd2d4sKrNQrquXRBZOUlNr1k4uYE0l6cL6KZuPCpW7Fk0ctZ/SwR2w
         dvaBW/6bm7NPcdxV+cEyk+0lC/8WcMtZTjeuQIxLvgaMkCO+u/7w6rQY/bXkA2cm17aw
         PEGg==
X-Gm-Message-State: AOAM533rECs+X3gzFkxss6ba52KcYNAbSkqxVo/JHjl/owYr9Qqhmfpy
        SR/T9qk2Ujaa+28RWO4OQgvFTmgaM1LM
X-Google-Smtp-Source: ABdhPJxqimdu4udH3YpMhv4DNL7SlC0GK4WlaPmSq55hwqof4iZVOI53YgJLP6O5Bzyu7KGewUovCZWfoeXF
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:7e45:: with SMTP id
 z66mr2968982wmc.126.1616148152068; Fri, 19 Mar 2021 03:02:32 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:28 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-21-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 20/38] KVM: arm64: Use kvm_arch in kvm_s2_mmu
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make use of the stage 2 pgtable code for the host stage 2,
change kvm_s2_mmu to use a kvm_arch pointer in lieu of the kvm pointer,
as the host will have the former but not the latter.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/include/asm/kvm_mmu.h  | 6 +++++-
 arch/arm64/kvm/mmu.c              | 8 ++++----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f813e1191027..4859c9de75d7 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -94,7 +94,7 @@ struct kvm_s2_mmu {
 	/* The last vcpu id that ran on each physical CPU */
 	int __percpu *last_vcpu_ran;
 
-	struct kvm *kvm;
+	struct kvm_arch *arch;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index ce02a4052dcf..6f743e20cb06 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -272,7 +272,7 @@ static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
  */
 static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
 {
-	write_sysreg(kern_hyp_va(mmu->kvm)->arch.vtcr, vtcr_el2);
+	write_sysreg(kern_hyp_va(mmu->arch)->vtcr, vtcr_el2);
 	write_sysreg(kvm_get_vttbr(mmu), vttbr_el2);
 
 	/*
@@ -283,5 +283,9 @@ static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 }
 
+static inline struct kvm *kvm_s2_mmu_to_kvm(struct kvm_s2_mmu *mmu)
+{
+	return container_of(mmu->arch, struct kvm, arch);
+}
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index d6eb1fb21232..0f16b70befa8 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -165,7 +165,7 @@ static void *kvm_host_va(phys_addr_t phys)
 static void __unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64 size,
 				 bool may_block)
 {
-	struct kvm *kvm = mmu->kvm;
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
 	phys_addr_t end = start + size;
 
 	assert_spin_locked(&kvm->mmu_lock);
@@ -470,7 +470,7 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 	for_each_possible_cpu(cpu)
 		*per_cpu_ptr(mmu->last_vcpu_ran, cpu) = -1;
 
-	mmu->kvm = kvm;
+	mmu->arch = &kvm->arch;
 	mmu->pgt = pgt;
 	mmu->pgd_phys = __pa(pgt->pgd);
 	mmu->vmid.vmid_gen = 0;
@@ -552,7 +552,7 @@ void stage2_unmap_vm(struct kvm *kvm)
 
 void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
 {
-	struct kvm *kvm = mmu->kvm;
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
 	struct kvm_pgtable *pgt = NULL;
 
 	spin_lock(&kvm->mmu_lock);
@@ -621,7 +621,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
  */
 static void stage2_wp_range(struct kvm_s2_mmu *mmu, phys_addr_t addr, phys_addr_t end)
 {
-	struct kvm *kvm = mmu->kvm;
+	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
 	stage2_apply_range_resched(kvm, addr, end, kvm_pgtable_stage2_wrprotect);
 }
 
-- 
2.31.0.rc2.261.g7f71774620-goog


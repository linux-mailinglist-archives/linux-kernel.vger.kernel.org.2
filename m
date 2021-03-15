Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BB433BEF1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbhCOOv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbhCOOgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:48 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B05C061764
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:22 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id b15so23148226qvz.15
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HRAFWrKIzylHbXfgNm/Fu2Q8xoVgUT5PJ9wf7XKiM18=;
        b=DCcz3x1/kW/GD99FmKaXddapQt41XZ32XNsYp7QWBDLlVO24xW5DpiW59uYWRTX1DJ
         KwMvZL7qz9CseKSBVwI41fMrKiTvUUJcGyZDt9OUAYImbWTblGSBvA4nUu4IX+ZlHBo8
         hL20TRKTR4Qc88S21vfhSOuuUZ5OQntet777ua+efKJ4/93MkK1gH91l9s87ZdZCAiYT
         CYP9rP7uKnd843PIJBZXtROVc8w7J0I1k4Q7Ldv/Fk1Ye5f9DKst+rK6Pgyy81K8xTWs
         JejWtJ1SIW/fOH7WNLx+hrjx+vQAQdgSUqS2y1sJ/NPZd1xCpdDB6ognRrHWdoLl5xjd
         Xc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HRAFWrKIzylHbXfgNm/Fu2Q8xoVgUT5PJ9wf7XKiM18=;
        b=pad8fjNl2iN1qs7MYlulhjs4KCyWoxvYyW2+6H7ig21D2aVFLLhYXXKlhm8CO4xyjV
         GN7T2wMZ5XiICsa0z5JNxHuPJ6N6fBgqLct5gI16Fklco3e+SNSBlPxcjyUWRfO8Sxm9
         FuXDvFoXoSVRACXm2uYSBcf2M9wTublgld82gFJr0MwvbV4dJzO2ZqYHEaLzFP+ZlruJ
         0OOlTT2U3KWD4UEmFdhUWsKJU2FxA/mjw8V2DUmyx7fK6YJRGp0l8Mm7XTR665hzNSEi
         6w1yjIjeDPRXcE4nOOf/g2FjPU3bsG0lMn3pMt/T5hNmkOgqCoG2tCDpOfy3TS/bTYdM
         7wPQ==
X-Gm-Message-State: AOAM532SAyowXH+qvIbI03zIIDvOoCLabSfoBHvexJv8DQ2k9pXkqlda
        pl9HxA65WUs+Tp0uqNSoEFqEodc9rXjE
X-Google-Smtp-Source: ABdhPJyzqo0wyW19psT2TxHKUfltEf1yo5fncKMm24FmM3kFIm49/9SjdrDd5UArPWMDFW3pIsdD5UK2gyVu
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:4904:: with SMTP id
 bh4mr24441509qvb.53.1615818981861; Mon, 15 Mar 2021 07:36:21 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:20 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-21-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 20/36] KVM: arm64: Use kvm_arch in kvm_s2_mmu
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
index b9d45a1f8538..90565782ce3e 100644
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
index 41f9c03cbcc3..3257cadfab24 100644
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


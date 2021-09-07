Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B374028DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344203AbhIGMeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:34:31 -0400
Received: from foss.arm.com ([217.140.110.172]:35524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344193AbhIGMe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:34:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A1656D;
        Tue,  7 Sep 2021 05:33:21 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9DD7B3F766;
        Tue,  7 Sep 2021 05:33:16 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [PATCH v2 2/2] KVM: arm64: Add memcg accounting to KVM allocations
Date:   Tue,  7 Sep 2021 20:31:12 +0800
Message-Id: <20210907123112.10232-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210907123112.10232-1-justin.he@arm.com>
References: <20210907123112.10232-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by commit 254272ce6505 ("kvm: x86: Add memcg accounting to KVM
allocations"), it would be better to make arm64 KVM consistent with
common kvm codes.

The memory allocations of VM scope should be charged into VM process
cgroup, hence change GFP_KERNEL to GFP_KERNEL_ACCOUNT.

There remain a few cases since these allocations are global, not in VM
scope.

Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/kvm/arm.c      | 6 ++++--
 arch/arm64/kvm/mmu.c      | 2 +-
 arch/arm64/kvm/pmu-emul.c | 2 +-
 arch/arm64/kvm/reset.c    | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 0ca72f5cda41..7a7c478b8e6b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -293,10 +293,12 @@ long kvm_arch_dev_ioctl(struct file *filp,
 
 struct kvm *kvm_arch_alloc_vm(void)
 {
+	size_t sz = sizeof(struct kvm);
+
 	if (!has_vhe())
-		return kzalloc(sizeof(struct kvm), GFP_KERNEL);
+		return kzalloc(sz, GFP_KERNEL_ACCOUNT);
 
-	return vzalloc(sizeof(struct kvm));
+	return __vmalloc(sz, GFP_KERNEL_ACCOUNT | __GFP_HIGHMEM | __GFP_ZERO);
 }
 
 void kvm_arch_free_vm(struct kvm *kvm)
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 0625bf2353c2..801845ebd9d5 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -465,7 +465,7 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 		return -EINVAL;
 	}
 
-	pgt = kzalloc(sizeof(*pgt), GFP_KERNEL);
+	pgt = kzalloc(sizeof(*pgt), GFP_KERNEL_ACCOUNT);
 	if (!pgt)
 		return -ENOMEM;
 
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index f33825c995cb..05d42f6b89e4 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -971,7 +971,7 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 		mutex_lock(&vcpu->kvm->lock);
 
 		if (!vcpu->kvm->arch.pmu_filter) {
-			vcpu->kvm->arch.pmu_filter = bitmap_alloc(nr_events, GFP_KERNEL);
+			vcpu->kvm->arch.pmu_filter = bitmap_alloc(nr_events, GFP_KERNEL_ACCOUNT);
 			if (!vcpu->kvm->arch.pmu_filter) {
 				mutex_unlock(&vcpu->kvm->lock);
 				return -ENOMEM;
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index cba7872d69a8..608c1baaaa63 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -106,7 +106,7 @@ static int kvm_vcpu_finalize_sve(struct kvm_vcpu *vcpu)
 		    vl > SVE_VL_ARCH_MAX))
 		return -EIO;
 
-	buf = kzalloc(SVE_SIG_REGS_SIZE(sve_vq_from_vl(vl)), GFP_KERNEL);
+	buf = kzalloc(SVE_SIG_REGS_SIZE(sve_vq_from_vl(vl)), GFP_KERNEL_ACCOUNT);
 	if (!buf)
 		return -ENOMEM;
 
-- 
2.17.1


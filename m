Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49063F7A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbhHYQSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:18:52 -0400
Received: from foss.arm.com ([217.140.110.172]:54726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240593AbhHYQS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A439D113E;
        Wed, 25 Aug 2021 09:17:42 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559F33F66F;
        Wed, 25 Aug 2021 09:17:41 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 19/39] KVM: arm64: Do not emulate SPE on CPUs which don't have SPE
Date:   Wed, 25 Aug 2021 17:17:55 +0100
Message-Id: <20210825161815.266051-20-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel allows heterogeneous systems where FEAT_SPE is not present on
all CPUs. This presents a challenge for KVM, as it will have to touch the
SPE registers when emulating SPE for a guest, and those accesses will cause
an undefined exception if SPE is not present on the CPU.

Avoid this situation by comparing the cpumask of the physical CPUs that
support SPE with the cpu list provided by userspace via the
KVM_ARM_VCPU_SUPPORTED_CPUS ioctl and refusing the run the VCPU if there is
a mismatch.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/kvm_spe.h |  2 ++
 arch/arm64/kvm/arm.c             |  3 +++
 arch/arm64/kvm/spe.c             | 12 ++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_spe.h b/arch/arm64/include/asm/kvm_spe.h
index 328115ce0b48..ed67ddbf8132 100644
--- a/arch/arm64/include/asm/kvm_spe.h
+++ b/arch/arm64/include/asm/kvm_spe.h
@@ -16,11 +16,13 @@ static __always_inline bool kvm_supports_spe(void)
 
 void kvm_spe_init_supported_cpus(void);
 void kvm_spe_vm_init(struct kvm *kvm);
+int kvm_spe_check_supported_cpus(struct kvm_vcpu *vcpu);
 #else
 #define kvm_supports_spe()	(false)
 
 static inline void kvm_spe_init_supported_cpus(void) {}
 static inline void kvm_spe_vm_init(struct kvm *kvm) {}
+static inline int kvm_spe_check_supported_cpus(struct kvm_vcpu *vcpu) { return -ENOEXEC; }
 #endif /* CONFIG_KVM_ARM_SPE */
 
 #endif /* __ARM64_KVM_SPE_H__ */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 82cb7b5b3b45..8f7025f2e4a0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -633,6 +633,9 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	if (!kvm_arm_vcpu_is_finalized(vcpu))
 		return -EPERM;
 
+	if (kvm_vcpu_has_spe(vcpu) && kvm_spe_check_supported_cpus(vcpu))
+		return -EPERM;
+
 	vcpu->arch.has_run_once = true;
 
 	kvm_arm_vcpu_init_debug(vcpu);
diff --git a/arch/arm64/kvm/spe.c b/arch/arm64/kvm/spe.c
index 83f92245f881..8d2afc137151 100644
--- a/arch/arm64/kvm/spe.c
+++ b/arch/arm64/kvm/spe.c
@@ -30,3 +30,15 @@ void kvm_spe_vm_init(struct kvm *kvm)
 	/* Set supported_cpus if it isn't already initialized. */
 	kvm_spe_init_supported_cpus();
 }
+
+int kvm_spe_check_supported_cpus(struct kvm_vcpu *vcpu)
+{
+	/* SPE is supported on all CPUs, we don't care about the VCPU mask */
+	if (cpumask_equal(supported_cpus, cpu_possible_mask))
+		return 0;
+
+	if (!cpumask_subset(&vcpu->arch.supported_cpus, supported_cpus))
+		return -ENOEXEC;
+
+	return 0;
+}
-- 
2.33.0


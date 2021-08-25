Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC98C3F7A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbhHYQSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:18:44 -0400
Received: from foss.arm.com ([217.140.110.172]:54788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239986AbhHYQSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 734691435;
        Wed, 25 Aug 2021 09:17:39 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23D673F66F;
        Wed, 25 Aug 2021 09:17:38 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 17/39] KVM: arm64: Set the VCPU SPE feature bit when SPE is available
Date:   Wed, 25 Aug 2021 17:17:53 +0100
Message-Id: <20210825161815.266051-18-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that KVM SPE emulation is supported before allowing userspace to set
the KVM_ARM_VCPU_SPE feature.

According to ARM DDI 0487G.a, page D9-2946 the Profiling Buffer is disabled
if the owning Exception level is 32 bit, reject the SPE feature if the
VCPU's execution state at EL1 is aarch32.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  3 +++
 arch/arm64/kvm/reset.c            | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 1f3b46a6df81..948adb152104 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -807,6 +807,9 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 #define kvm_vcpu_has_pmu(vcpu)					\
 	(test_bit(KVM_ARM_VCPU_PMU_V3, (vcpu)->arch.features))
 
+#define kvm_vcpu_has_spe(vcpu)					\
+	(test_bit(KVM_ARM_VCPU_SPE, (vcpu)->arch.features))
+
 int kvm_trng_call(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_KVM
 extern phys_addr_t hyp_mem_base;
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index cba7872d69a8..17b9f1b29c24 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -27,6 +27,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_spe.h>
 #include <asm/virt.h>
 
 /* Maximum phys_shift supported for any VM on this host */
@@ -189,6 +190,21 @@ static bool vcpu_allowed_register_width(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+static int kvm_vcpu_enable_spe(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_supports_spe())
+		return -EINVAL;
+
+	/*
+	 * The Profiling Buffer is disabled if the owning Exception level is
+	 * aarch32.
+	 */
+	if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_EL1_32BIT))
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * kvm_reset_vcpu - sets core registers and sys_regs to reset value
  * @vcpu: The VCPU pointer
@@ -245,6 +261,13 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
+	if (kvm_vcpu_has_spe(vcpu)) {
+		if (kvm_vcpu_enable_spe(vcpu)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
 	switch (vcpu->arch.target) {
 	default:
 		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
-- 
2.33.0


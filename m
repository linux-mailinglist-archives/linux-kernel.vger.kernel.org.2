Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E46C3F7A35
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242082AbhHYQTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:19:33 -0400
Received: from foss.arm.com ([217.140.110.172]:54928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241214AbhHYQSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1666F143D;
        Wed, 25 Aug 2021 09:18:04 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA8D13F66F;
        Wed, 25 Aug 2021 09:18:02 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 32/39] KVM: arm64: Save/restore PMSNEVFR_EL1 on VCPU put/load
Date:   Wed, 25 Aug 2021 17:18:08 +0100
Message-Id: <20210825161815.266051-33-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FEAT_SPEv1p2 introduced a new register, PMSNEVFR_EL1. The SPE driver is not
using the register, so save the register to the guest context on vcpu_put()
and restore it on vcpu_load() since it will not be touched by the host, and
the value programmed by the guest doesn't affect the host.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/include/asm/kvm_spe.h  |  6 ++++++
 arch/arm64/include/asm/sysreg.h   |  1 +
 arch/arm64/kvm/arm.c              |  2 ++
 arch/arm64/kvm/spe.c              | 29 +++++++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c         |  1 +
 6 files changed, 40 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e704847a7645..66f0b999cb5f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -239,6 +239,7 @@ enum vcpu_sysreg {
 
        /* Statistical Profiling Extension Registers. */
 	PMSCR_EL1,      /* Statistical Profiling Control Register */
+	PMSNEVFR_EL1,   /* Sampling Inverted Event Filter Register */
 	PMSICR_EL1,     /* Sampling Interval Counter Register */
 	PMSIRR_EL1,     /* Sampling Interval Reload Register */
 	PMSFCR_EL1,     /* Sampling Filter Control Register */
diff --git a/arch/arm64/include/asm/kvm_spe.h b/arch/arm64/include/asm/kvm_spe.h
index 934eedb0de46..6b8d4cf2cd37 100644
--- a/arch/arm64/include/asm/kvm_spe.h
+++ b/arch/arm64/include/asm/kvm_spe.h
@@ -28,6 +28,9 @@ int kvm_spe_vcpu_first_run_init(struct kvm_vcpu *vcpu);
 void kvm_spe_write_sysreg(struct kvm_vcpu *vcpu, int reg, u64 val);
 u64 kvm_spe_read_sysreg(struct kvm_vcpu *vcpu, int reg);
 
+void kvm_spe_vcpu_load(struct kvm_vcpu *vcpu);
+void kvm_spe_vcpu_put(struct kvm_vcpu *vcpu);
+
 int kvm_spe_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
 int kvm_spe_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
 int kvm_spe_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
@@ -45,6 +48,9 @@ static inline int kvm_spe_vcpu_first_run_init(struct kvm_vcpu *vcpu) { return -E
 static inline void kvm_spe_write_sysreg(struct kvm_vcpu *vcpu, int reg, u64 val) {}
 static inline u64 kvm_spe_read_sysreg(struct kvm_vcpu *vcpu, int reg) { return 0; }
 
+static inline void kvm_spe_vcpu_load(struct kvm_vcpu *vcpu) {}
+static inline void kvm_spe_vcpu_put(struct kvm_vcpu *vcpu) {}
+
 static inline int kvm_spe_set_attr(struct kvm_vcpu *vcpu,
 				   struct kvm_device_attr *attr)
 {
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index b2d691bc1049..cedab4494a71 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -921,6 +921,7 @@
 
 #define ID_AA64DFR0_PMSVER_8_2		0x1
 #define ID_AA64DFR0_PMSVER_8_3		0x2
+#define ID_AA64DFR0_PMSVER_8_7		0x3
 
 #define ID_DFR0_PERFMON_SHIFT		24
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6af7ef26d2c1..cd64894b286e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -466,6 +466,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (vcpu_has_ptrauth(vcpu))
 		vcpu_ptrauth_disable(vcpu);
 	kvm_arch_vcpu_load_debug_state_flags(vcpu);
+	kvm_spe_vcpu_load(vcpu);
 
 	if (!cpumask_empty(&vcpu->arch.supported_cpus) &&
 	    !cpumask_test_cpu(smp_processor_id(), &vcpu->arch.supported_cpus))
@@ -474,6 +475,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	kvm_spe_vcpu_put(vcpu);
 	kvm_arch_vcpu_put_debug_state_flags(vcpu);
 	kvm_arch_vcpu_put_fp(vcpu);
 	if (has_vhe())
diff --git a/arch/arm64/kvm/spe.c b/arch/arm64/kvm/spe.c
index f760ccd8306a..711736c49f63 100644
--- a/arch/arm64/kvm/spe.c
+++ b/arch/arm64/kvm/spe.c
@@ -67,6 +67,35 @@ u64 kvm_spe_read_sysreg(struct kvm_vcpu *vcpu, int reg)
 	return __vcpu_sys_reg(vcpu, reg);
 }
 
+static unsigned int kvm_spe_get_pmsver(void)
+{
+	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
+
+	return cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_PMSVER_SHIFT);
+}
+
+void kvm_spe_vcpu_load(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_vcpu_has_spe(vcpu))
+		return;
+
+	if (kvm_spe_get_pmsver() < ID_AA64DFR0_PMSVER_8_7)
+		return;
+
+	write_sysreg_s(__vcpu_sys_reg(vcpu, PMSNEVFR_EL1), SYS_PMSNEVFR_EL1);
+}
+
+void kvm_spe_vcpu_put(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_vcpu_has_spe(vcpu))
+		return;
+
+	if (kvm_spe_get_pmsver() < ID_AA64DFR0_PMSVER_8_7)
+		return;
+
+	__vcpu_sys_reg(vcpu, PMSNEVFR_EL1) = read_sysreg_s(SYS_PMSNEVFR_EL1);
+}
+
 static bool kvm_vcpu_supports_spe(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_supports_spe())
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 843822be5695..064742cee425 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1562,6 +1562,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },
 
 	{ SPE_SYS_REG(SYS_PMSCR_EL1), .reg = PMSCR_EL1 },
+	{ SPE_SYS_REG(SYS_PMSNEVFR_EL1), .reg = PMSNEVFR_EL1 },
 	{ SPE_SYS_REG(SYS_PMSICR_EL1), .reg = PMSICR_EL1 },
 	{ SPE_SYS_REG(SYS_PMSIRR_EL1), .reg = PMSIRR_EL1 },
 	{ SPE_SYS_REG(SYS_PMSFCR_EL1), .reg = PMSFCR_EL1 },
-- 
2.33.0


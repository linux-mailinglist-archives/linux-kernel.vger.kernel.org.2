Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEC53F7A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbhHYQTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:19:12 -0400
Received: from foss.arm.com ([217.140.110.172]:54878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241038AbhHYQSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EF94142F;
        Wed, 25 Aug 2021 09:17:54 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20EE23F66F;
        Wed, 25 Aug 2021 09:17:52 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 26/39] KVM: arm64: VHE: Change MDCR_EL2 at world switch if VCPU has SPE
Date:   Wed, 25 Aug 2021 17:18:02 +0100
Message-Id: <20210825161815.266051-27-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a VCPU has the SPE feature, MDCR_EL2 sets the buffer owning regime to
EL1&0. Write the guest's MDCR_EL2 value as late as possible and restore the
host's value as soon as possible at each world switch to make the profiling
blackout window as small as possible for the host.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/kvm_hyp.h   |  2 +-
 arch/arm64/kvm/debug.c             | 14 +++++++++++--
 arch/arm64/kvm/hyp/vhe/switch.c    | 33 +++++++++++++++++++++++-------
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c |  2 +-
 4 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 9d60b3006efc..657d0c94cf82 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -95,7 +95,7 @@ void __sve_restore_state(void *sve_pffr, u32 *fpsr);
 
 #ifndef __KVM_NVHE_HYPERVISOR__
 void activate_traps_vhe_load(struct kvm_vcpu *vcpu);
-void deactivate_traps_vhe_put(void);
+void deactivate_traps_vhe_put(struct kvm_vcpu *vcpu);
 #endif
 
 u64 __guest_enter(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 64e8211366b6..70712cd85f32 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -249,9 +249,19 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
 		vcpu->arch.flags |= KVM_ARM64_DEBUG_DIRTY;
 
 	/* Write mdcr_el2 changes since vcpu_load on VHE systems */
-	if (has_vhe() && orig_mdcr_el2 != vcpu->arch.mdcr_el2)
-		write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
+	if (has_vhe()) {
+		/*
+		 * MDCR_EL2 can modify the SPE buffer owning regime, defer the
+		 * write until the VCPU is run.
+		 */
+		if (kvm_vcpu_has_spe(vcpu))
+			goto out;
+
+		if (orig_mdcr_el2 != vcpu->arch.mdcr_el2)
+			write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
+	}
 
+out:
 	trace_kvm_arm_set_dreg32("MDSCR_EL1", vcpu_read_sys_reg(vcpu, MDSCR_EL1));
 }
 
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 983ba1570d72..ec4e179d56ae 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -31,12 +31,29 @@ DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
 DEFINE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
 DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 
+static void __restore_host_mdcr_el2(struct kvm_vcpu *vcpu)
+{
+	u64 mdcr_el2;
+
+	mdcr_el2 = read_sysreg(mdcr_el2);
+	mdcr_el2 &= MDCR_EL2_HPMN_MASK | MDCR_EL2_TPMS;
+	write_sysreg(mdcr_el2, mdcr_el2);
+}
+
+static void __restore_guest_mdcr_el2(struct kvm_vcpu *vcpu)
+{
+	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
+}
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
 
 	___activate_traps(vcpu);
 
+	if (kvm_vcpu_has_spe(vcpu))
+		__restore_guest_mdcr_el2(vcpu);
+
 	val = read_sysreg(cpacr_el1);
 	val |= CPACR_EL1_TTA;
 	val &= ~CPACR_EL1_ZEN;
@@ -81,7 +98,11 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 	 */
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 
+	if (kvm_vcpu_has_spe(vcpu))
+		__restore_host_mdcr_el2(vcpu);
+
 	write_sysreg(CPACR_EL1_DEFAULT, cpacr_el1);
+
 	write_sysreg(vectors, vbar_el1);
 }
 NOKPROBE_SYMBOL(__deactivate_traps);
@@ -90,16 +111,14 @@ void activate_traps_vhe_load(struct kvm_vcpu *vcpu)
 {
 	__activate_traps_common(vcpu);
 
-	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
+	if (!kvm_vcpu_has_spe(vcpu))
+		__restore_guest_mdcr_el2(vcpu);
 }
 
-void deactivate_traps_vhe_put(void)
+void deactivate_traps_vhe_put(struct kvm_vcpu *vcpu)
 {
-	u64 mdcr_el2 = read_sysreg(mdcr_el2);
-
-	mdcr_el2 &= MDCR_EL2_HPMN_MASK | MDCR_EL2_TPMS;
-
-	write_sysreg(mdcr_el2, mdcr_el2);
+	if (!kvm_vcpu_has_spe(vcpu))
+		__restore_host_mdcr_el2(vcpu);
 
 	__deactivate_traps_common();
 }
diff --git a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
index 2a0b8c88d74f..007a12dd4351 100644
--- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
@@ -101,7 +101,7 @@ void kvm_vcpu_put_sysregs_vhe(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *host_ctxt;
 
 	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
-	deactivate_traps_vhe_put();
+	deactivate_traps_vhe_put(vcpu);
 
 	__sysreg_save_el1_state(guest_ctxt);
 	__sysreg_save_user_state(guest_ctxt);
-- 
2.33.0


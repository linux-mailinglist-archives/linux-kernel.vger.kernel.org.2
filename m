Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5759E35457C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbhDEQnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:43:50 -0400
Received: from foss.arm.com ([217.140.110.172]:55962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242548AbhDEQnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:43:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0025F1042;
        Mon,  5 Apr 2021 09:43:40 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3816C3F694;
        Mon,  5 Apr 2021 09:43:38 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     maz@kernel.org, mathieu.poirier@linaro.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        mike.leach@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, leo.yan@linaro.org, robh@kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 07/20] arm64: kvm: Enable access to TRBE support for host
Date:   Mon,  5 Apr 2021 17:42:54 +0100
Message-Id: <20210405164307.1720226-8-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210405164307.1720226-1-suzuki.poulose@arm.com>
References: <20210405164307.1720226-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a nvhe host, the EL2 must allow the EL1&0 translation
regime for TraceBuffer (MDCR_EL2.E2TB == 0b11). This must
be saved/restored over a trip to the guest. Also, before
entering the guest, we must flush any trace data if the
TRBE was enabled. And we must prohibit the generation
of trace while we are in EL1 by clearing the TRFCR_EL1.

For vhe, the EL2 must prevent the EL1 access to the Trace
Buffer.

The MDCR_EL2 bit definitions for TRBE are available here :

  https://developer.arm.com/documentation/ddi0601/2020-12/AArch64-Registers/

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/el2_setup.h | 13 ++++++++++++
 arch/arm64/include/asm/kvm_arm.h   |  2 ++
 arch/arm64/include/asm/kvm_host.h  |  3 +++
 arch/arm64/kernel/hyp-stub.S       |  3 ++-
 arch/arm64/kvm/debug.c             | 14 ++++++++----
 arch/arm64/kvm/hyp/nvhe/debug-sr.c | 34 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c   |  1 +
 7 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index d77d358f9395..bda918948471 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -65,6 +65,19 @@
 						// use EL1&0 translation.
 
 .Lskip_spe_\@:
+	/* Trace buffer */
+	ubfx	x0, x1, #ID_AA64DFR0_TRBE_SHIFT, #4
+	cbz	x0, .Lskip_trace_\@		// Skip if TraceBuffer is not present
+
+	mrs_s	x0, SYS_TRBIDR_EL1
+	and	x0, x0, TRBIDR_PROG
+	cbnz	x0, .Lskip_trace_\@		// If TRBE is available at EL2
+
+	mov	x0, #(MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT)
+	orr	x2, x2, x0			// allow the EL1&0 translation
+						// to own it.
+
+.Lskip_trace_\@:
 	msr	mdcr_el2, x2			// Configure debug traps
 .endm
 
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 94d4025acc0b..692c9049befa 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -278,6 +278,8 @@
 #define CPTR_EL2_DEFAULT	CPTR_EL2_RES1
 
 /* Hyp Debug Configuration Register bits */
+#define MDCR_EL2_E2TB_MASK	(UL(0x3))
+#define MDCR_EL2_E2TB_SHIFT	(UL(24))
 #define MDCR_EL2_TTRF		(1 << 19)
 #define MDCR_EL2_TPMS		(1 << 14)
 #define MDCR_EL2_E2PB_MASK	(UL(0x3))
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index acc2b45dd433..a61282eb11bc 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -315,6 +315,8 @@ struct kvm_vcpu_arch {
 		struct kvm_guest_debug_arch regs;
 		/* Statistical profiling extension */
 		u64 pmscr_el1;
+		/* Self-hosted trace */
+		u64 trfcr_el1;
 	} host_debug_state;
 
 	/* VGIC state */
@@ -401,6 +403,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_PENDING_EXCEPTION	(1 << 8) /* Exception pending */
 #define KVM_ARM64_EXCEPT_MASK		(7 << 9) /* Target EL/MODE */
 #define KVM_ARM64_DEBUG_STATE_SAVE_SPE	(1 << 12) /* Save SPE context if active  */
+#define KVM_ARM64_DEBUG_STATE_SAVE_TRBE	(1 << 13) /* Save TRBE context if active  */
 
 /*
  * When KVM_ARM64_PENDING_EXCEPTION is set, KVM_ARM64_EXCEPT_MASK can
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 5eccbd62fec8..05d25e645b46 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -115,9 +115,10 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
 	mrs_s	x0, SYS_VBAR_EL12
 	msr	vbar_el1, x0
 
-	// Use EL2 translations for SPE and disable access from EL1
+	// Use EL2 translations for SPE & TRBE and disable access from EL1
 	mrs	x0, mdcr_el2
 	bic	x0, x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
+	bic	x0, x0, #(MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT)
 	msr	mdcr_el2, x0
 
 	// Transfer the MM state from EL1 to EL2
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index b6d2c33ad1df..6f992c696911 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -89,7 +89,7 @@ void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu)
  *  - Debug ROM Address (MDCR_EL2_TDRA)
  *  - OS related registers (MDCR_EL2_TDOSA)
  *  - Statistical profiler (MDCR_EL2_TPMS/MDCR_EL2_E2PB)
- *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
+ *  - Self-hosted Trace (MDCR_EL2_TTRF/MDCR_EL2_E2TB)
  *
  * Additionally, KVM only traps guest accesses to the debug registers if
  * the guest is not actively using them (see the KVM_ARM64_DEBUG_DIRTY
@@ -107,8 +107,8 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
 	trace_kvm_arm_setup_debug(vcpu, vcpu->guest_debug);
 
 	/*
-	 * This also clears MDCR_EL2_E2PB_MASK to disable guest access
-	 * to the profiling buffer.
+	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
+	 * to disable guest access to the profiling and trace buffers
 	 */
 	vcpu->arch.mdcr_el2 = __this_cpu_read(mdcr_el2) & MDCR_EL2_HPMN_MASK;
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
@@ -248,9 +248,15 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
 	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_PMSVER_SHIFT) &&
 	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(SYS_PMBIDR_EL1_P_SHIFT)))
 		vcpu->arch.flags |= KVM_ARM64_DEBUG_STATE_SAVE_SPE;
+
+	/* Check if we have TRBE implemented and available at the host */
+	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_TRBE_SHIFT) &&
+	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_PROG))
+		vcpu->arch.flags |= KVM_ARM64_DEBUG_STATE_SAVE_TRBE;
 }
 
 void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.flags &= ~KVM_ARM64_DEBUG_STATE_SAVE_SPE;
+	vcpu->arch.flags &= ~(KVM_ARM64_DEBUG_STATE_SAVE_SPE |
+			      KVM_ARM64_DEBUG_STATE_SAVE_TRBE);
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index e6ee9b7faec6..7d3f25868cae 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -52,11 +52,43 @@ static void __debug_restore_spe(u64 pmscr_el1)
 	write_sysreg_s(pmscr_el1, SYS_PMSCR_EL1);
 }
 
+static void __debug_save_trace(u64 *trfcr_el1)
+{
+	*trfcr_el1 = 0;
+
+	/* Check if the TRBE is enabled */
+	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_ENABLE))
+		return;
+	/*
+	 * Prohibit trace generation while we are in guest.
+	 * Since access to TRFCR_EL1 is trapped, the guest can't
+	 * modify the filtering set by the host.
+	 */
+	*trfcr_el1 = read_sysreg_s(SYS_TRFCR_EL1);
+	write_sysreg_s(0, SYS_TRFCR_EL1);
+	isb();
+	/* Drain the trace buffer to memory */
+	tsb_csync();
+	dsb(nsh);
+}
+
+static void __debug_restore_trace(u64 trfcr_el1)
+{
+	if (!trfcr_el1)
+		return;
+
+	/* Restore trace filter controls */
+	write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
+}
+
 void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
 	/* Disable and flush SPE data generation */
 	if (vcpu->arch.flags & KVM_ARM64_DEBUG_STATE_SAVE_SPE)
 		__debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
+	/* Disable and flush Self-Hosted Trace generation */
+	if (vcpu->arch.flags & KVM_ARM64_DEBUG_STATE_SAVE_TRBE)
+		__debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
 }
 
 void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
@@ -68,6 +100,8 @@ void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.flags & KVM_ARM64_DEBUG_STATE_SAVE_SPE)
 		__debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
+	if (vcpu->arch.flags & KVM_ARM64_DEBUG_STATE_SAVE_TRBE)
+		__debug_restore_trace(vcpu->arch.host_debug_state.trfcr_el1);
 }
 
 void __debug_switch_to_host(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 68ab6b4d5141..736805232521 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -95,6 +95,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 
 	mdcr_el2 &= MDCR_EL2_HPMN_MASK;
 	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
+	mdcr_el2 |= MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT;
 
 	write_sysreg(mdcr_el2, mdcr_el2);
 	if (is_protected_kvm_enabled())
-- 
2.24.1


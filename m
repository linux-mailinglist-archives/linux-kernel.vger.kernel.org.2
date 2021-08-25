Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FB53F7A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242045AbhHYQTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:19:07 -0400
Received: from foss.arm.com ([217.140.110.172]:54778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240960AbhHYQSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 407B11063;
        Wed, 25 Aug 2021 09:17:51 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6A313F66F;
        Wed, 25 Aug 2021 09:17:49 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 24/39] KVM: arm64: debug: Configure MDCR_EL2 when a VCPU has SPE
Date:   Wed, 25 Aug 2021 17:18:00 +0100
Message-Id: <20210825161815.266051-25-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the guest running at EL1 to use SPE when that feature is enabled for
the VCPU by setting the profiling buffer owning translation regime to EL1&0
and disabling traps to the profiling control registers. Keep trapping
accesses to the buffer control registers because that's needed to emulate
the buffer management interrupt.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h |  1 +
 arch/arm64/kvm/debug.c           | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index d436831dd706..d939da6f54dc 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -285,6 +285,7 @@
 #define MDCR_EL2_TPMS		(1 << 14)
 #define MDCR_EL2_E2PB_MASK	(UL(0x3))
 #define MDCR_EL2_E2PB_SHIFT	(UL(12))
+#define MDCR_EL2_E2PB_EL1_TRAP	(UL(2))
 #define MDCR_EL2_TDRA		(1 << 11)
 #define MDCR_EL2_TDOSA		(1 << 10)
 #define MDCR_EL2_TDA		(1 << 9)
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index d5e79d7ee6e9..64e8211366b6 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -77,24 +77,39 @@ void kvm_arm_init_debug(void)
  *  - Performance monitors (MDCR_EL2_TPM/MDCR_EL2_TPMCR)
  *  - Debug ROM Address (MDCR_EL2_TDRA)
  *  - OS related registers (MDCR_EL2_TDOSA)
- *  - Statistical profiler (MDCR_EL2_TPMS/MDCR_EL2_E2PB)
  *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
  *  - Self-hosted Trace (MDCR_EL2_TTRF/MDCR_EL2_E2TB)
  */
 static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 {
 	/*
-	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
-	 * to disable guest access to the profiling and trace buffers
+	 * This also clears MDCR_EL2_E2TB_MASK to disable guest access to the
+	 * trace buffers.
 	 */
 	vcpu->arch.mdcr_el2 = __this_cpu_read(mdcr_el2) & MDCR_EL2_HPMN_MASK;
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
-				MDCR_EL2_TPMS |
 				MDCR_EL2_TTRF |
 				MDCR_EL2_TPMCR |
 				MDCR_EL2_TDRA |
 				MDCR_EL2_TDOSA);
 
+	if (kvm_supports_spe() && kvm_vcpu_has_spe(vcpu)) {
+		/*
+		 * Use EL1&0 for the profiling buffer translation regime and
+		 * trap accesses to the buffer control registers; leave
+		 * MDCR_EL2.TPMS unset and do not trap accesses to the profiling
+		 * control registers.
+		 */
+		vcpu->arch.mdcr_el2 |= MDCR_EL2_E2PB_EL1_TRAP << MDCR_EL2_E2PB_SHIFT;
+	} else {
+		/*
+		 * Trap accesses to the profiling control registers; leave
+		 * MDCR_EL2.E2PB unset and use the EL2&0 translation regime for
+		 * the profiling buffer.
+		 */
+		vcpu->arch.mdcr_el2 |= MDCR_EL2_TPMS;
+	}
+
 	/* Is the VM being debugged by userspace? */
 	if (vcpu->guest_debug)
 		/* Route all software debug exceptions to EL2 */
-- 
2.33.0


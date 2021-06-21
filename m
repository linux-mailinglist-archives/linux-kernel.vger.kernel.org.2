Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CD73AE80A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFULVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:21:02 -0400
Received: from foss.arm.com ([217.140.110.172]:32868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhFULUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:20:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57D48D6E;
        Mon, 21 Jun 2021 04:18:39 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ACAF3F718;
        Mon, 21 Jun 2021 04:18:36 -0700 (PDT)
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
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v17 4/6] KVM: arm64: Expose KVM_ARM_CAP_MTE
Date:   Mon, 21 Jun 2021 12:17:14 +0100
Message-Id: <20210621111716.37157-5-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210621111716.37157-1-steven.price@arm.com>
References: <20210621111716.37157-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's now safe for the VMM to enable MTE in a guest, so expose the
capability to user space.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/kvm/arm.c      | 9 +++++++++
 arch/arm64/kvm/reset.c    | 4 ++++
 arch/arm64/kvm/sys_regs.c | 3 +++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e720148232a0..28ce26a68f09 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -93,6 +93,12 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		r = 0;
 		kvm->arch.return_nisv_io_abort_to_user = true;
 		break;
+	case KVM_CAP_ARM_MTE:
+		if (!system_supports_mte() || kvm->created_vcpus)
+			return -EINVAL;
+		r = 0;
+		kvm->arch.mte_enabled = true;
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -237,6 +243,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		 */
 		r = 1;
 		break;
+	case KVM_CAP_ARM_MTE:
+		r = system_supports_mte();
+		break;
 	case KVM_CAP_STEAL_TIME:
 		r = kvm_arm_pvtime_supported();
 		break;
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index d37ebee085cf..9e6922b9503a 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -244,6 +244,10 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	switch (vcpu->arch.target) {
 	default:
 		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
+			if (vcpu->kvm->arch.mte_enabled) {
+				ret = -EINVAL;
+				goto out;
+			}
 			pstate = VCPU_RESET_PSTATE_SVC;
 		} else {
 			pstate = VCPU_RESET_PSTATE_EL1;
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 5c75b24eae21..f6f126eb6ac1 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1312,6 +1312,9 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *rd)
 {
+	if (kvm_has_mte(vcpu->kvm))
+		return 0;
+
 	return REG_HIDDEN;
 }
 
-- 
2.20.1


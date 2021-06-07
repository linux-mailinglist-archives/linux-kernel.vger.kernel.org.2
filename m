Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA24239DABB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhFGLKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:10:43 -0400
Received: from foss.arm.com ([217.140.110.172]:58616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231270AbhFGLKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:10:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE75D11D4;
        Mon,  7 Jun 2021 04:08:51 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 906113F73D;
        Mon,  7 Jun 2021 04:08:48 -0700 (PDT)
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
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: [PATCH v14 6/8] KVM: arm64: Expose KVM_ARM_CAP_MTE
Date:   Mon,  7 Jun 2021 12:08:14 +0100
Message-Id: <20210607110816.25762-7-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210607110816.25762-1-steven.price@arm.com>
References: <20210607110816.25762-1-steven.price@arm.com>
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
 arch/arm64/kvm/reset.c    | 3 ++-
 arch/arm64/kvm/sys_regs.c | 3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 1cb39c0803a4..e89a5e275e25 100644
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
index 956cdc240148..50635eacfa43 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -220,7 +220,8 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	switch (vcpu->arch.target) {
 	default:
 		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
-			if (!cpus_have_const_cap(ARM64_HAS_32BIT_EL1)) {
+			if (!cpus_have_const_cap(ARM64_HAS_32BIT_EL1) ||
+			    vcpu->kvm->arch.mte_enabled) {
 				ret = -EINVAL;
 				goto out;
 			}
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 440315a556c2..d4e1c1b1a08d 100644
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5E0362459
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhDPPoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:44:02 -0400
Received: from foss.arm.com ([217.140.110.172]:44598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235412AbhDPPn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:43:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FC3E11B3;
        Fri, 16 Apr 2021 08:43:34 -0700 (PDT)
Received: from e112269-lin.arm.com (autoplooker.cambridge.arm.com [10.1.194.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA85C3F99C;
        Fri, 16 Apr 2021 08:43:31 -0700 (PDT)
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
Subject: [PATCH v11 4/6] arm64: kvm: Expose KVM_ARM_CAP_MTE
Date:   Fri, 16 Apr 2021 16:43:07 +0100
Message-Id: <20210416154309.22129-5-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416154309.22129-1-steven.price@arm.com>
References: <20210416154309.22129-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's now safe for the VMM to enable MTE in a guest, so expose the
capability to user space.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/kvm/arm.c      | 9 +++++++++
 arch/arm64/kvm/sys_regs.c | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index fc4c95dd2d26..46bf319f6cb7 100644
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
@@ -234,6 +240,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		 */
 		r = 1;
 		break;
+	case KVM_CAP_ARM_MTE:
+		r = system_supports_mte();
+		break;
 	case KVM_CAP_STEAL_TIME:
 		r = kvm_arm_pvtime_supported();
 		break;
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 377ae6efb0ef..46937bfaac8a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1306,6 +1306,9 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
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


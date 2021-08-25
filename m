Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C23F7A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbhHYQTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:19:09 -0400
Received: from foss.arm.com ([217.140.110.172]:54870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241165AbhHYQSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1D3513A1;
        Wed, 25 Aug 2021 09:17:52 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84A133F66F;
        Wed, 25 Aug 2021 09:17:51 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 25/39] KVM: arm64: Move the write to MDCR_EL2 out of __activate_traps_common()
Date:   Wed, 25 Aug 2021 17:18:01 +0100
Message-Id: <20210825161815.266051-26-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To run a guest with SPE, MDCR_EL2 must be configured such that the buffer
owning regime is EL1&0. With VHE enabled, the guest runs at EL2 and
changing the owning regime to EL1&0 too early in vcpu_put() would mean
creating an extended blackout window for the host.

Move the MDCR_EL2 write out of __activate_traps_common() to prepare for
executing it later in the run loop in the VHE case. This also makes
__activate_traps_common() look more like __deactivate_traps_common(), which
does not touch the register.

No functional change intended.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 1 -
 arch/arm64/kvm/hyp/nvhe/switch.c        | 2 ++
 arch/arm64/kvm/hyp/vhe/switch.c         | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index e4a2f295a394..5084a54d012e 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -92,7 +92,6 @@ static inline void __activate_traps_common(struct kvm_vcpu *vcpu)
 		write_sysreg(0, pmselr_el0);
 		write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
 	}
-	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
 }
 
 static inline void __deactivate_traps_common(void)
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index f7af9688c1f7..0c70d897a493 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -41,6 +41,8 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 	___activate_traps(vcpu);
 	__activate_traps_common(vcpu);
 
+	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
+
 	val = CPTR_EL2_DEFAULT;
 	val |= CPTR_EL2_TTA | CPTR_EL2_TAM;
 	if (!update_fp_enabled(vcpu)) {
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 86d4c8c33f3e..983ba1570d72 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -89,6 +89,8 @@ NOKPROBE_SYMBOL(__deactivate_traps);
 void activate_traps_vhe_load(struct kvm_vcpu *vcpu)
 {
 	__activate_traps_common(vcpu);
+
+	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
 }
 
 void deactivate_traps_vhe_put(void)
-- 
2.33.0


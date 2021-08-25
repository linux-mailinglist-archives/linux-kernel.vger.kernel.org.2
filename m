Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2233F7A40
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbhHYQUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:20:12 -0400
Received: from foss.arm.com ([217.140.110.172]:54768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241987AbhHYQS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 183DC14BF;
        Wed, 25 Aug 2021 09:18:12 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDAE53F66F;
        Wed, 25 Aug 2021 09:18:10 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 37/39] KVM: arm64: Add PMSIDR_EL1 to the SPE register context
Date:   Wed, 25 Aug 2021 17:18:13 +0100
Message-Id: <20210825161815.266051-38-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMSIDR_EL1 is not part of the VCPU register context because the profiling
control registers were not trapped and the register is read-only. With the
introduction of the KVM_ARM_VCPU_SPE_STOP API, KVM will start trapping
accesses to the profiling control registers, add PMSIDR_EL1 to the VCPU
register context to prevent undefined exceptions in the guest.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/sys_regs.c         | 22 +++++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index cc46f1406196..f866c4556ff9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -247,6 +247,7 @@ enum vcpu_sysreg {
 	PMSFCR_EL1,     /* Sampling Filter Control Register */
 	PMSEVFR_EL1,    /* Sampling Event Filter Register */
 	PMSLATFR_EL1,   /* Sampling Latency Filter Register */
+	PMSIDR_EL1,	/* Sampling Profiling ID Register */
 	PMBLIMITR_EL1,  /* Profiling Buffer Limit Address Register */
 	PMBPTR_EL1,     /* Profiling Buffer Write Pointer Register */
 	PMBSR_EL1,      /* Profiling Buffer Status/syndrome Register */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index cc711b081f31..1a85a0cedbec 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -603,6 +603,18 @@ static unsigned int spe_visibility(const struct kvm_vcpu *vcpu,
 	return REG_HIDDEN;
 }
 
+static void reset_pmsidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	/*
+	 * When SPE is stopped by userspace, the guest reads the in-memory value
+	 * of the register. When SPE is resumed, accesses to the control
+	 * registers are not trapped and the guest reads the hardware
+	 * value. Reset PMSIDR_EL1 to the hardware value to avoid mistmatches
+	 * between the two.
+	 */
+	vcpu_write_sys_reg(vcpu, read_sysreg_s(SYS_PMSIDR_EL1), PMSIDR_EL1);
+}
+
 static bool access_spe_reg(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			   const struct sys_reg_desc *r)
 {	int reg = r->reg;
@@ -613,10 +625,14 @@ static bool access_spe_reg(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 				  *vcpu_pc(vcpu), *vcpu_cpsr(vcpu));
 	}
 
-	if (p->is_write)
+	if (p->is_write) {
+		if (reg == PMSIDR_EL1)
+			return write_to_read_only(vcpu, p, r);
+
 		kvm_spe_write_sysreg(vcpu, reg, val);
-	else
+	} else {
 		p->regval = kvm_spe_read_sysreg(vcpu, reg);
+	}
 
 	return true;
 }
@@ -1568,7 +1584,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SPE_SYS_REG(SYS_PMSFCR_EL1), .reg = PMSFCR_EL1 },
 	{ SPE_SYS_REG(SYS_PMSEVFR_EL1), .reg = PMSEVFR_EL1 },
 	{ SPE_SYS_REG(SYS_PMSLATFR_EL1), .reg = PMSLATFR_EL1 },
-	{ SPE_SYS_REG(SYS_PMSIDR_EL1), .reset = NULL },
+	{ SPE_SYS_REG(SYS_PMSIDR_EL1), .reset = reset_pmsidr, .reg = PMSIDR_EL1 },
 	{ SPE_SYS_REG(SYS_PMBLIMITR_EL1), .reg = PMBLIMITR_EL1 },
 	{ SPE_SYS_REG(SYS_PMBPTR_EL1), .reg = PMBPTR_EL1 },
 	{ SPE_SYS_REG(SYS_PMBSR_EL1), .reg = PMBSR_EL1 },
-- 
2.33.0


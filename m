Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370673758C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhEFQzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:55:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17591 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhEFQzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:55:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FbfkT4f4Vz1BHvj;
        Fri,  7 May 2021 00:52:01 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.85.115) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 00:54:27 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <linuxarm@huawei.com>
Subject: [RFC PATCH 1/3] arch/arm64: Introduce a capability to tell whether 16-bit VMID is available
Date:   Thu, 6 May 2021 17:52:30 +0100
Message-ID: <20210506165232.1969-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210506165232.1969-1-shameerali.kolothum.thodi@huawei.com>
References: <20210506165232.1969-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.85.115]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Grall <julien.grall@arm.com>

At the moment, the function kvm_get_vmid_bits() is looking up for the
sanitized value of ID_AA64MMFR1_EL1 and extract the information
regarding the number of VMID bits supported.

This is fine as the function is mainly used during VMID roll-over. New
use in a follow-up patch will require the function to be called a every
context switch so we want the function to be more efficient.

A new capability is introduced to tell whether 16-bit VMID is
available.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/include/asm/cpucaps.h | 3 ++-
 arch/arm64/include/asm/kvm_mmu.h | 4 +---
 arch/arm64/kernel/cpufeature.c   | 9 +++++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index c40f2490cd7b..acb92da5c254 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -67,7 +67,8 @@
 #define ARM64_HAS_LDAPR				59
 #define ARM64_KVM_PROTECTED_MODE		60
 #define ARM64_WORKAROUND_NVIDIA_CARMEL_CNP	61
+#define ARM64_HAS_16BIT_VMID			62
 
-#define ARM64_NCAPS				62
+#define ARM64_NCAPS				63
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 90873851f677..c3080966ef83 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -213,9 +213,7 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled);
 
 static inline unsigned int kvm_get_vmid_bits(void)
 {
-	int reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
-
-	return get_vmid_bits(reg);
+	return cpus_have_const_cap(ARM64_HAS_16BIT_VMID) ? 16 : 8;
 }
 
 /*
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e5281e1c8f1d..ff956fb2f712 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2203,6 +2203,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.min_field_value = 1,
 	},
+	{
+		.capability = ARM64_HAS_16BIT_VMID,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.sys_reg = SYS_ID_AA64MMFR1_EL1,
+		.field_pos = ID_AA64MMFR1_VMIDBITS_SHIFT,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = ID_AA64MMFR1_VMIDBITS_16,
+		.matches = has_cpuid_feature,
+	},
 	{},
 };
 
-- 
2.17.1


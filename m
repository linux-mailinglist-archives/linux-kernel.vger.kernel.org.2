Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8270E3AA098
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhFPQAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:00:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3253 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbhFPP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:59:26 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G4qMF2gQ0z6K6RF;
        Wed, 16 Jun 2021 23:47:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 16 Jun 2021 17:57:18 +0200
Received: from A2006125610.china.huawei.com (10.47.83.191) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 16:57:11 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <Alexandru.Elisei@arm.com>, <linuxarm@huawei.com>
Subject: [PATCH v2 1/3] arch/arm64: Introduce a capability to tell whether 16-bit VMID is available
Date:   Wed, 16 Jun 2021 16:56:04 +0100
Message-ID: <20210616155606.2806-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
References: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.83.191]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
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
 arch/arm64/include/asm/kvm_mmu.h | 4 +---
 arch/arm64/kernel/cpufeature.c   | 9 +++++++++
 arch/arm64/tools/cpucaps         | 1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 25ed956f9af1..2abdea7dcb43 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -223,9 +223,7 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled);
 
 static inline unsigned int kvm_get_vmid_bits(void)
 {
-	int reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
-
-	return get_vmid_bits(reg);
+	return cpus_have_const_cap(ARM64_HAS_16BIT_VMID) ? 16 : 8;
 }
 
 /*
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index efed2830d141..0642ebe118b0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2218,6 +2218,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
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
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 21fbdda7086e..456b4cf1ba27 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -3,6 +3,7 @@
 # Internal CPU capabilities constants, keep this list sorted
 
 BTI
+HAS_16BIT_VMID
 HAS_32BIT_EL0
 HAS_32BIT_EL1
 HAS_ADDRESS_AUTH
-- 
2.17.1


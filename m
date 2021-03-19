Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7A034194F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCSKCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCSKCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C4EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k189so12663518ybb.17
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HQLvqkzQDnETn9PekW0bc3q8GhHOMLkRmjnMVMoijk4=;
        b=TWjfu8Ch1LR7kLuqkT3fj4DYZrQ109ThSSKFMpSDW4DeIuRlc/hfgOQucJ+FbNNSvy
         RqzbPmRFD4szdz5pRx6xPcS1PRk5vRnvVgyQlS/Z8Hd1JubQVrpSpTFtGqlG5FqMxHP5
         rrmdH2HFjflY5nJwppDo+AOkjYlHL0NtX+3PQ3v/bOLuZLMuxWKkwX54/IXomG9ZV1ZO
         vghn6OxgNmqx4HNc3eY6bCqXtKU4RbHpURpBLjz2VzwaNaGN7j4yG5n1YRE0XQXoaEf8
         Ti/mY3flc876xB7zuDSLwZjMUnHTFkrd4vqZMQM2qTc8j3Zpv4DlaH4VY0+KKlnisTN2
         Ny8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HQLvqkzQDnETn9PekW0bc3q8GhHOMLkRmjnMVMoijk4=;
        b=DWid9ZEzBjJDvc3XqT/syy/UU+Rg7WrwaAN+YyUePBmUFGwDj1VuKuncltEVcjv1IZ
         fZN+xdpuxwp6dDV3N0XYKpdGk/uoxKaLaXySMXyeObwYKsf64bnxieu81dOgS5qixgYV
         DpQjp5nBagrpcXkMTqNduW4U6yKkXuUf2tidP4//p60rPq8SWTEakKmKtrOXPA+FQaH4
         nAkPUXf8ecnaqfTfz68cb1fTGz//vGioPrklCL21mHjDDpWgUJJVDo+CyTWaqpFAfQnz
         XLkhh7+cV2JS3nGPQ2a1KelQy7bxvYdeRSraBQ5rZ/aifHyIUH5aEbQ9N7boxvLWkTBy
         7q3g==
X-Gm-Message-State: AOAM531FgFzNW5E0U10Z5UBdvDtWY+H7YpL8wZdVXg1yZBUtchATUCg7
        tDmDogW5MF8KenqCGlGTMyRoUyae6Pye
X-Google-Smtp-Source: ABdhPJxfBQDz/PxQeXfXU8hq0IS4w7K1P0f2IcFdLU5MHSdevDTfJOdc/mnNj00CZd8QR/Ym3ntzEYaL89sb
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a25:9247:: with SMTP id
 e7mr5048548ybo.10.1616148137509; Fri, 19 Mar 2021 03:02:17 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:21 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-14-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 13/38] KVM: arm64: Enable access to sanitized CPU features
 at EL2
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the infrastructure in KVM enabling to copy CPU feature
registers into EL2-owned data-structures, to allow reading sanitised
values directly at EL2 in nVHE.

Given that only a subset of these features are being read by the
hypervisor, the ones that need to be copied are to be listed under
<asm/kvm_cpufeature.h> together with the name of the nVHE variable that
will hold the copy. This introduces only the infrastructure enabling
this copy. The first users will follow shortly.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/cpufeature.h     |  1 +
 arch/arm64/include/asm/kvm_cpufeature.h | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h       |  4 ++++
 arch/arm64/kernel/cpufeature.c          | 13 +++++++++++++
 arch/arm64/kvm/sys_regs.c               | 19 +++++++++++++++++++
 5 files changed, 59 insertions(+)
 create mode 100644 arch/arm64/include/asm/kvm_cpufeature.h

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 61177bac49fa..a85cea2cac57 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -607,6 +607,7 @@ void check_local_cpu_capabilities(void);
 
 u64 read_sanitised_ftr_reg(u32 id);
 u64 __read_sysreg_by_encoding(u32 sys_id);
+int copy_ftr_reg(u32 id, struct arm64_ftr_reg *dst);
 
 static inline bool cpu_supports_mixed_endian_el0(void)
 {
diff --git a/arch/arm64/include/asm/kvm_cpufeature.h b/arch/arm64/include/asm/kvm_cpufeature.h
new file mode 100644
index 000000000000..3d245f96a9fe
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_cpufeature.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 - Google LLC
+ * Author: Quentin Perret <qperret@google.com>
+ */
+
+#ifndef __ARM64_KVM_CPUFEATURE_H__
+#define __ARM64_KVM_CPUFEATURE_H__
+
+#include <asm/cpufeature.h>
+
+#include <linux/build_bug.h>
+
+#if defined(__KVM_NVHE_HYPERVISOR__)
+#define DECLARE_KVM_HYP_CPU_FTR_REG(name) extern struct arm64_ftr_reg name
+#define DEFINE_KVM_HYP_CPU_FTR_REG(name) struct arm64_ftr_reg name
+#else
+#define DECLARE_KVM_HYP_CPU_FTR_REG(name) extern struct arm64_ftr_reg kvm_nvhe_sym(name)
+#define DEFINE_KVM_HYP_CPU_FTR_REG(name) BUILD_BUG()
+#endif
+
+#endif
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 6a2031af9562..02e172dc5087 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -740,9 +740,13 @@ void kvm_clr_pmu_events(u32 clr);
 
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
+
+void setup_kvm_el2_caps(void);
 #else
 static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
 static inline void kvm_clr_pmu_events(u32 clr) {}
+
+static inline void setup_kvm_el2_caps(void) {}
 #endif
 
 void kvm_vcpu_load_sysregs_vhe(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 066030717a4c..6252476e4e73 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1154,6 +1154,18 @@ u64 read_sanitised_ftr_reg(u32 id)
 }
 EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
 
+int copy_ftr_reg(u32 id, struct arm64_ftr_reg *dst)
+{
+	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(id);
+
+	if (!regp)
+		return -EINVAL;
+
+	*dst = *regp;
+
+	return 0;
+}
+
 #define read_sysreg_case(r)	\
 	case r:		val = read_sysreg_s(r); break;
 
@@ -2773,6 +2785,7 @@ void __init setup_cpu_features(void)
 
 	setup_system_capabilities();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
+	setup_kvm_el2_caps();
 
 	if (system_supports_32bit_el0())
 		setup_elf_hwcaps(compat_elf_hwcaps);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4f2f1e3145de..6c5d133689ae 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -21,6 +21,7 @@
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
 #include <asm/kvm_arm.h>
+#include <asm/kvm_cpufeature.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
@@ -2775,3 +2776,21 @@ void kvm_sys_reg_table_init(void)
 	/* Clear all higher bits. */
 	cache_levels &= (1 << (i*3))-1;
 }
+
+#define CPU_FTR_REG_HYP_COPY(id, name) \
+	{ .sys_id = id, .dst = (struct arm64_ftr_reg *)&kvm_nvhe_sym(name) }
+struct __ftr_reg_copy_entry {
+	u32			sys_id;
+	struct arm64_ftr_reg	*dst;
+} hyp_ftr_regs[] __initdata = {
+};
+
+void __init setup_kvm_el2_caps(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hyp_ftr_regs); i++) {
+		WARN(copy_ftr_reg(hyp_ftr_regs[i].sys_id, hyp_ftr_regs[i].dst),
+		     "%u feature register not found\n", hyp_ftr_regs[i].sys_id);
+	}
+}
-- 
2.31.0.rc2.261.g7f71774620-goog


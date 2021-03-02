Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B576332A886
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241873AbhCBRjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384535AbhCBPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:19 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C59FC0698C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:37 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id v13so10264534wrs.21
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Nj4Lfx4RBIkW7BkT83ganNaPcX2b1UPE5UuHOUQIP/k=;
        b=tmr1KtLaO4/NP9tlla1YXcoWiHt6S/lyYGmlGgJ0Zr5eKBoywZKo2fFE09qqkxGgE+
         +699HOE+XAFcrR4AIYIZbOQfv9aFekmPN6fd1G1UiOcjzq5yVvyjR/NzqaVfFFisI9d5
         MOaOrIWVXy4K8JbLSQ5IRbi6sMMtMohkuOewhMFCG0uggzp1b38bUpp3QU6nRnv9g9cN
         CQf9B18zjiwgYCJ75IFtxXykGgPP9io4KwYSTZ7g2zRXI+IlUDXKMqZDAJEWA41VeXl9
         UPdWjbh0T/ghx5K4u/p1SX2ZDllUuthzTnBO0A5+543kn1/J7ZhuiVyqHTME1tmkE06i
         CSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nj4Lfx4RBIkW7BkT83ganNaPcX2b1UPE5UuHOUQIP/k=;
        b=pLy4q8vV62MbpWf9Xck6gx8jLg2N2eKV5TwNWOZi4YGFDwA4JpGvjHbGPCq3VVvCHE
         0YGCZs4af2VL45kcIRkkPTBHDcgSDrFP0RbAtrJLwJGBV5wX+nH2V8f1rzYpGYch+P9o
         YkPz3bj3nYjoBo/bBi8bBP3N/dg1EYerXBj9jtzATRW2o/i7xSbRRbk/Hm3psZkrM2Dm
         y8vzfU7BpU14tuq+rbHbdcSNviLA8u92z1c5JTR51VLoUI8sb5AKd3q9T+3pSwJOQTX8
         CwczB1TPzm1Tt5neudeLHMqhhDUc6tezE6Inx4ZIIPOZNtGp7sOHc66piR9MsuXBL9Fr
         QIVg==
X-Gm-Message-State: AOAM531JGkiMrfsqVwGxfIv8KE8jLR6ZeExmk9JDUdYPytJYOkGLBsN5
        WbV0thlfZ0q74B+OBvx1whwAbV1ejqJ/
X-Google-Smtp-Source: ABdhPJwvpQIv+znxityhogRj6zoOeSFEDLfbBBRns10dBwlnGJToVJKnQCrYhTdzCU5GSNUlw+0Kk2km+ios
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a5d:43cc:: with SMTP id
 v12mr14983560wrr.287.1614697235745; Tue, 02 Mar 2021 07:00:35 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:43 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-14-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 13/32] KVM: arm64: Enable access to sanitized CPU features
 at EL2
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
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
will hold the copy.

While at it, introduce the first user of this infrastructure by
implementing __flush_dcache_area at EL2, which needs
arm64_ftr_reg_ctrel0.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/cpufeature.h     |  1 +
 arch/arm64/include/asm/kvm_cpufeature.h | 17 +++++++++++++++++
 arch/arm64/include/asm/kvm_host.h       |  4 ++++
 arch/arm64/kernel/cpufeature.c          | 13 +++++++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile        |  3 ++-
 arch/arm64/kvm/hyp/nvhe/cache.S         | 13 +++++++++++++
 arch/arm64/kvm/hyp/nvhe/cpufeature.c    |  8 ++++++++
 arch/arm64/kvm/sys_regs.c               | 21 +++++++++++++++++++++
 8 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/kvm_cpufeature.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/cache.S
 create mode 100644 arch/arm64/kvm/hyp/nvhe/cpufeature.c

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
index 000000000000..d34f85cba358
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_cpufeature.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 - Google LLC
+ * Author: Quentin Perret <qperret@google.com>
+ */
+
+#include <asm/cpufeature.h>
+
+#ifndef KVM_HYP_CPU_FTR_REG
+#if defined(__KVM_NVHE_HYPERVISOR__)
+#define KVM_HYP_CPU_FTR_REG(id, name) extern struct arm64_ftr_reg name;
+#else
+#define KVM_HYP_CPU_FTR_REG(id, name) DECLARE_KVM_NVHE_SYM(name);
+#endif
+#endif
+
+KVM_HYP_CPU_FTR_REG(SYS_CTR_EL0, arm64_ftr_reg_ctrel0)
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 06ca4828005f..459ee557f87c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -751,9 +751,13 @@ void kvm_clr_pmu_events(u32 clr);
 
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
index 066030717a4c..f2d8b479ff74 100644
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
+	memcpy(dst, regp, sizeof(*regp));
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
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 6894a917f290..0033591553fc 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -13,7 +13,8 @@ lib-objs := clear_page.o copy_page.o memcpy.o memset.o
 lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
-	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o
+	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o \
+	 cache.o cpufeature.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o
 obj-y += $(lib-objs)
diff --git a/arch/arm64/kvm/hyp/nvhe/cache.S b/arch/arm64/kvm/hyp/nvhe/cache.S
new file mode 100644
index 000000000000..36cef6915428
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/cache.S
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Code copied from arch/arm64/mm/cache.S.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/alternative.h>
+
+SYM_FUNC_START_PI(__flush_dcache_area)
+	dcache_by_line_op civac, sy, x0, x1, x2, x3
+	ret
+SYM_FUNC_END_PI(__flush_dcache_area)
diff --git a/arch/arm64/kvm/hyp/nvhe/cpufeature.c b/arch/arm64/kvm/hyp/nvhe/cpufeature.c
new file mode 100644
index 000000000000..a887508f996f
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/cpufeature.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 - Google LLC
+ * Author: Quentin Perret <qperret@google.com>
+ */
+
+#define KVM_HYP_CPU_FTR_REG(id, name) struct arm64_ftr_reg name;
+#include <asm/kvm_cpufeature.h>
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4f2f1e3145de..84be93df52fa 100644
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
@@ -2775,3 +2776,23 @@ void kvm_sys_reg_table_init(void)
 	/* Clear all higher bits. */
 	cache_levels &= (1 << (i*3))-1;
 }
+
+#undef KVM_HYP_CPU_FTR_REG
+#define KVM_HYP_CPU_FTR_REG(id, name) \
+	{ .sys_id = id, .dst = (struct arm64_ftr_reg *)&kvm_nvhe_sym(name) },
+struct __ftr_reg_copy_entry {
+	u32			sys_id;
+	struct arm64_ftr_reg	*dst;
+} hyp_ftr_regs[] __initdata = {
+	#include <asm/kvm_cpufeature.h>
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
2.30.1.766.gb4fecdf3b7-goog


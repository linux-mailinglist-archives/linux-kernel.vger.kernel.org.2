Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36FA33BEED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbhCOOvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbhCOOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:21 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F7C0613DE
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:08 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id g5so15119579wrd.22
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ejSdEmSBdNi/kfV0DlBlHDLEv8YzLctWMTd9qBGfPIg=;
        b=qEehBrxjiyhBSRtd8i/vGt1Gi32mIQYCC2vHMVk27tVrjawfQ9TbwezlkftTJwFim3
         U1ZaO+/raxpNYPHOkD4SygGQcOtHnHflsSUlziHs4bX+drcZ2rxeN5l2rJ8ZQYvP6mYy
         2xK84YTg1wtxjBbY81Jk9PlrBz3mlf5ruaEvQi5DiHu9Wvt3G/a8TXNUtIb5hQ87AJNc
         cquCcwWv3x2NWW6em9HCHDRH+UBDEIkDcnDRcPzBgiYdHPfis4LeKRgQc9PV+mXGC+l8
         SNtJ1ixEUqGt8IjH6LUQadlIk1OHtuZB3PUdXVJ81TWEWTQ0WeljpQw0T+hCrIBURzPN
         FiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ejSdEmSBdNi/kfV0DlBlHDLEv8YzLctWMTd9qBGfPIg=;
        b=Be6vijp+1oJgduRB/yBFUnmlYSD4FuL5Th+ykw9+t3NvRgheVeIRy5jZ9i7Eaa84dq
         E74FlSyGOQHqnRDIceekzbEp/PNByO0UWsAA+yAXCAkWEizlx8LDFRwX3bcMyBh9w5/t
         mM78YNprkrbY6qNCxQsMTKhDCrL8VFQMCR+L/o8sqCYUAWYbwem/JGhMYne5yVhEEo0Z
         9qUQJedobqyUPSeey4t/6nixR+N4LGKRMqadaQEzwFNYDlMs8lh2SON7u2DN/uT58/CQ
         41o5eYKWMneTSo5fySIwpkn70OTkTglGHQiiZNrw9t1mauYVnD4i5jAY1cFhnpScgRCI
         KlSw==
X-Gm-Message-State: AOAM531wg4u0jf+eM2aroZ9LaviaRp8Ra5PRM6/3AdOm1/JlsA3SpPc9
        FuTTf1rS4HKFmTJ1Css4v6tUDiuxJli8
X-Google-Smtp-Source: ABdhPJxki5tSObCjbZC0GBDxqOcKFaarc27zP1fE/bMGCrDiEJBzlGPqx8PF3XxaOEPF+eYlbWRCqwThKFDL
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a5d:54c4:: with SMTP id
 x4mr27426272wrv.329.1615818967562; Mon, 15 Mar 2021 07:36:07 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:13 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-14-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 13/36] KVM: arm64: Enable access to sanitized CPU features
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
 arch/arm64/include/asm/kvm_cpufeature.h | 15 +++++++++++++++
 arch/arm64/include/asm/kvm_host.h       |  4 ++++
 arch/arm64/kernel/cpufeature.c          | 13 +++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c       |  7 +++++++
 arch/arm64/kvm/sys_regs.c               | 19 +++++++++++++++++++
 6 files changed, 59 insertions(+)
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
index 000000000000..3fd9f60d2180
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_cpufeature.h
@@ -0,0 +1,15 @@
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
+#define KVM_HYP_CPU_FTR_REG(name) extern struct arm64_ftr_reg name
+#else
+#define KVM_HYP_CPU_FTR_REG(name) extern struct arm64_ftr_reg kvm_nvhe_sym(name)
+#endif
+#endif
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
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
index 879559057dee..cc829b9db0da 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
@@ -38,3 +38,10 @@ unsigned long __hyp_per_cpu_offset(unsigned int cpu)
 	elf_base = (unsigned long)&__per_cpu_start;
 	return this_cpu_base - elf_base;
 }
+
+/*
+ * Define the CPU feature registers variables that will hold the copies of
+ * the host's sanitized values.
+ */
+#define KVM_HYP_CPU_FTR_REG(name) struct arm64_ftr_reg name
+#include <asm/kvm_cpufeature.h>
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


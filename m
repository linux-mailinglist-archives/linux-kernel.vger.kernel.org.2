Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A8B3C1E82
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 06:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhGIEka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 00:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhGIEk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 00:40:28 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9223BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 21:37:44 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h4so8719648pgp.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 21:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ETT27YTe1Df1R34anpclNh/mV2vuSiYHLPmA2jkljAE=;
        b=dmlECuSGzQyT5BPgzoazb9gJYXKcWH37icvNOgZw3JI5O2XU1fCzPX6W+JxiavMd5Y
         scIVQeiaRcZ1l5KpD5zrGJ+/WAobQlvoW4/EiobILmMS+XW8TD2yOCS+Kijs4IGU+OiX
         HH1Dnh7r/BPjoIvuPN/qVdzlL2Go2M62+fnlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETT27YTe1Df1R34anpclNh/mV2vuSiYHLPmA2jkljAE=;
        b=fuJfhL+ziZGN/HCwYJJRjBHFzVpXfxU/uWXhVMNdanI8CMBoab/oK5XBMO2fH0IGq3
         09DlfGawddOLdeCtDUHkWOladKIwfoU5mVxP95sd/xm/AXv2AzX7Pg1YZIuPeweCpVth
         3rwu0c+8q6xMU1IjSAKQD9f4xtynZiYD5O0pl0qqEdoty9m+R5Qu5E9ZGm2EKOCummjh
         V3Kk58pNnf/xe8jdfVjFLtDEKfbcUZMveCN6zciNYvH5id+PJKtz79XQuEcNXl0lxIMS
         HUuvuro95s7xIn6dRLy6ZUpsc93ylLwQBBJZ6rPtLXGQK5LLwloEMHx+ylYD6K3CMVZ1
         ptAQ==
X-Gm-Message-State: AOAM530msWc3VKl2SGXC8GaUgiOKt5dskcCeKsiGCYs+bTfckmMQz157
        J9wchnV4Cw2Vzxr7xF9snzFXiQ==
X-Google-Smtp-Source: ABdhPJyUpwfKVXdRnNKLdaV06jZZYOCtJWZE+pQ7Yig5Okf20u5ZB19Pmb0K+S0mixoNDsX0ipuwgg==
X-Received: by 2002:a63:1226:: with SMTP id h38mr35402819pgl.376.1625805464184;
        Thu, 08 Jul 2021 21:37:44 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:a30d:fc4:7834:ee08])
        by smtp.gmail.com with ESMTPSA id y4sm4420760pfa.14.2021.07.08.21.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 21:37:43 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Suleiman Souhlal <suleiman@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 4/4] arm64: add host pv-vcpu-state support
Date:   Fri,  9 Jul 2021 13:37:13 +0900
Message-Id: <20210709043713.887098-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210709043713.887098-1-senozhatsky@chromium.org>
References: <20210709043713.887098-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PV-vcpu-state support bits to the host. Host uses the guest
PV-state per-CPU pointers to update the VCPU state each time
it kvm_arch_vcpu_load() or kvm_arch_vcpu_put() the VCPU, so
that guest scheduler can become aware of the fact that not
all VCPUs are always available. Currently guest scheduler
on amr64 always assumes that all CPUs are available because
vcpu_is_preempted() is not implemented on arm64.

- schbench -t 3 -m 3 -p 4096

  Latency percentiles (usec)
        BASE
================================================
        50.0th: 1 (3556427 samples)
        75.0th: 13 (879210 samples)
        90.0th: 15 (893311 samples)
        95.0th: 18 (159594 samples)
        *99.0th: 118 (224187 samples)
        99.5th: 691 (28555 samples)
        99.9th: 7384 (23076 samples)
        min=1, max=104218
avg worker transfer: 25192.00 ops/sec 98.41MB/s

        PATCHED
================================================
        50.0th: 1 (3507010 samples)
        75.0th: 13 (1635775 samples)
        90.0th: 16 (901271 samples)
        95.0th: 24 (281051 samples)
        *99.0th: 114 (255581 samples)
        99.5th: 382 (33051 samples)
        99.9th: 6392 (26592 samples)
        min=1, max=83877
avg worker transfer: 28613.39 ops/sec 111.77MB/s

- perf bench sched all

  ops/sec
        BASE                 PATCHED
================================================
        33452		     36485
        33541		     39405
        33365		     36858
        33455		     38047
        33449		     37866
        33616		     34922
        33479		     34388
        33594		     37203
        33458		     35363
        33704		     35180

Student's T-test

         N           Min           Max        Median           Avg        Stddev
base     10         33365         33704         33479       33511.3     100.92467
patched  10         34388         39405         36858       36571.7      1607.454
Difference at 95.0% confidence
	3060.4 +/- 1070.09
	9.13244% +/- 3.19321%
	(Student's t, pooled s = 1138.88)

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 arch/arm64/include/asm/kvm_host.h | 23 +++++++++++
 arch/arm64/kvm/Makefile           |  3 +-
 arch/arm64/kvm/arm.c              |  3 ++
 arch/arm64/kvm/hypercalls.c       | 11 ++++++
 arch/arm64/kvm/pv-vcpu-state.c    | 64 +++++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/pv-vcpu-state.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 41911585ae0c..e782f4d0c916 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -381,6 +381,12 @@ struct kvm_vcpu_arch {
 		u64 last_steal;
 		gpa_t base;
 	} steal;
+
+	/* PV state of the VCPU */
+	struct {
+		gpa_t base;
+		struct gfn_to_hva_cache ghc;
+	} vcpu_state;
 };
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
@@ -695,6 +701,23 @@ static inline bool kvm_arm_is_pvtime_enabled(struct kvm_vcpu_arch *vcpu_arch)
 	return (vcpu_arch->steal.base != GPA_INVALID);
 }
 
+int kvm_init_vcpu_state(struct kvm_vcpu *vcpu, gfn_t addr);
+int kvm_release_vcpu_state(struct kvm_vcpu *vcpu);
+
+static inline void kvm_arm_vcpu_state_init(struct kvm_vcpu_arch *vcpu_arch)
+{
+	vcpu_arch->vcpu_state.base = GPA_INVALID;
+	memset(&vcpu_arch->vcpu_state.ghc, 0, sizeof(struct gfn_to_hva_cache));
+}
+
+static inline bool
+kvm_arm_is_vcpu_state_enabled(struct kvm_vcpu_arch *vcpu_arch)
+{
+	return (vcpu_arch->vcpu_state.base != GPA_INVALID);
+}
+
+void kvm_update_vcpu_preempted(struct kvm_vcpu *vcpu, bool preempted);
+
 void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 989bb5dad2c8..2a3ee82c6d90 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -12,7 +12,8 @@ obj-$(CONFIG_KVM) += hyp/
 
 kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 $(KVM)/vfio.o $(KVM)/irqchip.o $(KVM)/binary_stats.o \
-	 arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
+	 arm.o mmu.o mmio.o psci.o perf.o hypercalls.o \
+	 pvtime.o pv-vcpu-state.o \
 	 inject_fault.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o \
 	 vgic-sys-reg-v3.o fpsimd.o pmu.o \
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e9a2b8f27792..43e995c9fddb 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -332,6 +332,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	kvm_arm_reset_debug_ptr(vcpu);
 
 	kvm_arm_pvtime_vcpu_init(&vcpu->arch);
+	kvm_arm_vcpu_state_init(&vcpu->arch);
 
 	vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
 
@@ -429,10 +430,12 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (vcpu_has_ptrauth(vcpu))
 		vcpu_ptrauth_disable(vcpu);
 	kvm_arch_vcpu_load_debug_state_flags(vcpu);
+	kvm_update_vcpu_preempted(vcpu, false);
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	kvm_update_vcpu_preempted(vcpu, true);
 	kvm_arch_vcpu_put_debug_state_flags(vcpu);
 	kvm_arch_vcpu_put_fp(vcpu);
 	if (has_vhe())
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 30da78f72b3b..95bcf86e0b6f 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -110,6 +110,9 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		case ARM_SMCCC_HV_PV_TIME_FEATURES:
 			val[0] = SMCCC_RET_SUCCESS;
 			break;
+		case ARM_SMCCC_HV_PV_VCPU_STATE_FEATURES:
+			val[0] = SMCCC_RET_SUCCESS;
+			break;
 		}
 		break;
 	case ARM_SMCCC_HV_PV_TIME_FEATURES:
@@ -139,6 +142,14 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 	case ARM_SMCCC_TRNG_RND32:
 	case ARM_SMCCC_TRNG_RND64:
 		return kvm_trng_call(vcpu);
+	case ARM_SMCCC_HV_PV_VCPU_STATE_INIT:
+		if (kvm_init_vcpu_state(vcpu, smccc_get_arg1(vcpu)) == 0)
+			val[0] = SMCCC_RET_SUCCESS;
+		break;
+	case ARM_SMCCC_HV_PV_VCPU_STATE_RELEASE:
+		if (kvm_release_vcpu_state(vcpu) == 0)
+			val[0] = SMCCC_RET_SUCCESS;
+		break;
 	default:
 		return kvm_psci_call(vcpu);
 	}
diff --git a/arch/arm64/kvm/pv-vcpu-state.c b/arch/arm64/kvm/pv-vcpu-state.c
new file mode 100644
index 000000000000..8496bb2a5966
--- /dev/null
+++ b/arch/arm64/kvm/pv-vcpu-state.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/arm-smccc.h>
+#include <linux/kvm_host.h>
+
+#include <asm/kvm_mmu.h>
+#include <asm/paravirt.h>
+
+#include <kvm/arm_psci.h>
+
+int kvm_init_vcpu_state(struct kvm_vcpu *vcpu, gpa_t addr)
+{
+	struct kvm *kvm = vcpu->kvm;
+	int ret;
+	u64 idx;
+
+	if (kvm_arm_is_vcpu_state_enabled(&vcpu->arch))
+		return 0;
+
+	idx = srcu_read_lock(&kvm->srcu);
+	ret = kvm_gfn_to_hva_cache_init(vcpu->kvm,
+					&vcpu->arch.vcpu_state.ghc,
+					addr,
+					sizeof(struct vcpu_state));
+	srcu_read_unlock(&kvm->srcu, idx);
+
+	if (!ret)
+		vcpu->arch.vcpu_state.base = addr;
+	return ret;
+}
+
+int kvm_release_vcpu_state(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_arm_is_vcpu_state_enabled(&vcpu->arch))
+		return 0;
+
+	kvm_arm_vcpu_state_init(&vcpu->arch);
+	return 0;
+}
+
+void kvm_update_vcpu_preempted(struct kvm_vcpu *vcpu, bool preempted)
+{
+	struct kvm *kvm = vcpu->kvm;
+	u64 idx;
+
+	if (!kvm_arm_is_vcpu_state_enabled(&vcpu->arch))
+		return;
+
+	/*
+	 * This function is called from atomic context, so we need to
+	 * disable page faults. kvm_write_guest_cached() will call
+	 * might_fault().
+	 */
+	pagefault_disable();
+	/*
+	 * Need to take the SRCU lock because kvm_write_guest_offset_cached()
+	 * calls kvm_memslots();
+	 */
+	idx = srcu_read_lock(&kvm->srcu);
+	kvm_write_guest_cached(kvm, &vcpu->arch.vcpu_state.ghc,
+			       &preempted, sizeof(bool));
+	srcu_read_unlock(&kvm->srcu, idx);
+	pagefault_enable();
+}
-- 
2.32.0.93.g670b81a890-goog


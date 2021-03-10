Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F593334619
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhCJR7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhCJR6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:32 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6981FC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:32 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id e13so7544749ejd.21
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MDAOMBrujHgZpnE20qSGm1QQUtAE8AkHofkpYK5DKw8=;
        b=SPKpXNIElrr/kccAA33eiC02lZd/YQo1wMyMgbwKipLQ+IprzwGijG8z/UEp/8m9OC
         Veedhj366bN5pJ475K//bVmQiIU7RKOllPbey+Ghj/nPBpAKLcxSo3gg6ce2CmkbPcfa
         4cO2C4TLjUn7RmzR90g9nGZMaYv5Hb5DMkVAlioaUgTg+QJ7OKoyBeYQf24G90aqnIOA
         W4z1DhqjHLAQiZH2cITd8qvnmA90p57cPxzcnuSlzTQx4C58FJ28jGV39gFwlPix5G0I
         yk0GvWB8qWNv9qfZblGybI/B5paabO4TAT+2uEIiDcSjGJ+TRrbqj/eiAyqOmw8oDpZV
         i4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MDAOMBrujHgZpnE20qSGm1QQUtAE8AkHofkpYK5DKw8=;
        b=bYLZBwdcDUDKfj9xoO4zKvB5fbyWA9FMA0DmFWRRhlpHbrSKiqLFra1nqOWxoxIWDY
         9o4TmXRIKOWrLqEXIeQJz4Nv0akYjb/Zo9lUuGXQQ62Kjl0kN+dybGZIRIfC41Pcb8YP
         Yw2ty/9/i2NWR50vMf4swOi4CuFqSOryCCEoFrGQamCLyfUhF8PC+0tMey1wzis3LmUD
         3LldiWAh/v0v+9OCQP36HbLeXPn2R4qdODVUeEQHIMOVRENYvQnyqUdmZN4NPW2XUj3i
         3ggxXixjrTfGYEx1kmPa/mdbHST+8tgDvqCWt5ns1Zs0HQjhAOOHv8Kv0cLDbNDMGPdN
         rwYw==
X-Gm-Message-State: AOAM531GsIIvRFzx345nkS9gr/JCbiUd/2WpI5asu6nnwM6KE5KyzsiZ
        Iyp1YuaqpXzWLfKVeKGrjDUwZDIlZjGZ
X-Google-Smtp-Source: ABdhPJxtAtrUYpq8wz+am4H4wifwHgXtajAQPy3lRNGJJ51Ane5m5Z0baC9vyZnXI1Mel9wGB6uDORVXo5Bt
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a17:906:607:: with SMTP id
 s7mr4814258ejb.495.1615399110936; Wed, 10 Mar 2021 09:58:30 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:34 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-18-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 17/34] KVM: arm64: Elevate hypervisor mappings creation at EL2
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous commits have introduced infrastructure to enable the EL2 code
to manage its own stage 1 mappings. However, this was preliminary work,
and none of it is currently in use.

Put all of this together by elevating the mapping creation at EL2 when
memory protection is enabled. In this case, the host kernel running
at EL1 still creates _temporary_ EL2 mappings, only used while
initializing the hypervisor, but frees them right after.

As such, all calls to create_hyp_mappings() after kvm init has finished
turn into hypercalls, as the host now has no 'legal' way to modify the
hypevisor page tables directly.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h |  2 +-
 arch/arm64/kvm/arm.c             | 87 +++++++++++++++++++++++++++++---
 arch/arm64/kvm/mmu.c             | 43 ++++++++++++++--
 3 files changed, 120 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 5c42ec023cc7..ce02a4052dcf 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -166,7 +166,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu);
 
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
-int kvm_mmu_init(void);
+int kvm_mmu_init(u32 *hyp_va_bits);
 
 static inline void *__kvm_vector_slot2addr(void *base,
 					   enum arm64_hyp_spectre_vector slot)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 26e573cdede3..7d62211109d9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1421,7 +1421,7 @@ static void cpu_prepare_hyp_mode(int cpu)
 	kvm_flush_dcache_to_poc(params, sizeof(*params));
 }
 
-static void cpu_init_hyp_mode(void)
+static void hyp_install_host_vector(void)
 {
 	struct kvm_nvhe_init_params *params;
 	struct arm_smccc_res res;
@@ -1439,6 +1439,11 @@ static void cpu_init_hyp_mode(void)
 	params = this_cpu_ptr_nvhe_sym(kvm_init_params);
 	arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(__kvm_hyp_init), virt_to_phys(params), &res);
 	WARN_ON(res.a0 != SMCCC_RET_SUCCESS);
+}
+
+static void cpu_init_hyp_mode(void)
+{
+	hyp_install_host_vector();
 
 	/*
 	 * Disabling SSBD on a non-VHE system requires us to enable SSBS
@@ -1481,7 +1486,10 @@ static void cpu_set_hyp_vector(void)
 	struct bp_hardening_data *data = this_cpu_ptr(&bp_hardening_data);
 	void *vector = hyp_spectre_vector_selector[data->slot];
 
-	*this_cpu_ptr_hyp_sym(kvm_hyp_vector) = (unsigned long)vector;
+	if (!is_protected_kvm_enabled())
+		*this_cpu_ptr_hyp_sym(kvm_hyp_vector) = (unsigned long)vector;
+	else
+		kvm_call_hyp_nvhe(__pkvm_cpu_set_vector, data->slot);
 }
 
 static void cpu_hyp_reinit(void)
@@ -1489,13 +1497,14 @@ static void cpu_hyp_reinit(void)
 	kvm_init_host_cpu_context(&this_cpu_ptr_hyp_sym(kvm_host_data)->host_ctxt);
 
 	cpu_hyp_reset();
-	cpu_set_hyp_vector();
 
 	if (is_kernel_in_hyp_mode())
 		kvm_timer_init_vhe();
 	else
 		cpu_init_hyp_mode();
 
+	cpu_set_hyp_vector();
+
 	kvm_arm_init_debug();
 
 	if (vgic_present)
@@ -1691,18 +1700,59 @@ static void teardown_hyp_mode(void)
 	}
 }
 
+static int do_pkvm_init(u32 hyp_va_bits)
+{
+	void *per_cpu_base = kvm_ksym_ref(kvm_arm_hyp_percpu_base);
+	int ret;
+
+	preempt_disable();
+	hyp_install_host_vector();
+	ret = kvm_call_hyp_nvhe(__pkvm_init, hyp_mem_base, hyp_mem_size,
+				num_possible_cpus(), kern_hyp_va(per_cpu_base),
+				hyp_va_bits);
+	preempt_enable();
+
+	return ret;
+}
+
+static int kvm_hyp_init_protection(u32 hyp_va_bits)
+{
+	void *addr = phys_to_virt(hyp_mem_base);
+	int ret;
+
+	ret = create_hyp_mappings(addr, addr + hyp_mem_size, PAGE_HYP);
+	if (ret)
+		return ret;
+
+	ret = do_pkvm_init(hyp_va_bits);
+	if (ret)
+		return ret;
+
+	free_hyp_pgds();
+
+	return 0;
+}
+
 /**
  * Inits Hyp-mode on all online CPUs
  */
 static int init_hyp_mode(void)
 {
+	u32 hyp_va_bits;
 	int cpu;
-	int err = 0;
+	int err = -ENOMEM;
+
+	/*
+	 * The protected Hyp-mode cannot be initialized if the memory pool
+	 * allocation has failed.
+	 */
+	if (is_protected_kvm_enabled() && !hyp_mem_base)
+		goto out_err;
 
 	/*
 	 * Allocate Hyp PGD and setup Hyp identity mapping
 	 */
-	err = kvm_mmu_init();
+	err = kvm_mmu_init(&hyp_va_bits);
 	if (err)
 		goto out_err;
 
@@ -1818,6 +1868,14 @@ static int init_hyp_mode(void)
 			goto out_err;
 	}
 
+	if (is_protected_kvm_enabled()) {
+		err = kvm_hyp_init_protection(hyp_va_bits);
+		if (err) {
+			kvm_err("Failed to init hyp memory protection\n");
+			goto out_err;
+		}
+	}
+
 	return 0;
 
 out_err:
@@ -1826,6 +1884,16 @@ static int init_hyp_mode(void)
 	return err;
 }
 
+static int finalize_hyp_mode(void)
+{
+	if (!is_protected_kvm_enabled())
+		return 0;
+
+	static_branch_enable(&kvm_protected_mode_initialized);
+
+	return 0;
+}
+
 static void check_kvm_target_cpu(void *ret)
 {
 	*(int *)ret = kvm_target_cpu();
@@ -1942,8 +2010,15 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		goto out_hyp;
 
+	if (!in_hyp_mode) {
+		err = finalize_hyp_mode();
+		if (err) {
+			kvm_err("Failed to finalize Hyp protection\n");
+			goto out_hyp;
+		}
+	}
+
 	if (is_protected_kvm_enabled()) {
-		static_branch_enable(&kvm_protected_mode_initialized);
 		kvm_info("Protected nVHE mode initialized successfully\n");
 	} else if (in_hyp_mode) {
 		kvm_info("VHE mode initialized successfully\n");
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 4d41d7838d53..9d331bf262d2 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -221,15 +221,39 @@ void free_hyp_pgds(void)
 	if (hyp_pgtable) {
 		kvm_pgtable_hyp_destroy(hyp_pgtable);
 		kfree(hyp_pgtable);
+		hyp_pgtable = NULL;
 	}
 	mutex_unlock(&kvm_hyp_pgd_mutex);
 }
 
+static bool kvm_host_owns_hyp_mappings(void)
+{
+	if (static_branch_likely(&kvm_protected_mode_initialized))
+		return false;
+
+	/*
+	 * This can happen at boot time when __create_hyp_mappings() is called
+	 * after the hyp protection has been enabled, but the static key has
+	 * not been flipped yet.
+	 */
+	if (!hyp_pgtable && is_protected_kvm_enabled())
+		return false;
+
+	WARN_ON(!hyp_pgtable);
+
+	return true;
+}
+
 static int __create_hyp_mappings(unsigned long start, unsigned long size,
 				 unsigned long phys, enum kvm_pgtable_prot prot)
 {
 	int err;
 
+	if (!kvm_host_owns_hyp_mappings()) {
+		return kvm_call_hyp_nvhe(__pkvm_create_mappings,
+					 start, size, phys, prot);
+	}
+
 	mutex_lock(&kvm_hyp_pgd_mutex);
 	err = kvm_pgtable_hyp_map(hyp_pgtable, start, size, phys, prot);
 	mutex_unlock(&kvm_hyp_pgd_mutex);
@@ -291,6 +315,16 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
 	unsigned long base;
 	int ret = 0;
 
+	if (!kvm_host_owns_hyp_mappings()) {
+		base = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
+					 phys_addr, size, prot);
+		if (IS_ERR_OR_NULL((void *)base))
+			return PTR_ERR((void *)base);
+		*haddr = base;
+
+		return 0;
+	}
+
 	mutex_lock(&kvm_hyp_pgd_mutex);
 
 	/*
@@ -1270,10 +1304,9 @@ static struct kvm_pgtable_mm_ops kvm_hyp_mm_ops = {
 	.virt_to_phys		= kvm_host_pa,
 };
 
-int kvm_mmu_init(void)
+int kvm_mmu_init(u32 *hyp_va_bits)
 {
 	int err;
-	u32 hyp_va_bits;
 
 	hyp_idmap_start = __pa_symbol(__hyp_idmap_text_start);
 	hyp_idmap_start = ALIGN_DOWN(hyp_idmap_start, PAGE_SIZE);
@@ -1287,8 +1320,8 @@ int kvm_mmu_init(void)
 	 */
 	BUG_ON((hyp_idmap_start ^ (hyp_idmap_end - 1)) & PAGE_MASK);
 
-	hyp_va_bits = 64 - ((idmap_t0sz & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET);
-	kvm_debug("Using %u-bit virtual addresses at EL2\n", hyp_va_bits);
+	*hyp_va_bits = 64 - ((idmap_t0sz & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET);
+	kvm_debug("Using %u-bit virtual addresses at EL2\n", *hyp_va_bits);
 	kvm_debug("IDMAP page: %lx\n", hyp_idmap_start);
 	kvm_debug("HYP VA range: %lx:%lx\n",
 		  kern_hyp_va(PAGE_OFFSET),
@@ -1313,7 +1346,7 @@ int kvm_mmu_init(void)
 		goto out;
 	}
 
-	err = kvm_pgtable_hyp_init(hyp_pgtable, hyp_va_bits, &kvm_hyp_mm_ops);
+	err = kvm_pgtable_hyp_init(hyp_pgtable, *hyp_va_bits, &kvm_hyp_mm_ops);
 	if (err)
 		goto out_free_pgtable;
 
-- 
2.30.1.766.gb4fecdf3b7-goog


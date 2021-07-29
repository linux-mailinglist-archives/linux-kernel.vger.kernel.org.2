Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF133DA171
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhG2KoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:44:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3521 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbhG2KoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:44:07 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gb6NP3TTXz6FG6D;
        Thu, 29 Jul 2021 18:34:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 12:44:02 +0200
Received: from A2006125610.china.huawei.com (10.47.90.183) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 11:43:55 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <Alexandru.Elisei@arm.com>, <qperret@google.com>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 3/4] KVM: arm64: Align the VMID allocation with the arm64 ASID one
Date:   Thu, 29 Jul 2021 11:40:08 +0100
Message-ID: <20210729104009.382-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210729104009.382-1-shameerali.kolothum.thodi@huawei.com>
References: <20210729104009.382-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.90.183]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Grall <julien.grall@arm.com>

At the moment, the VMID algorithm will send an SGI to all the
CPUs to force an exit and then broadcast a full TLB flush and
I-Cache invalidation.

This patch uses the new VMID allocator. The benefits are:
   - Aligns with arm64 ASID algorithm.
   - CPUs are not forced to exit at roll-over. Instead,
     the VMID will be marked reserved and context invalidation
     is broadcasted. This will reduce the IPIs traffic.
   - More flexible to add support for pinned KVM VMIDs in
     the future.
   
With the new algo, the code is now adapted:
    - The call to update_vmid() will be done with preemption
      disabled as the new algo requires to store information
      per-CPU.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/include/asm/kvm_host.h     |   4 +-
 arch/arm64/include/asm/kvm_mmu.h      |   4 +-
 arch/arm64/kvm/Makefile               |   2 +-
 arch/arm64/kvm/arm.c                  | 121 +++++++-------------------
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |   3 +-
 arch/arm64/kvm/mmu.c                  |   1 -
 6 files changed, 36 insertions(+), 99 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ee0de63396ec..bb993bce1363 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -71,9 +71,7 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
 void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu);
 
 struct kvm_vmid {
-	/* The VMID generation used for the virt. memory system */
-	u64    vmid_gen;
-	u32    vmid;
+	atomic64_t id;
 };
 
 struct kvm_s2_mmu {
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index b52c5c4b9a3d..61edd05a000c 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -115,6 +115,7 @@ alternative_cb_end
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
+#include <asm/kvm_host.h>
 
 void kvm_update_va_mask(struct alt_instr *alt,
 			__le32 *origptr, __le32 *updptr, int nr_inst);
@@ -259,7 +260,8 @@ static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
 	u64 cnp = system_supports_cnp() ? VTTBR_CNP_BIT : 0;
 
 	baddr = mmu->pgd_phys;
-	vmid_field = (u64)vmid->vmid << VTTBR_VMID_SHIFT;
+	vmid_field = atomic64_read(&vmid->id) << VTTBR_VMID_SHIFT;
+	vmid_field &= VTTBR_VMID_MASK(kvm_arm_vmid_bits);
 	return kvm_phys_to_vttbr(baddr) | vmid_field | cnp;
 }
 
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 989bb5dad2c8..4a607d52356c 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -16,7 +16,7 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 inject_fault.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o \
 	 vgic-sys-reg-v3.o fpsimd.o pmu.o \
-	 arch_timer.o trng.o\
+	 arch_timer.o trng.o vmid.o \
 	 vgic/vgic.o vgic/vgic-init.o \
 	 vgic/vgic-irqfd.o vgic/vgic-v2.o \
 	 vgic/vgic-v3.o vgic/vgic-v4.o \
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e9a2b8f27792..077e55a511a9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -55,11 +55,6 @@ static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
-/* The VMID used in the VTTBR */
-static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
-static u32 kvm_next_vmid;
-static DEFINE_SPINLOCK(kvm_vmid_lock);
-
 static bool vgic_present;
 
 static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
@@ -500,87 +495,6 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 	return vcpu_mode_priv(vcpu);
 }
 
-/* Just ensure a guest exit from a particular CPU */
-static void exit_vm_noop(void *info)
-{
-}
-
-void force_vm_exit(const cpumask_t *mask)
-{
-	preempt_disable();
-	smp_call_function_many(mask, exit_vm_noop, NULL, true);
-	preempt_enable();
-}
-
-/**
- * need_new_vmid_gen - check that the VMID is still valid
- * @vmid: The VMID to check
- *
- * return true if there is a new generation of VMIDs being used
- *
- * The hardware supports a limited set of values with the value zero reserved
- * for the host, so we check if an assigned value belongs to a previous
- * generation, which requires us to assign a new value. If we're the first to
- * use a VMID for the new generation, we must flush necessary caches and TLBs
- * on all CPUs.
- */
-static bool need_new_vmid_gen(struct kvm_vmid *vmid)
-{
-	u64 current_vmid_gen = atomic64_read(&kvm_vmid_gen);
-	smp_rmb(); /* Orders read of kvm_vmid_gen and kvm->arch.vmid */
-	return unlikely(READ_ONCE(vmid->vmid_gen) != current_vmid_gen);
-}
-
-/**
- * update_vmid - Update the vmid with a valid VMID for the current generation
- * @vmid: The stage-2 VMID information struct
- */
-static void update_vmid(struct kvm_vmid *vmid)
-{
-	if (!need_new_vmid_gen(vmid))
-		return;
-
-	spin_lock(&kvm_vmid_lock);
-
-	/*
-	 * We need to re-check the vmid_gen here to ensure that if another vcpu
-	 * already allocated a valid vmid for this vm, then this vcpu should
-	 * use the same vmid.
-	 */
-	if (!need_new_vmid_gen(vmid)) {
-		spin_unlock(&kvm_vmid_lock);
-		return;
-	}
-
-	/* First user of a new VMID generation? */
-	if (unlikely(kvm_next_vmid == 0)) {
-		atomic64_inc(&kvm_vmid_gen);
-		kvm_next_vmid = 1;
-
-		/*
-		 * On SMP we know no other CPUs can use this CPU's or each
-		 * other's VMID after force_vm_exit returns since the
-		 * kvm_vmid_lock blocks them from reentry to the guest.
-		 */
-		force_vm_exit(cpu_all_mask);
-		/*
-		 * Now broadcast TLB + ICACHE invalidation over the inner
-		 * shareable domain to make sure all data structures are
-		 * clean.
-		 */
-		kvm_call_hyp(__kvm_flush_vm_context);
-	}
-
-	vmid->vmid = kvm_next_vmid;
-	kvm_next_vmid++;
-	kvm_next_vmid &= (1 << kvm_get_vmid_bits()) - 1;
-
-	smp_wmb();
-	WRITE_ONCE(vmid->vmid_gen, atomic64_read(&kvm_vmid_gen));
-
-	spin_unlock(&kvm_vmid_lock);
-}
-
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -759,8 +673,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 */
 		cond_resched();
 
-		update_vmid(&vcpu->arch.hw_mmu->vmid);
-
 		check_vcpu_requests(vcpu);
 
 		/*
@@ -770,6 +682,15 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 */
 		preempt_disable();
 
+		/*
+		 * The VMID allocator only tracks active VMIDs per
+		 * physical CPU, and therefore the VMID allocated may not be
+		 * preserved on VMID roll-over if the task was preempted,
+		 * making a thread's VMID inactive. So we need to call
+		 * kvm_arm_vmid_update() in non-premptible context.
+		 */
+		kvm_arm_vmid_update(&vcpu->arch.hw_mmu->vmid);
+
 		kvm_pmu_flush_hwstate(vcpu);
 
 		local_irq_disable();
@@ -808,8 +729,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 */
 		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
 
-		if (ret <= 0 || need_new_vmid_gen(&vcpu->arch.hw_mmu->vmid) ||
-		    kvm_request_pending(vcpu)) {
+		if (ret <= 0 || kvm_request_pending(vcpu)) {
 			vcpu->mode = OUTSIDE_GUEST_MODE;
 			isb(); /* Ensure work in x_flush_hwstate is committed */
 			kvm_pmu_sync_hwstate(vcpu);
@@ -1519,6 +1439,7 @@ static void cpu_hyp_reset(void)
 {
 	if (!is_kernel_in_hyp_mode())
 		__hyp_reset_vectors();
+
 }
 
 /*
@@ -1698,9 +1619,26 @@ static bool init_psci_relay(void)
 
 static int init_common_resources(void)
 {
+	int err;
+
+	/*
+	 * Initialize the VMID allocator telling it to allocate a single
+	 * VMID per VM.
+	 */
+	err = kvm_arm_vmid_alloc_init();
+	if (err) {
+		kvm_err("Failed to initialize VMID allocator.\n");
+		return err;
+	}
+
 	return kvm_set_ipa_limit();
 }
 
+static void free_common_resources(void)
+{
+	kvm_arm_vmid_alloc_free();
+}
+
 static int init_subsystems(void)
 {
 	int err = 0;
@@ -2108,7 +2046,7 @@ int kvm_arch_init(void *opaque)
 
 	err = kvm_arm_init_sve();
 	if (err)
-		return err;
+		goto out_err;
 
 	if (!in_hyp_mode) {
 		err = init_hyp_mode();
@@ -2149,6 +2087,7 @@ int kvm_arch_init(void *opaque)
 	if (!in_hyp_mode)
 		teardown_hyp_mode();
 out_err:
+	free_common_resources();
 	return err;
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d938ce95d3bd..858de201247e 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -109,8 +109,7 @@ int kvm_host_prepare_stage2(void *pgt_pool_base)
 	mmu->pgd_phys = __hyp_pa(host_kvm.pgt.pgd);
 	mmu->arch = &host_kvm.arch;
 	mmu->pgt = &host_kvm.pgt;
-	mmu->vmid.vmid_gen = 0;
-	mmu->vmid.vmid = 0;
+	atomic64_set(&mmu->vmid.id, 0);
 
 	return 0;
 }
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 3155c9e778f0..18346f56e036 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -485,7 +485,6 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 	mmu->arch = &kvm->arch;
 	mmu->pgt = pgt;
 	mmu->pgd_phys = __pa(pgt->pgd);
-	mmu->vmid.vmid_gen = 0;
 	return 0;
 
 out_destroy_pgtable:
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB65F3AA099
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhFPQAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:00:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3254 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhFPP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:59:46 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G4qMd5X2rz6K6R6;
        Wed, 16 Jun 2021 23:47:57 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 16 Jun 2021 17:57:38 +0200
Received: from A2006125610.china.huawei.com (10.47.83.191) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 16:57:31 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <Alexandru.Elisei@arm.com>, <linuxarm@huawei.com>
Subject: [PATCH v2 2/3] kvm/arm: Introduce a new vmid allocator for KVM
Date:   Wed, 16 Jun 2021 16:56:05 +0100
Message-ID: <20210616155606.2806-3-shameerali.kolothum.thodi@huawei.com>
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

A new VMID allocator for arm64 KVM use. This is based on
arm64 asid allocator algorithm.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/include/asm/kvm_host.h |   4 +
 arch/arm64/kvm/vmid.c             | 206 ++++++++++++++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 arch/arm64/kvm/vmid.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7cd7d5c8c4bc..75a7e8071012 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -680,6 +680,10 @@ int kvm_arm_pvtime_get_attr(struct kvm_vcpu *vcpu,
 int kvm_arm_pvtime_has_attr(struct kvm_vcpu *vcpu,
 			    struct kvm_device_attr *attr);
 
+int kvm_arm_vmid_alloc_init(void);
+void kvm_arm_vmid_alloc_free(void);
+void kvm_arm_update_vmid(atomic64_t *id);
+
 static inline void kvm_arm_pvtime_vcpu_init(struct kvm_vcpu_arch *vcpu_arch)
 {
 	vcpu_arch->steal.base = GPA_INVALID;
diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
new file mode 100644
index 000000000000..687e18d33130
--- /dev/null
+++ b/arch/arm64/kvm/vmid.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * VMID allocator.
+ *
+ * Based on arch/arm64/mm/context.c
+ *
+ * Copyright (C) 2002-2003 Deep Blue Solutions Ltd, all rights reserved.
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+
+#include <asm/kvm_asm.h>
+#include <asm/kvm_mmu.h>
+
+static u32 vmid_bits;
+static DEFINE_RAW_SPINLOCK(cpu_vmid_lock);
+
+static atomic64_t vmid_generation;
+static unsigned long *vmid_map;
+
+static DEFINE_PER_CPU(atomic64_t, active_vmids);
+static DEFINE_PER_CPU(u64, reserved_vmids);
+static cpumask_t tlb_flush_pending;
+
+#define VMID_MASK		(~GENMASK(vmid_bits - 1, 0))
+#define VMID_FIRST_VERSION	(1UL << vmid_bits)
+
+#define NUM_USER_VMIDS		VMID_FIRST_VERSION
+#define vmid2idx(vmid)		((vmid) & ~VMID_MASK)
+#define idx2vmid(idx)		vmid2idx(idx)
+
+#define vmid_gen_match(vmid) \
+	(!(((vmid) ^ atomic64_read(&vmid_generation)) >> vmid_bits))
+
+static void flush_context(void)
+{
+	int cpu;
+	u64 vmid;
+
+	bitmap_clear(vmid_map, 0, NUM_USER_VMIDS);
+
+	for_each_possible_cpu(cpu) {
+		vmid = atomic64_xchg_relaxed(&per_cpu(active_vmids, cpu), 0);
+		/*
+		 * If this CPU has already been through a
+		 * rollover, but hasn't run another task in
+		 * the meantime, we must preserve its reserved
+		 * VMID, as this is the only trace we have of
+		 * the process it is still running.
+		 */
+		if (vmid == 0)
+			vmid = per_cpu(reserved_vmids, cpu);
+		__set_bit(vmid2idx(vmid), vmid_map);
+		per_cpu(reserved_vmids, cpu) = vmid;
+	}
+
+	/*
+	 * Queue a TLB invalidation for each CPU to perform on next
+	 * context-switch
+	 */
+	cpumask_setall(&tlb_flush_pending);
+}
+
+static bool check_update_reserved_vmid(u64 vmid, u64 newvmid)
+{
+	int cpu;
+	bool hit = false;
+
+	/*
+	 * Iterate over the set of reserved VMIDs looking for a match.
+	 * If we find one, then we can update our mm to use newvmid
+	 * (i.e. the same VMID in the current generation) but we can't
+	 * exit the loop early, since we need to ensure that all copies
+	 * of the old VMID are updated to reflect the mm. Failure to do
+	 * so could result in us missing the reserved VMID in a future
+	 * generation.
+	 */
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(reserved_vmids, cpu) == vmid) {
+			hit = true;
+			per_cpu(reserved_vmids, cpu) = newvmid;
+		}
+	}
+
+	return hit;
+}
+
+static u64 new_vmid(atomic64_t *id)
+{
+	static u32 cur_idx = 1;
+	u64 vmid = atomic64_read(id);
+	u64 generation = atomic64_read(&vmid_generation);
+
+	if (vmid != 0) {
+		u64 newvmid = generation | (vmid & ~VMID_MASK);
+
+		/*
+		 * If our current VMID was active during a rollover, we
+		 * can continue to use it and this was just a false alarm.
+		 */
+		if (check_update_reserved_vmid(vmid, newvmid))
+			return newvmid;
+
+		/*
+		 * We had a valid VMID in a previous life, so try to re-use
+		 * it if possible.
+		 */
+		if (!__test_and_set_bit(vmid2idx(vmid), vmid_map))
+			return newvmid;
+	}
+
+	/*
+	 * Allocate a free VMID. If we can't find one, take a note of the
+	 * currently active VMIDs and mark the TLBs as requiring flushes.  We
+	 * always count from VMID #2 (index 1), as we use VMID #0 for host.
+	 */
+	vmid = find_next_zero_bit(vmid_map, NUM_USER_VMIDS, cur_idx);
+	if (vmid != NUM_USER_VMIDS)
+		goto set_vmid;
+
+	/* We're out of VMIDs, so increment the global generation count */
+	generation = atomic64_add_return_relaxed(VMID_FIRST_VERSION,
+						 &vmid_generation);
+	flush_context();
+
+	/* We have more VMIDs than CPUs, so this will always succeed */
+	vmid = find_next_zero_bit(vmid_map, NUM_USER_VMIDS, 1);
+
+set_vmid:
+	__set_bit(vmid, vmid_map);
+	cur_idx = vmid;
+	return idx2vmid(vmid) | generation;
+}
+
+void kvm_arm_update_vmid(atomic64_t *id)
+{
+	unsigned long flags;
+	unsigned int cpu;
+	u64 vmid, old_active_vmid;
+
+	vmid = atomic64_read(id);
+
+	/*
+	 * The memory ordering here is subtle.
+	 * If our active_vmids is non-zero and the VMID matches the current
+	 * generation, then we update the active_vmids entry with a relaxed
+	 * cmpxchg. Racing with a concurrent rollover means that either:
+	 *
+	 * - We get a zero back from the cmpxchg and end up waiting on the
+	 *   lock. Taking the lock synchronises with the rollover and so
+	 *   we are forced to see the updated generation.
+	 *
+	 * - We get a valid VMID back from the cmpxchg, which means the
+	 *   relaxed xchg in flush_context will treat us as reserved
+	 *   because atomic RmWs are totally ordered for a given location.
+	 */
+	old_active_vmid = atomic64_read(this_cpu_ptr(&active_vmids));
+	if (old_active_vmid && vmid_gen_match(vmid) &&
+	    atomic64_cmpxchg_relaxed(this_cpu_ptr(&active_vmids),
+				     old_active_vmid, vmid))
+		return;
+
+	raw_spin_lock_irqsave(&cpu_vmid_lock, flags);
+
+	/* Check that our VMID belongs to the current generation. */
+	vmid = atomic64_read(id);
+	if (!vmid_gen_match(vmid)) {
+		vmid = new_vmid(id);
+		atomic64_set(id, vmid);
+	}
+
+	cpu = smp_processor_id();
+	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
+		kvm_call_hyp(__kvm_tlb_flush_local_all);
+
+	atomic64_set(this_cpu_ptr(&active_vmids), vmid);
+	raw_spin_unlock_irqrestore(&cpu_vmid_lock, flags);
+}
+
+/*
+ * Initialize the VMID allocator
+ */
+int kvm_arm_vmid_alloc_init(void)
+{
+	vmid_bits = kvm_get_vmid_bits();
+
+	/*
+	 * Expect allocation after rollover to fail if we don't have at least
+	 * one more VMID than CPUs. VMID #0 is always reserved.
+	 */
+	WARN_ON(NUM_USER_VMIDS - 1 <= num_possible_cpus());
+	atomic64_set(&vmid_generation, VMID_FIRST_VERSION);
+	vmid_map = kcalloc(BITS_TO_LONGS(NUM_USER_VMIDS),
+			   sizeof(*vmid_map), GFP_KERNEL);
+	if (!vmid_map)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void kvm_arm_vmid_alloc_free(void)
+{
+	kfree(vmid_map);
+}
-- 
2.17.1


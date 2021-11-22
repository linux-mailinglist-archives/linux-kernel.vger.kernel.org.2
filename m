Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFB6458E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbhKVMWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:22:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4120 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhKVMW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:22:29 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyRC46N3Dz6GDKL;
        Mon, 22 Nov 2021 20:18:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 13:19:21 +0100
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 12:19:14 +0000
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <Alexandru.Elisei@arm.com>, <qperret@google.com>,
        <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v4 1/4] KVM: arm64: Introduce a new VMID allocator for KVM
Date:   Mon, 22 Nov 2021 12:18:41 +0000
Message-ID: <20211122121844.867-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com>
References: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new VMID allocator for arm64 KVM use. This is based on
arm64 ASID allocator algorithm.

One major deviation from the ASID allocator is the way we
flush the context. Unlike ASID allocator, we expect less
frequent rollover in the case of VMIDs. Hence, instead of
marking the CPU as flush_pending and issuing a local context
invalidation on the next context switch, we  broadcast TLB
flush + I-cache invalidation over the inner shareable domain
on rollover.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/include/asm/kvm_host.h |   4 +
 arch/arm64/kvm/vmid.c             | 177 ++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 arch/arm64/kvm/vmid.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2a5f7f38006f..f4a86a79ea4a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -690,6 +690,10 @@ int kvm_arm_pvtime_get_attr(struct kvm_vcpu *vcpu,
 int kvm_arm_pvtime_has_attr(struct kvm_vcpu *vcpu,
 			    struct kvm_device_attr *attr);
 
+int kvm_arm_vmid_alloc_init(void);
+void kvm_arm_vmid_alloc_free(void);
+void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid);
+
 static inline void kvm_arm_pvtime_vcpu_init(struct kvm_vcpu_arch *vcpu_arch)
 {
 	vcpu_arch->steal.base = GPA_INVALID;
diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
new file mode 100644
index 000000000000..aa01c97f7df0
--- /dev/null
+++ b/arch/arm64/kvm/vmid.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * VMID allocator.
+ *
+ * Based on Arm64 ASID allocator algorithm.
+ * Please refer arch/arm64/mm/context.c for detailed
+ * comments on algorithm.
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
+static unsigned int kvm_arm_vmid_bits;
+static DEFINE_RAW_SPINLOCK(cpu_vmid_lock);
+
+static atomic64_t vmid_generation;
+static unsigned long *vmid_map;
+
+static DEFINE_PER_CPU(atomic64_t, active_vmids);
+static DEFINE_PER_CPU(u64, reserved_vmids);
+
+#define VMID_MASK		(~GENMASK(kvm_arm_vmid_bits - 1, 0))
+#define VMID_FIRST_VERSION	(1UL << kvm_arm_vmid_bits)
+
+#define NUM_USER_VMIDS		VMID_FIRST_VERSION
+#define vmid2idx(vmid)		((vmid) & ~VMID_MASK)
+#define idx2vmid(idx)		vmid2idx(idx)
+
+#define vmid_gen_match(vmid) \
+	(!(((vmid) ^ atomic64_read(&vmid_generation)) >> kvm_arm_vmid_bits))
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
+
+		/* Preserve reserved VMID */
+		if (vmid == 0)
+			vmid = per_cpu(reserved_vmids, cpu);
+		__set_bit(vmid2idx(vmid), vmid_map);
+		per_cpu(reserved_vmids, cpu) = vmid;
+	}
+
+	/*
+	 * Unlike ASID allocator, we expect less frequent rollover in
+	 * case of VMIDs. Hence, instead of marking the CPU as
+	 * flush_pending and issuing a local context invalidation on
+	 * the next context-switch, we broadcast TLB flush + I-cache
+	 * invalidation over the inner shareable domain on rollover.
+	 */
+	 kvm_call_hyp(__kvm_flush_vm_context);
+}
+
+static bool check_update_reserved_vmid(u64 vmid, u64 newvmid)
+{
+	int cpu;
+	bool hit = false;
+
+	/*
+	 * Iterate over the set of reserved VMIDs looking for a match
+	 * and update to use newvmid (i.e. the same VMID in the current
+	 * generation).
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
+static u64 new_vmid(struct kvm_vmid *kvm_vmid)
+{
+	static u32 cur_idx = 1;
+	u64 vmid = atomic64_read(&kvm_vmid->id);
+	u64 generation = atomic64_read(&vmid_generation);
+
+	if (vmid != 0) {
+		u64 newvmid = generation | (vmid & ~VMID_MASK);
+
+		if (check_update_reserved_vmid(vmid, newvmid)) {
+			atomic64_set(&kvm_vmid->id, newvmid);
+			return newvmid;
+		}
+
+		if (!__test_and_set_bit(vmid2idx(vmid), vmid_map)) {
+			atomic64_set(&kvm_vmid->id, newvmid);
+			return newvmid;
+		}
+	}
+
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
+	vmid = idx2vmid(vmid) | generation;
+	atomic64_set(&kvm_vmid->id, vmid);
+	return vmid;
+}
+
+void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid)
+{
+	unsigned long flags;
+	u64 vmid, old_active_vmid;
+
+	vmid = atomic64_read(&kvm_vmid->id);
+
+	/*
+	 * Please refer comments in check_and_switch_context() in
+	 * arch/arm64/mm/context.c.
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
+	vmid = atomic64_read(&kvm_vmid->id);
+	if (!vmid_gen_match(vmid))
+		vmid = new_vmid(kvm_vmid);
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
+	kvm_arm_vmid_bits = kvm_get_vmid_bits();
+
+	/*
+	 * Expect allocation after rollover to fail if we don't have
+	 * at least one more VMID than CPUs. VMID #0 is always reserved.
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


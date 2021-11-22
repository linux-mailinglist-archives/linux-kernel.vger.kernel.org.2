Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3BB458E26
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbhKVMWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:22:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4123 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239539AbhKVMWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:22:54 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyRBx0H9Pz6H8CN;
        Mon, 22 Nov 2021 20:18:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 13:19:45 +0100
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 12:19:39 +0000
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <Alexandru.Elisei@arm.com>, <qperret@google.com>,
        <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v4 4/4] KVM: arm64: Make active_vmids invalid on vCPU schedule out
Date:   Mon, 22 Nov 2021 12:18:44 +0000
Message-ID: <20211122121844.867-5-shameerali.kolothum.thodi@huawei.com>
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

Like ASID allocator, we copy the active_vmids into the
reserved_vmids on a rollover. But it's unlikely that
every CPU will have a vCPU as current task and we may
end up unnecessarily reserving the VMID space.

Hence, set active_vmids to an invalid one when scheduling
out a vCPU.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/arm.c              |  1 +
 arch/arm64/kvm/vmid.c             | 25 ++++++++++++++++++++++---
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 752d4408e3d0..22f952effd03 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -692,6 +692,7 @@ extern unsigned int kvm_arm_vmid_bits;
 int kvm_arm_vmid_alloc_init(void);
 void kvm_arm_vmid_alloc_free(void);
 void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid);
+void kvm_arm_vmid_clear_active(void);
 
 static inline void kvm_arm_pvtime_vcpu_init(struct kvm_vcpu_arch *vcpu_arch)
 {
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 0544011b0fc6..bfe926805240 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -431,6 +431,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_timer_vcpu_put(vcpu);
 	kvm_vgic_put(vcpu);
 	kvm_vcpu_pmu_restore_host(vcpu);
+	kvm_arm_vmid_clear_active();
 
 	vcpu->cpu = -1;
 }
diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
index 9aff692b6b7d..966ebb2d12e5 100644
--- a/arch/arm64/kvm/vmid.c
+++ b/arch/arm64/kvm/vmid.c
@@ -32,6 +32,13 @@ static DEFINE_PER_CPU(u64, reserved_vmids);
 #define vmid2idx(vmid)		((vmid) & ~VMID_MASK)
 #define idx2vmid(idx)		vmid2idx(idx)
 
+/*
+ * As vmid #0 is always reserved, we will never allocate one
+ * as below and can be treated as invalid. This is used to
+ * set the active_vmids on vCPU schedule out.
+ */
+#define VMID_ACTIVE_INVALID		VMID_FIRST_VERSION
+
 #define vmid_gen_match(vmid) \
 	(!(((vmid) ^ atomic64_read(&vmid_generation)) >> kvm_arm_vmid_bits))
 
@@ -122,6 +129,12 @@ static u64 new_vmid(struct kvm_vmid *kvm_vmid)
 	return vmid;
 }
 
+/* Called from vCPU sched out with preemption disabled */
+void kvm_arm_vmid_clear_active(void)
+{
+	atomic64_set(this_cpu_ptr(&active_vmids), VMID_ACTIVE_INVALID);
+}
+
 void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid)
 {
 	unsigned long flags;
@@ -132,11 +145,17 @@ void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid)
 	/*
 	 * Please refer comments in check_and_switch_context() in
 	 * arch/arm64/mm/context.c.
+	 *
+	 * Unlike ASID allocator, we set the active_vmids to
+	 * VMID_ACTIVE_INVALID on vCPU schedule out to avoid
+	 * reserving the VMID space needlessly on rollover.
+	 * Hence explicitly check here for a "!= 0" to
+	 * handle the sync with a concurrent rollover.
 	 */
 	old_active_vmid = atomic64_read(this_cpu_ptr(&active_vmids));
-	if (old_active_vmid && vmid_gen_match(vmid) &&
-	    atomic64_cmpxchg_relaxed(this_cpu_ptr(&active_vmids),
-				     old_active_vmid, vmid))
+	if (old_active_vmid != 0 && vmid_gen_match(vmid) &&
+	    0 != atomic64_cmpxchg_relaxed(this_cpu_ptr(&active_vmids),
+					  old_active_vmid, vmid))
 		return;
 
 	raw_spin_lock_irqsave(&cpu_vmid_lock, flags);
-- 
2.17.1


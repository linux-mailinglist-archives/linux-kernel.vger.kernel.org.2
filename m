Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850DA3DA173
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhG2KoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:44:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3522 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbhG2KoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:44:15 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gb6NZ3C6lz6FG8P;
        Thu, 29 Jul 2021 18:34:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 12:44:11 +0200
Received: from A2006125610.china.huawei.com (10.47.90.183) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 11:44:04 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <Alexandru.Elisei@arm.com>, <qperret@google.com>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 4/4] KVM: arm64: Clear active_vmids on vCPU schedule out
Date:   Thu, 29 Jul 2021 11:40:09 +0100
Message-ID: <20210729104009.382-5-shameerali.kolothum.thodi@huawei.com>
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

Like ASID allocator, we copy the active_vmids into the
reserved_vmids on a rollover. But it's unlikely that
every CPU will have a vCPU as current task and we may
end up unnecessarily reserving the VMID space.

Hence, clear active_vmids when scheduling out a vCPU.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/include/asm/kvm_host.h | 1 +
 arch/arm64/kvm/arm.c              | 1 +
 arch/arm64/kvm/vmid.c             | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index bb993bce1363..d93141cb8d16 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -687,6 +687,7 @@ extern unsigned int kvm_arm_vmid_bits;
 int kvm_arm_vmid_alloc_init(void);
 void kvm_arm_vmid_alloc_free(void);
 void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid);
+void kvm_arm_vmid_clear_active(void);
 
 static inline void kvm_arm_pvtime_vcpu_init(struct kvm_vcpu_arch *vcpu_arch)
 {
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 077e55a511a9..b134a1b89c84 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -435,6 +435,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_timer_vcpu_put(vcpu);
 	kvm_vgic_put(vcpu);
 	kvm_vcpu_pmu_restore_host(vcpu);
+	kvm_arm_vmid_clear_active();
 
 	vcpu->cpu = -1;
 }
diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
index 5584e84aed95..5fd51f5445c1 100644
--- a/arch/arm64/kvm/vmid.c
+++ b/arch/arm64/kvm/vmid.c
@@ -116,6 +116,12 @@ static u64 new_vmid(struct kvm_vmid *kvm_vmid)
 	return idx2vmid(vmid) | generation;
 }
 
+/* Call with preemption disabled */
+void kvm_arm_vmid_clear_active(void)
+{
+	atomic64_set(this_cpu_ptr(&active_vmids), 0);
+}
+
 void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid)
 {
 	unsigned long flags;
-- 
2.17.1


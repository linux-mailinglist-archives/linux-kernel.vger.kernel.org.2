Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A92458E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbhKVMWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:22:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4121 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhKVMWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:22:37 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyRBc4KRDz6H7jW;
        Mon, 22 Nov 2021 20:18:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 13:19:29 +0100
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 12:19:22 +0000
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <Alexandru.Elisei@arm.com>, <qperret@google.com>,
        <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v4 2/4] KVM: arm64: Make VMID bits accessible outside of allocator
Date:   Mon, 22 Nov 2021 12:18:42 +0000
Message-ID: <20211122121844.867-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com>
References: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we already set the kvm_arm_vmid_bits in the VMID allocator
init function, make it accessible outside as well so that it can
be used in the subsequent patch.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/include/asm/kvm_host.h | 1 +
 arch/arm64/kernel/image-vars.h    | 3 +++
 arch/arm64/kvm/vmid.c             | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f4a86a79ea4a..51af17e16115 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -690,6 +690,7 @@ int kvm_arm_pvtime_get_attr(struct kvm_vcpu *vcpu,
 int kvm_arm_pvtime_has_attr(struct kvm_vcpu *vcpu,
 			    struct kvm_device_attr *attr);
 
+extern unsigned int kvm_arm_vmid_bits;
 int kvm_arm_vmid_alloc_init(void);
 void kvm_arm_vmid_alloc_free(void);
 void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid);
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index c96a9a0043bf..c12963c3a055 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -79,6 +79,9 @@ KVM_NVHE_ALIAS(__hyp_stub_vectors);
 /* Kernel symbol used by icache_is_vpipt(). */
 KVM_NVHE_ALIAS(__icache_flags);
 
+/* VMID bits set by the KVM VMID allocator */
+KVM_NVHE_ALIAS(kvm_arm_vmid_bits);
+
 /* Kernel symbols needed for cpus_have_final/const_caps checks. */
 KVM_NVHE_ALIAS(arm64_const_caps_ready);
 KVM_NVHE_ALIAS(cpu_hwcap_keys);
diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
index aa01c97f7df0..9aff692b6b7d 100644
--- a/arch/arm64/kvm/vmid.c
+++ b/arch/arm64/kvm/vmid.c
@@ -16,7 +16,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
 
-static unsigned int kvm_arm_vmid_bits;
+unsigned int kvm_arm_vmid_bits;
 static DEFINE_RAW_SPINLOCK(cpu_vmid_lock);
 
 static atomic64_t vmid_generation;
-- 
2.17.1


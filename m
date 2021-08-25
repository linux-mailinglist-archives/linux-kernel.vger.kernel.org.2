Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DC43F7A29
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbhHYQS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:18:59 -0400
Received: from foss.arm.com ([217.140.110.172]:54824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239453AbhHYQSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29C92143D;
        Wed, 25 Aug 2021 09:17:46 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABB083F66F;
        Wed, 25 Aug 2021 09:17:44 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: [RFC PATCH v4 21/39] KVM: arm64: Add SPE VCPU device attribute to set the interrupt number
Date:   Wed, 25 Aug 2021 17:17:57 +0100
Message-Id: <20210825161815.266051-22-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

Add KVM_ARM_VCPU_SPE_CTRL(KVM_ARM_VCPU_SPE_IRQ) to allow the user to set
the interrupt number for the buffer management interrupt.

[ Alexandru E: Split from "KVM: arm64: Add a new VCPU device control group
               for SPE" ]

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 Documentation/virt/kvm/devices/vcpu.rst | 19 ++++++
 arch/arm64/include/asm/kvm_host.h       |  2 +
 arch/arm64/include/asm/kvm_spe.h        | 10 +++
 arch/arm64/include/uapi/asm/kvm.h       |  1 +
 arch/arm64/kvm/spe.c                    | 86 +++++++++++++++++++++++++
 5 files changed, 118 insertions(+)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index 85399c005197..05821d40849f 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -166,3 +166,22 @@ including the layout of the stolen time structure.
 ===============================
 
 :Architectures: ARM64
+
+4.1 ATTRIBUTE: KVM_ARM_VCPU_SPE_IRQ
+-----------------------------------
+
+:Parameters: in kvm_device_attr.addr the address for the Profiling Buffer
+             management interrupt number as a pointer to an int
+
+Returns:
+
+	 =======  ======================================================
+	 -EBUSY   Interrupt number already set for this VCPU
+	 -EFAULT  Error accessing the buffer management interrupt number
+	 -EINVAL  Invalid interrupt number
+	 -ENXIO   SPE not supported or not properly configured
+	 =======  ======================================================
+
+Specifies the Profiling Buffer management interrupt number. The interrupt number
+must be a PPI and the interrupt number must be the same for each VCPU. SPE
+emulation requires an in-kernel vGIC implementation.
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 948adb152104..7b957e439b3d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -26,6 +26,7 @@
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_spe.h>
 #include <asm/thread_info.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
@@ -353,6 +354,7 @@ struct kvm_vcpu_arch {
 	struct vgic_cpu vgic_cpu;
 	struct arch_timer_cpu timer_cpu;
 	struct kvm_pmu pmu;
+	struct kvm_vcpu_spe spe;
 
 	/*
 	 * Anything that is not used directly from assembly code goes
diff --git a/arch/arm64/include/asm/kvm_spe.h b/arch/arm64/include/asm/kvm_spe.h
index ce0f5b3f2027..2fe11868719d 100644
--- a/arch/arm64/include/asm/kvm_spe.h
+++ b/arch/arm64/include/asm/kvm_spe.h
@@ -6,6 +6,8 @@
 #ifndef __ARM64_KVM_SPE_H__
 #define __ARM64_KVM_SPE_H__
 
+#include <linux/kvm.h>
+
 #ifdef CONFIG_KVM_ARM_SPE
 DECLARE_STATIC_KEY_FALSE(kvm_spe_available);
 
@@ -14,6 +16,11 @@ static __always_inline bool kvm_supports_spe(void)
 	return static_branch_likely(&kvm_spe_available);
 }
 
+struct kvm_vcpu_spe {
+	bool initialized;	/* SPE initialized for the VCPU */
+	int irq_num;		/* Buffer management interrut number */
+};
+
 void kvm_spe_init_supported_cpus(void);
 void kvm_spe_vm_init(struct kvm *kvm);
 int kvm_spe_check_supported_cpus(struct kvm_vcpu *vcpu);
@@ -24,6 +31,9 @@ int kvm_spe_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
 #else
 #define kvm_supports_spe()	(false)
 
+struct kvm_vcpu_spe {
+};
+
 static inline void kvm_spe_init_supported_cpus(void) {}
 static inline void kvm_spe_vm_init(struct kvm *kvm) {}
 static inline int kvm_spe_check_supported_cpus(struct kvm_vcpu *vcpu) { return -ENOEXEC; }
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 7159a1e23da2..c55d94a1a8f5 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -369,6 +369,7 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_ARM_VCPU_PVTIME_CTRL	2
 #define   KVM_ARM_VCPU_PVTIME_IPA	0
 #define KVM_ARM_VCPU_SPE_CTRL		3
+#define   KVM_ARM_VCPU_SPE_IRQ		0
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_VCPU2_SHIFT		28
diff --git a/arch/arm64/kvm/spe.c b/arch/arm64/kvm/spe.c
index 56a3fdb35623..2fdb42e27675 100644
--- a/arch/arm64/kvm/spe.c
+++ b/arch/arm64/kvm/spe.c
@@ -43,17 +43,103 @@ int kvm_spe_check_supported_cpus(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static bool kvm_vcpu_supports_spe(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_supports_spe())
+		return false;
+
+	if (!kvm_vcpu_has_spe(vcpu))
+		return false;
+
+	if (!irqchip_in_kernel(vcpu->kvm))
+		return false;
+
+	return true;
+}
+
+static bool kvm_spe_irq_is_valid(struct kvm *kvm, int irq)
+{
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	if (!irq_is_ppi(irq))
+		return -EINVAL;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!vcpu->arch.spe.irq_num)
+			continue;
+
+		if (vcpu->arch.spe.irq_num != irq)
+			return false;
+	}
+
+	return true;
+}
+
 int kvm_spe_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 {
+	if (!kvm_vcpu_supports_spe(vcpu))
+		return -ENXIO;
+
+	if (vcpu->arch.spe.initialized)
+		return -EBUSY;
+
+	switch (attr->attr) {
+	case KVM_ARM_VCPU_SPE_IRQ: {
+		int __user *uaddr = (int __user *)(long)attr->addr;
+		int irq;
+
+		if (vcpu->arch.spe.irq_num)
+			return -EBUSY;
+
+		if (get_user(irq, uaddr))
+			return -EFAULT;
+
+		if (!kvm_spe_irq_is_valid(vcpu->kvm, irq))
+			return -EINVAL;
+
+		kvm_debug("Set KVM_ARM_VCPU_SPE_IRQ: %d\n", irq);
+		vcpu->arch.spe.irq_num = irq;
+		return 0;
+	}
+	}
+
 	return -ENXIO;
 }
 
 int kvm_spe_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 {
+	if (!kvm_vcpu_supports_spe(vcpu))
+		return -ENXIO;
+
+	switch (attr->attr) {
+	case KVM_ARM_VCPU_SPE_IRQ: {
+		int __user *uaddr = (int __user *)(long)attr->addr;
+		int irq;
+
+		if (!vcpu->arch.spe.irq_num)
+			return -ENXIO;
+
+		irq = vcpu->arch.spe.irq_num;
+		if (put_user(irq, uaddr))
+			return -EFAULT;
+
+		return 0;
+	}
+	}
+
 	return -ENXIO;
 }
 
 int kvm_spe_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 {
+	if (!kvm_vcpu_supports_spe(vcpu))
+		return -ENXIO;
+
+	switch(attr->attr) {
+	case KVM_ARM_VCPU_SPE_IRQ:
+		return 0;
+	}
+
 	return -ENXIO;
 }
-- 
2.33.0


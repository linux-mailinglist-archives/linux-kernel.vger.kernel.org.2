Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA033F7A39
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbhHYQTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:19:55 -0400
Received: from foss.arm.com ([217.140.110.172]:54958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240934AbhHYQSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB4CF147A;
        Wed, 25 Aug 2021 09:18:08 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AB543F66F;
        Wed, 25 Aug 2021 09:18:07 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 35/39] KVM: arm64: Add an userspace API to stop a VCPU profiling
Date:   Wed, 25 Aug 2021 17:18:11 +0100
Message-Id: <20210825161815.266051-36-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the KVM_ARM_VCPU_SPE_CTRL(KVM_ARM_VCPU_SPE_STOP) VCPU attribute to
allow userspace to request that KVM disables profiling for that VCPU. The
ioctl does nothing yet.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 Documentation/virt/kvm/devices/vcpu.rst | 36 +++++++++++++++++++++++++
 arch/arm64/include/uapi/asm/kvm.h       |  4 +++
 arch/arm64/kvm/spe.c                    | 23 +++++++++++++---
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index c275c320e500..b4e38261b00f 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -201,3 +201,39 @@ Returns:
 Request initialization of the Statistical Profiling Extension for this VCPU.
 Must be done after initializaing the in-kernel irqchip and after setting the
 Profiling Buffer management interrupt number for the VCPU.
+
+4.3 ATTRIBUTE: KVM_ARM_VCPU_SPE_STOP
+------------------------------------
+
+:Parameters: in kvm_device_attr.addr the address to the flag that specifies
+             what KVM should do when the guest enables profiling
+
+The flag must be exactly one of:
+
+- KVM_ARM_VCPU_SPE_STOP_TRAP: trap all register accesses and ignore the guest
+  trying to enable profiling.
+- KVM_ARM_VCPU_SPE_STOP_EXIT: exit to userspace when the guest tries to enable
+  profiling.
+- KVM_ARM_VCPU_SPE_RESUME: resume profiling, if it was previously stopped using
+  this attribute.
+
+If KVM detects that a vcpu is trying to run with SPE enabled when
+KVM_ARM_VCPU_STOP_EXIT is set, KVM_RUN will return without entering the guest
+with kvm_run.exit_reason equal to KVM_EXIT_FAIL_ENTRY, and the fail_entry struct
+will be zeroed.
+
+Returns:
+
+	 =======  ============================================
+	 -EAGAIN  SPE not initialized
+	 -EFAULT  Error accessing the flag
+	 -EINVAL  Invalid flag
+	 -ENXIO   SPE not supported or not properly configured
+	 =======  ============================================
+
+Request that KVM disables SPE for the given vcpu. This can be useful for
+migration, which relies on tracking dirty pages by write-protecting memory, but
+breaks SPE in the guest as KVM does not handle buffer stage 2 faults.
+
+The attribute must be set after SPE has been initialized successfully. It can be
+set multiple times, with the latest value overwritting the previous one.
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index d4c0b53a5fb2..75a5113f610e 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -371,6 +371,10 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_ARM_VCPU_SPE_CTRL		3
 #define   KVM_ARM_VCPU_SPE_IRQ		0
 #define   KVM_ARM_VCPU_SPE_INIT		1
+#define   KVM_ARM_VCPU_SPE_STOP		2
+#define     KVM_ARM_VCPU_SPE_STOP_TRAP		(1 << 0)
+#define     KVM_ARM_VCPU_SPE_STOP_EXIT		(1 << 1)
+#define     KVM_ARM_VCPU_SPE_RESUME		(1 << 2)
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_VCPU2_SHIFT		28
diff --git a/arch/arm64/kvm/spe.c b/arch/arm64/kvm/spe.c
index 5b69501dc3da..2630e777fe1d 100644
--- a/arch/arm64/kvm/spe.c
+++ b/arch/arm64/kvm/spe.c
@@ -220,14 +220,14 @@ int kvm_spe_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	if (!kvm_vcpu_supports_spe(vcpu))
 		return -ENXIO;
 
-	if (vcpu->arch.spe.initialized)
-		return -EBUSY;
-
 	switch (attr->attr) {
 	case KVM_ARM_VCPU_SPE_IRQ: {
 		int __user *uaddr = (int __user *)(long)attr->addr;
 		int irq;
 
+		if (vcpu->arch.spe.initialized)
+			return -EBUSY;
+
 		if (vcpu->arch.spe.irq_num)
 			return -EBUSY;
 
@@ -248,11 +248,27 @@ int kvm_spe_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 		if (!vgic_initialized(vcpu->kvm))
 			return -ENXIO;
 
+		if (vcpu->arch.spe.initialized)
+			return -EBUSY;
+
 		if (kvm_vgic_set_owner(vcpu, vcpu->arch.spe.irq_num, &vcpu->arch.spe))
 			return -ENXIO;
 
 		vcpu->arch.spe.initialized = true;
 		return 0;
+	case KVM_ARM_VCPU_SPE_STOP: {
+		int __user *uaddr = (int __user *)(long)attr->addr;
+		int flags;
+
+		if (!vcpu->arch.spe.initialized)
+			return -EAGAIN;
+
+		if (get_user(flags, uaddr))
+			return -EFAULT;
+
+		if (!flags)
+			return -EINVAL;
+	}
 	}
 
 	return -ENXIO;
@@ -290,6 +306,7 @@ int kvm_spe_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	switch(attr->attr) {
 	case KVM_ARM_VCPU_SPE_IRQ:
 	case KVM_ARM_VCPU_SPE_INIT:
+	case KVM_ARM_VCPU_SPE_STOP:
 		return 0;
 	}
 
-- 
2.33.0


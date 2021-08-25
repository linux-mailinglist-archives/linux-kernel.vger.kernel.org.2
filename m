Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB993F7A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241920AbhHYQS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:18:56 -0400
Received: from foss.arm.com ([217.140.110.172]:54816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239184AbhHYQSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 684F6143B;
        Wed, 25 Aug 2021 09:17:44 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8A173F66F;
        Wed, 25 Aug 2021 09:17:42 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: [RFC PATCH v4 20/39] KVM: arm64: Add a new VCPU device control group for SPE
Date:   Wed, 25 Aug 2021 17:17:56 +0100
Message-Id: <20210825161815.266051-21-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

Add a new VCPU device control group to control various aspects of KVM's SPE
emulation. Functionality will be added in later patches.

[ Alexandru E: Rewrote patch ]

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 Documentation/virt/kvm/devices/vcpu.rst |  5 +++++
 arch/arm64/include/asm/kvm_spe.h        | 20 ++++++++++++++++++++
 arch/arm64/include/uapi/asm/kvm.h       |  1 +
 arch/arm64/kvm/guest.c                  | 10 ++++++++++
 arch/arm64/kvm/spe.c                    | 15 +++++++++++++++
 5 files changed, 51 insertions(+)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index 2acec3b9ef65..85399c005197 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -161,3 +161,8 @@ Specifies the base address of the stolen time structure for this VCPU. The
 base address must be 64 byte aligned and exist within a valid guest memory
 region. See Documentation/virt/kvm/arm/pvtime.rst for more information
 including the layout of the stolen time structure.
+
+4. GROUP: KVM_ARM_VCPU_SPE_CTRL
+===============================
+
+:Architectures: ARM64
diff --git a/arch/arm64/include/asm/kvm_spe.h b/arch/arm64/include/asm/kvm_spe.h
index ed67ddbf8132..ce0f5b3f2027 100644
--- a/arch/arm64/include/asm/kvm_spe.h
+++ b/arch/arm64/include/asm/kvm_spe.h
@@ -17,12 +17,32 @@ static __always_inline bool kvm_supports_spe(void)
 void kvm_spe_init_supported_cpus(void);
 void kvm_spe_vm_init(struct kvm *kvm);
 int kvm_spe_check_supported_cpus(struct kvm_vcpu *vcpu);
+
+int kvm_spe_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
+int kvm_spe_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
+int kvm_spe_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
 #else
 #define kvm_supports_spe()	(false)
 
 static inline void kvm_spe_init_supported_cpus(void) {}
 static inline void kvm_spe_vm_init(struct kvm *kvm) {}
 static inline int kvm_spe_check_supported_cpus(struct kvm_vcpu *vcpu) { return -ENOEXEC; }
+
+static inline int kvm_spe_set_attr(struct kvm_vcpu *vcpu,
+				   struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
+static inline int kvm_spe_get_attr(struct kvm_vcpu *vcpu,
+				   struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
+static inline int kvm_spe_has_attr(struct kvm_vcpu *vcpu,
+				   struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
 #endif /* CONFIG_KVM_ARM_SPE */
 
 #endif /* __ARM64_KVM_SPE_H__ */
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 9f0a8ea50ea9..7159a1e23da2 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -368,6 +368,7 @@ struct kvm_arm_copy_mte_tags {
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
 #define KVM_ARM_VCPU_PVTIME_CTRL	2
 #define   KVM_ARM_VCPU_PVTIME_IPA	0
+#define KVM_ARM_VCPU_SPE_CTRL		3
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_VCPU2_SHIFT		28
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 1dfb83578277..316110b5dd95 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -24,6 +24,7 @@
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_spe.h>
 #include <asm/sigcontext.h>
 
 #include "trace.h"
@@ -962,6 +963,9 @@ int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
 	case KVM_ARM_VCPU_PVTIME_CTRL:
 		ret = kvm_arm_pvtime_set_attr(vcpu, attr);
 		break;
+	case KVM_ARM_VCPU_SPE_CTRL:
+		ret = kvm_spe_set_attr(vcpu, attr);
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -985,6 +989,9 @@ int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
 	case KVM_ARM_VCPU_PVTIME_CTRL:
 		ret = kvm_arm_pvtime_get_attr(vcpu, attr);
 		break;
+	case KVM_ARM_VCPU_SPE_CTRL:
+		ret = kvm_spe_get_attr(vcpu, attr);
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -1008,6 +1015,9 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
 	case KVM_ARM_VCPU_PVTIME_CTRL:
 		ret = kvm_arm_pvtime_has_attr(vcpu, attr);
 		break;
+	case KVM_ARM_VCPU_SPE_CTRL:
+		ret = kvm_spe_has_attr(vcpu, attr);
+		break;
 	default:
 		ret = -ENXIO;
 		break;
diff --git a/arch/arm64/kvm/spe.c b/arch/arm64/kvm/spe.c
index 8d2afc137151..56a3fdb35623 100644
--- a/arch/arm64/kvm/spe.c
+++ b/arch/arm64/kvm/spe.c
@@ -42,3 +42,18 @@ int kvm_spe_check_supported_cpus(struct kvm_vcpu *vcpu)
 
 	return 0;
 }
+
+int kvm_spe_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
+
+int kvm_spe_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
+
+int kvm_spe_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A723F7A13
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbhHYQSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:18:34 -0400
Received: from foss.arm.com ([217.140.110.172]:54736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239399AbhHYQSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71570D6E;
        Wed, 25 Aug 2021 09:17:31 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22D013F66F;
        Wed, 25 Aug 2021 09:17:29 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 12/39] KVM: arm64: Add the KVM_ARM_VCPU_SUPPORTED_CPUS VCPU ioctl
Date:   Wed, 25 Aug 2021 17:17:48 +0100
Message-Id: <20210825161815.266051-13-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ioctl is used to specify a list of physical CPUs on which the VCPU is
allowed to run. The ioctl introduces no constraints on the VCPU scheduling,
and userspace is expected to manage the VCPU affinity. Attempting to run
the VCPU on a CPU not present in the list will result in KVM_RUN returning
-ENOEXEC.

The expectation is that this ioctl will be used by KVM to prevent errors,
like accesses to undefined registers, when emulating VCPU features for
which hardware support is present only on a subset of the CPUs present in
the system.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 Documentation/virt/kvm/api.rst    | 22 ++++++++++++++++++++--
 arch/arm64/include/asm/kvm_host.h |  3 +++
 arch/arm64/kvm/arm.c              | 31 +++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |  4 ++++
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 5aa251df7077..994faa24690a 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -396,8 +396,10 @@ Errors:
 
   =======    ==============================================================
   EINTR      an unmasked signal is pending
-  ENOEXEC    the vcpu hasn't been initialized or the guest tried to execute
-             instructions from device memory (arm64)
+  ENOEXEC    the vcpu hasn't been initialized, the guest tried to execute
+             instructions from device memory (arm64) or the vcpu has been
+             scheduled on a cpu not in the list specified by
+             KVM_ARM_VCPU_SUPPORTED_CPUS (arm64).
   ENOSYS     data abort outside memslots with no syndrome info and
              KVM_CAP_ARM_NISV_TO_USER not enabled (arm64)
   EPERM      SVE feature set but not finalized (arm64)
@@ -5293,6 +5295,22 @@ the trailing ``'\0'``, is indicated by ``name_size`` in the header.
 The Stats Data block contains an array of 64-bit values in the same order
 as the descriptors in Descriptors block.
 
+4.134 KVM_ARM_VCPU_SUPPORTED_CPUS
+---------------------------------
+
+:Capability: KVM_CAP_ARM_SUPPORTED_CPUS
+:Architectures: arm64
+:Type: vcpu ioctl
+:Parameters: const char * representing a range of supported CPUs
+:Returns: 0 on success, < 0 on error
+
+Specifies a list of physical CPUs on which the VCPU can run. KVM will not make
+any attempts to prevent the VCPU from being scheduled on a CPU which is not
+present in the list; when that happens, KVM_RUN will return -ENOEXEC.
+
+The format for the range of supported CPUs is specified in the comment for
+the function lib/bitmap.c::bitmap_parselist().
+
 5. The kvm_run structure
 ========================
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a57f33368a3e..1f3b46a6df81 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -396,6 +396,9 @@ struct kvm_vcpu_arch {
 	 * see kvm_vcpu_load_sysregs_vhe and kvm_vcpu_put_sysregs_vhe. */
 	bool sysregs_loaded_on_cpu;
 
+	cpumask_t supported_cpus;
+	bool cpu_not_supported;
+
 	/* Guest PV state */
 	struct {
 		u64 last_steal;
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 4bd4b8b082a4..e8a7c0c3a086 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -301,6 +301,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_LOCK_USER_MEMORY_REGION:
 		r = 1;
 		break;
+	case KVM_CAP_ARM_VCPU_SUPPORTED_CPUS:
+		r = 1;
+		break;
 	default:
 		r = 0;
 	}
@@ -456,6 +459,10 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (vcpu_has_ptrauth(vcpu))
 		vcpu_ptrauth_disable(vcpu);
 	kvm_arch_vcpu_load_debug_state_flags(vcpu);
+
+	if (!cpumask_empty(&vcpu->arch.supported_cpus) &&
+	    !cpumask_test_cpu(smp_processor_id(), &vcpu->arch.supported_cpus))
+		vcpu->arch.cpu_not_supported = true;
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -844,6 +851,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 */
 		preempt_disable();
 
+		if (unlikely(vcpu->arch.cpu_not_supported)) {
+			vcpu->arch.cpu_not_supported = false;
+			ret = -ENOEXEC;
+			preempt_enable();
+			continue;
+		}
+
 		kvm_pmu_flush_hwstate(vcpu);
 
 		local_irq_disable();
@@ -1361,6 +1375,23 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 
 		return kvm_arm_vcpu_set_events(vcpu, &events);
 	}
+	case KVM_ARM_VCPU_SUPPORTED_CPUS: {
+		char *cpulist;
+
+		r = -ENOEXEC;
+		if (unlikely(vcpu->arch.has_run_once))
+			break;
+
+		cpulist = strndup_user((const char __user *)argp, PAGE_SIZE);
+		if (IS_ERR(cpulist)) {
+			r = PTR_ERR(cpulist);
+			break;
+		}
+
+		r = cpulist_parse(cpulist, &vcpu->arch.supported_cpus);
+		kfree(cpulist);
+		break;
+	}
 	case KVM_ARM_VCPU_FINALIZE: {
 		int what;
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index bcf62c7bdd2d..e5acc925c528 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1113,6 +1113,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
 #define KVM_CAP_ARM_MTE 205
 #define KVM_CAP_ARM_LOCK_USER_MEMORY_REGION 206
+#define KVM_CAP_ARM_VCPU_SUPPORTED_CPUS 207
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1594,6 +1595,9 @@ struct kvm_enc_region {
 #define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
 #define KVM_S390_CLEAR_RESET	_IO(KVMIO,   0xc4)
 
+/* Available with KVM_CAP_ARM_VCPU_SUPPORTED_CPUS */
+#define KVM_ARM_VCPU_SUPPORTED_CPUS    _IOW(KVMIO, 0xc5, const char *)
+
 struct kvm_s390_pv_sec_parm {
 	__u64 origin;
 	__u64 length;
-- 
2.33.0


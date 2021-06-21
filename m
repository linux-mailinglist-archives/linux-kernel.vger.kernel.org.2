Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A403AE80C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFULVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:21:12 -0400
Received: from foss.arm.com ([217.140.110.172]:32912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhFULVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:21:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49288D6E;
        Mon, 21 Jun 2021 04:18:45 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E2C73F718;
        Mon, 21 Jun 2021 04:18:42 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v17 6/6] KVM: arm64: Document MTE capability and ioctl
Date:   Mon, 21 Jun 2021 12:17:16 +0100
Message-Id: <20210621111716.37157-7-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210621111716.37157-1-steven.price@arm.com>
References: <20210621111716.37157-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new capability (KVM_CAP_ARM_MTE) identifies that the kernel supports
granting a guest access to the tags, and provides a mechanism for the
VMM to enable it.

A new ioctl (KVM_ARM_MTE_COPY_TAGS) provides a simple way for a VMM to
access the tags of a guest without having to maintain a PROT_MTE mapping
in userspace. The above capability gates access to the ioctl.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 Documentation/virt/kvm/api.rst | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 7fcb2fd38f42..97661a97943f 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5034,6 +5034,43 @@ see KVM_XEN_VCPU_SET_ATTR above.
 The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
 with the KVM_XEN_VCPU_GET_ATTR ioctl.
 
+4.130 KVM_ARM_MTE_COPY_TAGS
+---------------------------
+
+:Capability: KVM_CAP_ARM_MTE
+:Architectures: arm64
+:Type: vm ioctl
+:Parameters: struct kvm_arm_copy_mte_tags
+:Returns: number of bytes copied, < 0 on error (-EINVAL for incorrect
+          arguments, -EFAULT if memory cannot be accessed).
+
+::
+
+  struct kvm_arm_copy_mte_tags {
+	__u64 guest_ipa;
+	__u64 length;
+	void __user *addr;
+	__u64 flags;
+	__u64 reserved[2];
+  };
+
+Copies Memory Tagging Extension (MTE) tags to/from guest tag memory. The
+``guest_ipa`` and ``length`` fields must be ``PAGE_SIZE`` aligned. The ``addr``
+field must point to a buffer which the tags will be copied to or from.
+
+``flags`` specifies the direction of copy, either ``KVM_ARM_TAGS_TO_GUEST`` or
+``KVM_ARM_TAGS_FROM_GUEST``.
+
+The size of the buffer to store the tags is ``(length / 16)`` bytes
+(granules in MTE are 16 bytes long). Each byte contains a single tag
+value. This matches the format of ``PTRACE_PEEKMTETAGS`` and
+``PTRACE_POKEMTETAGS``.
+
+If an error occurs before any data is copied then a negative error code is
+returned. If some tags have been copied before an error occurs then the number
+of bytes successfully copied is returned. If the call completes successfully
+then ``length`` is returned.
+
 5. The kvm_run structure
 ========================
 
@@ -6362,6 +6399,30 @@ default.
 
 See Documentation/x86/sgx/2.Kernel-internals.rst for more details.
 
+7.26 KVM_CAP_ARM_MTE
+--------------------
+
+:Architectures: arm64
+:Parameters: none
+
+This capability indicates that KVM (and the hardware) supports exposing the
+Memory Tagging Extensions (MTE) to the guest. It must also be enabled by the
+VMM before creating any VCPUs to allow the guest access. Note that MTE is only
+available to a guest running in AArch64 mode and enabling this capability will
+cause attempts to create AArch32 VCPUs to fail.
+
+When enabled the guest is able to access tags associated with any memory given
+to the guest. KVM will ensure that the tags are maintained during swap or
+hibernation of the host; however the VMM needs to manually save/restore the
+tags as appropriate if the VM is migrated.
+
+When this capability is enabled all memory in memslots must be mapped as
+not-shareable (no MAP_SHARED), attempts to create a memslot with a
+MAP_SHARED mmap will result in an -EINVAL return.
+
+When enabled the VMM may make use of the ``KVM_ARM_MTE_COPY_TAGS`` ioctl to
+perform a bulk copy of tags to/from the guest.
+
 8. Other capabilities.
 ======================
 
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F105736245E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhDPPoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:44:12 -0400
Received: from foss.arm.com ([217.140.110.172]:44652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236485AbhDPPoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:44:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 895981396;
        Fri, 16 Apr 2021 08:43:40 -0700 (PDT)
Received: from e112269-lin.arm.com (autoplooker.cambridge.arm.com [10.1.194.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBBE13F99C;
        Fri, 16 Apr 2021 08:43:37 -0700 (PDT)
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
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: [PATCH v11 6/6] KVM: arm64: Document MTE capability and ioctl
Date:   Fri, 16 Apr 2021 16:43:09 +0100
Message-Id: <20210416154309.22129-7-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416154309.22129-1-steven.price@arm.com>
References: <20210416154309.22129-1-steven.price@arm.com>
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

Signed-off-by: Steven Price <steven.price@arm.com>
---
 Documentation/virt/kvm/api.rst | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 1a2b5210cdbf..ccc84f21ba5e 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4938,6 +4938,40 @@ see KVM_XEN_VCPU_SET_ATTR above.
 The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
 with the KVM_XEN_VCPU_GET_ATTR ioctl.
 
+4.131 KVM_ARM_MTE_COPY_TAGS
+---------------------------
+
+:Capability: KVM_CAP_ARM_MTE
+:Architectures: arm64
+:Type: vm ioctl
+:Parameters: struct kvm_arm_copy_mte_tags
+:Returns: 0 on success, < 0 on error
+
+::
+
+  struct kvm_arm_copy_mte_tags {
+	__u64 guest_ipa;
+	__u64 length;
+	union {
+		void __user *addr;
+		__u64 padding;
+	};
+	__u64 flags;
+	__u64 reserved[2];
+  };
+
+Copies Memory Tagging Extension (MTE) tags to/from guest tag memory. The
+``guest_ipa`` and ``length`` fields must be ``PAGE_SIZE`` aligned. The ``addr``
+fieldmust point to a buffer which the tags will be copied to or from.
+
+``flags`` specifies the direction of copy, either ``KVM_ARM_TAGS_TO_GUEST`` or
+``KVM_ARM_TAGS_FROM_GUEST``.
+
+The size of the buffer to store the tags is ``(length / MTE_GRANULE_SIZE)``
+bytes (i.e. 1/16th of the corresponding size). Each byte contains a single tag
+value. This matches the format of ``PTRACE_PEEKMTETAGS`` and
+``PTRACE_POKEMTETAGS``.
+
 5. The kvm_run structure
 ========================
 
@@ -6227,6 +6261,25 @@ KVM_RUN_BUS_LOCK flag is used to distinguish between them.
 This capability can be used to check / enable 2nd DAWR feature provided
 by POWER10 processor.
 
+7.23 KVM_CAP_ARM_MTE
+--------------------
+
+:Architectures: arm64
+:Parameters: none
+
+This capability indicates that KVM (and the hardware) supports exposing the
+Memory Tagging Extensions (MTE) to the guest. It must also be enabled by the
+VMM before the guest will be granted access.
+
+When enabled the guest is able to access tags associated with any memory given
+to the guest. KVM will ensure that the pages are flagged ``PG_mte_tagged`` so
+that the tags are maintained during swap or hibernation of the host; however
+the VMM needs to manually save/restore the tags as appropriate if the VM is
+migrated.
+
+When enabled the VMM may make use of the ``KVM_ARM_MTE_COPY_TAGS`` ioctl to
+perform a bulk copy of tags to/from the guest.
+
 8. Other capabilities.
 ======================
 
-- 
2.20.1


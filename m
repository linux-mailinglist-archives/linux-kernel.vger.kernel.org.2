Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262CE3280C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhCAO1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:27:11 -0500
Received: from foss.arm.com ([217.140.110.172]:59112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235781AbhCAOZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:25:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D1B61396;
        Mon,  1 Mar 2021 06:23:51 -0800 (PST)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D7D13F70D;
        Mon,  1 Mar 2021 06:23:48 -0800 (PST)
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
Subject: [PATCH v9 6/6] KVM: arm64: Document MTE capability and ioctl
Date:   Mon,  1 Mar 2021 14:23:15 +0000
Message-Id: <20210301142315.30920-7-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210301142315.30920-1-steven.price@arm.com>
References: <20210301142315.30920-1-steven.price@arm.com>
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
 Documentation/virt/kvm/api.rst | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index aed52b0fc16e..1406ea138127 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4939,6 +4939,23 @@ KVM_XEN_VCPU_ATTR_TYPE_VCPU_TIME_INFO
 Allows Xen vCPU attributes to be read. For the structure and types,
 see KVM_XEN_VCPU_SET_ATTR above.
 
+4.131 KVM_ARM_MTE_COPY_TAGS
+---------------------------
+
+:Capability: KVM_CAP_ARM_MTE
+:Architectures: arm64
+:Type: vm ioctl
+:Parameters: struct kvm_arm_copy_mte_tags
+:Returns: 0 on success, < 0 on error
+
+Copies Memory Tagging Extension (MTE) tags to/from guest tag memory. The
+starting address and length of guest memory must be ``PAGE_SIZE`` aligned.
+
+The size of the buffer to store the tags is ``(length / MTE_GRANULE_SIZE)``
+bytes (i.e. 1/16th of the corresponding size). Each byte contains a single tag
+value. This matches the format of ``PTRACE_PEEKMTETAGS`` and
+``PTRACE_POKEMTETAGS``.
+
 5. The kvm_run structure
 ========================
 
@@ -6227,6 +6244,25 @@ KVM_RUN_BUS_LOCK flag is used to distinguish between them.
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
+that the tags are maintained during swap or hibernation of the host, however
+the VMM needs to manually save/restore the tags as appropriate if the VM is
+migrated.
+
+When enabled the VMM may make use of the ``KVM_ARM_MTE_COPY_TAGS`` ioctl to
+perform a bulk copy of tags to/from the guest
+
 8. Other capabilities.
 ======================
 
@@ -6716,3 +6752,4 @@ KVM_XEN_HVM_SET_ATTR, KVM_XEN_HVM_GET_ATTR, KVM_XEN_VCPU_SET_ATTR and
 KVM_XEN_VCPU_GET_ATTR ioctls, as well as the delivery of exception vectors
 for event channel upcalls when the evtchn_upcall_pending field of a vcpu's
 vcpu_info is set.
+
-- 
2.20.1


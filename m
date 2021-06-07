Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D2039E584
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFGReM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231177AbhFGReK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:34:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7871661090;
        Mon,  7 Jun 2021 17:32:16 +0000 (UTC)
Date:   Mon, 7 Jun 2021 18:32:14 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v14 8/8] KVM: arm64: Document MTE capability and ioctl
Message-ID: <20210607173213.GC17957@arm.com>
References: <20210607110816.25762-1-steven.price@arm.com>
 <20210607110816.25762-9-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607110816.25762-9-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 12:08:16PM +0100, Steven Price wrote:
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 22d077562149..fc6f0cbc30b3 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5034,6 +5034,42 @@ see KVM_XEN_VCPU_SET_ATTR above.
>  The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
>  with the KVM_XEN_VCPU_GET_ATTR ioctl.
>  
> +4.130 KVM_ARM_MTE_COPY_TAGS
> +---------------------------
> +
> +:Capability: KVM_CAP_ARM_MTE
> +:Architectures: arm64
> +:Type: vm ioctl
> +:Parameters: struct kvm_arm_copy_mte_tags
> +:Returns: number of bytes copied, < 0 on error

I guess you can be a bit more specific here, -EINVAL on incorrect
arguments, -EFAULT if the guest memory cannot be accessed.

> +
> +::
> +
> +  struct kvm_arm_copy_mte_tags {
> +	__u64 guest_ipa;
> +	__u64 length;
> +	void __user *addr;
> +	__u64 flags;
> +	__u64 reserved[2];
> +  };
> +
> +Copies Memory Tagging Extension (MTE) tags to/from guest tag memory. The
> +``guest_ipa`` and ``length`` fields must be ``PAGE_SIZE`` aligned. The ``addr``
> +fieldmust point to a buffer which the tags will be copied to or from.

s/fieldmust/field must/

> +
> +``flags`` specifies the direction of copy, either ``KVM_ARM_TAGS_TO_GUEST`` or
> +``KVM_ARM_TAGS_FROM_GUEST``.
> +
> +The size of the buffer to store the tags is ``(length / 16)`` bytes
> +(granules in MTE are 16 bytes long). Each byte contains a single tag
> +value. This matches the format of ``PTRACE_PEEKMTETAGS`` and
> +``PTRACE_POKEMTETAGS``.

One difference I think with ptrace() is that iov_len (length here) is
the actual buffer size. But for kvm I think this works better since
length is tied to the guest_ipa.

> +
> +If an error occurs before any data is copied then a negative error code is
> +returned. If some tags have been copied before an error occurs then the number
> +of bytes successfully copied is returned. If the call completes successfully
> +then ``length`` is returned.
> +
>  5. The kvm_run structure
>  ========================
>  
> @@ -6362,6 +6398,27 @@ default.
>  
>  See Documentation/x86/sgx/2.Kernel-internals.rst for more details.
>  
> +7.26 KVM_CAP_ARM_MTE
> +--------------------
> +
> +:Architectures: arm64
> +:Parameters: none
> +
> +This capability indicates that KVM (and the hardware) supports exposing the
> +Memory Tagging Extensions (MTE) to the guest. It must also be enabled by the
> +VMM before creating any VCPUs to allow the guest access. Note that MTE is only
> +available to a guest running in AArch64 mode and enabling this capability will
> +cause attempts to create AArch32 VCPUs to fail.
> +
> +When enabled the guest is able to access tags associated with any memory given
> +to the guest. KVM will ensure that the pages are flagged ``PG_mte_tagged`` so
> +that the tags are maintained during swap or hibernation of the host; however

I'd drop PG_mte_tagged here, that's just how the implementation handles
it, not necessary for describing the API. You can just say "KVM will
ensure that the tags are maintained during swap or hibernation of the
host"

> +the VMM needs to manually save/restore the tags as appropriate if the VM is
> +migrated.
> +
> +When enabled the VMM may make use of the ``KVM_ARM_MTE_COPY_TAGS`` ioctl to
> +perform a bulk copy of tags to/from the guest.
> +
>  8. Other capabilities.
>  ======================
>  
> -- 
> 2.20.1

Otherwise, feel free to add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B12A4312B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhJRJGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:06:55 -0400
Received: from foss.arm.com ([217.140.110.172]:34288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhJRJGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:06:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73917101E;
        Mon, 18 Oct 2021 02:04:40 -0700 (PDT)
Received: from [10.57.25.70] (unknown [10.57.25.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 508933F70D;
        Mon, 18 Oct 2021 02:04:39 -0700 (PDT)
Subject: Re: [RFC PATCH v4 02/39] KVM: arm64: Add lock/unlock memslot user API
To:     Alexandru Elisei <alexandru.elisei@arm.com>, maz@kernel.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, will@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
 <20210825161815.266051-3-alexandru.elisei@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <480ab754-dd07-1f24-4721-ccfdf0991d53@arm.com>
Date:   Mon, 18 Oct 2021 10:04:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210825161815.266051-3-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2021 17:17, Alexandru Elisei wrote:
> Stage 2 faults triggered by the profiling buffer attempting to write to
> memory are reported by the SPE hardware by asserting a buffer management
> event interrupt. Interrupts are by their nature asynchronous, which means
> that the guest might have changed its stage 1 translation tables since the
> attempted write. SPE reports the guest virtual address that caused the data
> abort, not the IPA, which means that KVM would have to walk the guest's
> stage 1 tables to find the IPA. Using the AT instruction to walk the
> guest's tables in hardware is not an option because it doesn't report the
> IPA in the case of a stage 2 fault on a stage 1 table walk.
> 
> Avoid both issues by pre-mapping the guest memory at stage 2. This is being
> done by adding a capability that allows the user to pin the memory backing
> a memslot. The same capability can be used to unlock a memslot, which
> unpins the pages associated with the memslot, but doesn't unmap the IPA
> range from stage 2; in this case, the addresses will be unmapped from stage
> 2 via the MMU notifiers when the process' address space changes.
> 
> For now, the capability doesn't actually do anything other than checking
> that the usage is correct; the memory operations will be added in future
> patches.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>   Documentation/virt/kvm/api.rst   | 56 +++++++++++++++++++++++
>   arch/arm64/include/asm/kvm_mmu.h |  3 ++
>   arch/arm64/kvm/arm.c             | 42 ++++++++++++++++--
>   arch/arm64/kvm/mmu.c             | 76 ++++++++++++++++++++++++++++++++
>   include/uapi/linux/kvm.h         |  8 ++++
>   5 files changed, 181 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index dae68e68ca23..741327ef06b0 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6682,6 +6682,62 @@ MAP_SHARED mmap will result in an -EINVAL return.
>   When enabled the VMM may make use of the ``KVM_ARM_MTE_COPY_TAGS`` ioctl to
>   perform a bulk copy of tags to/from the guest.
>   
> +7.29 KVM_CAP_ARM_LOCK_USER_MEMORY_REGION
> +----------------------------------------
> +
> +:Architectures: arm64
> +:Target: VM
> +:Parameters: flags is one of KVM_ARM_LOCK_USER_MEMORY_REGION_FLAGS_LOCK or
> +                     KVM_ARM_LOCK_USER_MEMORY_REGION_FLAGS_UNLOCK
> +             args[0] is the slot number
> +             args[1] specifies the permisions when the memslot is locked or if
> +                     all memslots should be unlocked
> +
> +The presence of this capability indicates that KVM supports locking the memory
> +associated with the memslot, and unlocking a previously locked memslot.
> +
> +The 'flags' parameter is defined as follows:
> +
> +7.29.1 KVM_ARM_LOCK_USER_MEMORY_REGION_FLAGS_LOCK
> +-------------------------------------------------
> +
> +:Capability: 'flags' parameter to KVM_CAP_ARM_LOCK_USER_MEMORY_REGION
> +:Architectures: arm64
> +:Target: VM
> +:Parameters: args[0] contains the memory slot number
> +             args[1] contains the permissions for the locked memory:
> +                     KVM_ARM_LOCK_MEMORY_READ (mandatory) to map it with
> +                     read permissions and KVM_ARM_LOCK_MEMORY_WRITE
> +                     (optional) with write permissions
> +:Returns: 0 on success; negative error code on failure
> +
> +Enabling this capability causes the memory described by the memslot to be
> +pinned in the process address space and the corresponding stage 2 IPA range
> +mapped at stage 2. The permissions specified in args[1] apply to both
> +mappings. The memory pinned with this capability counts towards the max
> +locked memory limit for the current process.
> +
> +The capability must be enabled before any VCPUs have run. The virtual memory
> +range described by the memslot must be mapped in the userspace process without
> +any gaps. It is considered an error if write permissions are specified for a
> +memslot which logs dirty pages.
> +
> +7.29.2 KVM_ARM_LOCK_USER_MEMORY_REGION_FLAGS_UNLOCK
> +---------------------------------------------------
> +
> +:Capability: 'flags' parameter to KVM_CAP_ARM_LOCK_USER_MEMORY_REGION
> +:Architectures: arm64
> +:Target: VM
> +:Parameters: args[0] contains the memory slot number
> +             args[1] optionally contains the flag KVM_ARM_UNLOCK_MEM_ALL,
> +                     which unlocks all previously locked memslots.
> +:Returns: 0 on success; negative error code on failure
> +
> +Enabling this capability causes the memory pinned when locking the memslot
> +specified in args[0] to be unpinned, or, optionally, the memory associated
> +with all locked memslots, to be unpinned. The IPA range is not unmapped
> +from stage 2.
> +
>   8. Other capabilities.
>   ======================
>   
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index b52c5c4b9a3d..ef079b5eb475 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -216,6 +216,9 @@ static inline void __invalidate_icache_guest_page(void *va, size_t size)
>   void kvm_set_way_flush(struct kvm_vcpu *vcpu);
>   void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled);
>   
> +int kvm_mmu_lock_memslot(struct kvm *kvm, u64 slot, u64 flags);
> +int kvm_mmu_unlock_memslot(struct kvm *kvm, u64 slot, u64 flags);
> +
>   static inline unsigned int kvm_get_vmid_bits(void)
>   {
>   	int reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index ddace63528f1..57ac97b30b3d 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -80,16 +80,43 @@ int kvm_arch_check_processor_compat(void *opaque)
>   	return 0;
>   }
>   
> +static int kvm_arm_lock_memslot_supported(void)
> +{
> +	return 0;
> +}
> +
> +static int kvm_lock_user_memory_region_ioctl(struct kvm *kvm,
> +					     struct kvm_enable_cap *cap)
> +{
> +	u64 slot, flags;
> +	u32 action;
> +
> +	if (cap->args[2] || cap->args[3])
> +		return -EINVAL;
> +
> +	slot = cap->args[0];
> +	flags = cap->args[1];

nit: ^^ Please could we rename "flags" => "perm" (ission) ?

> +	action = cap->flags;

We already have cap->flags, and using arg[1] as flags ( which indeed
is permission by definition) is confusing.

Suzuki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD78388F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353766AbhESNxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:53:25 -0400
Received: from foss.arm.com ([217.140.110.172]:40196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239473AbhESNxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:53:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B5BA31B;
        Wed, 19 May 2021 06:52:04 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C3DA3F73B;
        Wed, 19 May 2021 06:52:01 -0700 (PDT)
Subject: Re: [PATCH v12 7/8] KVM: arm64: ioctl to fetch/store tags in a guest
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-8-steven.price@arm.com> <87sg2ltexj.wl-maz@kernel.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <5c0f6cd7-5f2d-de5b-f057-f3b307cb9416@arm.com>
Date:   Wed, 19 May 2021 14:51:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87sg2ltexj.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2021 19:04, Marc Zyngier wrote:
> On Mon, 17 May 2021 13:32:38 +0100,
> Steven Price <steven.price@arm.com> wrote:
>>
>> The VMM may not wish to have it's own mapping of guest memory mapped
>> with PROT_MTE because this causes problems if the VMM has tag checking
>> enabled (the guest controls the tags in physical RAM and it's unlikely
>> the tags are correct for the VMM).
>>
>> Instead add a new ioctl which allows the VMM to easily read/write the
>> tags from guest memory, allowing the VMM's mapping to be non-PROT_MTE
>> while the VMM can still read/write the tags for the purpose of
>> migration.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>  arch/arm64/include/uapi/asm/kvm.h | 11 +++++
>>  arch/arm64/kvm/arm.c              | 69 +++++++++++++++++++++++++++++++
>>  include/uapi/linux/kvm.h          |  1 +
>>  3 files changed, 81 insertions(+)
>>
>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>> index 24223adae150..b3edde68bc3e 100644
>> --- a/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -184,6 +184,17 @@ struct kvm_vcpu_events {
>>  	__u32 reserved[12];
>>  };
>>  
>> +struct kvm_arm_copy_mte_tags {
>> +	__u64 guest_ipa;
>> +	__u64 length;
>> +	void __user *addr;
>> +	__u64 flags;
>> +	__u64 reserved[2];
>> +};
>> +
>> +#define KVM_ARM_TAGS_TO_GUEST		0
>> +#define KVM_ARM_TAGS_FROM_GUEST		1
>> +
>>  /* If you need to interpret the index values, here is the key: */
>>  #define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
>>  #define KVM_REG_ARM_COPROC_SHIFT	16
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index e89a5e275e25..4b6c83beb75d 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -1309,6 +1309,65 @@ static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
>>  	}
>>  }
>>  
>> +static int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
>> +				      struct kvm_arm_copy_mte_tags *copy_tags)
>> +{
>> +	gpa_t guest_ipa = copy_tags->guest_ipa;
>> +	size_t length = copy_tags->length;
>> +	void __user *tags = copy_tags->addr;
>> +	gpa_t gfn;
>> +	bool write = !(copy_tags->flags & KVM_ARM_TAGS_FROM_GUEST);
>> +	int ret = 0;
>> +
>> +	if (copy_tags->reserved[0] || copy_tags->reserved[1])
>> +		return -EINVAL;
>> +
>> +	if (copy_tags->flags & ~KVM_ARM_TAGS_FROM_GUEST)
>> +		return -EINVAL;
>> +
>> +	if (length & ~PAGE_MASK || guest_ipa & ~PAGE_MASK)
>> +		return -EINVAL;
>> +
>> +	gfn = gpa_to_gfn(guest_ipa);
>> +
>> +	mutex_lock(&kvm->slots_lock);
>> +
>> +	while (length > 0) {
>> +		kvm_pfn_t pfn = gfn_to_pfn_prot(kvm, gfn, write, NULL);
>> +		void *maddr;
>> +		unsigned long num_tags = PAGE_SIZE / MTE_GRANULE_SIZE;
> 
> nit: this is a compile time constant, make it a #define. This will
> avoid the confusing overloading of "num_tags" as both an input and an
> output for the mte_copy_tags-* functions.

No problem, I agree my usage of num_tags wasn't very clear.

>> +
>> +		if (is_error_noslot_pfn(pfn)) {
>> +			ret = -EFAULT;
>> +			goto out;
>> +		}
>> +
>> +		maddr = page_address(pfn_to_page(pfn));
>> +
>> +		if (!write) {
>> +			num_tags = mte_copy_tags_to_user(tags, maddr, num_tags);
>> +			kvm_release_pfn_clean(pfn);
>> +		} else {
>> +			num_tags = mte_copy_tags_from_user(maddr, tags,
>> +							   num_tags);
>> +			kvm_release_pfn_dirty(pfn);
>> +		}
>> +
>> +		if (num_tags != PAGE_SIZE / MTE_GRANULE_SIZE) {
>> +			ret = -EFAULT;
>> +			goto out;
>> +		}
>> +
>> +		gfn++;
>> +		tags += num_tags;
>> +		length -= PAGE_SIZE;
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&kvm->slots_lock);
>> +	return ret;
>> +}
>> +
> 
> nit again: I'd really prefer it if you moved this to guest.c, where we
> already have a bunch of the save/restore stuff.

Sure - I'll move it across.

Thanks,

Steve

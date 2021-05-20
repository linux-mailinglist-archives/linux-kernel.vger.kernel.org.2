Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732F438B3D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhETP73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:59:29 -0400
Received: from foss.arm.com ([217.140.110.172]:54570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232488AbhETP71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:59:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 563B131B;
        Thu, 20 May 2021 08:58:05 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 804E03F73B;
        Thu, 20 May 2021 08:58:02 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v12 7/8] KVM: arm64: ioctl to fetch/store tags in a guest
To:     Catalin Marinas <catalin.marinas@arm.com>
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
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-8-steven.price@arm.com> <20210520120556.GC12251@arm.com>
Message-ID: <dd5ab3a0-5a74-b145-2485-d6d871be945b@arm.com>
Date:   Thu, 20 May 2021 16:58:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520120556.GC12251@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2021 13:05, Catalin Marinas wrote:
> On Mon, May 17, 2021 at 01:32:38PM +0100, Steven Price wrote:
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
> 
> I forgot the past discussions, what's the reserved for? Future
> expansion?

Yes - for future expansion. Marc asked for them[1]:

> I'd be keen on a couple of reserved __64s. Just in case...

[1] https://lore.kernel.org/r/87ft14xl9e.wl-maz%40kernel.org

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
> 
> Do we need to check if PG_mte_tagged is set? If the page was not faulted
> into the guest address space but the VMM has the page, does the
> gfn_to_pfn_prot() guarantee that a kvm_set_spte_gfn() was called? If
> not, this may read stale tags.

Ah, I hadn't thought about that... No I don't believe gfn_to_pfn_prot()
will fault it into the guest.

>> +		} else {
>> +			num_tags = mte_copy_tags_from_user(maddr, tags,
>> +							   num_tags);
>> +			kvm_release_pfn_dirty(pfn);
>> +		}
> 
> Same question here, if the we can't guarantee the stage 2 pte being set,
> we'd need to set PG_mte_tagged.

This is arguably worse as we'll be writing tags into the guest but
without setting PG_mte_tagged - so they'll be lost when the guest then
faults the pages in. Which sounds like it should break migration.

I think the below should be safe, and avoids the overhead of setting the
flag just for reads.

Thanks,

Steve

----8<----
		page = pfn_to_page(pfn);
		maddr = page_address(page);

		if (!write) {
			if (test_bit(PG_mte_tagged, &page->flags))
				num_tags = mte_copy_tags_to_user(tags, maddr,
							MTE_GRANULES_PER_PAGE);
			else
				/* No tags in memory, so write zeros */
				num_tags = MTE_GRANULES_PER_PAGE -
					clear_user(tag, MTE_GRANULES_PER_PAGE);
			kvm_release_pfn_clean(pfn);
		} else {
			num_tags = mte_copy_tags_from_user(maddr, tags,
							MTE_GRANULES_PER_PAGE);
			kvm_release_pfn_dirty(pfn);
		}

		if (num_tags != MTE_GRANULES_PER_PAGE) {
			ret = -EFAULT;
			goto out;
		}

		if (write)
			test_and_set_bit(PG_mte_tagged, &page->flags);

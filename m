Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8896738C352
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhEUJjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:39:13 -0400
Received: from foss.arm.com ([217.140.110.172]:42896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhEUJjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:39:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEF5C101E;
        Fri, 21 May 2021 02:28:55 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49AE43F73D;
        Fri, 21 May 2021 02:28:53 -0700 (PDT)
Subject: Re: [PATCH v12 4/8] arm64: kvm: Introduce MTE VM feature
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
 <20210517123239.8025-5-steven.price@arm.com> <20210520115426.GB12251@arm.com>
 <5f0996d6-0a6e-ebcd-afcd-8290faba6780@arm.com>
 <20210520175037.GG12251@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <21629fb6-4287-88b2-2287-2a63496cff79@arm.com>
Date:   Fri, 21 May 2021 10:28:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520175037.GG12251@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2021 18:50, Catalin Marinas wrote:
> On Thu, May 20, 2021 at 04:05:46PM +0100, Steven Price wrote:
>> On 20/05/2021 12:54, Catalin Marinas wrote:
>>> On Mon, May 17, 2021 at 01:32:35PM +0100, Steven Price wrote:
>>>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>>>> index c5d1f3c87dbd..8660f6a03f51 100644
>>>> --- a/arch/arm64/kvm/mmu.c
>>>> +++ b/arch/arm64/kvm/mmu.c
>>>> @@ -822,6 +822,31 @@ transparent_hugepage_adjust(struct kvm_memory_slot *memslot,
>>>>  	return PAGE_SIZE;
>>>>  }
>>>>  
>>>> +static int sanitise_mte_tags(struct kvm *kvm, unsigned long size,
>>>> +			     kvm_pfn_t pfn)
>>>> +{
>>>> +	if (kvm_has_mte(kvm)) {
>>>> +		/*
>>>> +		 * The page will be mapped in stage 2 as Normal Cacheable, so
>>>> +		 * the VM will be able to see the page's tags and therefore
>>>> +		 * they must be initialised first. If PG_mte_tagged is set,
>>>> +		 * tags have already been initialised.
>>>> +		 */
>>>> +		unsigned long i, nr_pages = size >> PAGE_SHIFT;
>>>> +		struct page *page = pfn_to_online_page(pfn);
>>>> +
>>>> +		if (!page)
>>>> +			return -EFAULT;
>>>
>>> IIRC we ended up with pfn_to_online_page() to reject ZONE_DEVICE pages
>>> that may be mapped into a guest and we have no idea whether they support
>>> MTE. It may be worth adding a comment, otherwise, as Marc said, the page
>>> wouldn't disappear.
>>
>> I'll add a comment.
>>
>>>> +
>>>> +		for (i = 0; i < nr_pages; i++, page++) {
>>>> +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
>>>> +				mte_clear_page_tags(page_address(page));
>>>
>>> We started the page->flags thread and ended up fixing it for the host
>>> set_pte_at() as per the first patch:
>>>
>>> https://lore.kernel.org/r/c3293d47-a5f2-ea4a-6730-f5cae26d8a7e@arm.com
>>>
>>> Now, can we have a race between the stage 2 kvm_set_spte_gfn() and a
>>> stage 1 set_pte_at()? Only the latter takes a lock. Or between two
>>> kvm_set_spte_gfn() in different VMs? I think in the above thread we
>>> concluded that there's only a problem if the page is shared between
>>> multiple VMMs (MAP_SHARED). How realistic is this and what's the
>>> workaround?
>>>
>>> Either way, I think it's worth adding a comment here on the race on
>>> page->flags as it looks strange that here it's just a test_and_set_bit()
>>> while set_pte_at() uses a spinlock.
>>>
>>
>> Very good point! I should have thought about that. I think splitting the
>> test_and_set_bit() in two (as with the cache flush) is sufficient. While
>> there technically still is a race which could lead to user space tags
>> being clobbered:
>>
>> a) It's very odd for a VMM to be doing an mprotect() after the fact to
>> add PROT_MTE, or to be sharing the memory with another process which
>> sets PROT_MTE.
>>
>> b) The window for the race is incredibly small and the VMM (generally)
>> needs to be robust against the guest changing tags anyway.
>>
>> But I'll add a comment here as well:
>>
>> 	/*
>> 	 * There is a potential race between sanitising the
>> 	 * flags here and user space using mprotect() to add
>> 	 * PROT_MTE to access the tags, however by splitting
>> 	 * the test/set the only risk is user space tags
>> 	 * being overwritten by the mte_clear_page_tags() call.
>> 	 */
> 
> I think (well, I haven't re-checked), an mprotect() in the VMM ends up
> calling set_pte_at_notify() which would call kvm_set_spte_gfn() and that
> will map the page in the guest. So the problem only appears between
> different VMMs sharing the same page. In principle they can be
> MAP_PRIVATE but they'd be CoW so the race wouldn't matter. So it's left
> with MAP_SHARED between multiple VMMs.

mprotect.c only has a call to set_pte_at() not set_pte_at_notify(). And
AFAICT the MMU notifiers are called to invalidate only in
change_pmd_range(). So the stage 2 mappings would be invalidated rather
than populated. However I believe this should cause synchronisation
because of the KVM mmu_lock. So from my reading you are right an
mprotect() can't race.

MAP_SHARED between multiple VMs is then the only potential problem.

> I think we should just state that this is unsafe and they can delete
> each-others tags. If we are really worried, we can export that lock you
> added in mte.c.
> 

I'll just update the comment for now.

Thanks,

Steve

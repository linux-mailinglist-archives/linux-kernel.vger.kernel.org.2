Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB9A3501FC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbhCaOPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235758AbhCaOOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617200066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWfseHyMDmnbmy78Fa+ZyCroksy1qHofcVaPy2EiTbQ=;
        b=NRYsSZRCXDgshNzeMTKEmnQK8QpGq3xhKu18i1seC54Z5rc5046rp/JdBPlqiHVilPJCQG
        VwI1gt84cWJJCuCKhLdXKT5xH2mnjnQNbVw0v4BvU0fT+J+/Ri+hxLb3GiXSfsQ7bsPUoV
        8hp7ZEgOggShUQoNL/bStJhc5hQqxdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-xamaPO5pMw25ouUJ_K9Tqw-1; Wed, 31 Mar 2021 10:14:22 -0400
X-MC-Unique: xamaPO5pMw25ouUJ_K9Tqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E7341018F64;
        Wed, 31 Mar 2021 14:14:19 +0000 (UTC)
Received: from [10.36.113.60] (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB5B619727;
        Wed, 31 Mar 2021 14:14:13 +0000 (UTC)
To:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>, Haibo Xu <Haibo.Xu@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        qemu-devel@nongnu.org, Marc Zyngier <maz@kernel.org>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20210312151902.17853-1-steven.price@arm.com>
 <20210312151902.17853-3-steven.price@arm.com>
 <20210327152324.GA28167@arm.com> <20210328122131.GB17535@arm.com>
 <e0b88560-34e1-dcc4-aaa7-9a7a5b771824@arm.com>
 <20210330103013.GD18075@arm.com>
 <8977120b-841d-4882-2472-6e403bc9c797@redhat.com>
 <20210331092109.GA21921@arm.com>
 <d545a051-a02a-4c3a-0afe-66612839ba32@redhat.com>
 <86a968c8-7a0e-44a4-28c3-bac62c2b7d65@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v10 2/6] arm64: kvm: Introduce MTE VM feature
Message-ID: <eebe69ad-1a2f-91ee-75b1-f295d7a3389c@redhat.com>
Date:   Wed, 31 Mar 2021 16:14:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <86a968c8-7a0e-44a4-28c3-bac62c2b7d65@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.21 12:41, Steven Price wrote:
> On 31/03/2021 10:32, David Hildenbrand wrote:
>> On 31.03.21 11:21, Catalin Marinas wrote:
>>> On Wed, Mar 31, 2021 at 09:34:44AM +0200, David Hildenbrand wrote:
>>>> On 30.03.21 12:30, Catalin Marinas wrote:
>>>>> On Mon, Mar 29, 2021 at 05:06:51PM +0100, Steven Price wrote:
>>>>>> On 28/03/2021 13:21, Catalin Marinas wrote:
>>>>>>> On Sat, Mar 27, 2021 at 03:23:24PM +0000, Catalin Marinas wrote:
>>>>>>>> On Fri, Mar 12, 2021 at 03:18:58PM +0000, Steven Price wrote:
>>>>>>>>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>>>>>>>>> index 77cb2d28f2a4..b31b7a821f90 100644
>>>>>>>>> --- a/arch/arm64/kvm/mmu.c
>>>>>>>>> +++ b/arch/arm64/kvm/mmu.c
>>>>>>>>> @@ -879,6 +879,22 @@ static int user_mem_abort(struct kvm_vcpu
>>>>>>>>> *vcpu, phys_addr_t fault_ipa,
>>>>>>>>>          if (vma_pagesize == PAGE_SIZE && !force_pte)
>>>>>>>>>              vma_pagesize = transparent_hugepage_adjust(memslot,
>>>>>>>>> hva,
>>>>>>>>>                                     &pfn, &fault_ipa);
>>>>>>>>> +
>>>>>>>>> +    if (fault_status != FSC_PERM && kvm_has_mte(kvm) &&
>>>>>>>>> pfn_valid(pfn)) {
>>>>>>>>> +        /*
>>>>>>>>> +         * VM will be able to see the page's tags, so we must
>>>>>>>>> ensure
>>>>>>>>> +         * they have been initialised. if PG_mte_tagged is set,
>>>>>>>>> tags
>>>>>>>>> +         * have already been initialised.
>>>>>>>>> +         */
>>>>>>>>> +        struct page *page = pfn_to_page(pfn);
>>>>>>>>> +        unsigned long i, nr_pages = vma_pagesize >> PAGE_SHIFT;
>>>>>>>>> +
>>>>>>>>> +        for (i = 0; i < nr_pages; i++, page++) {
>>>>>>>>> +            if (!test_and_set_bit(PG_mte_tagged, &page->flags))
>>>>>>>>> +                mte_clear_page_tags(page_address(page));
>>>>>>>>> +        }
>>>>>>>>> +    }
>>>>>>>>
>>>>>>>> This pfn_valid() check may be problematic. Following commit
>>>>>>>> eeb0753ba27b
>>>>>>>> ("arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory"), it
>>>>>>>> returns
>>>>>>>> true for ZONE_DEVICE memory but such memory is allowed not to
>>>>>>>> support
>>>>>>>> MTE.
>>>>>>>
>>>>>>> Some more thinking, this should be safe as any ZONE_DEVICE would be
>>>>>>> mapped as untagged memory in the kernel linear map. It could be
>>>>>>> slightly
>>>>>>> inefficient if it unnecessarily tries to clear tags in ZONE_DEVICE,
>>>>>>> untagged memory. Another overhead is pfn_valid() which will likely
>>>>>>> end
>>>>>>> up calling memblock_is_map_memory().
>>>>>>>
>>>>>>> However, the bigger issue is that Stage 2 cannot disable tagging for
>>>>>>> Stage 1 unless the memory is Non-cacheable or Device at S2. Is
>>>>>>> there a
>>>>>>> way to detect what gets mapped in the guest as Normal Cacheable
>>>>>>> memory
>>>>>>> and make sure it's only early memory or hotplug but no ZONE_DEVICE
>>>>>>> (or
>>>>>>> something else like on-chip memory)?  If we can't guarantee that all
>>>>>>> Cacheable memory given to a guest supports tags, we should disable
>>>>>>> the
>>>>>>> feature altogether.
>>>>>>
>>>>>> In stage 2 I believe we only have two types of mapping - 'normal' or
>>>>>> DEVICE_nGnRE (see stage2_map_set_prot_attr()). Filtering out the
>>>>>> latter is a
>>>>>> case of checking the 'device' variable, and makes sense to avoid the
>>>>>> overhead you describe.
>>>>>>
>>>>>> This should also guarantee that all stage-2 cacheable memory
>>>>>> supports tags,
>>>>>> as kvm_is_device_pfn() is simply !pfn_valid(), and pfn_valid()
>>>>>> should only
>>>>>> be true for memory that Linux considers "normal".
>>>>
>>>> If you think "normal" == "normal System RAM", that's wrong; see below.
>>>
>>> By "normal" I think both Steven and I meant the Normal Cacheable memory
>>> attribute (another being the Device memory attribute).
> 
> Sadly there's no good standardised terminology here. Aarch64 provides
> the "normal (cacheable)" definition. Memory which is mapped as "Normal
> Cacheable" is implicitly MTE capable when shared with a guest (because
> the stage 2 mappings don't allow restricting MTE other than mapping it
> as Device memory).
> 
> So MTE also forces us to have a definition of memory which is "bog
> standard memory"[1] separate from the mapping attributes. This is the
> main memory which fully supports MTE.
> 
> Separate from the "bog standard" we have the "special"[1] memory, e.g.
> ZONE_DEVICE memory may be mapped as "Normal Cacheable" at stage 1 but
> that memory may not support MTE tags. This memory can only be safely
> shared with a guest in the following situations:
> 
>    1. MTE is completely disabled for the guest
> 
>    2. The stage 2 mappings are 'device' (e.g. DEVICE_nGnRE)
> 
>    3. We have some guarantee that guest MTE access are in some way safe.
> 
> (1) is the situation today (without this patch series). But it prevents
> the guest from using MTE in any form.
> 
> (2) is pretty terrible for general memory, but is the get-out clause for
> mapping devices into the guest.
> 
> (3) isn't something we have any architectural way of discovering. We'd
> need to know what the device did with the MTE accesses (and any caches
> between the CPU and the device) to ensure there aren't any side-channels
> or h/w lockup issues. We'd also need some way of describing this memory
> to the guest.
> 
> So at least for the time being the approach is to avoid letting a guest
> with MTE enabled have access to this sort of memory.
> 
> [1] Neither "bog standard" nor "special" are real terms - like I said
> there's a lack of standardised terminology.
> 
>>>>> That's the problem. With Anshuman's commit I mentioned above,
>>>>> pfn_valid() returns true for ZONE_DEVICE mappings (e.g. persistent
>>>>> memory, not talking about some I/O mapping that requires Device_nGnRE).
>>>>> So kvm_is_device_pfn() is false for such memory and it may be mapped as
>>>>> Normal but it is not guaranteed to support tagging.
>>>>
>>>> pfn_valid() means "there is a struct page"; if you do pfn_to_page() and
>>>> touch the page, you won't fault. So Anshuman's commit is correct.
>>>
>>> I agree.
>>>
>>>> pfn_to_online_page() means, "there is a struct page and it's system RAM
>>>> that's in use; the memmap has a sane content"
>>>
>>> Does pfn_to_online_page() returns a valid struct page pointer for
>>> ZONE_DEVICE pages? IIUC, these are not guaranteed to be system RAM, for
>>> some definition of system RAM (I assume NVDIMM != system RAM). For
>>> example, pmem_attach_disk() calls devm_memremap_pages() and this would
>>> use the Normal Cacheable memory attribute without necessarily being
>>> system RAM.
>>
>> No, not for ZONE_DEVICE.
>>
>> However, if you expose PMEM via dax/kmem as System RAM to the system (->
>> add_memory_driver_managed()), then PMEM (managed via ZONE_NOMRAL or
>> ZONE_MOVABLE) would work with pfn_to_online_page() -- as the system
>> thinks it's "ordinary system RAM" and the memory is managed by the buddy.
> 
> So if I'm understanding this correctly for KVM we need to use
> pfn_to_online_pages() and reject if NULL is returned? In the case of
> dax/kmem there already needs to be validation that the memory supports
> MTE (otherwise we break user space) before it's allowed into the
> "ordinary system RAM" bucket.

That should work.

1. One alternative is

if (!pfn_valid(pfn))
	return false;
#ifdef CONFIG_ZONE_DEVICE
page = pfn_to_page(pfn);
if (page_zonenum(page) == ZONE_DEVICE)
	return false;
#endif
return true;


Note that when you are dealing with random PFNs, this approach is in 
general not safe; the memmap could be uninitialized and contain garbage. 
You can have false positives for ZONE_DEVICE.


2. Yet another (slower?) variant to detect (some?) ZONE_DEVICE is

pgmap = get_dev_pagemap(pfn, NULL);
put_dev_pagemap(pgmap);

if (pgmap)
	return false;
return true;



I know that /dev/mem mappings can be problematic ... because the memmap 
could be in any state and actually we shouldn't even touch/rely on any 
"struct pages" at all, as we have a pure PFN mapping ...

-- 
Thanks,

David / dhildenb


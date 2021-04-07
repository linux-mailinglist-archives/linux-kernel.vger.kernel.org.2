Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AA4356951
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350877AbhDGKUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:20:21 -0400
Received: from foss.arm.com ([217.140.110.172]:54784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350875AbhDGKUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:20:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CAA01FB;
        Wed,  7 Apr 2021 03:20:10 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E77E23F694;
        Wed,  7 Apr 2021 03:20:07 -0700 (PDT)
Subject: Re: [PATCH v10 2/6] arm64: kvm: Introduce MTE VM feature
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
 <20210331184311.GA10737@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <e2612bd8-b356-a9cd-cfdf-26f4aa813578@arm.com>
Date:   Wed, 7 Apr 2021 11:20:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331184311.GA10737@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2021 19:43, Catalin Marinas wrote:
> On Wed, Mar 31, 2021 at 11:41:20AM +0100, Steven Price wrote:
>> On 31/03/2021 10:32, David Hildenbrand wrote:
>>> On 31.03.21 11:21, Catalin Marinas wrote:
>>>> On Wed, Mar 31, 2021 at 09:34:44AM +0200, David Hildenbrand wrote:
>>>>> On 30.03.21 12:30, Catalin Marinas wrote:
>>>>>> On Mon, Mar 29, 2021 at 05:06:51PM +0100, Steven Price wrote:
>>>>>>> On 28/03/2021 13:21, Catalin Marinas wrote:
>>>>>>>> However, the bigger issue is that Stage 2 cannot disable
>>>>>>>> tagging for Stage 1 unless the memory is Non-cacheable or
>>>>>>>> Device at S2. Is there a way to detect what gets mapped in
>>>>>>>> the guest as Normal Cacheable memory and make sure it's
>>>>>>>> only early memory or hotplug but no ZONE_DEVICE (or
>>>>>>>> something else like on-chip memory)?ï¿½ If we can't
>>>>>>>> guarantee that all Cacheable memory given to a guest
>>>>>>>> supports tags, we should disable the feature altogether.
>>>>>>>
>>>>>>> In stage 2 I believe we only have two types of mapping -
>>>>>>> 'normal' or DEVICE_nGnRE (see stage2_map_set_prot_attr()).
>>>>>>> Filtering out the latter is a case of checking the 'device'
>>>>>>> variable, and makes sense to avoid the overhead you
>>>>>>> describe.
>>>>>>>
>>>>>>> This should also guarantee that all stage-2 cacheable
>>>>>>> memory supports tags,
>>>>>>> as kvm_is_device_pfn() is simply !pfn_valid(), and
>>>>>>> pfn_valid() should only
>>>>>>> be true for memory that Linux considers "normal".
>>>>>
>>>>> If you think "normal" == "normal System RAM", that's wrong; see
>>>>> below.
>>>>
>>>> By "normal" I think both Steven and I meant the Normal Cacheable memory
>>>> attribute (another being the Device memory attribute).
>>
>> Sadly there's no good standardised terminology here. Aarch64 provides the
>> "normal (cacheable)" definition. Memory which is mapped as "Normal
>> Cacheable" is implicitly MTE capable when shared with a guest (because the
>> stage 2 mappings don't allow restricting MTE other than mapping it as Device
>> memory).
>>
>> So MTE also forces us to have a definition of memory which is "bog standard
>> memory"[1] separate from the mapping attributes. This is the main memory
>> which fully supports MTE.
>>
>> Separate from the "bog standard" we have the "special"[1] memory, e.g.
>> ZONE_DEVICE memory may be mapped as "Normal Cacheable" at stage 1 but that
>> memory may not support MTE tags. This memory can only be safely shared with
>> a guest in the following situations:
>>
>>   1. MTE is completely disabled for the guest
>>
>>   2. The stage 2 mappings are 'device' (e.g. DEVICE_nGnRE)
>>
>>   3. We have some guarantee that guest MTE access are in some way safe.
>>
>> (1) is the situation today (without this patch series). But it prevents the
>> guest from using MTE in any form.
>>
>> (2) is pretty terrible for general memory, but is the get-out clause for
>> mapping devices into the guest.
>>
>> (3) isn't something we have any architectural way of discovering. We'd need
>> to know what the device did with the MTE accesses (and any caches between
>> the CPU and the device) to ensure there aren't any side-channels or h/w
>> lockup issues. We'd also need some way of describing this memory to the
>> guest.
>>
>> So at least for the time being the approach is to avoid letting a guest with
>> MTE enabled have access to this sort of memory.
> 
> When a slot is added by the VMM, if it asked MTE in guest (I guess
> that's an opt-in by the VMM, haven't checked the other patches), can we
> reject it if it's is going to be mapped as Normal Cacheable but it is a
> ZONE_DEVICE (i.e. !kvm_is_device_pfn() + one of David's suggestions to
> check for ZONE_DEVICE)? This way we don't need to do more expensive
> checks in set_pte_at().

The problem is that KVM allows the VMM to change the memory backing a 
slot while the guest is running. This is obviously useful for the likes 
of migration, but ultimately means that even if you were to do checks at 
the time of slot creation, you would need to repeat the checks at 
set_pte_at() time to ensure a mischievous VMM didn't swap the page for a 
problematic one.

> We could simplify the set_pte_at() further if we require that the VMM
> has a PROT_MTE mapping. This does not mean it cannot have two mappings,
> the other without PROT_MTE. But at least we get a set_pte_at() when
> swapping in which has PROT_MTE.

That is certainly an option - but from what I've seen of trying to 
implement a VMM to support MTE, the PROT_MTE mapping is not what you 
actually want in user space. Two mappings is possible but is likely to 
complicate the VMM.

> We could add another PROT_TAGGED or something which means PG_mte_tagged
> set but still mapped as Normal Untagged. It's just that we are short of
> pte bits for another flag.

That could help here - although it's slightly odd as you're asking the 
kernel to track the tags, but not allowing user space (direct) access to 
them. Like you say using us the precious bits for this seems like it 
might be short-sighted.

> Can we somehow identify when the S2 pte is set and can we get access to
> the prior swap pte? This way we could avoid changes to set_pte_at() for
> S2 faults.
> 

Unless I'm misunderstanding the code the swap information is (only) 
stored in the stage 1 user-space VMM PTE. When we get a stage 2 fault 
this triggers a corresponding access attempt to the VMM's address space. 
It's at this point when populating the VMM's page tables that the swap 
information is discovered.

The problem at the moment is a mismatch regarding whether the page needs 
tags or not. The VMM's mapping can (currently) be !PROT_MTE which means 
we wouldn't normally require restoring/zeroing the tags. However the 
stage 2 access requires that the tags be preserved. Requiring PROT_MTE 
(or PROT_TAGGED as above) would certainly simplify the handling in the 
kernel.

Of course I did propose the 'requiring PROT_MTE' approach before which 
led to a conversation[1] ending with a conclusion[2] that:

    I'd much rather the kernel just
    provided us with an API for what we want, which is (1) the guest
    RAM as just RAM with no tag checking and separately (2) some
    mechanism yet-to-be-designed which lets us bulk copy a page's
    worth of tags for migration.

Which is what I've implemented ;)

Do you think it's worth investigating the PROT_TAGGED approach as a 
middle ground? My gut feeling is that it's a waste of a VM flag, but I 
agree it would certainly make the code cleaner.

Steve

[1] 
https://lore.kernel.org/kvmarm/CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com/
[2] 
https://lore.kernel.org/kvmarm/CAFEAcA_K47jKSp46DFK-AKWv6MD1pkrEB6FNz=HNGdxmBDCSbw@mail.gmail.com/

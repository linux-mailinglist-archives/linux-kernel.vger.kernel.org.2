Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB143DFA11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 05:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhHDDp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 23:45:58 -0400
Received: from foss.arm.com ([217.140.110.172]:56058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhHDDp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 23:45:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8083213A1;
        Tue,  3 Aug 2021 20:45:44 -0700 (PDT)
Received: from [10.163.67.195] (unknown [10.163.67.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 747FC3F719;
        Tue,  3 Aug 2021 20:45:42 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64/mm: Fix idmap on [16K|36VA|48PA]
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <1627879359-30303-1-git-send-email-anshuman.khandual@arm.com>
 <20210803103440.GA5786@arm.com>
 <7bad50a2-76f1-7946-3a15-35e46fb289c0@arm.com>
 <20210803131201.GB5786@arm.com>
Message-ID: <4d6a4a0c-7f68-991d-5b0e-08c280543fe8@arm.com>
Date:   Wed, 4 Aug 2021 09:16:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210803131201.GB5786@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/21 6:42 PM, Catalin Marinas wrote:
> On Tue, Aug 03, 2021 at 04:57:04PM +0530, Anshuman Khandual wrote:
>> On 8/3/21 4:04 PM, Catalin Marinas wrote:
>>> On Mon, Aug 02, 2021 at 10:12:39AM +0530, Anshuman Khandual wrote:
>>>> +/*
>>>> + * In this particular CONFIG_ARM64_16K_PAGES config, there might be a
>>>> + * scenario where 'idmap_text_end' ends up high enough in the PA range
>>>> + * requiring two additional idmap page table levels. Reduce idmap_t0sz
>>>> + * to cover the entire PA range. This prevents table misconfiguration
>>>> + * when a given idmap_t0sz value just requires single additional level
>>>> + * where as two levels have been built.
>>>> + */
>>>> +#if defined(CONFIG_ARM64_VA_BITS_36) && defined(CONFIG_ARM64_PA_BITS_48)
> 
> I don't think you need the PA_BITS_48 check in here. It's either this
> one or PA_BITS_52 in the future. Anyway, I think so far our assumption

Even PA_BITS_52 range will be well within the two extra idmap page table
levels limit, so it should be covered with this proposed code.

> is that the kernel will always be placed in the first 48-bit, so we
> don't need extra check.

The check on ARM64_PA_BITS_48 here is a code hardening construct. Because
(PAGE_SHIFT - 3) is an important factor which ends up pushing the idmap to
have two extra levels. Could we just assert ARM64_16K_PAGES instead, along
with ARM64_VA_BITS_36 ? I am concerned because in future other page size
configs might have ARM64_VA_BITS_36 as well.

Something like ...

#if defined(CONFIG_ARM64_VA_BITS_36) && defined(CONFIG_ARM64_16K_PAGES)

> 
>>>> +	mov	x4, EXTRA_PTRS_1
>>>> +	create_table_entry x0, x3, EXTRA_SHIFT_1, x4, x5, x6
>>>> +
>>>> +	mov	x4, PTRS_PER_PTE
>>>> +	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
>>>> +
>>>> +	mov	x5, #64 - PHYS_MASK_SHIFT
>>>> +	adr_l	x6, idmap_t0sz
>>>> +	str	x5, [x6]
>>>> +	dmb	sy
>>>> +	dc	ivac, x6
>>>> +#else
>>>>  	mov	x4, EXTRA_PTRS
>>>>  	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
>>>> +#endif
>>>>  #else
>>>>  	/*
>>>>  	 * If VA_BITS == 48, we don't have to configure an additional
>>>
>>> There's a prior idmap_t0sz setting based on __idmap_text_end. Isn't that
>>> sufficient? We don't care about covering the whole PA space, just the
>>> __idmap_text_end.
>>
>> Right but its bit tricky here.
>>
>> __idmap_text_end could be any where between VA_BITS (36) and PA_BITS (48)
>> which would require (one or two) additional page table levels. But in this
>> solution it creates two additional page table levels for idmap which would
>> completely map upto PA_BITS, regardless of __idmap_text_end's position. So
>> in case __idmap_text_end is between VA_BITS (36) and VA_BITS(47), a single
>> additional page table level is required where as we have created two ! So
>> to avoid such a situation, adjust idmap_t0sz accordingly. Otherwise there
>> will be a MMU mis-configuration.
> 
> I get it now. You need 4 levels with 16K pages for idmap as 3 levels
> (one extra in head.S) are not sufficient. The normal page table uses 2
> levels with 36-bit VA. Here you chose to go with 4 levels always as the
> simplest option.
> 
> Do we need to adjust idmap_ptrs_per_pgd? I think even without your

IIUC idmap_ptrs_per_pgd tracks the number of entries at the highest level
i.e PGD but *as per* the VA_BITS config. IIUC it is used by map_memory()
which creates the mapping for the standard VA_BITS based idmap without the
extra levels, which get their entries populated with create_table_entry().
Hence idmap_ptrs_per_pgd need not be updated when new levels are added. It
should be left unchanged as PTRS_PER_PGD.

> patch, its value is wrong as it doesn't seem to be adjusted for the

The only time the entries get adjusted is when existing number of levels
dont change but all entries at PGD i.e PTRS_PER_PGD are not required. But
seems like it is not done correctly either.

Current idmap_t0sz is decided on what is required for __idmap_text_end
coverage but not PHYS_MASK_SHIFT. So the number of entries at PGD level
should be computed as follows.

idmap_ptrs_per_pgd = 1 << ((64 - idmap_t0sz) - PGDIR_SHIFT)

but instead here is what we have.

        /*
         * If VA_BITS == 48, we don't have to configure an additional
         * translation level, but the top-level table has more entries.
         */
        mov     x4, #1 << (PHYS_MASK_SHIFT - PGDIR_SHIFT)
        str_l   x4, idmap_ptrs_per_pgd, x5

A reduced idmap_t0sz here covers __idmap_text_end not PHYS_MASK_SHIFT.
I guess this just works because idmap page table levels required for the
reduced idmap_t0sz and PHYS_MASK_SHIFT remains the same in all possible
cases for now. The only deviation would have been [16K|36VA|48PA] which
must have faced this issue but then it was blocked by another problem
altogether (being solved here).

> extra level. I can't figure out whether it matter but I think we should
> remove this variable altogether and just set the x4 register to what we
> need in head.S

Right, idmap_ptrs_per_pgd is not required for anything else other than
map_memory() which take it at x4. Could be dropped without any problem.

> 
>> This patch is indented for stable back port and hence tries to be as simple
>> and minimal as possible. So it creates two additional page table levels
>> mapping upto PA_BITS without just considering __idmap_text_end's position.
>> Reducing __idmap_t0sz upto PA_BITS should not be a problem irrespective of
>> ID_AA64MMFR0_EL1.PARANGE value. As __idmap_text_end would never be on a PA
>> which is not supported. Hence out of range PA would never be on the bus for
>> translation.
> 
> I'd rather have a clean solution (might as well be this one) than
> worrying about a stable back-port. It's highly unlikely that we'll trip
> over this problem in practice: first you'd need RAM above 47-bit and
> second you'd have to enable EXPERT and 36-bit VA.

I am working on a solution which re-works idmap extension logic based on the
difference between __idmap_text_end and PGDIR_SHIFT coverage, then creating
additional page table levels and reducing idmap_t0sz appropriately. All the
existing code including this fix here, will be dropped completely. Because
it might be difficult to extend this patch to get the entire thing in order,
the idea was to just fix [16K|36VA|48PA] which could then be backported and
then do the rework in mainline (which need not be backported).

To summarize here, you would prefer to skip the above transition and instead
directly move to the rework which may not be backported ? Please do suggest.

> 
> It looks like idmap_t0sz is used by the kvm_mmu_init() code to calculate
> hyp_va_bits. Does it mean that idmap_t0sz should always match PA_SIZE?

Default value for idmap_t0sz is TCR_T0SZ(VA_BITS_MIN) unless it gets reduced
further to map __idmap_text_end after extending the idmap levels. So it does
not always match PA_SIZE.

> Or maybe we should just decouple the two.

I dont have adequate understanding on this area. It seems like the hyp borrows
the already discovered __idmap_text_end placement via idmap_t0sz to figure out
whether it also needs to have an extended ID map (at EL2). Decoupling it might
suggest KVM should rediscover __idmap_text_end's placement ?

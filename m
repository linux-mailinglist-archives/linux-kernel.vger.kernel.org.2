Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA131C5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 03:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBPC4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 21:56:14 -0500
Received: from foss.arm.com ([217.140.110.172]:53518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhBPC4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 21:56:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AC9531B;
        Mon, 15 Feb 2021 18:55:25 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DC793F73D;
        Mon, 15 Feb 2021 18:55:21 -0800 (PST)
Subject: Re: [PATCH v2 1/1] arm64: mm: correct the inside linear map
 boundaries during hotplug check
To:     Ard Biesheuvel <ardb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210215192237.362706-1-pasha.tatashin@soleen.com>
 <20210215192237.362706-2-pasha.tatashin@soleen.com>
 <CAMj1kXGxyV0=s6jVZ674O_2amkYSnwSnubnozbzD6g6GOMJE-A@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <73bf9ad0-37a9-78f4-3583-2845dcb24f34@arm.com>
Date:   Tue, 16 Feb 2021 08:25:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGxyV0=s6jVZ674O_2amkYSnwSnubnozbzD6g6GOMJE-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/21 12:57 AM, Ard Biesheuvel wrote:
> On Mon, 15 Feb 2021 at 20:22, Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>>
>> Memory hotplug may fail on systems with CONFIG_RANDOMIZE_BASE because the
>> linear map range is not checked correctly.
>>
>> The start physical address that linear map covers can be actually at the
>> end of the range because of randomization. Check that and if so reduce it
>> to 0.
>>
>> This can be verified on QEMU with setting kaslr-seed to ~0ul:
>>
>> memstart_offset_seed = 0xffff
>> START: __pa(_PAGE_OFFSET(vabits_actual)) = ffff9000c0000000
>> END:   __pa(PAGE_END - 1) =  1000bfffffff
>>
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>> Fixes: 58284a901b42 ("arm64/mm: Validate hotplug range before creating linear mapping")
>> Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> 
>> ---
>>  arch/arm64/mm/mmu.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index ae0c3d023824..cc16443ea67f 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1444,14 +1444,30 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
>>
>>  static bool inside_linear_region(u64 start, u64 size)
>>  {
>> +       u64 start_linear_pa = __pa(_PAGE_OFFSET(vabits_actual));
>> +       u64 end_linear_pa = __pa(PAGE_END - 1);
>> +
>> +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>> +               /*
>> +                * Check for a wrap, it is possible because of randomized linear
>> +                * mapping the start physical address is actually bigger than
>> +                * the end physical address. In this case set start to zero
>> +                * because [0, end_linear_pa] range must still be able to cover
>> +                * all addressable physical addresses.
>> +                */
>> +               if (start_linear_pa > end_linear_pa)
>> +                       start_linear_pa = 0;
>> +       }
>> +
>> +       WARN_ON(start_linear_pa > end_linear_pa);
>> +
>>         /*
>>          * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
>>          * accommodating both its ends but excluding PAGE_END. Max physical
>>          * range which can be mapped inside this linear mapping range, must
>>          * also be derived from its end points.
>>          */
>> -       return start >= __pa(_PAGE_OFFSET(vabits_actual)) &&
>> -              (start + size - 1) <= __pa(PAGE_END - 1);
> 
> Can't we simply use signed arithmetic here? This expression works fine
> if the quantities are all interpreted as s64 instead of u64

There is a new generic framework which expects the platform to provide two
distinct range points (low and high) for hotplug address comparison. Those
range points can be different depending on whether address randomization
is enabled and the flip occurs. But this comparison here in the platform
code is going away.

This patch needs to rebased on the new framework which is part of linux-next.

https://patchwork.kernel.org/project/linux-mm/list/?series=425051

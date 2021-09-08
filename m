Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DAA403675
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351218AbhIHI6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:58:05 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:57835 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348212AbhIHI6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:58:04 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 82B11240014;
        Wed,  8 Sep 2021 08:56:47 +0000 (UTC)
Subject: Re: [PATCH v2 -next] riscv: mm: remove redundant trampoline PGD for
 64bit
To:     Nanyong Sun <sunnanyong@huawei.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, wangkefeng.wang@huawei.com,
        tiantao6@hisilicon.com, qiuwenbo@phytium.com.cn, rppt@kernel.org,
        jszhang@kernel.org, mick@ics.forth.gr
References: <mhng-ea598bd7-cae0-4b60-83c5-b862a664116d@palmerdabbelt-glaptop>
 <150d9366-c042-3119-d86f-163b579d91b4@huawei.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <13c4d471-dc3b-32d8-6535-36d3862592d4@ghiti.fr>
Date:   Wed, 8 Sep 2021 10:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <150d9366-c042-3119-d86f-163b579d91b4@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nanyong,

Le 8/09/2021 à 08:42, Nanyong Sun a écrit :
> 
> On 2021/8/14 6:08, Palmer Dabbelt wrote:
>> On Mon, 02 Aug 2021 05:43:02 PDT (-0700), alex@ghiti.fr wrote:
>>> Hi Nanyong,
>>>
>>> Le 28/07/2021 à 13:55, Alex Ghiti a écrit :
>>>>
>>>>
>>>> Le 28/07/2021 à 04:49, Nanyong Sun a écrit :
>>>>> Remove redundant trampoline PGD for 64bit and add more comment
>>>>> for why 32bit systems need trampoline PGD.
>>>>>
>>>>>
>>>>> +load_kernel_pgd:
>>>>> +        /*
>>>>> +         * Switch to kernel page tables.  A full fence is necessary
>>>>> in order to
>>>>> +         * avoid using the trampoline translations, which are only
>>>>> correct for
>>>>> +         * the first superpage.  Fetching the fence is guarnteed 
>>>>> to work
>>>>> +         * because that first superpage is translated the same way.
>>>>> +         */
>>>>> +        csrw CSR_SATP, a2
>>>>> +        sfence.vma
>>>>> +
>>>>> +load_done:
>>>>>       /* Set trap vector to spin forever to help debug */
>>>>>       la a0, .Lsecondary_park
>>>>>       csrw CSR_TVEC, a0
>>>
>>>
>>> I suppose stvec was set this way to catch any problem with early_pg_dir,
>>> you moved that and then this defeats this original purpose.
>>
> Hi Alex,
> 
>      I don't think so, before set early_pg_dir to satp, it's the 
> physical address world, we must set stvec as
> 
> the first place in virtual address world we want jump to. And I don't 
> think ".Lsecondary_park " can catch
> 
> problem of bad early_pg_dir, if the basic page table is wrong, CPU also 
> can not go to the virtual address stored in stvec correctly.

But I think then that it loops forever at the stvec address which allows 
to know where the boot failed.

> 
> More, in the original code, before set trampoline_pg_dir, what if the 
> trampoline_pg_dir had a problem?

You're right but this debug 'feature' was not installed, I guess 
somebody had a hard time at some point with the early page table and not 
the trampoline :)

Anyway, I was just pointing that you 'broke' the current way things work 
and unless this is for an explicit good reason, that should not happen.

> 
>> Essentially.
>>
>> The specific issue is that the JTAG debug spec is defined (or at least 
>> was when I was using it, it's been years since I've needed to do that) 
>> in terms of committed instructions.  Thus if you end up in a position 
>> where the processer is unable to commit an instruction you also lose 
>> the ability to do anything meaningful with the debugger, thus 
>> essentially locking up the system.
>>
>> The most common way to end up in a situation where the processor is 
>> unable to commit an instruction is to have a fault with an invalid 
>> trap vector: maybe dangling from M-mode, the last boot, reset, 
>> whatever.  Then as soon as you take a trap the system locks up.  Any 
>> trap before we have a working trap handler is a bug, but it's way 
>> harder to debug things when the debugger doesn't function.
>>
>> There is of course no way to fundamentally prevent these sort of 
>> no-commitable-instruction situations, but I got into the habbit of 
>> just setting up a trivial trap entry point ASAP -- it probably took a 
>> dozen rounds of trying to debug the debugger only to realize it was 
>> per spec to hang, but that idiom eventually crept into pretty much 
>> everything.
>>
>> Not sure if the debug spec is still written this way (or if debuggers 
>> respect it), as I haven't had to use one in a while.
>>
>>>
>>>
>>>>>
>>>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>>>> index ac48742fa6fc..306fcb2334fa 100644
>>>>> --- a/arch/riscv/mm/init.c
>>>>> +++ b/arch/riscv/mm/init.c
>>>>> @@ -219,13 +219,17 @@ unsigned long pfn_base __ro_after_init;
>>>>>   EXPORT_SYMBOL(pfn_base);
>>>>>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>>>>> +#ifndef CONFIG_64BIT
>>>>>   pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>>>>> +#endif /* CONFIG_64BIT */
>>>
>>>
>>> As stated in Documentation/process/coding-style.rst, it is better to use
>>> __maybe_unused rather than #ifdefs.
>>>
>>>
> I'm afraid that __maybe_unused can not save one page memory here.

What do you mean?

>>>
>>> Overall this version adds more complexity to assembly code than I
>>> thought, but I don't see any way to improve that (which does not mean
>>> there isn't!).
>>>
>>> Thanks,
>>>
>>> Alex
>>>
> Thanks for your review, let me figure out a better solution.
>>>
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

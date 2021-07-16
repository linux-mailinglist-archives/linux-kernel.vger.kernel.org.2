Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1C03CB7C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbhGPNTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:19:54 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41851 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhGPNTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:19:51 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 432A3C000B;
        Fri, 16 Jul 2021 13:16:51 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.14 Merge Window, Part 1
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
References: <mhng-90f1c895-95b6-4480-937d-ee859a4542c3@palmerdabbelt-glaptop>
 <cb401208-8774-9653-e780-6e9d4d3a41c0@ghiti.fr>
 <20210716205758.05620241@xhacker>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <2f29eb6d-493f-9fd6-2215-ec7bca480b32@ghiti.fr>
Date:   Fri, 16 Jul 2021 15:16:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716205758.05620241@xhacker>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

Le 16/07/2021 à 14:57, Jisheng Zhang a écrit :
> On Thu, 15 Jul 2021 09:11:14 +0200
> Alex Ghiti <alex@ghiti.fr> wrote:
> 
>> Hi Palmer,
>>
>> Le 11/07/2021 à 20:45, Palmer Dabbelt a écrit :
>>> On Fri, 09 Jul 2021 12:58:10 PDT (-0700), alex@ghiti.fr wrote:
>>>>
>>>>
>>>> Le 9/07/2021 à 16:53, Palmer Dabbelt a écrit :
>>>>> The following changes since commit
>>>>> 8a4102a0cf07cc76a18f373f6b49485258cc6af4:
>>>>>
>>>>>     riscv: mm: Fix W+X mappings at boot (2021-06-01 21:15:09 -0700)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>     git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
>>>>> tags/riscv-for-linus-5.14-mw0
>>>>>
>>>>> for you to fetch changes up to 1958e5aef5098e28b7d6e6a2972649901ebecace:
>>>>>
>>>>>     riscv: xip: Fix duplicate included asm/pgtable.h (2021-07-06
>>>>> 16:17:40 -0700)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> RISC-V Patches for the 5.14 Merge Window, Part 1
>>>>>
>>>>> In addition to We have a handful of new features for 5.14:
>>>>>
>>>>> * Support for transparent huge pages.
>>>>> * Support for generic PCI resources mapping.
>>>>> * Support for the mem= kernel parameter.
>>>>> * Support for KFENCE.
>>>>> * A handful of fixes to avoid W+X mappings in the kernel.
>>>>> * Support for VMAP_STACK based overflow detection.
>>>>> * An optimized copy_{to,from}_user.
>>>>> ----------------------------------------------------------------
>>>>> There are some Kconfig merge conflicts.  They should be pretty
>>>>> straight-forward, but we do have a symbol out of order -- I thought I
>>>>> had a
>>>>> script to check for that, but I guess it doesn't work.  I just sent
>>>>> out a patch
>>>>> to fix it up.
>>>>>
>>>>> diff --cc arch/riscv/Kconfig
>>>>> index 3590eb76000e,469a70bd8da6..d36f3c5029fd
>>>>> --- a/arch/riscv/Kconfig
>>>>> +++ b/arch/riscv/Kconfig
>>>>> @@@ -60,12 -61,11 +61,12 @@@ config RISC
>>>>>           select GENERIC_TIME_VSYSCALL if MMU && 64BIT
>>>>>           select HANDLE_DOMAIN_IRQ
>>>>>           select HAVE_ARCH_AUDITSYSCALL
>>>>> -       select HAVE_ARCH_JUMP_LABEL
>>>>> -       select HAVE_ARCH_JUMP_LABEL_RELATIVE
>>>>> +       select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
>>>>> +       select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
>>>>>           select HAVE_ARCH_KASAN if MMU && 64BIT
>>>>>           select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
>>>>>    +      select HAVE_ARCH_KFENCE if MMU && 64BIT
>>>>> -       select HAVE_ARCH_KGDB
>>>>> +       select HAVE_ARCH_KGDB if !XIP_KERNEL
>>>>>           select HAVE_ARCH_KGDB_QXFER_PKT
>>>>>           select HAVE_ARCH_MMAP_RND_BITS if MMU
>>>>>           select HAVE_ARCH_SECCOMP_FILTER
>>>>> @@@ -81,11 -80,9 +82,14 @@@
>>>>>           select HAVE_GCC_PLUGINS
>>>>>           select HAVE_GENERIC_VDSO if MMU && 64BIT
>>>>>           select HAVE_IRQ_TIME_ACCOUNTING
>>>>>    +      select HAVE_KPROBES
>>>>>    +      select HAVE_KPROBES_ON_FTRACE
>>>>>    +      select HAVE_KRETPROBES
>>>>> +       select HAVE_KPROBES if !XIP_KERNEL
>>>>> +       select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>>>>> +       select HAVE_KRETPROBES if !XIP_KERNEL
>>>>>    +      select HAVE_MOVE_PMD
>>>>>    +      select HAVE_MOVE_PUD
>>>>>           select HAVE_PCI
>>>>>           select HAVE_PERF_EVENTS
>>>>>           select HAVE_PERF_REGS
>>>>> @@@ -108,7 -104,7 +112,8 @@@
>>>>>           select SYSCTL_EXCEPTION_TRACE
>>>>>           select THREAD_INFO_IN_TASK
>>>>>           select UACCESS_MEMCPY if !MMU
>>>>>    +      select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
>>>>> +       select ZONE_DMA32 if 64BIT
>>>>>
>>>>>     config ARCH_MMAP_RND_BITS_MIN
>>>>>           default 18 if 64BIT
>>>>> ----------------------------------------------------------------
>>>>> Akira Tsukamoto (1):
>>>>>         riscv: __asm_copy_to-from_user: Optimize unaligned memory
>>>>> access and pipeline stall
>>>>>
>>>>> Alexandre Ghiti (6):
>>>>>         riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED
>>>>>         riscv: Simplify xip and !xip kernel address conversion macros
>>>>
>>>> @Palmer: As said in the thread of this patchset multiple times, those 2
>>>> patches should not be merged as it assumes that the base DRAM address is
>>>> always 0x8000_0000 for all rv64 platforms: I don't think it is true,
>>>> is it?
>>>
>>> Sorry, I remember saying something about that but must have missed the
>>> resposeses.  Do you have a pointer to the discussion?  If this break
>>> stuff I'm happy to revert it, which can be done post-rc1.  I just need
>>> to see what's actually broken first, because IIUC this was de-facto how
>>> things worked already.
>>>    
>>
>> Really sorry about my response delay.
>>
>> The thing is that removing CONFIG_PHYS_RAM_BASE_FIXED defines
>> CONFIG_PHYS_RAM_BASE to 0x8000_0000 for all rv64 chips, but I believe
>> this is implementation specific: for now, this base address was passed
>> into the device tree, and here it makes this value static.
>>
>> This issue with my patch was originally pointed by Jisheng, Geert and Arnd.
>>
>> If this is not a problem and you have a pointer to a document that
>> specifies this, I would be very happy to have the link :)
>>
>> Thanks and again sorry about my response delay,
>>
> 
> Hi Alex,
> 
> Since the PR has been merged into linux-5.14-rc1, directly reverting seems
> not a good idea. IMHO, it's better to send patch(es) against current 5.14-rc1
> tree. what do you think?
> 
> Thanks

I have a patchset that fixes this problem cleanly, I have to check but I 
think it depends on an another larger patchset that cleans the code a 
lot, I'll see if I can extract only this part and submit it as a fix.

I take a look and get back ASAP!

Thanks,

Alex

> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774BF3A56BF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 08:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFMGRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 02:17:03 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59065 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFMGRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 02:17:02 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 2C5B0E0006;
        Sun, 13 Jun 2021 06:14:54 +0000 (UTC)
Subject: Re: [PATCH v4 1/4] riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     emil.renner.berthing@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, jszhang@kernel.org,
        Christoph Hellwig <hch@infradead.org>, zong.li@sifive.com,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <CANBLGcy3HrnmrweSpnDZViVstoWJYh4sCBoaX_24AsgWd=Q9XA@mail.gmail.com>
 <mhng-dfabeabd-e6df-4035-a9d0-c16269390120@palmerdabbelt-glaptop>
 <20210613084447.6db3cc02@xhacker>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <98bfae5f-748e-f951-876a-254d98197e10@ghiti.fr>
Date:   Sun, 13 Jun 2021 08:14:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210613084447.6db3cc02@xhacker>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 13/06/2021 à 02:44, Jisheng Zhang a écrit :
> On Sat, 12 Jun 2021 17:23:51 -0700 (PDT)
> Palmer Dabbelt <palmer@dabbelt.com> wrote:
> 
>> On Sat, 12 Jun 2021 16:23:03 PDT (-0700), emil.renner.berthing@gmail.com wrote:
>>> On Fri, 4 Jun 2021 at 13:51, Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>>
>>>> Make the physical RAM base address available for all kernels, not only
>>>> XIP kernels as it will allow to simplify address conversions macros.
>>>
>>> Am I just reading it wrong or won't this patch make it so that the same kernel
>>> can't run on two chips with physical ram starting at different addresses?
> 
> I mentioned this point in http://lists.infradead.org/pipermail/linux-riscv/2021-June/006840.html
> 
>>
>> IIUC we were in that position, at least without relocatable kernels.
>> Maybe I'm misunderstanding this, though?
> 
> Just my humble opinion, before this series patch, at least geneirc Image
> for RV64 + MMU + !XIP is doable.
> 

This patch declares that the physical ram address is at 0x8000_0000, 
whatever the chip, which may not be the case in practice. I did not 
expect Palmer would take this one and had planned to simply push a v5 
without the first 2 patches, but things happened this week that 
prevented me to do that. IMO, we should just wait for a v5 that I'll 
push when possible (probably today or in the coming days).

Thanks,

Alex

> Thanks
> 
>>
>>>
>>> /Emil
>>>   
>>>> ---
>>>>   arch/riscv/Kconfig | 6 ------
>>>>   1 file changed, 6 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>> index b58596b141fc..3d8e7e4bb45c 100644
>>>> --- a/arch/riscv/Kconfig
>>>> +++ b/arch/riscv/Kconfig
>>>> @@ -493,13 +493,8 @@ config STACKPROTECTOR_PER_TASK
>>>>          def_bool y
>>>>          depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
>>>>
>>>> -config PHYS_RAM_BASE_FIXED
>>>> -       bool "Explicitly specified physical RAM address"
>>>> -       default n
>>>> -
>>>>   config PHYS_RAM_BASE
>>>>          hex "Platform Physical RAM address"
>>>> -       depends on PHYS_RAM_BASE_FIXED
>>>>          default "0x80000000"
>>>>          help
>>>>            This is the physical address of RAM in the system. It has to be
>>>> @@ -512,7 +507,6 @@ config XIP_KERNEL
>>>>          # This prevents XIP from being enabled by all{yes,mod}config, which
>>>>          # fail to build since XIP doesn't support large kernels.
>>>>          depends on !COMPILE_TEST
>>>> -       select PHYS_RAM_BASE_FIXED
>>>>          help
>>>>            Execute-In-Place allows the kernel to run from non-volatile storage
>>>>            directly addressable by the CPU, such as NOR flash. This saves RAM
>>>> --
>>>> 2.30.2
>>>>
>>>>
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
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

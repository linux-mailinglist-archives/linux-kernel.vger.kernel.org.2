Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FF636F6E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhD3IKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:10:07 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:39079 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhD3IKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:10:05 -0400
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 172C6240020;
        Fri, 30 Apr 2021 08:09:14 +0000 (UTC)
Subject: Re: [PATCH] riscv: Disallow to build XIP_KERNEL with SOC_SIFIVE
From:   Alex Ghiti <alex@ghiti.fr>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210429084541.28083-1-alex@ghiti.fr>
 <CAM4kBBK=yQ=jXYw85Ti7Y3EyGd11aOYt7QnD4+fFFkDhvrwcxA@mail.gmail.com>
 <1a4a0a88-6ff5-66ad-6819-53dd96f76849@ghiti.fr>
Message-ID: <35b97408-328a-a9cd-1bb8-6758f42bde2d@ghiti.fr>
Date:   Fri, 30 Apr 2021 04:09:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1a4a0a88-6ff5-66ad-6819-53dd96f76849@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 4/29/21 à 8:13 AM, Alex Ghiti a écrit :
> Le 4/29/21 à 5:11 AM, Vitaly Wool a écrit :
>> On Thu, Apr 29, 2021 at 10:47 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>
>>> RISCV_ERRATA_ALTERNATIVE patches text at runtime which is not 
>>> possible when
>>> the kernel is executed from the flash in XIP mode, and as the SIFIVE
>>> errata must be fixed somehow, disallow to build a XIP kernel that
>>> supports SIFIVE socs.
>>
>> Could you please hold off this patch for a bit? I will try to come up
>> with an alternative solution. It should be possible to define a
>> special section within the RW area and place the functions that need
>> such patching there.
>> Not that I like that much but at least we'll keep the ability to use
>> XIP on SiFive.
> 
> Ok, I'm wondering why I did not think of that...I'll give it a try just 
> to punish myself.
> 
> Thanks Vitaly,
> 
> Alex
> 

I tried what you proposed and it works well, *callers* must be placed 
into this writable section in RAM and that's it, that may be more 
complicated if at some point the patched functions are generic but I 
think we can use an intermediate riscv function to patch instead or 
something else.

The modifications I did only consist in putting alternative section in 
RAM and place the exception vector table in this section.

If you can do the proper patch, I'll let you do it, otherwise I'll do 
that later as I have other things to do before.

So Palmer you can drop this patch.

Thanks again,

>>
>> Best regards,
>>     Vitaly
>>
>>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>>> ---
>>>   arch/riscv/Kconfig.erratas | 2 +-
>>>   arch/riscv/Kconfig.socs    | 1 +
>>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
>>> index d5d03ae8d685..9537dbd67357 100644
>>> --- a/arch/riscv/Kconfig.erratas
>>> +++ b/arch/riscv/Kconfig.erratas
>>> @@ -2,7 +2,7 @@ menu "CPU errata selection"
>>>
>>>   config RISCV_ERRATA_ALTERNATIVE
>>>          bool "RISC-V alternative scheme"
>>> -       default y
>>> +       default y if !XIP_KERNEL
>>>          help
>>>            This Kconfig allows the kernel to automatically patch the
>>>            errata required by the execution platform at run time. The
>>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>>> index 00c2b205654c..9cb38bc9d7cd 100644
>>> --- a/arch/riscv/Kconfig.socs
>>> +++ b/arch/riscv/Kconfig.socs
>>> @@ -9,6 +9,7 @@ config SOC_MICROCHIP_POLARFIRE
>>>
>>>   config SOC_SIFIVE
>>>          bool "SiFive SoCs"
>>> +       depends on !XIP_KERNEL
>>>          select SERIAL_SIFIVE if TTY
>>>          select SERIAL_SIFIVE_CONSOLE if TTY
>>>          select CLK_SIFIVE
>>> -- 
>>> 2.20.1
>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

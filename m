Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B20436EA37
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhD2MS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:18:29 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45171 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2MS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:18:28 -0400
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 02D596000D;
        Thu, 29 Apr 2021 12:17:39 +0000 (UTC)
Subject: Re: [PATCH] riscv: Disallow to build XIP_KERNEL with SOC_SIFIVE
To:     Anup Patel <anup@brainfault.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
References: <20210429084541.28083-1-alex@ghiti.fr>
 <CAAhSdy0Wxjop+X2AUp8azDS9JdD21pmdapUjH0vU9rNBu7Evjg@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <6442db5b-ad37-3bb3-b828-caf3311569d0@ghiti.fr>
Date:   Thu, 29 Apr 2021 08:17:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy0Wxjop+X2AUp8azDS9JdD21pmdapUjH0vU9rNBu7Evjg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 4/29/21 à 5:04 AM, Anup Patel a écrit :
> On Thu, Apr 29, 2021 at 2:15 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>
>> RISCV_ERRATA_ALTERNATIVE patches text at runtime which is not possible when
>> the kernel is executed from the flash in XIP mode, and as the SIFIVE
>> errata must be fixed somehow, disallow to build a XIP kernel that
>> supports SIFIVE socs.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>   arch/riscv/Kconfig.erratas | 2 +-
>>   arch/riscv/Kconfig.socs    | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
>> index d5d03ae8d685..9537dbd67357 100644
>> --- a/arch/riscv/Kconfig.erratas
>> +++ b/arch/riscv/Kconfig.erratas
>> @@ -2,7 +2,7 @@ menu "CPU errata selection"
>>
>>   config RISCV_ERRATA_ALTERNATIVE
>>          bool "RISC-V alternative scheme"
>> -       default y
>> +       default y if !XIP_KERNEL
>>          help
>>            This Kconfig allows the kernel to automatically patch the
>>            errata required by the execution platform at run time. The
>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>> index 00c2b205654c..9cb38bc9d7cd 100644
>> --- a/arch/riscv/Kconfig.socs
>> +++ b/arch/riscv/Kconfig.socs
>> @@ -9,6 +9,7 @@ config SOC_MICROCHIP_POLARFIRE
>>
>>   config SOC_SIFIVE
>>          bool "SiFive SoCs"
>> +       depends on !XIP_KERNEL
> 
> Does this mean that now all SOCs will have to explicitly say
> "depends on !XIP_KERNEL"
>  > How about adding "depends on !XIP_KERNEL" for RISCV_ERRATA_ALTERNATIVE ?

In any case, I had to add this because I could not get rid of the 
following warnings:

WARNING: unmet direct dependencies detected for ERRATA_SIFIVE
   Depends on [n]: RISCV_ERRATA_ALTERNATIVE [=n]
   Selected by [y]:
   - SOC_SIFIVE [=y]

If you have a solution for that, without touching any SOC_* config, I'll 
take it.

I'll try to implement what Vitaly proposed as it sounds way better than 
this "bandage" patch.

Thanks Anup,

Alex

> 
> Regards,
> Anup
> 
>>          select SERIAL_SIFIVE if TTY
>>          select SERIAL_SIFIVE_CONSOLE if TTY
>>          select CLK_SIFIVE
>> --
>> 2.20.1
>>
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

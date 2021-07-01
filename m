Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64163B965C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 21:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhGATHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 15:07:41 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:60911 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhGATHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 15:07:40 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 192381C0009;
        Thu,  1 Jul 2021 19:05:04 +0000 (UTC)
Subject: Re: [PATCH 1/3] riscv: Fix memory_limit for 64-bit kernel
From:   Alex Ghiti <alex@ghiti.fr>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210629091349.3802690-1-alex@ghiti.fr>
 <6a38fb9a-d658-836b-4ff4-7c47cadb7db0@huawei.com>
 <8e1bef59-8a65-dfdf-d09d-f578323348be@ghiti.fr>
Message-ID: <86866409-50a9-1974-6bcd-30d66945b238@ghiti.fr>
Date:   Thu, 1 Jul 2021 21:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8e1bef59-8a65-dfdf-d09d-f578323348be@ghiti.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 1/07/2021 à 21:01, Alex Ghiti a écrit :
> Le 1/07/2021 à 12:44, Kefeng Wang a écrit :
>>
>> On 2021/6/29 17:13, Alexandre Ghiti wrote:
>>> As described in Documentation/riscv/vm-layout.rst, the end of the
>>> virtual address space for 64-bit kernel is occupied by the modules/BPF/
>>> kernel mappings so this actually reduces the amount of memory we are 
>>> able
>>> to map and then use in the linear mapping. So make sure this limit is
>>> correctly set.
>>>
>>> Fixes: c9811e379b21 ("riscv: Add mem kernel parameter support")
>>
>>
>> Should the Fixes tag be de043da0b9e7 （“RISC-V: Fix usage of 
>> memblock_enforce_memory_limit“）,
>>
>> The -PAGE_OFFSET is set to the maximal physical memory from this point :)
> 
> Oops, thank you!

Actually the commit you mentioned was merged way before I moved the 
kernel to the end of the address space, so the proper Fixes tag should be:

Fixes: 2bfc6cd81bd1 ("riscv: Move kernel mapping outside of linear mapping")

Thanks anyway,

> 
> Alex
> 
>>
>>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>>> ---
>>>   arch/riscv/mm/init.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index 12f956b3a674..04a5db3a9788 100644
>>> --- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -124,10 +124,17 @@ void __init mem_init(void)
>>>   }
>>>   /*
>>> - * The default maximal physical memory size is -PAGE_OFFSET,
>>> - * limit the memory size via mem.
>>> + * The default maximal physical memory size is -PAGE_OFFSET for 
>>> 32-bit kernel,
>>> + * whereas for 64-bit kernel, the end of the virtual address space 
>>> is occupied
>>> + * by the modules/BPF/kernel mappings which reduces the available 
>>> size of the
>>> + * linear mapping.
>>> + * Limit the memory size via mem.
>>>    */
>>> +#ifdef CONFIG_64BIT
>>> +static phys_addr_t memory_limit = -PAGE_OFFSET - SZ_4G;
>>> +#else
>>>   static phys_addr_t memory_limit = -PAGE_OFFSET;
>>> +#endif
>>>   static int __init early_mem(char *p)
>>>   {
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

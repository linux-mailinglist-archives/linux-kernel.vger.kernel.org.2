Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8B535EE23
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349577AbhDNHDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:03:40 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:58963 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346947AbhDNHDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:03:38 -0400
Received: from [172.16.5.113] (82-65-183-113.subs.proxad.net [82.65.183.113])
        (Authenticated sender: alex@ghiti.fr)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 4E84B100006;
        Wed, 14 Apr 2021 07:03:14 +0000 (UTC)
Subject: Re: [PATCH] implement flush_cache_vmap for RISC-V
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Jiuyang Liu <liu@jiuyang.me>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <waterman@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210412000531.12249-1-liu@jiuyang.me>
 <20210412150817.33f49be8@xhacker.debian>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <18d198ac-7bc0-934d-e1e9-eca01b790d61@ghiti.fr>
Date:   Wed, 14 Apr 2021 03:03:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210412150817.33f49be8@xhacker.debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 4/12/21 à 3:08 AM, Jisheng Zhang a écrit :
> Hi Jiuyang,
> 
> On Mon, 12 Apr 2021 00:05:30 +0000 Jiuyang Liu <liu@jiuyang.me> wrote:
> 
> 
>>
>> This patch implements flush_cache_vmap for RISC-V, since it modifies PTE.
>> Without this patch, SFENCE.VMA won't be added to related codes, which
>> might introduce a bug in the out-of-order micro-architecture
>> implementations.
>>
>> Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
>> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
>> Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
> 
> IIRC, Palmer hasn't given this Reviewed-by tag.
> 
>> ---
> 
> Could you plz add version and changes? IIRC, this is the v3.
> 
>>   arch/riscv/include/asm/cacheflush.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
>> index 23ff70350992..3fd528badc35 100644
>> --- a/arch/riscv/include/asm/cacheflush.h
>> +++ b/arch/riscv/include/asm/cacheflush.h
>> @@ -30,6 +30,12 @@ static inline void flush_dcache_page(struct page *page)
>>   #define flush_icache_user_page(vma, pg, addr, len) \
>>          flush_icache_mm(vma->vm_mm, 0)
>>
>> +/*
>> + * flush_cache_vmap is invoked after map_kernel_range() has installed the page
>> + * table entries, which modifies PTE, SFENCE.VMA should be inserted.
> 
> Just my humble opinion, flush_cache_vmap() may not be necessary. vmalloc_fault
> can take care of this, and finally sfence.vma is inserted in related path.
> 


I believe Palmer and Jisheng are right, my initial proposal to implement 
flush_cache_vmap is wrong.

But then, Jiuyang should not have noticed any problem here, so what's 
wrong? @Jiuyang: Does implementing flush_cache_vmap fix your issue?

And regarding flush_cache_vunmap, from Jisheng call stack, it seems also 
not necessary.

@Jiuyang: Can you tell us more about what you noticed?


> Regards
> 
>> + */
>> +#define flush_cache_vmap(start, end) flush_tlb_all()
>> +
>>   #ifndef CONFIG_SMP
>>
>>   #define flush_icache_all() local_flush_icache_all()
>> --
>> 2.31.1
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

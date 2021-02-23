Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1F932257D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 06:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhBWFmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 00:42:39 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:51165 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhBWFmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:42:37 -0500
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id CBC6E240003;
        Tue, 23 Feb 2021 05:41:52 +0000 (UTC)
Subject: Re: [PATCH] riscv: Pass virtual addresses to kasan_mem_to_shadow
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, glider@google.com, rppt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        linux-riscv@lists.infradead.org, dvyukov@google.com
References: <mhng-ed9c69f4-96ab-417c-90da-4c03a48d1268@palmerdabbelt-glaptop>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <ed70634f-f578-d1d5-7543-915477466d6f@ghiti.fr>
Date:   Tue, 23 Feb 2021 00:41:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <mhng-ed9c69f4-96ab-417c-90da-4c03a48d1268@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

Le 2/22/21 à 9:58 PM, Palmer Dabbelt a écrit :
> On Mon, 22 Feb 2021 00:07:34 PST (-0800), alex@ghiti.fr wrote:
>> kasan_mem_to_shadow translates virtual addresses to kasan shadow
>> addresses whereas for_each_mem_range returns physical addresses: it is
>> then required to use __va on those addresses before passing them to
>> kasan_mem_to_shadow.
>>
>> Fixes: b10d6bca8720 ("arch, drivers: replace for_each_membock() with 
>> for_each_mem_range()")
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>  arch/riscv/mm/kasan_init.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
>> index 4b9149f963d3..6d3b88f2c566 100644
>> --- a/arch/riscv/mm/kasan_init.c
>> +++ b/arch/riscv/mm/kasan_init.c
>> @@ -148,8 +148,8 @@ void __init kasan_init(void)
>>              (void *)kasan_mem_to_shadow((void *)VMALLOC_END));
>>
>>      for_each_mem_range(i, &_start, &_end) {
>> -        void *start = (void *)_start;
>> -        void *end = (void *)_end;
>> +        void *start = (void *)__va(_start);
>> +        void *end = (void *)__va(_end);
>>
>>          if (start >= end)
>>              break;
> 
> Thanks, but unless I'm missing something this is already in Linus' tree as
> c25a053e1577 ("riscv: Fix KASAN memory mapping.").

You're right, I missed this one: but for some reasons, this patch does 
not appear in for-next.

Thanks,

Alex

> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

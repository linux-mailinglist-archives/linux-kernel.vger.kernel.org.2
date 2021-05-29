Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B853A394CC5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhE2PTZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 29 May 2021 11:19:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64695 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhE2PTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 11:19:24 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FslY60NWYzBBP6;
        Sat, 29 May 2021 17:17:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6BGtUzHSN--V; Sat, 29 May 2021 17:17:45 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FslY56ZrCzBBNq;
        Sat, 29 May 2021 17:17:45 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id DDD90478; Sat, 29 May 2021 17:22:14 +0200 (CEST)
Received: from 37.167.129.206 ([37.167.129.206]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Sat, 29 May 2021 17:22:14 +0200
Date:   Sat, 29 May 2021 17:22:14 +0200
Message-ID: <20210529172214.Horde.njR-7XrYj7R9yHI41_Pujw3@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Santosh Sivaraj <santosh@fossix.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 11/15] powerpc: convert to setup_initial_init_mm()
References: <20210529105504.180544-1-wangkefeng.wang@huawei.com>
 <20210529105504.180544-12-wangkefeng.wang@huawei.com>
 <87y2bxemi4.fsf@fossix.org>
In-Reply-To: <87y2bxemi4.fsf@fossix.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Santosh Sivaraj <santosh@fossix.org> a écrit :

> Kefeng Wang <wangkefeng.wang@huawei.com> writes:
>
>> Use setup_initial_init_mm() helper to simplify code.

I only got that patch, and patchwork as well  
(https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=246315)

Can you tell where I can see and get the full series ?

And next time can you copy all patches to linuxppc-dev

Thanks
Christophe

>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  arch/powerpc/kernel/setup-common.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/setup-common.c  
>> b/arch/powerpc/kernel/setup-common.c
>> index 046fe21b5c3b..c046d99efd18 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
>> @@ -928,10 +928,7 @@ void __init setup_arch(char **cmdline_p)
>>
>>  	klp_init_thread_info(&init_task);
>>
>> -	init_mm.start_code = (unsigned long)_stext;
>> -	init_mm.end_code = (unsigned long) _etext;
>> -	init_mm.end_data = (unsigned long) _edata;
>> -	init_mm.brk = klimit;
>> +	setup_initial_init_mm(_stext, _etext, _edata, _end);
>
> This function definition is not visible for those who have subscribed only to
> linuxppc-dev mailing list. I had to do a web-search with the ID.
>
> Thanks,
> Santosh
>
>>
>>  	mm_iommu_init(&init_mm);
>>  	irqstack_early_init();
>> --
>> 2.26.2



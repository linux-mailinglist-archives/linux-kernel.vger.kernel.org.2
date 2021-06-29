Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B903B71C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhF2MJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:09:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5802 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232937AbhF2MJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:09:24 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GDjrb5W3wzB9jv;
        Tue, 29 Jun 2021 14:06:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zHQr_DDFz2aM; Tue, 29 Jun 2021 14:06:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GDjrZ4ZgvzB9f4;
        Tue, 29 Jun 2021 14:06:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7AD418B7C1;
        Tue, 29 Jun 2021 14:06:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dNp7uxly07AA; Tue, 29 Jun 2021 14:06:54 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C9F38B7BE;
        Tue, 29 Jun 2021 14:06:53 +0200 (CEST)
Subject: Re: [PATCH] powerpc/4xx: Fix setup_kuep() on SMP
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <b9c2a9add0f11754539e24c6f421bd2009327c36.1624863323.git.christophe.leroy@csgroup.eu>
 <87tulg7uh6.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <920c4c49-5185-a0d5-0ab2-484effc307cc@csgroup.eu>
Date:   Tue, 29 Jun 2021 14:06:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87tulg7uh6.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/06/2021 à 13:58, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> On SMP, setup_kuep() is also called from start_secondary() since
>> commit 86f46f343272 ("powerpc/32s: Initialise KUAP and KUEP in C").
>>
>> start_secondary() is not an __init function.
>>
>> Remove the __init marker from setup_kuep() and bail out when
>> not caller on the first CPU as the work is already done.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Fixes: 10248dcba120 ("powerpc/44x: Implement Kernel Userspace Exec Protection (KUEP)")
>> Fixes: 86f46f343272 ("powerpc/32s: Initialise KUAP and KUEP in C").
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/mm/nohash/44x.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/nohash/44x.c b/arch/powerpc/mm/nohash/44x.c
>> index 7da6d1e9fc9b..20c18bd5b9a0 100644
>> --- a/arch/powerpc/mm/nohash/44x.c
>> +++ b/arch/powerpc/mm/nohash/44x.c
>> @@ -241,8 +241,11 @@ void __init mmu_init_secondary(int cpu)
>>   #endif /* CONFIG_SMP */
>>   
>>   #ifdef CONFIG_PPC_KUEP
>> -void __init setup_kuep(bool disabled)
>> +void setup_kuep(bool disabled)
>>   {
>> +	if (smp_processor_id() != boot_cpuid)
>> +		return;
>> +
>>   	if (disabled)
>>   		patch_instruction_site(&patch__tlb_44x_kuep, ppc_inst(PPC_RAW_NOP()));
>>   	else
> 
> Building ppc44x_defconfig gives me:
> 
>    /linux/arch/powerpc/mm/nohash/44x.c: In function 'setup_kuep':
>    /linux/arch/powerpc/mm/nohash/44x.c:246:35: error: 'boot_cpuid' undeclared (first use in this function); did you mean 'boot_cpu_init'?
>      246 |         if (smp_processor_id() != boot_cpuid)
>          |                                   ^~~~~~~~~~
>          |                                   boot_cpu_init
>    /linux/arch/powerpc/mm/nohash/44x.c:246:35: note: each undeclared identifier is reported only once for each function it appears in


Seems like we need <asm/smp.h> when we don't have CONFIG_SMP.

I tested it with akebono_defconfig, looks like it has CONFIG_SMP.

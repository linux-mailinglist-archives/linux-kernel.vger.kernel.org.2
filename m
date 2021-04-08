Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE798358847
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhDHPZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:25:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10345 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231785AbhDHPZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:25:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FGQ7c23dGz9txdj;
        Thu,  8 Apr 2021 17:25:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zsF4pkh7DYuh; Thu,  8 Apr 2021 17:25:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FGQ7c0v8Xz9txdh;
        Thu,  8 Apr 2021 17:25:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B4BD68B7D1;
        Thu,  8 Apr 2021 17:25:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qTLohSVjcwj3; Thu,  8 Apr 2021 17:25:33 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 120BE8B7D0;
        Thu,  8 Apr 2021 17:25:33 +0200 (CEST)
Subject: Re: [PATCH v1 2/8] powerpc/mem: Remove address argument to
 flush_coherent_icache()
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <311235752428dacbee81728767aacc2bf4222384.1617816138.git.christophe.leroy@csgroup.eu>
 <8cbdcfc4446154bd3323cc68827f114aa9bbc5e7.1617816138.git.christophe.leroy@csgroup.eu>
 <87k0pdb1n6.fsf@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <8fdbc753-4ed6-ee3f-3317-f0ea5b95bbc9@csgroup.eu>
Date:   Thu, 8 Apr 2021 17:25:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87k0pdb1n6.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/04/2021 à 10:50, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> flush_coherent_icache() can use any valid address as mentionned
>> by the comment.
>>
>> Use PAGE_OFFSET as base address. This allows removing the
>> user access stuff.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/mm/mem.c | 13 +++++--------
>>   1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>> index ce6c81ce4362..19f807b87697 100644
>> --- a/arch/powerpc/mm/mem.c
>> +++ b/arch/powerpc/mm/mem.c
>> @@ -342,10 +342,9 @@ void free_initmem(void)
>>   
>>   /**
>>    * flush_coherent_icache() - if a CPU has a coherent icache, flush it
>> - * @addr: The base address to use (can be any valid address, the whole cache will be flushed)
>>    * Return true if the cache was flushed, false otherwise
>>    */
>> -static inline bool flush_coherent_icache(unsigned long addr)
>> +static inline bool flush_coherent_icache(void)
>>   {
>>   	/*
>>   	 * For a snooping icache, we still need a dummy icbi to purge all the
>> @@ -355,9 +354,7 @@ static inline bool flush_coherent_icache(unsigned long addr)
>>   	 */
>>   	if (cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
>>   		mb(); /* sync */
>> -		allow_read_from_user((const void __user *)addr, L1_CACHE_BYTES);
>> -		icbi((void *)addr);
>> -		prevent_read_from_user((const void __user *)addr, L1_CACHE_BYTES);
>> +		icbi((void *)PAGE_OFFSET);
>>   		mb(); /* sync */
>>   		isync();
>>   		return true;
> 
> do we need that followup sync? Usermanual suggest sync; icbi(any address);
> isync sequence.

I don't know.

The original implementation is here: https://github.com/linuxppc/linux/commit/0ce636700

Christophe

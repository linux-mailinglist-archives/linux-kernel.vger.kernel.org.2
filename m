Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0593F6F62
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbhHYGWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:22:17 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:47301 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238160AbhHYGWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:22:15 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GvbTh5VrXz9sV8;
        Wed, 25 Aug 2021 08:21:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zzsld8JHovDO; Wed, 25 Aug 2021 08:21:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GvbTh4Hczz9sV5;
        Wed, 25 Aug 2021 08:21:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7021B8B83B;
        Wed, 25 Aug 2021 08:21:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iJMTbDJFvujA; Wed, 25 Aug 2021 08:21:28 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E98D28B76A;
        Wed, 25 Aug 2021 08:21:27 +0200 (CEST)
Subject: Re: [PATCH v3 3/3] powerpc: Define and use MSR_RI only on non
 booke/40x
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629707037.git.christophe.leroy@csgroup.eu>
 <627ead32d40c840f9e8a329b60647b649eceb2aa.1629707037.git.christophe.leroy@csgroup.eu>
 <8735qyceev.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <65a5052c-6aa6-d940-fd44-a656cb964053@csgroup.eu>
Date:   Wed, 25 Aug 2021 08:21:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8735qyceev.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/08/2021 à 06:54, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> 40x and BOOKE don't have MSR_RI.
>>
>> Define MSR_RI only for platforms where it exists. For the other ones,
>> defines it as BUILD_BUG for C and do not define it for ASM.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>> v3: Fixes kvm_emul.S and include <linux/bug.h> in <asm/reg.h>
>> ---
>>   arch/powerpc/include/asm/reg.h       |  5 +++++
>>   arch/powerpc/include/asm/reg_booke.h |  6 +++---
>>   arch/powerpc/kernel/head_32.h        |  4 ++++
>>   arch/powerpc/kernel/kvm_emul.S       | 13 +++++++++++++
>>   arch/powerpc/kernel/process.c        |  2 +-
>>   arch/powerpc/lib/sstep.c             |  2 +-
>>   6 files changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> index be85cf156a1f..b270b570fb51 100644
>> --- a/arch/powerpc/include/asm/reg.h
>> +++ b/arch/powerpc/include/asm/reg.h
>> @@ -109,7 +109,12 @@
>>   #ifndef MSR_PMM
>>   #define MSR_PMM		__MASK(MSR_PMM_LG)	/* Performance monitor */
>>   #endif
>> +#if !defined(CONFIG_BOOKE) && !defined(CONFIG_40x)
>>   #define MSR_RI		__MASK(MSR_RI_LG)	/* Recoverable Exception */
> 
> This breaks 64-bit BookE, which is using MSR_RI in bookehv_interrupts.S.
> 
> eg. ppc64_book3e_allmodconfig gives:
> 
>    arch/powerpc/kvm/bookehv_interrupts.S: Assembler messages:
>    arch/powerpc/kvm/bookehv_interrupts.S:221: Error: invalid operands (*ABS* and *UND* sections) for `|'
>    etc.

Oops, I missed that one. Should be easy to fix though as this file is dedicated to BOOKE we can just 
remove MSR_RI from there.

> 
> ISA v2.07B says MSR_RI is Book3S only, but looking at the e500mc manual
> it does have bit 62 defined as RI.

Oh !

So it makes the story different, even different than what we have in kernel today where everything 
is more or less based on CONFIG_BOOKE or CONFIG_40x.

> 
> I can fix it with:
> 
> +#if !(defined(CONFIG_BOOKE) && !defined(CONFIG_PPC_BOOK3E)) && !defined(CONFIG_40x)
>   #define MSR_RI         __MASK(MSR_RI_LG)       /* Recoverable Exception */

Why CONFIG_PPC_BOOK3E ? Shouldn't it be CONFIG_PPC_E500MC instead ?

> 
> 
> But that's getting really ugly, and we'd have to repeat it elsewhere.
> 
> I think we need a kconfig symbol that captures which platforms should
> use MSR_RI, something like:
> 
>    CONFIG PPC_MSR_RI
>      def_bool y
>      depends on !40x && (!BOOKE || PPC_BOOK3E)


Yes I think that would be the best.


> 
> 
> Or maybe we should just define MSR_RI to 0 for platforms that don't use
> it, to avoid so much ifdefing?
> 

Well, I tried to take the same approach as Ben in the original patch 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/61ad3646674e6bf541a8f7fb420cdf556d0b2152.camel@kernel.crashing.org/
but with a smoother approach for C files to avoid ifdefs there.

However for ASM it is different, we can't use tricks like BUILD_BUG. When we had MSR_RI completely 
undefined on all booke it was rather easy, only a few #ifdefs needed in parts common to 3S and 3E. 
But if we bring back MSR_RI on the e500mc that becomes more complex, and I agree with you too many 
#ifdefs will be unfriendly.

On the other hand, setting MSR_RI to 0 will make all tests that check msr & MSR_RI fails during run. 
Isn't it worse than what we have today ?

Maybe the way out is to carrefully look at the situations where e500mc uses MSR_RI, because 
according to the reference manual it is limited to a few situations:

4.4 Recoverability and MSR[RI]
MSR[RI] is an MSR (and save/restore register) storage bit for compatibility with pre-Book E PowerPC
processors. When an interrupt occurs, the recoverable interrupt bit, MSR[RI] is unchanged by the 
interrupt
mechanism when a new MSR is established; however, when a machine check, error report or NMI
interrupt occurs, MSR[RI] is cleared.
If used properly, RI determines whether an interrupt that is taken at the machine check interrupt 
vector can
be safely returned from (that is, that architected state set by the interrupt mechanism has been 
safely stored
by software). RI should be set by software when all MSR values are first established. When an interrupt
occurs that is taken at the machine check interrupt vector, software should set RI when it has 
safely stored
MCSRR0 and MCSRR1. The associated MCSRR1 bit should be checked to determine whether the
interrupt occurred when another machine check interrupt was being processed and before state was
successfully saved. If MCSRR1[RI] is set, it is safe to return when processing is complete.

So, let's think about it.

By the way patch 2 of the series could go now, it doesn't introduces anything new, it only cleans up 
things a bit.

Christophe

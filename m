Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0750D41052E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 10:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbhIRIit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 04:38:49 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:49481 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236345AbhIRIis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 04:38:48 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HBPMR2qpfz9sTp;
        Sat, 18 Sep 2021 10:37:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EfG-Wo9it80d; Sat, 18 Sep 2021 10:37:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HBPMR1GVGz9sTK;
        Sat, 18 Sep 2021 10:37:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FE278B768;
        Sat, 18 Sep 2021 10:37:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 18YJ-zT83g0K; Sat, 18 Sep 2021 10:37:22 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.70])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8AE2D8B764;
        Sat, 18 Sep 2021 10:37:22 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc/32: Don't use a struct based type for pte_t
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <c904599f33aaf6bb7ee2836a9ff8368509e0d78d.1631887042.git.christophe.leroy@csgroup.eu>
 <87tuiiimwu.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <05827f28-873e-ead1-ad32-7aad883b5418@csgroup.eu>
Date:   Sat, 18 Sep 2021 10:37:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87tuiiimwu.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/09/2021 à 05:26, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> Long time ago we had a config item called STRICT_MM_TYPECHECKS
>> to build the kernel with pte_t defined as a structure in order
>> to perform additional build checks or build it with pte_t
>> defined as a simple type in order to get simpler generated code.
>>
>> Commit 670eea924198 ("powerpc/mm: Always use STRICT_MM_TYPECHECKS")
>> made the struct based definition the only one, considering that the
>> generated code was similar in both cases.
>>
>> That's right on ppc64 because the ABI is such that the content of a
>> struct having a single simple type element is passed as register,
>> but on ppc32 such a structure is passed via the stack like any
>> structure.
>>
>> Simple test function:
>>
>> 	pte_t test(pte_t pte)
>> 	{
>> 		return pte;
>> 	}
>>
>> Before this patch we get
>>
>> 	c00108ec <test>:
>> 	c00108ec:	81 24 00 00 	lwz     r9,0(r4)
>> 	c00108f0:	91 23 00 00 	stw     r9,0(r3)
>> 	c00108f4:	4e 80 00 20 	blr
>>
>> So, for PPC32, restore the simple type behaviour we got before
>> commit 670eea924198, but instead of adding a config option to
>> activate type check, do it when __CHECKER__ is set so that type
>> checking is performed by 'sparse' and provides feedback like:
>>
>> 	arch/powerpc/mm/pgtable.c:466:16: warning: incorrect type in return expression (different base types)
>> 	arch/powerpc/mm/pgtable.c:466:16:    expected unsigned long
>> 	arch/powerpc/mm/pgtable.c:466:16:    got struct pte_t [usertype] x
> 
> OK that's a good trade off.
> 
> One question below ...
> 
>> diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
>> index d11b4c61d686..c60199fc6fa6 100644
>> --- a/arch/powerpc/include/asm/pgtable-types.h
>> +++ b/arch/powerpc/include/asm/pgtable-types.h
>> @@ -5,14 +5,26 @@
>>   /* PTE level */
>>   #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
>>   typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
>> -#else
>> +#elif defined(__CHECKER__) || !defined(CONFIG_PPC32)
> 
> It would be nicer if this logic was in Kconfig.
> 
> eg. restore config STRICT_MM_TYPECHECKS but make it always enabled for
> 64-bit, and depend on CHECKER for 32-bit.
> 
> The only thing is I'm not sure if we can test __CHECKER__ in Kconfig?


I think Kconfig doesn't see __CHECKER__, otherwise it would mean that a 
build may get different whether you build with C=1/2 or not.

__CHECKER__ is a define added by sparse when doing the CHECK on a per 
object basis.

What I can do is to add:

#if defined(__CHECKER__) || !defined(CONFIG_PPC32)
#define STRICT_MM_TYPECHECKS
#endif

Christophe

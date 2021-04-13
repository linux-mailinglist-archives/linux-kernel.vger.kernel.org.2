Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE93E35E41B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbhDMQhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:37:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8358 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345371AbhDMQhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:37:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FKWTL3l94z9v4hC;
        Tue, 13 Apr 2021 18:36:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DydKvha3r-0P; Tue, 13 Apr 2021 18:36:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FKWTL1dSsz9v4h8;
        Tue, 13 Apr 2021 18:36:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B63518B7AA;
        Tue, 13 Apr 2021 18:36:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id l6EiQIyyQ9dS; Tue, 13 Apr 2021 18:36:39 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5627A8B75F;
        Tue, 13 Apr 2021 18:36:39 +0200 (CEST)
Subject: Re: [PATCH v1 2/2] powerpc/atomics: Use immediate operand when
 possible
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <09da6fec57792d6559d1ea64e00be9870b02dab4.1617896018.git.christophe.leroy@csgroup.eu>
 <9f50b5fadeb090553e5c2fae025052d04d52f3c7.1617896018.git.christophe.leroy@csgroup.eu>
 <20210412220821.GN26583@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <063ca819-1276-8deb-0d9b-ea6ec33f9a98@csgroup.eu>
Date:   Tue, 13 Apr 2021 18:36:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210412220821.GN26583@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/04/2021 à 00:08, Segher Boessenkool a écrit :
> Hi!
> 
> On Thu, Apr 08, 2021 at 03:33:45PM +0000, Christophe Leroy wrote:
>> +#define ATOMIC_OP(op, asm_op, dot, sign)				\
>>   static __inline__ void atomic_##op(int a, atomic_t *v)			\
>>   {									\
>>   	int t;								\
>>   									\
>>   	__asm__ __volatile__(						\
>>   "1:	lwarx	%0,0,%3		# atomic_" #op "\n"			\
>> -	#asm_op " %0,%2,%0\n"						\
>> +	#asm_op "%I2" dot " %0,%0,%2\n"					\
>>   "	stwcx.	%0,0,%3 \n"						\
>>   "	bne-	1b\n"							\
>> -	: "=&r" (t), "+m" (v->counter)					\
>> -	: "r" (a), "r" (&v->counter)					\
>> +	: "=&b" (t), "+m" (v->counter)					\
>> +	: "r"#sign (a), "r" (&v->counter)				\
>>   	: "cc");							\
>>   }									\
> 
> You need "b" (instead of "r") only for "addi".  You can use "addic"
> instead, which clobbers XER[CA], but *all* inline asm does, so that is
> not a downside here (it is also not slower on any CPU that matters).
> 
>> @@ -238,14 +238,14 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>>   "1:	lwarx	%0,0,%1		# atomic_fetch_add_unless\n\
>>   	cmpw	0,%0,%3 \n\
>>   	beq	2f \n\
>> -	add	%0,%2,%0 \n"
>> +	add%I2	%0,%0,%2 \n"
>>   "	stwcx.	%0,0,%1 \n\
>>   	bne-	1b \n"
>>   	PPC_ATOMIC_EXIT_BARRIER
>> -"	subf	%0,%2,%0 \n\
>> +"	sub%I2	%0,%0,%2 \n\
>>   2:"
>> -	: "=&r" (t)
>> -	: "r" (&v->counter), "r" (a), "r" (u)
>> +	: "=&b" (t)
>> +	: "r" (&v->counter), "rI" (a), "r" (u)
>>   	: "cc", "memory");
> 
> Same here.

Yes, I thought about addic, I didn't find an early solution because I forgot the matching 'addc'.

Now with the couple addc/addic it works well.

Thanks

> 
> Nice patches!
> 
> Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
> 

Christophe

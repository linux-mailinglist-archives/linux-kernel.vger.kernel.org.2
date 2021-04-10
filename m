Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2355935AC82
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhDJJnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:43:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:14173 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhDJJnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:43:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FHVRM0d15z9ty4F;
        Sat, 10 Apr 2021 11:42:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NqKYI2gOJ2e7; Sat, 10 Apr 2021 11:42:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FHVRL6mxcz9ty3r;
        Sat, 10 Apr 2021 11:42:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 22ECD8B78E;
        Sat, 10 Apr 2021 11:42:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AoC6bvYuYijx; Sat, 10 Apr 2021 11:42:56 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8750B8B766;
        Sat, 10 Apr 2021 11:42:54 +0200 (CEST)
Subject: Re: [PATCH v3] powerpc/traps: Enhance readability for trap types
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Xiongwei Song <sxwjean@me.com>, benh@kernel.crashing.org,
        paulus@samba.org, oleg@redhat.com, npiggin@gmail.com,
        aneesh.kumar@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        mikey@neuling.org, haren@linux.ibm.com, akpm@linux-foundation.org,
        rppt@kernel.org, jniethe5@gmail.com, atrajeev@linux.vnet.ibm.com,
        maddy@linux.ibm.com, peterz@infradead.org, kjain@linux.ibm.com,
        kan.liang@linux.intel.com, aik@ozlabs.ru, alistair@popple.id.au,
        pmladek@suse.com, john.ogness@linutronix.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
References: <20210408140750.26832-1-sxwjean@me.com>
 <70ece993-12bd-335c-d246-914564eb51dd@csgroup.eu>
 <874kgfdmxq.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f0a6713d-756c-86f2-636d-2a478bab9be4@csgroup.eu>
Date:   Sat, 10 Apr 2021 11:42:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <874kgfdmxq.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/04/2021 à 02:04, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> Le 08/04/2021 à 16:07, Xiongwei Song a écrit :
>>> From: Xiongwei Song <sxwjean@gmail.com>
>>>
>>> Create a new header named traps.h, define macros to list ppc interrupt
>>> types in traps.h, replace the reference of the trap hex values with these
>>> macros.
> ...
>>> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
>>> index 7c633896d758..5ce9898bc9a6 100644
>>> --- a/arch/powerpc/include/asm/interrupt.h
>>> +++ b/arch/powerpc/include/asm/interrupt.h
>>> @@ -8,6 +8,7 @@
>>>    #include <asm/ftrace.h>
>>>    #include <asm/kprobes.h>
>>>    #include <asm/runlatch.h>
>>> +#include <asm/traps.h>
>>>    
>>>    struct interrupt_state {
>>>    #ifdef CONFIG_PPC_BOOK3E_64
>>> @@ -59,7 +60,7 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrup
>>>    		 * CT_WARN_ON comes here via program_check_exception,
>>>    		 * so avoid recursion.
>>>    		 */
>>> -		if (TRAP(regs) != 0x700)
>>> +		if (TRAP(regs) != INTERRUPT_PROGRAM)
>>>    			CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
>>>    	}
>>>    #endif
>>> @@ -156,7 +157,8 @@ static inline void interrupt_nmi_enter_prepare(struct pt_regs *regs, struct inte
>>>    	/* Don't do any per-CPU operations until interrupt state is fixed */
>>>    #endif
>>>    	/* Allow DEC and PMI to be traced when they are soft-NMI */
>>> -	if (TRAP(regs) != 0x900 && TRAP(regs) != 0xf00 && TRAP(regs) != 0x260) {
>>> +	if (TRAP(regs) != INTERRUPT_DECREMENTER &&
>>> +	    TRAP(regs) != INTERRUPT_PERFMON) {
>>
>> I think too long names hinder readability, see later for suggestions.
> 
> I asked for the longer names :)
> 
> I think they make it easier for people who are less familiar with the
> architecture than us to make sense of the names.

Ok

> 
> And there's only a couple of cases where it requires splitting a line,
> and they could be converted to use switch if we think it's a problem.

> 
>>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>>> index 0c0b1c2cfb49..641b3feef7ee 100644
>>> --- a/arch/powerpc/mm/fault.c
>>> +++ b/arch/powerpc/mm/fault.c
>>> @@ -588,20 +589,24 @@ void __bad_page_fault(struct pt_regs *regs, int sig)
>>>    	/* kernel has accessed a bad area */
>>>    
>>>    	switch (TRAP(regs)) {
>>> -	case 0x300:
>>> -	case 0x380:
>>> -	case 0xe00:
>>> +	case INTERRUPT_DATA_STORAGE:
>>> +#ifdef CONFIG_PPC_BOOK3S
>>> +	case INTERRUPT_DATA_SEGMENT:
>>> +	case INTERRUPT_H_DATA_STORAGE:
>>> +#endif
>>
>> It would be better to avoid #ifdefs when none where necessary before.
> 
> Yes I agree.
> 
> I think these can all be avoided by defining most of the values
> regardless of what platform we're building for. Only the values that
> overlap need to be kept behind an ifdef.

Even if values overlap we can keep multiple definitions for the same value.

It is only when the same name has different values that we need to keep them behind ifdef. Is there 
any ?

Christophe

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7683387D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhCLIlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:41:15 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:17155 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232299AbhCLIk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:40:59 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DxfRF1DSgz9v0v7;
        Fri, 12 Mar 2021 09:40:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Gn7TlhMAF9ZL; Fri, 12 Mar 2021 09:40:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DxfRD60Dgz9v0v4;
        Fri, 12 Mar 2021 09:40:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6EE928B764;
        Fri, 12 Mar 2021 09:40:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id io9eXAHyt1an; Fri, 12 Mar 2021 09:40:57 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9F538B80F;
        Fri, 12 Mar 2021 09:40:56 +0100 (CET)
Subject: Re: [PATCH v2 02/43] powerpc/traps: Declare unrecoverable_exception()
 as __noreturn
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
 <f097a1071254e8f6875588f8fb9771467824a569.1615291471.git.christophe.leroy@csgroup.eu>
 <1615339022.cb2m6h66vl.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9e96b084-1914-f82e-5577-183bb7082d18@csgroup.eu>
Date:   Fri, 12 Mar 2021 09:40:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615339022.cb2m6h66vl.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/03/2021 à 02:22, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of March 9, 2021 10:09 pm:
>> unrecoverable_exception() is never expected to return, most callers
>> have an infiniteloop in case it returns.
>>
>> Ensure it really never returns by terminating it with a BUG(), and
>> declare it __no_return.
>>
>> It always GCC to really simplify functions calling it. In the exemple
>> below, it avoids the stack frame in the likely fast path and avoids
>> code duplication for the exit.
>>
>> With this patch:
> 
> [snip]
> 
> Nice.
> 
>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>> index a44a30b0688c..d5c9d9ddd186 100644
>> --- a/arch/powerpc/kernel/traps.c
>> +++ b/arch/powerpc/kernel/traps.c
>> @@ -2170,11 +2170,15 @@ DEFINE_INTERRUPT_HANDLER(SPEFloatingPointRoundException)
>>    * in the MSR is 0.  This indicates that SRR0/1 are live, and that
>>    * we therefore lost state by taking this exception.
>>    */
>> -void unrecoverable_exception(struct pt_regs *regs)
>> +void __noreturn unrecoverable_exception(struct pt_regs *regs)
>>   {
>>   	pr_emerg("Unrecoverable exception %lx at %lx (msr=%lx)\n",
>>   		 regs->trap, regs->nip, regs->msr);
>>   	die("Unrecoverable exception", regs, SIGABRT);
>> +	/* die() should not return */
>> +	WARN(true, "die() unexpectedly returned");
>> +	for (;;)
>> +		;
>>   }
> 
> I don't think the WARN should be added because that will cause another
> interrupt after something is already badly wrong, so this might just
> make it harder to debug.
> 
> For example if die() is falling through for some reason, we warn and
> cause a program check here, and that might also be unrecoverable so it
> might come through here and fall through again and warn again, etc.
> 
> Putting the infinite loop is good enough I think (and better than there
> was previously).

Ok, dropped the WARN()

> 
> Otherwise
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Thanks,
> Nick
> 

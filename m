Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3D03AB54B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhFQOBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:01:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22188 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231651AbhFQOBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:01:23 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G5Nvk3mNMzBBqj;
        Thu, 17 Jun 2021 15:59:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id afJekXhDhNvo; Thu, 17 Jun 2021 15:59:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G5Nvg4NlXzBBsC;
        Thu, 17 Jun 2021 15:59:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 49CEC8B81B;
        Thu, 17 Jun 2021 15:59:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PdJWFZHSalpG; Thu, 17 Jun 2021 15:59:11 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF7898B815;
        Thu, 17 Jun 2021 15:59:10 +0200 (CEST)
Subject: Re: [PATCH v3 1/5] powerpc/interrupt: Rename and lightly change
 syscall_exit_prepare_main()
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <8071cd2e2f2bdc0711e6ac435dff4a09ff21fee2.1623745949.git.christophe.leroy@csgroup.eu>
 <1623929016.jy0026dpmc.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b0d1d683-613b-6947-7923-015b6b36fe30@csgroup.eu>
Date:   Thu, 17 Jun 2021 15:58:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623929016.jy0026dpmc.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/06/2021 à 13:25, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of June 15, 2021 6:33 pm:
>> Rename syscall_exit_prepare_main() into interrupt_exit_prepare_main()
>>
>> Make it static as it is not used anywhere else.
>>
>> Pass it the 'ret' so that it can 'or' it directly instead of
>> oring twice, once inside the function and once outside.
>>
>> And remove 'r3' parameter which is not used.
>>
>> Also fix a typo where CONFIG_PPC_BOOK3S should be CONFIG_PPC_BOOK3S_64.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>> This series applies on top of Nic's series speeding up interrupt return on 64s
>>
>>   arch/powerpc/kernel/interrupt.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
>> index 74c995a42399..ba2d602d2da6 100644
>> --- a/arch/powerpc/kernel/interrupt.c
>> +++ b/arch/powerpc/kernel/interrupt.c
>> @@ -243,11 +243,10 @@ static notrace void booke_load_dbcr0(void)
>>   #endif
>>   }
>>   
>> -notrace unsigned long syscall_exit_prepare_main(unsigned long r3,
>> -						struct pt_regs *regs)
>> +static notrace unsigned long
>> +interrupt_exit_user_prepare_main(struct pt_regs *regs, unsigned long ret)
> 
> Hmm, I tried switching the order of the arguments thinking it would
> match caller and return registers better but didn't seem to help
> generated code. Yet I think I will make that change to your patch if
> you don't mind.

That's a static function that most likely gets inlined so the order of parameters makes no difference.
I tend to like that almost all functions dealing with interrupts take regs as first param, but I 
have no strong opinion about it so you can change it if that's better for you.

Christophe

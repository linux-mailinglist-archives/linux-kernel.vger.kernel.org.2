Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3807409A79
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhIMRQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:16:15 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:36045 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232274AbhIMRQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:16:13 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H7Y4w5GKJz9sTs;
        Mon, 13 Sep 2021 19:14:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N7hGuJ2nnmOP; Mon, 13 Sep 2021 19:14:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H7Y4w4Gd4z9sTr;
        Mon, 13 Sep 2021 19:14:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7402F8B76E;
        Mon, 13 Sep 2021 19:14:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DHIZJjoe87a4; Mon, 13 Sep 2021 19:14:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.172])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DCC9D8B763;
        Mon, 13 Sep 2021 19:14:55 +0200 (CEST)
Subject: Re: [PATCH RESEND v3 6/6] powerpc/signal: Use
 unsafe_copy_siginfo_to_user()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, hch@infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1718f38859d5366f82d5bef531f255cedf537b5d.1631537060.git.christophe.leroy@csgroup.eu>
 <2b179deba4fd4ec0868cdc48a0230dfa3aa5a22f.1631537060.git.christophe.leroy@csgroup.eu>
 <87h7eopixa.fsf@disp2133>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <fe9ffdd1-e37e-ab2b-3157-d6f60bcf23e5@csgroup.eu>
Date:   Mon, 13 Sep 2021 19:14:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87h7eopixa.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/09/2021 à 17:57, Eric W. Biederman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> Use unsafe_copy_siginfo_to_user() in order to do the copy
>> within the user access block.
>>
>> On an mpc 8321 (book3s/32) the improvment is about 5% on a process
>> sending a signal to itself.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>> v3: Don't leave compat aside, use the new unsafe_copy_siginfo_to_user32()
>> ---
>>   arch/powerpc/kernel/signal_32.c | 8 +++-----
>>   arch/powerpc/kernel/signal_64.c | 5 +----
>>   2 files changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
>> index ff101e2b3bab..3a2db8af2d65 100644
>> --- a/arch/powerpc/kernel/signal_32.c
>> +++ b/arch/powerpc/kernel/signal_32.c
>> @@ -710,9 +710,9 @@ static long restore_tm_user_regs(struct pt_regs *regs, struct mcontext __user *s
>>   }
>>   #endif
>>   
>> -#ifdef CONFIG_PPC64
>> +#ifndef CONFIG_PPC64
>>   
>> -#define copy_siginfo_to_user	copy_siginfo_to_user32
>> +#define unsafe_copy_siginfo_to_user32	unsafe_copy_siginfo_to_user
>>   
>>   #endif /* CONFIG_PPC64 */
> 
> Any particular reason to reverse the sense of this #ifdef?

Yes I had double definition of unsafe_copy_siginfo_to_user(), I could 
have ifdefed out unsafe_copy_siginfo_to_user() in signal.h, but I 
prefered to ifdef out copy_siginfo_to_user32() in compat.h

> 
> Otherwise this change looks much cleaner.

Thanks
Christophe


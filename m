Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD6F3F6EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 07:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhHYFpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 01:45:54 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:52591 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231816AbhHYFpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 01:45:53 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GvZgk5Lc4z9sTx;
        Wed, 25 Aug 2021 07:45:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RKrMKKLXkpmR; Wed, 25 Aug 2021 07:45:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GvZgk4C0qz9sTt;
        Wed, 25 Aug 2021 07:45:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E1438B83B;
        Wed, 25 Aug 2021 07:45:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dxNafVVCFkYi; Wed, 25 Aug 2021 07:45:06 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EB8758B76A;
        Wed, 25 Aug 2021 07:45:05 +0200 (CEST)
Subject: Re: [PATCH v3 1/3] powerpc: Remove MSR_PR check in
 interrupt_exit_{user/kernel}_prepare()
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <385ead49ccb66a259b25fee3eebf0bd4094068f3.1629707037.git.christophe.leroy@csgroup.eu>
 <87zgt6aybp.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f5f598a5-3830-ee21-aff5-cba06deeb959@csgroup.eu>
Date:   Wed, 25 Aug 2021 07:45:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87zgt6aybp.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/08/2021 à 07:27, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> In those hot functions that are called at every interrupt, any saved
>> cycle is worth it.
>>
>> interrupt_exit_user_prepare() and interrupt_exit_kernel_prepare() are
>> called from three places:
>> - From entry_32.S
>> - From interrupt_64.S
>> - From interrupt_exit_user_restart() and interrupt_exit_kernel_restart()
>>
>> In entry_32.S, there are inambiguously called based on MSR_PR:
>>
>> 	interrupt_return:
>> 		lwz	r4,_MSR(r1)
>> 		addi	r3,r1,STACK_FRAME_OVERHEAD
>> 		andi.	r0,r4,MSR_PR
>> 		beq	.Lkernel_interrupt_return
>> 		bl	interrupt_exit_user_prepare
>> 	...
>> 	.Lkernel_interrupt_return:
>> 		bl	interrupt_exit_kernel_prepare
>>
>> In interrupt_64.S, that's similar:
>>
>> 	interrupt_return_\srr\():
>> 		ld	r4,_MSR(r1)
>> 		andi.	r0,r4,MSR_PR
>> 		beq	interrupt_return_\srr\()_kernel
>> 	interrupt_return_\srr\()_user: /* make backtraces match the _kernel variant */
>> 		addi	r3,r1,STACK_FRAME_OVERHEAD
>> 		bl	interrupt_exit_user_prepare
>> 	...
>> 	interrupt_return_\srr\()_kernel:
>> 		addi	r3,r1,STACK_FRAME_OVERHEAD
>> 		bl	interrupt_exit_kernel_prepare
>>
>> In interrupt_exit_user_restart() and interrupt_exit_kernel_restart(),
>> MSR_PR is verified respectively by BUG_ON(!user_mode(regs)) and
>> BUG_ON(user_mode(regs)) prior to calling interrupt_exit_user_prepare()
>> and interrupt_exit_kernel_prepare().
>>
>> The verification in interrupt_exit_user_prepare() and
>> interrupt_exit_kernel_prepare() are therefore useless and can be removed.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Acked-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   arch/powerpc/kernel/interrupt.c | 2 --
>>   1 file changed, 2 deletions(-)
> 
> I'll pick this one up independent of the other two patches.
> 

Second patch should be ok as well, no ?

Christophe

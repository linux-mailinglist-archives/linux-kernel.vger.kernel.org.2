Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16D331616D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhBJIsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:48:18 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:47769 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhBJIq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:46:58 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DbCyv4br2z9v1NF;
        Wed, 10 Feb 2021 09:45:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QECMkfz-wJQJ; Wed, 10 Feb 2021 09:45:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DbCyv3m5Fz9v1NC;
        Wed, 10 Feb 2021 09:45:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6019F8B7FA;
        Wed, 10 Feb 2021 09:46:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BRme29R15nhT; Wed, 10 Feb 2021 09:46:00 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B52868B75F;
        Wed, 10 Feb 2021 09:45:59 +0100 (CET)
Subject: Re: [PATCH v5 20/22] powerpc/syscall: Avoid storing 'current' in
 another pointer
To:     Nicholas Piggin <npiggin@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        'Segher Boessenkool' <segher@kernel.crashing.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        Paul Mackerras <paulus@samba.org>
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
 <24804747098369ebcdac38970b8f7a1260bdd248.1612796617.git.christophe.leroy@csgroup.eu>
 <1612838134.rvncv9kzls.astroid@bobo.none>
 <20210209135053.GD27854@gate.crashing.org>
 <d35cc46eca474b2c9f94a4de269321e7@AcuMS.aculab.com>
 <f6ae2e77-3a89-c294-9a6e-58d84fbb46b1@csgroup.eu>
 <1612922312.mnpowzgd0r.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ebc815d8-f59e-ff8e-206d-bc2f39591055@csgroup.eu>
Date:   Wed, 10 Feb 2021 09:45:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612922312.mnpowzgd0r.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/02/2021 à 03:00, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of February 10, 2021 3:03 am:
>>
>>
>> Le 09/02/2021 à 15:31, David Laight a écrit :
>>> From: Segher Boessenkool
>>>> Sent: 09 February 2021 13:51
>>>>
>>>> On Tue, Feb 09, 2021 at 12:36:20PM +1000, Nicholas Piggin wrote:
>>>>> What if you did this?
>>>>
>>>>> +static inline struct task_struct *get_current(void)
>>>>> +{
>>>>> +	register struct task_struct *task asm ("r2");
>>>>> +
>>>>> +	return task;
>>>>> +}
>>>>
>>>> Local register asm variables are *only* guaranteed to live in that
>>>> register as operands to an asm.  See
>>>>     https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html#Local-Register-Variables
>>>> ("The only supported use" etc.)
>>>>
>>>> You can do something like
>>>>
>>>> static inline struct task_struct *get_current(void)
>>>> {
>>>> 	register struct task_struct *task asm ("r2");
>>>>
>>>> 	asm("" : "+r"(task));
>>>>
>>>> 	return task;
>>>> }
>>>>
>>>> which makes sure that "task" actually is in r2 at the point of that asm.
>>>
>>> If "r2" always contains current (and is never assigned by the compiler)
>>> why not use a global register variable for it?
>>>
>>
>>
>> The change proposed by Nick doesn't solve the issue.
> 
> It seemed to change code generation in a simple test case, oh well.
> 
>>
>> The problem is that at the begining of the function we have:
>>
>> 	unsigned long *ti_flagsp = &current_thread_info()->flags;
>>
>> When the function uses ti_flagsp for the first time, it does use 112(r2)
>>
>> Then the function calls some other functions.
>>
>> Most likely because the function could update 'current', GCC copies r2 into r30, so that if r2 get
>> changed by the called function, ti_flagsp is still based on the previous value of current.
>>
>> Allthough we know r2 wont change, GCC doesn't know it. And in order to save r2 into r30, it needs to
>> save r30 in the stack.
>>
>>
>> By using &current_thread_info()->flags directly instead of this intermediaite ti_flagsp pointer, GCC
>> uses r2 instead instead of doing a copy.
>>
>>
>> Nick, I don't understand the reason why you need that 'ti_flagsp' local var.
> 
> Just to save typing, I don't mind your patch I was just wondering if
> current could be improved in general.
> 

Thanks,

I'll post v6 of it as a follow-up of yesterday's two remaining follow-up patches.

Christophe

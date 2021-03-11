Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70853336BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 06:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCKFpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 00:45:53 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:35982 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhCKFps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 00:45:48 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DwybS6sFBz9v0Mh;
        Thu, 11 Mar 2021 06:45:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id n7spERAgRFLs; Thu, 11 Mar 2021 06:45:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DwybS5BvFz9v0Mg;
        Thu, 11 Mar 2021 06:45:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 737B18B7DC;
        Thu, 11 Mar 2021 06:45:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iIn_HabMNaH5; Thu, 11 Mar 2021 06:45:41 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F25618B767;
        Thu, 11 Mar 2021 06:45:40 +0100 (CET)
Subject: Re: [PATCH v2 03/15] powerpc/align: Convert emulate_spe() to
 user_access_begin
To:     Daniel Axtens <dja@axtens.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1615398265.git.christophe.leroy@csgroup.eu>
 <0ad4629c2d222019e82fcdfccc70d372beb4adf9.1615398265.git.christophe.leroy@csgroup.eu>
 <8735x2d4it.fsf@dja-thinkpad.axtens.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <cc59942e-7f8c-196d-a734-07674178e189@csgroup.eu>
Date:   Thu, 11 Mar 2021 06:45:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <8735x2d4it.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/03/2021 à 23:31, Daniel Axtens a écrit :
> Hi Christophe,
> 
>> This patch converts emulate_spe() to using user_access_being
> s/being/begin/ :)
>> logic.
>>
>> Since commit 662bbcb2747c ("mm, sched: Allow uaccess in atomic with
>> pagefault_disable()"), might_fault() doesn't fire when called from
>> sections where pagefaults are disabled, which must be the case
>> when using _inatomic variants of __get_user and __put_user. So
>> the might_fault() in user_access_begin() is not a problem.
> (likewise with the might_fault() in __get_user_nocheck, called from
> unsafe_get_user())

unsafe_get_user() call __get_user_nocheck() with do_allow = false, so there is no might_fault() there.

> 
>> There was a verification of user_mode() together with the access_ok(),
>> but the function returns in case !user_mode() immediately after
>> the access_ok() verification, so removing that test has no effect.
> 
> I agree that removing the test is safe.
> 
>> -	/* Verify the address of the operand */
>> -	if (unlikely(user_mode(regs) &&
>> -		     !access_ok(addr, nb)))
>> -		return -EFAULT;
>> -
> 
> I found the reasoning a bit confusing: I think it's safe to remove
> because:

Ok, I'll see if I can rephrase it.

> 
>   - we have the usermode check immediately following it:
> 
>>   	/* userland only */
>>   	if (unlikely(!user_mode(regs)))
>>   		return 0;
> 
>   - and then we have the access_ok() check as part of
>     user_read_access_begin later on in the function:
> 
>> +		if (!user_read_access_begin(addr, nb))
>> +			return -EFAULT;
>> +
> 
> 
>>   		switch (nb) {
>>   		case 8:
>> -			ret |= __get_user_inatomic(temp.v[0], p++);
>> -			ret |= __get_user_inatomic(temp.v[1], p++);
>> -			ret |= __get_user_inatomic(temp.v[2], p++);
>> -			ret |= __get_user_inatomic(temp.v[3], p++);
>> +			unsafe_get_user(temp.v[0], p++, Efault_read);
>> +			unsafe_get_user(temp.v[1], p++, Efault_read);
>> +			unsafe_get_user(temp.v[2], p++, Efault_read);
>> +			unsafe_get_user(temp.v[3], p++, Efault_read);
> 
> This will bail early rather than trying every possible read. I think
> that's OK. 

It tries every possible read, but at the end it bails out with EFAULT, so I see no point.

> I can't think of a situation where we could fail to read the
> first byte and then successfully read later bytes, for example. Also I
> can't think of a sane way userspace could depend on that behaviour. So I
> agree with this change (and the change to the write path).
> 
>>   			fallthrough;
>>   		case 4:
>> -			ret |= __get_user_inatomic(temp.v[4], p++);
>> -			ret |= __get_user_inatomic(temp.v[5], p++);
>> +			unsafe_get_user(temp.v[4], p++, Efault_read);
>> +			unsafe_get_user(temp.v[5], p++, Efault_read);
>>   			fallthrough;
>>   		case 2:
>> -			ret |= __get_user_inatomic(temp.v[6], p++);
>> -			ret |= __get_user_inatomic(temp.v[7], p++);
>> -			if (unlikely(ret))
>> -				return -EFAULT;
>> +			unsafe_get_user(temp.v[6], p++, Efault_read);
>> +			unsafe_get_user(temp.v[7], p++, Efault_read);
>>   		}
>> +		user_read_access_end();
>>   
>>   		switch (instr) {
>>   		case EVLDD:
>> @@ -255,31 +250,41 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
>>   
>>   	/* Store result to memory or update registers */
>>   	if (flags & ST) {
>> -		ret = 0;
>>   		p = addr;
>> +
>> +		if (!user_read_access_begin(addr, nb))
> 
> That should be a user_write_access_begin.

Good catch thanks.

> 
>> +			return -EFAULT;
>> +
> 
> 
>>   
>>   	return 1;
>> +
>> +Efault_read:
> 
> Checkpatch complains that this is CamelCase, which seems like a
> checkpatch problem. Efault_{read,write} seem like good labels to me.

I'm not keen of names mixing capital letters and lowercase, but Efault is the label that has been 
used almost everywhere with unsafe_get/put_user(), so I inclined myself.

> 
> (You don't need to change anything, I just like to check the checkpatch
> results when reviewing a patch.)
> 
>> +	user_read_access_end();
>> +	return -EFAULT;
>> +
>> +Efault_write:
>> +	user_write_access_end();
>> +	return -EFAULT;
>>   }
>>   #endif /* CONFIG_SPE */
>>
> 
> With the user_write_access_begin change:
>    Reviewed-by: Daniel Axtens <dja@axtens.net>
> 
> Kind regards,
> Daniel
> 

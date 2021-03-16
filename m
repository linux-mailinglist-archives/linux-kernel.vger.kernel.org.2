Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F137833CE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhCPG7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:59:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38653 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230119AbhCPG6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:58:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F03zY0WgDz9v01q;
        Tue, 16 Mar 2021 07:58:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id e2NK6-bMWQEG; Tue, 16 Mar 2021 07:58:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F03zX6r8nz9v01p;
        Tue, 16 Mar 2021 07:58:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B308B8B77F;
        Tue, 16 Mar 2021 07:58:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yBFLcIOLaKVI; Tue, 16 Mar 2021 07:58:49 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1CD688B766;
        Tue, 16 Mar 2021 07:58:49 +0100 (CET)
Subject: Re: [PATCH] smp: kernel/panic.c - silence warnings
To:     "heying (H)" <heying24@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>, peterz@infradead.org,
        mingo@kernel.org, frederic@kernel.org, paulmck@kernel.org,
        clg@kaod.org, qais.yousef@arm.com
Cc:     johnny.chenyi@huawei.com, linux-kernel@vger.kernel.org
References: <20210316040819.29085-1-heying24@huawei.com>
 <2e1a9910-a266-f327-2f5e-413b2f60546a@infradead.org>
 <f18e835b-12a5-bd59-fa40-f6893deea59d@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <af2bb486-56f2-3bcd-40d2-dd1441c1fc88@csgroup.eu>
Date:   Tue, 16 Mar 2021 07:58:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <f18e835b-12a5-bd59-fa40-f6893deea59d@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/03/2021 à 07:35, heying (H) a écrit :
> Thanks for your reply.
> 
> 
> 在 2021/3/16 13:15, Randy Dunlap 写道:
>> On 3/15/21 9:08 PM, He Ying wrote:
>>> We found these warnings in kernel/panic.c by using sparse tool:
>>> warning: symbol 'panic_smp_self_stop' was not declared.
>>> warning: symbol 'nmi_panic_self_stop' was not declared.
>>> warning: symbol 'crash_smp_send_stop' was not declared.
>>>
>>> To avoid them, add declarations for these three functions in
>>> include/linux/smp.h.
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: He Ying <heying24@huawei.com>
>>> ---
>>>   include/linux/smp.h | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/include/linux/smp.h b/include/linux/smp.h
>>> index 70c6f6284dcf..861a253cc179 100644
>>> --- a/include/linux/smp.h
>>> +++ b/include/linux/smp.h
>>> @@ -50,6 +50,14 @@ extern unsigned int total_cpus;
>>>   int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
>>>                    int wait);
>>> +/*
>>> + * Cpus stopping functions in panic. All have default weak definations.
>>                                                                definitions.
> Sorry for my typo.
>>
>>> + * Architecure dependent code may override them.
>>        Architecture-dependent
> Is that necessary?

Sure you are missing a 't'

Architecure ==> Architecture

>>
>>
>>> + */
>>> +void panic_smp_self_stop(void);
>>> +void nmi_panic_self_stop(struct pt_regs *regs);
>>> +void crash_smp_send_stop(void);
>>> +
>>>   /*
>>>    * Call a function on all processors
>>>    */
>>>
>>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397A033EF04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhCQLBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:01:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11144 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229904AbhCQLAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:00:53 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F0nJL0lMJzB09ZQ;
        Wed, 17 Mar 2021 12:00:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fIYz-sycb4US; Wed, 17 Mar 2021 12:00:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F0nJK50DvzB09ZN;
        Wed, 17 Mar 2021 12:00:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DBA2A8B83B;
        Wed, 17 Mar 2021 12:00:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lsc9qA8DkVwB; Wed, 17 Mar 2021 12:00:50 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EA7458B82F;
        Wed, 17 Mar 2021 12:00:48 +0100 (CET)
Subject: Re: [PATCH v2] smp: kernel/panic.c - silence warnings
To:     Ingo Molnar <mingo@kernel.org>, He Ying <heying24@huawei.com>
Cc:     peterz@infradead.org, frederic@kernel.org, paulmck@kernel.org,
        clg@kaod.org, qais.yousef@arm.com, johnny.chenyi@huawei.com,
        linux-kernel@vger.kernel.org
References: <20210316084150.75201-1-heying24@huawei.com>
 <20210317094908.GB1724119@gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9691919b-d014-7433-3345-812c9b19a677@csgroup.eu>
Date:   Wed, 17 Mar 2021 12:00:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210317094908.GB1724119@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/03/2021 à 10:49, Ingo Molnar a écrit :
> 
> * He Ying <heying24@huawei.com> wrote:
> 
>> We found these warnings in kernel/panic.c by using sparse tool:
>> warning: symbol 'panic_smp_self_stop' was not declared.
>> warning: symbol 'nmi_panic_self_stop' was not declared.
>> warning: symbol 'crash_smp_send_stop' was not declared.
>>
>> To avoid them, add declarations for these three functions in
>> include/linux/smp.h.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: He Ying <heying24@huawei.com>
>> ---
>> V1->V2:
>> - fix some misspellings
>>
>>   include/linux/smp.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/include/linux/smp.h b/include/linux/smp.h
>> index 70c6f6284dcf..27008a1c8111 100644
>> --- a/include/linux/smp.h
>> +++ b/include/linux/smp.h
>> @@ -50,6 +50,14 @@ extern unsigned int total_cpus;
>>   int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
>>   			     int wait);
>>   
>> +/*
>> + * Cpus stopping functions in panic. All have default weak definitions.
>> + * Architecture-dependent code may override them.
>> + */
>> +void panic_smp_self_stop(void);
>> +void nmi_panic_self_stop(struct pt_regs *regs);
>> +void crash_smp_send_stop(void);
> 

What do you mean ? 'extern' prototype is pointless for function prototypes and deprecated, no new 
function prototypes should be added with the 'extern' keyword.

checkpatch.pl tells you: "extern prototypes should be avoided in .h files"

Christophe

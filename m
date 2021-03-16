Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF3A33CE01
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhCPGgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:36:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14345 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhCPGgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:36:07 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F03R8740rz8yvq;
        Tue, 16 Mar 2021 14:34:12 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 16 Mar 2021 14:35:56 +0800
Subject: Re: [PATCH] smp: kernel/panic.c - silence warnings
To:     Randy Dunlap <rdunlap@infradead.org>, <peterz@infradead.org>,
        <mingo@kernel.org>, <frederic@kernel.org>, <paulmck@kernel.org>,
        <christophe.leroy@csgroup.eu>, <clg@kaod.org>,
        <qais.yousef@arm.com>
CC:     <johnny.chenyi@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20210316040819.29085-1-heying24@huawei.com>
 <2e1a9910-a266-f327-2f5e-413b2f60546a@infradead.org>
From:   "heying (H)" <heying24@huawei.com>
Message-ID: <f18e835b-12a5-bd59-fa40-f6893deea59d@huawei.com>
Date:   Tue, 16 Mar 2021 14:35:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2e1a9910-a266-f327-2f5e-413b2f60546a@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.


在 2021/3/16 13:15, Randy Dunlap 写道:
> On 3/15/21 9:08 PM, He Ying wrote:
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
>>   include/linux/smp.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/include/linux/smp.h b/include/linux/smp.h
>> index 70c6f6284dcf..861a253cc179 100644
>> --- a/include/linux/smp.h
>> +++ b/include/linux/smp.h
>> @@ -50,6 +50,14 @@ extern unsigned int total_cpus;
>>   int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
>>   			     int wait);
>>   
>> +/*
>> + * Cpus stopping functions in panic. All have default weak definations.
>                                                                definitions.
Sorry for my typo.
>
>> + * Architecure dependent code may override them.
>        Architecture-dependent
Is that necessary?
>
>
>> + */
>> +void panic_smp_self_stop(void);
>> +void nmi_panic_self_stop(struct pt_regs *regs);
>> +void crash_smp_send_stop(void);
>> +
>>   /*
>>    * Call a function on all processors
>>    */
>>
>

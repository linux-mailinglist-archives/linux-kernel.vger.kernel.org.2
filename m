Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E6137622C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhEGIhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:37:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17143 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbhEGIhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:37:00 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc3bs1dMPzqT3C;
        Fri,  7 May 2021 16:32:41 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.131) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 7 May 2021
 16:35:49 +0800
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <john.ogness@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <bobo.shaobowang@huawei.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <20210506091323.20ba2464@gandalf.local.home>
From:   luojiaxing <luojiaxing@huawei.com>
Message-ID: <a623b823-9497-db9d-9d81-6b8cbb0931d3@huawei.com>
Date:   Fri, 7 May 2021 16:35:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20210506091323.20ba2464@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.40.192.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/6 21:13, Steven Rostedt wrote:
> On Thu, 6 May 2021 16:00:26 +0800
> Luo Jiaxing <luojiaxing@huawei.com> wrote:
>
>> Some threads still call printk() for printing when resume_console() is
>> being executed. In practice, the printk() is executed for a period of time
>> and then returned. The duration is determined by the number of prints
>> cached in the prb during the suspend/resume process. At the same time,
>> resume_console() returns quickly.
>>
>> Base on owner/waiter machanism, the frist one who fail to lock console will
>> become waiter, and start spining. When current owner finish print one
>> informance, if a waiter is waitting, owner will give up and let waiter
>> become a new owner. New owner need to flush the whole prb unitl prb empty
>> or another new waiter come and take the job from him.
>>
>> So the first waiter after resume_console() will take seconds to help to
>> flush prb, but driver which call printk() may be bothered by this. New
>> a flag to mark resume flushing prb. When the console resume, before the
>> prb is empty, stop to set a new waiter temporarily.
>>
>> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
>> ---
>>   kernel/printk/printk.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 575a34b..2c680a5 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -287,6 +287,9 @@ EXPORT_SYMBOL(console_set_on_cmdline);
>>   /* Flag: console code may call schedule() */
>>   static int console_may_schedule;
>>   
>> +/* Flags: console flushing prb when resume */
>> +static atomic_t console_resume_flush_prb = ATOMIC_INIT(0);
> Why are you using an atomic? It's accessed within locks.


Hi, Steven, My method is to add a flag. When the flag is set, the 
console_resume context can exclusively keep the sonsole ower lock.

As for each CPU may invoke printk at any time, we have to ensure that 
each CPU can obtain the latest flag value in a timely manner.

Initially, wmb was also considered, but I think wmb is not suitable for 
machines with multiple NUMA nodes, atomic variables were used then.


In addition, only console_resume sets the flag, so whether the flag is 
locked is not considered.


Thanks

Jiaxing


>
> static bool console_resuming;
>
>
>> +
>>   enum con_msg_format_flags {
>>   	MSG_FORMAT_DEFAULT	= 0,
>>   	MSG_FORMAT_SYSLOG	= (1 << 0),
>> @@ -1781,7 +1784,8 @@ static int console_trylock_spinning(void)
>>   	raw_spin_lock(&console_owner_lock);
>>   	owner = READ_ONCE(console_owner);
>>   	waiter = READ_ONCE(console_waiter);
> 	resuming = READ_ONCE(console_removing);
>
>> -	if (!waiter && owner && owner != current) {
> 	if (!resuming && (!waiter ...
>
>> +	if (!waiter && owner && owner != current &&
>> +	    !atomic_read(&console_resume_flush_prb)) {
>>   		WRITE_ONCE(console_waiter, true);
>>   		spin = true;
>>   	}
>> @@ -2355,6 +2359,7 @@ void resume_console(void)
>>   	if (!console_suspend_enabled)
>>   		return;
>>   	down_console_sem();
>> +	atomic_set(&console_resume_flush_prb, 1);
>>   	console_suspended = 0;
> 	resuming = true;
>
>>   	console_unlock();
> 	/* Keep clearing resume from entering the console_unlock */
> 	smp_wmb();
> 	resuming = false;
>
>
>>   }
>> @@ -2592,6 +2597,8 @@ void console_unlock(void)
>>   	raw_spin_unlock(&logbuf_lock);
>>   
>>   	up_console_sem();
>> +	if (atomic_read(&console_resume_flush_prb))
>> +		atomic_set(&console_resume_flush_prb, 0);
> Get rid of the above.
>
> -- Steve
>
>>   
>>   	/*
>>   	 * Someone could have filled up the buffer again, so re-check if there's
>
> .
>


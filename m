Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7D377D51
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhEJHms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:42:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2547 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhEJHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:42:47 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FdtGX6z56zkYH6;
        Mon, 10 May 2021 15:39:00 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.131) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Mon, 10 May 2021
 15:41:31 +0800
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
To:     Petr Mladek <pmladek@suse.com>
CC:     <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        <john.ogness@linutronix.de>, <linux-kernel@vger.kernel.org>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>,
        <linuxarm@huawei.com>, <bobo.shaobowang@huawei.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley>
From:   luojiaxing <luojiaxing@huawei.com>
Message-ID: <f38cd7b9-22a4-b65d-fd37-2d95fe95fc00@huawei.com>
Date:   Mon, 10 May 2021 15:41:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <YJPxj83F1sBjHHAE@alley>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.40.192.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/6 21:39, Petr Mladek wrote:
> On Thu 2021-05-06 16:00:26, Luo Jiaxing wrote:
>> Some threads still call printk() for printing when resume_console() is
>> being executed. In practice, the printk() is executed for a period of time
>> and then returned. The duration is determined by the number of prints
>> cached in the prb during the suspend/resume process. At the same time,
>> resume_console() returns quickly.
> The last sentence is a bit misleading. resume_console() returns
> quickly only when @console_owner was passed to another process.
>
>
>> Base on owner/waiter machanism, the frist one who fail to lock console will
>> become waiter, and start spining. When current owner finish print one
>> informance, if a waiter is waitting, owner will give up and let waiter
>> become a new owner. New owner need to flush the whole prb unitl prb empty
>> or another new waiter come and take the job from him.
>>
>> So the first waiter after resume_console() will take seconds to help to
> It need not to be the first waiter. The console_lock owner might be passed
> several times.
>
> But you have a point. Many messages might get accumulated when the
> console was suspended and any console_owner might spend a long time
> processing them. resume_console() seems to be always called in
> preemptible context, so it is safe to process all messages here.
>
>
>> flush prb, but driver which call printk() may be bothered by this. New
>> a flag to mark resume flushing prb. When the console resume, before the
>> prb is empty, stop to set a new waiter temporarily.
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -287,6 +287,9 @@ EXPORT_SYMBOL(console_set_on_cmdline);
>>   /* Flag: console code may call schedule() */
>>   static int console_may_schedule;
>>   
>> +/* Flags: console flushing prb when resume */
>> +static atomic_t console_resume_flush_prb = ATOMIC_INIT(0);
>> +
>>   enum con_msg_format_flags {
>>   	MSG_FORMAT_DEFAULT	= 0,
>>   	MSG_FORMAT_SYSLOG	= (1 << 0),
>> @@ -1781,7 +1784,8 @@ static int console_trylock_spinning(void)
>>   	raw_spin_lock(&console_owner_lock);
>>   	owner = READ_ONCE(console_owner);
>>   	waiter = READ_ONCE(console_waiter);
>> -	if (!waiter && owner && owner != current) {
>> +	if (!waiter && owner && owner != current &&
>> +	    !atomic_read(&console_resume_flush_prb)) {
> atomic_set()/atomic_read() do not provide any memory barriers.
> IMHO, the atomic operations are not enough to serialize @console_owner
> and @console_resume_flush_prb manipulation.
>
> See below.
>
>>   		WRITE_ONCE(console_waiter, true);
>>   		spin = true;
>>   	}
>> @@ -2355,6 +2359,7 @@ void resume_console(void)
>>   	if (!console_suspend_enabled)
>>   		return;
>>   	down_console_sem();
>> +	atomic_set(&console_resume_flush_prb, 1);
>>   	console_suspended = 0;
>>   	console_unlock();
>>   }
>> @@ -2592,6 +2597,8 @@ void console_unlock(void)
>>   	raw_spin_unlock(&logbuf_lock);
>>   
>>   	up_console_sem();
>> +	if (atomic_read(&console_resume_flush_prb))
>> +		atomic_set(&console_resume_flush_prb, 0);
> This should be done under console_lock. Othwerwise,
> it is not serialized at all.
>
> Also there is one more return from console_unlock():
>
> 	if (!can_use_console()) {
> 		console_locked = 0;
> 		up_console_sem();
> 		return;
> 	}
>
> @console_resume_flush_prb must be cleared here as well.
> Otherwise, the next random console_unlock() caller will not
> be allowed to pass the console lock owner.
>
>
> OK, the above patch tries to tell console_trylock_spinning()
> that it should ignore console_owner even when set.
> @console_resume_flush_prb variable is set/read by different
> processes in parallel which makes it complicated.
>
> Instead, we should simply tell console_unlock() that it should not
> set console_owner in this case. The most strightforward
> way is to pass this via parameter.
>
> Such console_unlock() might be used even on another locations
> with preemptible context.
>
>
> What about the following patch?


Hi, Petr, I test your patch and I think it needs to make some 
modifications to fix the problem.


My test method is as follows:
Kernel thread A causes the console to enter suspend and then resume it 
10 seconds later.
Kernel thread B repeatedly invokes dev_info() for 15 seconds after the 
console suspend.

My expected result is that the call to dev_info() in kernel thread B 
does not block for a long time.

But the actual test result shows that kernel thread B is still blocked 
after console_resume.

I modified some of the code to meet expectations, Please check below.


>
>
> >From 574e844f512c9f450e64832f09cc389bc9915f83 Mon Sep 17 00:00:00 2001
> From: Petr Mladek <pmladek@suse.com>
> Date: Thu, 6 May 2021 12:40:56 +0200
> Subject: [PATCH] printk: Prevent softlockup when resuming console
>
> Many printk messages might get accumulated when consoles were suspended.
> They are proceed when console_unlock() is called in resume_console().
>
> The possibility to pass the console lock owner was added to reduce the risk
> of softlockup when too many messages were handled in an atomic context.
>
> Now, resume_console() is always in a preemptible context that is safe
> to handle all accumulated messages. The possibility to pass the console
> lock owner actually makes things worse. The new owner might be in an atomic
> context and might cause softlockup when processing all messages accumulated
> when the console was suspended.
>
> Create new console_unlock_preemptible() that will not allow to pass
> the console lock owner. As a result, all accumulated messages will
> be proceed in the safe preemptible process.
>
> Use it in resume_console(). But it might be used also on other locations
> where console lock was used in preemptible context and many messages
> might get accumulated when the process was sleeping.
>
> Reported-by: Luo Jiaxing <luojiaxing@huawei.com>
> Suggested-by: Luo Jiaxing <luojiaxing@huawei.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>   include/linux/console.h |  1 +
>   kernel/printk/printk.c  | 39 +++++++++++++++++++++++++++++++++------
>   2 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 20874db50bc8..0c444c6448e8 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -174,6 +174,7 @@ extern struct console *console_drivers;
>   extern void console_lock(void);
>   extern int console_trylock(void);
>   extern void console_unlock(void);
> +extern void console_unlock_preemptible(void);
>   extern void console_conditional_schedule(void);
>   extern void console_unblank(void);
>   extern void console_flush_on_panic(enum con_flush_mode mode);
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 421c35571797..a7e94c898646 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2425,7 +2425,7 @@ void resume_console(void)
>   		return;
>   	down_console_sem();
>   	console_suspended = 0;
> -	console_unlock();
> +	console_unlock_preemptible();
>   }
>   
>   /**
> @@ -2534,10 +2534,8 @@ static inline int can_use_console(void)
>    * the output prior to releasing the lock.
>    *
>    * If there is output waiting, we wake /dev/kmsg and syslog() users.
> - *
> - * console_unlock(); may be called from any context.
>    */
> -void console_unlock(void)
> +void __console_unlock(bool spinning_enabled)
>   {
>   	static char ext_text[CONSOLE_EXT_LOG_MAX];
>   	static char text[CONSOLE_LOG_MAX];
> @@ -2546,6 +2544,7 @@ void console_unlock(void)
>   	struct printk_info info;
>   	struct printk_record r;
>   
> +
>   	if (console_suspended) {
>   		up_console_sem();
>   		return;
> @@ -2637,13 +2636,15 @@ void console_unlock(void)
>   		 * finish. This task can not be preempted if there is a
>   		 * waiter waiting to take over.
>   		 */
> -		console_lock_spinning_enable();
> +		if (spinning_enabled)
> +			console_lock_spinning_enable();


change to


+               if (!spinning_enabled) {
+                       raw_spin_lock(&console_owner_lock);
+                       WRITE_ONCE(console_waiter, true);
+                       raw_spin_unlock(&console_owner_lock);
+               }


set console_waiter true here can prevent other thread from spinning.


>   
>   		stop_critical_timings();	/* don't trace print latency */
>   		call_console_drivers(ext_text, ext_len, text, len);
>   		start_critical_timings();
>   
> -		if (console_lock_spinning_disable_and_check()) {
> +		if (spinning_enabled &&
> +		    console_lock_spinning_disable_and_check()) {
>   			printk_safe_exit_irqrestore(flags);
>   			return;
>   		}


add some code to release console_waiter before return


@@ -2592,6 +2595,12 @@ void __console_unlock(bool spinning_enabled)
                         cond_resched();
         }

+       if (!spinning_enabled) {
+               raw_spin_lock(&console_owner_lock);
+               WRITE_ONCE(console_waiter, false);
+               raw_spin_unlock(&console_owner_lock);
+       }
+
         console_locked = 0;

Thanks

Jiaxing


> @@ -2670,8 +2671,34 @@ void console_unlock(void)
>   	if (retry && console_trylock())
>   		goto again;
>   }
> +
> +/*
> + * Classic console_unlock() that might be called in any context.
> + *
> + * It allows to pass the console lock owner when processing the buffered
> + * messages. It helps to prevent soft lockups in an atomic context.
> + */
> +void console_unlock()
> +{
> +	__console_unlock(true);
> +}
>   EXPORT_SYMBOL(console_unlock);
>   
> +/*
> + * Variant of the console unlock that can be called only in preemptible
> + * context.
> + *
> + * All messages are processed in this safe context. It helps to prevent
> + * softlockups when the console lock owner was passed to an atomic context.
> + */
> +void console_unlock_preemptible()
> +{
> +	lockdep_assert_preemption_enabled();
> +
> +	__console_unlock(false);
> +}
> +EXPORT_SYMBOL(console_unlock_preemptible);
> +
>   /**
>    * console_conditional_schedule - yield the CPU if required
>    *


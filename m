Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F90935578B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345569AbhDFPR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345563AbhDFPRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617722237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=soYidIvKsSOwqgZrinbzJOhQz2wKNaQ54JiSN4TC7cg=;
        b=URu1f0IoeTQGecrEQT6vRLw7bIOTb9Sp3mjs2b/nblPKxqO1XnlvJSbRTl5FJNW5mQSdO1
        6GmM/Zvp2o1p/XpA48DkNE4yHFu1rHl8p732kraliOrWciCVEmUSb8EpoFd5HGvTB+deg7
        mcuFykGtK8aBRncuq5wuD5FabrU/W0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-JR-AIwFJO2qci2j2pVIJMA-1; Tue, 06 Apr 2021 11:17:15 -0400
X-MC-Unique: JR-AIwFJO2qci2j2pVIJMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8939B107ACCA;
        Tue,  6 Apr 2021 15:17:13 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-144.rdu2.redhat.com [10.10.117.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C771B5D9D0;
        Tue,  6 Apr 2021 15:17:04 +0000 (UTC)
Subject: Re: [PATCH v4] sched/debug: Use sched_debug_lock to serialize use of
 cgroup_path[] only
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20210405234203.23526-1-longman@redhat.com>
 <YGwmsePipAYoAI2H@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c10d04c0-23f6-8bbb-2ba7-6d7e2ea0280e@redhat.com>
Date:   Tue, 6 Apr 2021 11:17:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YGwmsePipAYoAI2H@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 5:15 AM, Peter Zijlstra wrote:
> On Mon, Apr 05, 2021 at 07:42:03PM -0400, Waiman Long wrote:
>> The handling of sysrq key can be activated by echoing the key to
>> /proc/sysrq-trigger or via the magic key sequence typed into a terminal
>> that is connected to the system in some way (serial, USB or other mean).
>> In the former case, the handling is done in a user context. In the
>> latter case, it is likely to be in an interrupt context.
>> [ 7809.796281]  </NMI>
>> [ 7809.796282]  _raw_spin_lock_irqsave+0x32/0x40
>> [ 7809.796283]  print_cpu+0x261/0x7c0
>> [ 7809.796283]  sysrq_sched_debug_show+0x34/0x50
>> [ 7809.796284]  sysrq_handle_showstate+0xc/0x20
>> [ 7809.796284]  __handle_sysrq.cold.11+0x48/0xfb
>> [ 7809.796285]  write_sysrq_trigger+0x2b/0x30
>> [ 7809.796285]  proc_reg_write+0x39/0x60
>> [ 7809.796286]  vfs_write+0xa5/0x1a0
>> [ 7809.796286]  ksys_write+0x4f/0xb0
>> [ 7809.796287]  do_syscall_64+0x5b/0x1a0
>> [ 7809.796287]  entry_SYSCALL_64_after_hwframe+0x65/0xca
>> [ 7809.796288] RIP: 0033:0x7fabe4ceb648
>>
>> The purpose of sched_debug_lock is to serialize the use of the global
>> cgroup_path[] buffer in print_cpu(). The rests of the printk calls don't
>> need serialization from sched_debug_lock.
>> The print_cpu() function has two callers - sched_debug_show() and
>> sysrq_sched_debug_show().
> So what idiot is doing sysrq and that proc file at the same time? Why is
> it a problem now?
We got a customer bug report on watchdog panic because a process somehow 
stay within the sched_debug_lock for too long. I don't know what exactly 
the customer was doing, but we can reproduce the panic just by having 2 
parallel "echo t > /proc/sysrq-trigger" commands. This happens on 
certain selected systems. I was using some Dell systems for my testing. 
Of course, it is not sensible to have more than one sysrq happening at 
the same time. However, a parallel thread accessing /proc/sched_debug is 
certainly possible. That invokes similar code path.
>
>> @@ -470,16 +468,49 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
>>   #endif
>>   
>>   #ifdef CONFIG_CGROUP_SCHED
>> +static DEFINE_SPINLOCK(sched_debug_lock);
>>   static char group_path[PATH_MAX];
>> +static enum {
>> +	TOKEN_NONE,
>> +	TOKEN_ACQUIRED,
>> +	TOKEN_NA	/* Not applicable */
>> +} console_token = TOKEN_ACQUIRED;
>> +/*
>> + * All the print_cpu() callers from sched_debug_show() will be allowed
>> + * to contend for sched_debug_lock and use group_path[] as their SEQ_printf()
>> + * calls will be much faster. However only one print_cpu() caller from
>> + * sysrq_sched_debug_show() which outputs to the console will be allowed
>> + * to use group_path[]. Another parallel console writer will have to use
>> + * a shorter stack buffer instead. Since the console output will be garbled
>> + * anyway, truncation of some cgroup paths shouldn't be a big issue.
>> + */
>> +#define SEQ_printf_task_group_path(m, tg, fmt...)			\
>> +{									\
>> +	unsigned long flags;						\
>> +	int token = m ? TOKEN_NA					\
>> +		      : xchg_acquire(&console_token, TOKEN_NONE);	\
>> +									\
>> +	if (token == TOKEN_NONE) {					\
>> +		char buf[128];						\
>> +		task_group_path(tg, buf, sizeof(buf));			\
>> +		SEQ_printf(m, fmt, buf);				\
>> +	} else {							\
>> +		spin_lock_irqsave(&sched_debug_lock, flags);		\
>> +		task_group_path(tg, group_path, sizeof(group_path));	\
>> +		SEQ_printf(m, fmt, group_path);				\
>> +		spin_unlock_irqrestore(&sched_debug_lock, flags);	\
>> +		if (token == TOKEN_ACQUIRED)				\
>> +			smp_store_release(&console_token, token);	\
>> +	}								\
>>   }
> This is disgusting... you have an open-coded test-and-set lock like
> thing *AND* a spinlock, what gives?
>
>
> What's wrong with something simple like this?
>
> ---
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 4b49cc2af5c4..2ac2977f3b96 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -8,8 +8,6 @@
>    */
>   #include "sched.h"
>   
> -static DEFINE_SPINLOCK(sched_debug_lock);
> -
>   /*
>    * This allows printing both to /proc/sched_debug and
>    * to the console
> @@ -470,6 +468,7 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
>   #endif
>   
>   #ifdef CONFIG_CGROUP_SCHED
> +static DEFINE_SPINLOCK(group_path_lock);
>   static char group_path[PATH_MAX];
>   
>   static char *task_group_path(struct task_group *tg)
> @@ -481,6 +480,22 @@ static char *task_group_path(struct task_group *tg)
>   
>   	return group_path;
>   }
> +
> +#define SEQ_printf_task_group_path(m, tg)				\
> +do {									\
> +	if (spin_trylock(&group_path_lock)) {				\
> +		task_group_path(tg, group_path, sizeof(group_path));	\
> +		SEQ_printf(m, "%s", group_path);			\
> +		spin_unlock(&group_path_lock);				\
> +	} else {							\
> +		SEQ_printf(m, "looser!");				\
> +	}
> +} while (0)

I have no problem with using this as a possible solution as long as 
others agree. Of course, I won't use the term "looser". I will be more 
polite:-)

The current patch allows all /proc/sched_debug users and one sysrq user 
to use the full group_path[] buffer. I can certainly change it to allow 
1 user to use the full size path and the rests running the risk of path 
truncation.

Cheers,
Longman


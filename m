Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B9531F9AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 14:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhBSNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 08:09:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12195 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhBSNJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 08:09:37 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DhsKt1hRdzlM5P;
        Fri, 19 Feb 2021 21:06:58 +0800 (CST)
Received: from [10.174.176.231] (10.174.176.231) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Feb 2021 21:08:47 +0800
Subject: Re: nohz: Update tick instead of restarting tick in
 tick_nohz_idle_exit()
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <66014fea-7b84-358b-137d-d15190241528@huawei.com>
 <20210219121647.GB51281@lothringen>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <f69c5409-1b5e-734a-da09-e96010334329@huawei.com>
Date:   Fri, 19 Feb 2021 21:08:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210219121647.GB51281@lothringen>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.231]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/19 20:16, Frederic Weisbecker wrote:
> On Mon, Nov 23, 2020 at 09:22:08PM +0800, Yunfeng Ye wrote:
>> In realtime scenarios, the "nohz_full" parameter is configured. Tick
>> interference is not expected when there is only one realtime thread.
>> But when the idle thread is switched to the realtime thread, the tick
>> timer is restarted always.
>>
>> So on the nohz full mode, it is unnecessary to restart the tick timer
>> when there is only one realtime thread. Adding can_stop_full_tick()
>> before restarting the tick, if it return true, keep tick stopped.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> 
> Hi,
> 
> After reworking the codebase a bit, I've edited your patch and
> changelog and then queued it. I'll post it in a series after the
> merge window. See the result:
> 
Ok, Thanks. My first version patch which not be sent is a little like this.

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cc7cba20382e..e793c8f675e6 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -908,21 +908,24 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
        tick_nohz_restart(ts, now);
 }

-static void tick_nohz_full_update_tick(struct tick_sched *ts)
+static int tick_nohz_full_update_tick(struct tick_sched *ts, ktime_t now)
 {
 #ifdef CONFIG_NO_HZ_FULL
        int cpu = smp_processor_id();

        if (!tick_nohz_full_cpu(cpu))
-               return;
+               return -EINVAL;

        if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
-               return;
+               return -EINVAL;

        if (can_stop_full_tick(cpu, ts))
                tick_nohz_stop_sched_tick(ts, cpu);
        else if (ts->tick_stopped)
-               tick_nohz_restart_sched_tick(ts, ktime_get());
+               tick_nohz_restart_sched_tick(ts, now);
+       return 0;
+#else
+       return -EINVAL;
 #endif
 }

@@ -1080,7 +1083,7 @@ void tick_nohz_irq_exit(void)
        if (ts->inidle)
                tick_nohz_start_idle(ts);
        else
-               tick_nohz_full_update_tick(ts);
+               tick_nohz_full_update_tick(ts, ktime_get());
 }

 /**
@@ -1208,6 +1211,13 @@ void tick_nohz_idle_restart_tick(void)
                __tick_nohz_idle_restart_tick(ts, ktime_get());
 }

+static void tick_nohz_update_tick(struct tick_sched *ts, ktime_t now)
+{
+       if (tick_nohz_full_update_tick(ts) < 0)
+               tick_nohz_restart_sched_tick(ts, now);
+       tick_nohz_account_idle_ticks(ts);
+}
+
 /**
  * tick_nohz_idle_exit - restart the idle tick from the idle task
  *
@@ -1237,7 +1247,7 @@ void tick_nohz_idle_exit(void)
                tick_nohz_stop_idle(ts, now);

        if (tick_stopped)
-               __tick_nohz_idle_restart_tick(ts, now);
+               tick_nohz_update_tick(ts, now);

        local_irq_enable();
 }


> ---
> From: Yunfeng Ye <yeyunfeng@huawei.com>
> Date: Tue, 9 Feb 2021 23:59:19 +0100
> Subject: [PATCH] tick/nohz: Conditionally restart tick on idle exit
> 
> In nohz_full mode, switching from idle to a task will unconditionally
> issue a tick restart. If the task is alone in the runqueue or is the
> highest priority, the tick will fire once then eventually stop. But that
> alone is still undesired noise.
> 
> Therefore, only restart the tick on idle exit when it's strictly
> necessary.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/time/tick-sched.c | 44 ++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 3e272490fe2e..79796286a4ba 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -923,24 +923,28 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
>  	tick_nohz_restart(ts, now);
>  }
>  
> -static void tick_nohz_full_update_tick(struct tick_sched *ts)
> +static void __tick_nohz_full_update_tick(struct tick_sched *ts,
> +					 ktime_t now)
>  {
>  #ifdef CONFIG_NO_HZ_FULL
> -	int cpu;
> +	int cpu = smp_processor_id();
>  
> +	if (can_stop_full_tick(cpu, ts))
> +		tick_nohz_stop_sched_tick(ts, cpu);
> +	else if (ts->tick_stopped)
> +		tick_nohz_restart_sched_tick(ts, now);
> +#endif
> +}
> +
> +static void tick_nohz_full_update_tick(struct tick_sched *ts)
> +{
>  	if (!tick_nohz_full_this_cpu())
>  		return;
>  
>  	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
>  		return;
>  
> -	cpu = smp_processor_id();
> -
> -	if (can_stop_full_tick(cpu, ts))
> -		tick_nohz_stop_sched_tick(ts, cpu);
> -	else if (ts->tick_stopped)
> -		tick_nohz_restart_sched_tick(ts, ktime_get());
> -#endif
> +	__tick_nohz_full_update_tick(ts, ktime_get());
>  }
>  
>  static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
> @@ -1210,18 +1214,24 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
>  #endif
>  }
>  
> -static void __tick_nohz_idle_restart_tick(struct tick_sched *ts, ktime_t now)
> +void tick_nohz_idle_restart_tick(void)
>  {
> -	tick_nohz_restart_sched_tick(ts, now);
> -	tick_nohz_account_idle_ticks(ts);
> +	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> +
> +	if (ts->tick_stopped) {
> +		tick_nohz_restart_sched_tick(ts, ktime_get());
> +		tick_nohz_account_idle_ticks(ts);
> +	}
>  }
>  
> -void tick_nohz_idle_restart_tick(void)
> +static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
>  {
> -	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> +	if (tick_nohz_full_this_cpu())
> +		__tick_nohz_full_update_tick(ts, now);
> +	else
> +		tick_nohz_restart_sched_tick(ts, now);
>  
> -	if (ts->tick_stopped)
> -		__tick_nohz_idle_restart_tick(ts, ktime_get());
> +	tick_nohz_account_idle_ticks(ts);
>  }
>  
>  /**
> @@ -1253,7 +1263,7 @@ void tick_nohz_idle_exit(void)
>  		tick_nohz_stop_idle(ts, now);
>  
>  	if (tick_stopped)
> -		__tick_nohz_idle_restart_tick(ts, now);
> +		tick_nohz_idle_update_tick(ts, now);
>  
>  	local_irq_enable();
>  }
> 

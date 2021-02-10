Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DBB315D88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhBJCsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhBJCrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:47:06 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2836C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 18:46:25 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id u143so319029pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 18:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ecuGtecZvLvCggvcN+sYPB6YneHgnAEA3f8KI5p83/g=;
        b=tOzLiRFeFWO+ysC73UKl9aPCvY9+NDRTd4IU7C7971nweTgqQWjzgOZMBk+eOr1uQV
         Zie9M4qnFY/nuiKndX2o2TPOXQxm+E9psuDlwmSElaUxuwFcGeJHkLrs3K/JIjthq5xC
         5Qtprw6drFyopb5kXvN5FwtrZubQvV026KKaT+6ihWNiKMyYQZbiRqe682eTX/dsaklm
         QDMTcflJ+OiM4/cFuASeVk/yUtuG49y34SV7s9qwYyKYdex9TBff+3I2TxGLoGivgg3o
         TV8NnkhMsantrme6t3cY+id/ON6ms7HWdFjBcMHDzMhLZOYVVYiyFR50bm1UMi46vJ6r
         FGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ecuGtecZvLvCggvcN+sYPB6YneHgnAEA3f8KI5p83/g=;
        b=U/X0LrMi8r9i4f67hpZjC1o7UuWcNkJ1y3aALsvOurC1hDONpDc+gdqsddGr1XZOpd
         idltAcauOp28oQVd8reIwlYliN2rXKTqdjb1gQrTkdaXHBqXG3x3AO0wAS+6LtwBAxEN
         UktyOIGU//G8Anastcf+HL35h+OvPxCRqzw72sEtdTnUdgZV9r28UDMPeVrMz3tBG3Ep
         /mV+hoPjgvEXMweYI3cVAfhguzA3Cvd4AhaUjwNtCAJKeZm/0KnqopVLXvKV8aPp7HEJ
         FyTLqHsLLujvWWkgAvwoluS8TXXb2fPDInEtxxB3HgmOeVl4YJjahb/B//HORtuypYo1
         zLgA==
X-Gm-Message-State: AOAM533Nx4cq3qwGPut6pUA+fpIbEiUE44cOx+4h2DlggyuR0YNrGR93
        QiBtqBPMYPzZXBpbPLuGSjpgzQ==
X-Google-Smtp-Source: ABdhPJybCjZurwLYBeEVOWDsiQy/JqONP0yjYaUcPOlG0CcVYkcbNUuDszrDyLtaZ6K0j2jEHy1VGA==
X-Received: by 2002:a63:66c7:: with SMTP id a190mr1001605pgc.117.1612925184687;
        Tue, 09 Feb 2021 18:46:24 -0800 (PST)
Received: from [10.255.239.74] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id k12sm249090pfh.123.2021.02.09.18.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 18:46:24 -0800 (PST)
Subject: Re: [External] Re: [PATCH v2] psi: Remove the redundant psi_task_tick
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20210209071033.16989-1-zhouchengming@bytedance.com>
 <YCKuxoPnm/RFI18O@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <bee60747-dbad-cfc8-b0a3-a8ac4b1b0d0e@bytedance.com>
Date:   Wed, 10 Feb 2021 10:46:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCKuxoPnm/RFI18O@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Johannes,

在 2021/2/9 下午11:48, Johannes Weiner 写道:
> Hello Chengming,
>
> On Tue, Feb 09, 2021 at 03:10:33PM +0800, Chengming Zhou wrote:
>> When the current task in a cgroup is in_memstall, the corresponding groupc
>> on that cpu is in PSI_MEM_FULL state, so we can exploit that to remove the
>> redundant psi_task_tick from scheduler_tick to save this periodic cost.
> Can you please update the patch name and the changelog to the new
> version of the patch? It's not removing the redundant tick, it's
> moving the reclaim detection from the timer tick to the task state
> tracking machinery using the recently added ONCPU state.

Yes, I will change the name and changelog, it will be clearer for this patch : )

>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  include/linux/psi.h  |  1 -
>>  kernel/sched/core.c  |  1 -
>>  kernel/sched/psi.c   | 49 ++++++++++++++-----------------------------------
>>  kernel/sched/stats.h |  9 ---------
>>  4 files changed, 14 insertions(+), 46 deletions(-)
>>
>> diff --git a/include/linux/psi.h b/include/linux/psi.h
>> index 7361023f3fdd..65eb1476ac70 100644
>> --- a/include/linux/psi.h
>> +++ b/include/linux/psi.h
>> @@ -20,7 +20,6 @@ void psi_task_change(struct task_struct *task, int clear, int set);
>>  void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>>  		     bool sleep);
>>  
>> -void psi_memstall_tick(struct task_struct *task, int cpu);
>>  void psi_memstall_enter(unsigned long *flags);
>>  void psi_memstall_leave(unsigned long *flags);
>>  
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 15d2562118d1..31788a9b335b 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4533,7 +4533,6 @@ void scheduler_tick(void)
>>  	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
>>  	curr->sched_class->task_tick(rq, curr, 0);
>>  	calc_global_load_tick(rq);
>> -	psi_task_tick(rq);
>>  
>>  	rq_unlock(rq, &rf);
>>  
>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> index 2293c45d289d..6e46d9eb279b 100644
>> --- a/kernel/sched/psi.c
>> +++ b/kernel/sched/psi.c
>> @@ -644,8 +644,7 @@ static void poll_timer_fn(struct timer_list *t)
>>  	wake_up_interruptible(&group->poll_wait);
>>  }
>>  
>> -static void record_times(struct psi_group_cpu *groupc, int cpu,
>> -			 bool memstall_tick)
>> +static void record_times(struct psi_group_cpu *groupc, int cpu)
>>  {
>>  	u32 delta;
>>  	u64 now;
>> @@ -664,23 +663,6 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
>>  		groupc->times[PSI_MEM_SOME] += delta;
>>  		if (groupc->state_mask & (1 << PSI_MEM_FULL))
>>  			groupc->times[PSI_MEM_FULL] += delta;
>> -		else if (memstall_tick) {
>> -			u32 sample;
>> -			/*
>> -			 * Since we care about lost potential, a
>> -			 * memstall is FULL when there are no other
>> -			 * working tasks, but also when the CPU is
>> -			 * actively reclaiming and nothing productive
>> -			 * could run even if it were runnable.
>> -			 *
>> -			 * When the timer tick sees a reclaiming CPU,
>> -			 * regardless of runnable tasks, sample a FULL
>> -			 * tick (or less if it hasn't been a full tick
>> -			 * since the last state change).
>> -			 */
>> -			sample = min(delta, (u32)jiffies_to_nsecs(1));
>> -			groupc->times[PSI_MEM_FULL] += sample;
>> -		}
>>  	}
>>  
>>  	if (groupc->state_mask & (1 << PSI_CPU_SOME)) {
>> @@ -714,7 +696,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
>>  	 */
>>  	write_seqcount_begin(&groupc->seq);
>>  
>> -	record_times(groupc, cpu, false);
>> +	record_times(groupc, cpu);
>>  
>>  	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
>>  		if (!(m & (1 << t)))
>> @@ -738,6 +720,18 @@ static void psi_group_change(struct psi_group *group, int cpu,
>>  		if (test_state(groupc->tasks, s))
>>  			state_mask |= (1 << s);
>>  	}
>> +
>> +	/*
>> +	 * Since we care about lost potential, a memstall is FULL
>> +	 * when there are no other working tasks, but also when
>> +	 * the CPU is actively reclaiming and nothing productive
>> +	 * could run even if it were runnable. So when the current
>> +	 * task in a cgroup is in_memstall, the corresponding groupc
>> +	 * on that cpu is in PSI_MEM_FULL state.
>> +	 */
>> +	if (groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall)
>> +		state_mask |= (1 << PSI_MEM_FULL);
> This doesn't really work with the psi_task_switch() optimization. If
> we switch between two tasks inside a leaf group, where one is memstall
> and the other is not, we don't update the parents properly. So you
> need another branch in there as well for checking memstall. At which
> point the timer tick implementation is likely cheaper and simpler...

Thank you for pointing out this. I will add another branch there to check memstall to update

the parents properly and send a patch-v2.

Thanks.

>> @@ -144,14 +144,6 @@ static inline void psi_sched_switch(struct task_struct *prev,
>>  	psi_task_switch(prev, next, sleep);
>>  }
>>  
>> -static inline void psi_task_tick(struct rq *rq)
>> -{
>> -	if (static_branch_likely(&psi_disabled))
>> -		return;
>> -
>> -	if (unlikely(rq->curr->in_memstall))
>> -		psi_memstall_tick(rq->curr, cpu_of(rq));
>> -}
>>  #else /* CONFIG_PSI */
>>  static inline void psi_enqueue(struct task_struct *p, bool wakeup) {}
>>  static inline void psi_dequeue(struct task_struct *p, bool sleep) {}

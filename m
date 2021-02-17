Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADFC31D4CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 06:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhBQFJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 00:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhBQFJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 00:09:00 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F000C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 21:08:20 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p21so2093877pgl.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 21:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=rSbdzZy0zhA235v4H2lMk653Cgrt4U0Umw6xOgysAbg=;
        b=X4zGw/gC7CxpQfxbeiTJ+s2TZ/dSX6Kn3j4aACW9VDgDSmmZDiWDzjFsPUYLh7c+gB
         s3WMNTUk6Zfaor9Xv5aWxaEe9l8JvSBMB15jqurZGiUGN+fBs2VcIHtLz7vsSpT6wo9l
         k9t8+LhxMqf+SihJ3trElyCaqEZSPhZdqBzpMDIrkK5StDfNJncAwuj64tUW/gL1ewie
         L7+10WGmpJ8uiG19i/zMIIinSXta+kOCwSFy+3yjQUZADPkYVIhXCm82HOMnNj7h6BOy
         WgESStnTnktAT8XOs+WLk/D1pW9IfiZj+Ft3yoDwSmDtINz9btNNucUdGhhoBnjlnRbh
         Ywfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=rSbdzZy0zhA235v4H2lMk653Cgrt4U0Umw6xOgysAbg=;
        b=GDiHpun4EiCPodxWlSRxEBM4vQoQaZ00ao5xhLMqZp7sEdYDubydOnWDkR6ZaY4m/N
         OGmSiYZdApRpDavBbia8Z6IIfDDrRpp2obCHty5R30cj1EEsdHEpdgCRNKWVGto4Baqv
         50itpo5wfIAOPHk1By3h1DwPW9I1iR3CQCfWp4WsLU8AnYhKPeZfVyRO/nITu7vqVDV/
         Cp6Sgq+cWhWpw5nTPRCZN34amrfAayAL19hYNsXLVgkIPj1iI9DThGP69tCuz7NvMVvb
         RlYxBlWOGSqV8YVDhzpDh6JWkBcER5KbmAnMiVIJ2EhxyV+012T0jFWafco5Q/VB2jkU
         CTDg==
X-Gm-Message-State: AOAM530diG2RCq5laC4HA2NFCB/XJXyZaKTPbiTOjzdvC1hiSTh4Tvjf
        lRevDHp2rEWlkvQqZMgA4euDTg==
X-Google-Smtp-Source: ABdhPJwLrLKg3oNF9Ej2rKYaxNhZ3yF4wC/+ZO2sVS8Hp3F6umQnTkDvMwG2zDKRlTPoNyr/P5ymZg==
X-Received: by 2002:a62:8881:0:b029:1de:cc32:4266 with SMTP id l123-20020a6288810000b02901decc324266mr1137754pfd.60.1613538497045;
        Tue, 16 Feb 2021 21:08:17 -0800 (PST)
Received: from ?IPv6:2409:8a28:e6d:6480:41c9:75c:168:49f5? ([2409:8a28:e6d:6480:41c9:75c:168:49f5])
        by smtp.gmail.com with ESMTPSA id t6sm771693pgp.57.2021.02.16.21.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 21:08:16 -0800 (PST)
Subject: Re: [External] Re: [PATCH] psi: Optimize task switch inside shared
 cgroups
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20210209071413.17097-1-zhouchengming@bytedance.com>
 <YCwkZ+UwDzQVXUyc@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <17c5f30f-83b1-8f14-86a6-f3810950e5fe@bytedance.com>
Date:   Wed, 17 Feb 2021 13:08:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCwkZ+UwDzQVXUyc@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Johannes,

在 2021/2/17 上午4:00, Johannes Weiner 写道:
> Hello Chengming,
>
> This patch looks useful to me. A couple of comments below:
>
> On Tue, Feb 09, 2021 at 03:14:13PM +0800, Chengming Zhou wrote:
>> The commit 36b238d57172 ("psi: Optimize switching tasks inside shared
>> cgroups") only update cgroups whose state actually changes during a
>> task switch only in task preempt case, not in task sleep case.
>>
>> We actually don't need to clear and set TSK_ONCPU state for common cgroups
>> of next and prev task in sleep case, that can save many psi_group_change
>> especially when most activity comes from one leaf cgroup.
> Can you please make this a bit more concrete? Maybe include this:
>
> sleep before:
> psi_dequeue()
>   while ((group = iterate_groups(prev)))			# all ancestors
>     psi_group_change(prev, .clear=TSK_RUNNING|TSK_ONCPU)
> psi_task_switch()
>   while ((group = iterate_groups(next)))			# all ancestors
>     psi_group_change(next, .set=TSK_ONCPU)
>
> sleep after:
> psi_dequeue()
>   nop
> psi_task_switch()
>   while ((group = iterate_groups(next)))			# until (prev & next)
>     psi_group_change(next, .set=TSK_ONCPU)
>   while ((group = iterate_groups(prev)))			# all ancestors
>     psi_group_change(prev, .clear = common ? TSK_RUNNING : TSK_RUNNING|TSK_ONCPU)
>
> When a voluntary sleep switches to another task, we remove one call of
> psi_group_change() for every common cgroup ancestor of the two tasks.
Thank you for the very beautiful and detailed comments, must be included : )
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  kernel/sched/psi.c   | 27 +++++++++++++++++----------
>>  kernel/sched/stats.h | 17 +++--------------
>>  2 files changed, 20 insertions(+), 24 deletions(-)
>>
>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> index 6e46d9eb279b..6061e87089ac 100644
>> --- a/kernel/sched/psi.c
>> +++ b/kernel/sched/psi.c
>> @@ -836,20 +836,27 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>>  		}
>>  	}
>>  
>> -	/*
>> -	 * If this is a voluntary sleep, dequeue will have taken care
>> -	 * of the outgoing TSK_ONCPU alongside TSK_RUNNING already. We
>> -	 * only need to deal with it during preemption.
>> -	 */
>> -	if (sleep)
>> -		return;
>> -
>>  	if (prev->pid) {
>> -		psi_flags_change(prev, TSK_ONCPU, 0);
>> +		int clear = 0, set = 0;
>> +
>> +		if (sleep) {
>> +			clear |= TSK_RUNNING;
>> +			if (prev->in_iowait)
>> +				set |= TSK_IOWAIT;
>> +		}
> This needs a comment why it's doing psi_dequeue()'s job. How about this?
>
> 		/*
> 		 * When we're going to sleep, psi_dequeue() lets us handle
> 		 * TSK_RUNNING and TSK_IOWAIT here, where we can combine it
> 		 * with TSK_ONCPU and save walking common ancestors twice.
> 		 */
> 		if (sleep) {
> 			...
Make sense, will be added.
>> +		psi_flags_change(prev, clear | TSK_ONCPU, set);
>>  
>>  		iter = NULL;
>>  		while ((group = iterate_groups(prev, &iter)) && group != common)
>> -			psi_group_change(group, cpu, TSK_ONCPU, 0, true);
>> +			psi_group_change(group, cpu, clear | TSK_ONCPU, set, true);
>> +
>> +		if (sleep) {
>> +			while (group) {
>> +				psi_group_change(group, cpu, clear, set, true);
>> +				group = iterate_groups(prev, &iter);
>> +			}
>> +		}
> This function is *primarily* about handling TSK_ONCPU and secondarily
> optimizes the dequeue. It would be a bit clearer to do:
>
> 	int clear = TSK_ONCPU, set = 0;
>
> 	...
>
> 	/*
> 	 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
> 	 * with dequeuing too, finish that for the rest of the hierarchy.
> 	 */
> 	if (sleep) {
> 		clear &= TSK_ONCPU;
> 		for (; group; group = iterate_groups(prev, &iter))
> 			psi_group_change(group, cpu, clear, set, true);			
> 	}
>
Make sense, I will modify the patch and send a patch-v2.

BTW there is a typo above: clear &= ~TSK_ONCPU;

Thanks.

>> diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
>> index 9e4e67a94731..2d92c8467678 100644
>> --- a/kernel/sched/stats.h
>> +++ b/kernel/sched/stats.h
>> @@ -84,28 +84,17 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
>>  
>>  static inline void psi_dequeue(struct task_struct *p, bool sleep)
>>  {
>> -	int clear = TSK_RUNNING, set = 0;
>> -
>>  	if (static_branch_likely(&psi_disabled))
>>  		return;
>>  
>>  	if (!sleep) {
>> +		int clear = TSK_RUNNING;
>> +
>>  		if (p->in_memstall)
>>  			clear |= TSK_MEMSTALL;
>> -	} else {
>> -		/*
>> -		 * When a task sleeps, schedule() dequeues it before
>> -		 * switching to the next one. Merge the clearing of
>> -		 * TSK_RUNNING and TSK_ONCPU to save an unnecessary
>> -		 * psi_task_change() call in psi_sched_switch().
>> -		 */
>> -		clear |= TSK_ONCPU;
>>  
>> -		if (p->in_iowait)
>> -			set |= TSK_IOWAIT;
>> +		psi_task_change(p, clear, 0);
>>  	}
> Likewise, this really should have a comment for why it's not handling
> TSK_RUNNING to match psi_enqueue()!
>
> 	int clear = TSK_RUNNING;
>
> 	/*
> 	 * A voluntary sleep is a dequeue followed by a task switch. To
> 	 * avoid walking all ancestors twice, psi_task_switch() handles
> 	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
> 	 * Do nothing here.
> 	 */
> 	 if (sleep)
> 		return;
>
> 	if (p->in_memstall)
> 		clear |= TSK_MEMSTALL;
>
> 	psi_task_change(p, clear, 0);
> 	
> Thanks

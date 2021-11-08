Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4078E447DF0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbhKHKas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhKHKao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:30:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8175DC061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:28:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u18so25925732wrg.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 02:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZNuUBE/LGxmp/0VRtP1UjOnpC2VdkSU6yaid04Hb3OM=;
        b=LeGYJo9ZN+ivcw1NNmHItdaO+a/t18XBIZVMF7RdAJoCne7JzZfMO8FojzSSXHjlgE
         Pm7hWbFOoL2ovau+jcA6O6SH8SqaFuPBCWfQThIRuMnYt/8Z2g8TjDhPSHtmXeYvGr1K
         NBFv6m5j6+MaSfYCN38gcbOSHHhYXeRlaj5SgXJxNydOFEzvLihomUqy4ZLjFy11UPQV
         gGwIhITdnNNazmogik5sApWLRYabdhovVRPG5iFM1HBYe3QODzM/HYbxWNGgm4e1zPOG
         gfWJQQi+hjPjyiqOWj6TUeenO7EFIp+bbjiMoVfuM7Mwacqgm7DCDAyM2Qv7P+Yb8bXY
         5Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZNuUBE/LGxmp/0VRtP1UjOnpC2VdkSU6yaid04Hb3OM=;
        b=PFODZAoYFhZP/f+6tR+U4biLxJWuj4cuKtHV35Bj6+Ge4jF/nMGle2xtTxAOj7yEq3
         7aaNsYlBSXQGU8GcstYu/GHzNxhUY/s76/t9Dz8E6m5PalIfh3rKGf1IynUa+tByRbGt
         lYb+9PJQRY//GS0/tzCS7u7V+92zOYsd7namhu65iD8fV723cPi4VqhQ20wzFEEzsULG
         npYmsjeu6pR2mdaR8uEcAynsV8vNDbOzeWCDa9fSKMuqvRX6hLRChcd+G/kzK9n27CGi
         nWFuaDiavhCD0q6BVBEtS6D1DMt5FFAXm0m+QEPR2Y9NJYmGbvdUuMAZF0I2Y7VfvCh8
         +FRQ==
X-Gm-Message-State: AOAM533zJqxpqLTaIZlvo+tcCsInIr7F6ekpYBbJW/8CZ4nXxKfiXlrD
        lNvGbWltVfVRyCmfg98U1nxvzw==
X-Google-Smtp-Source: ABdhPJyBUHtgPoO1FOlxcBVQ/gnBed9BTNuaKSsHtX9ECUtqjFnl2WKfd5bNWkr8U4w5rFjVlKjJOg==
X-Received: by 2002:a5d:5986:: with SMTP id n6mr78823879wri.297.1636367279076;
        Mon, 08 Nov 2021 02:27:59 -0800 (PST)
Received: from ?IPv6:2003:f6:af05:3300:973b:5a52:fb00:84af? (p200300f6af053300973b5a52fb0084af.dip0.t-ipconnect.de. [2003:f6:af05:3300:973b:5a52:fb00:84af])
        by smtp.gmail.com with ESMTPSA id o8sm16433741wrm.67.2021.11.08.02.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 02:27:58 -0800 (PST)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Benjamin Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
 <20211103190613.3595047-1-minipli@grsecurity.net>
 <xm26ilx86gmp.fsf@google.com>
 <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com>
 <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net>
 <CAKfTPtBxoKBRWs4Z3Pxsk8==Ka9SG7NS3LzfOV33-2UXfhSM=g@mail.gmail.com>
 <cd3778d3-6980-a804-47e3-82b09dc960a4@grsecurity.net>
 <CAKfTPtDthksitm02sLowDMKbWZ29efth-YcPi0zVSFqbaZfiMA@mail.gmail.com>
 <8f4ed996-e6e5-75f4-b5fa-dffb7b7da05b@grsecurity.net>
 <20211105162914.215420-1-minipli@grsecurity.net>
 <20211106104854.GU174703@worktop.programming.kicks-ass.net>
From:   Mathias Krause <minipli@grsecurity.net>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining
 cfs_rq's
Message-ID: <9e8b2c49-2a10-2b34-e644-2b99708080bc@grsecurity.net>
Date:   Mon, 8 Nov 2021 11:27:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211106104854.GU174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.11.21 um 11:48 schrieb Peter Zijlstra:
> On Fri, Nov 05, 2021 at 05:29:14PM +0100, Mathias Krause wrote:
>>> Looks like it needs to be the kfree_rcu() one in this case. I'll prepare
>>> a patch.
>>
>> Testing the below patch right now. Looking good so far. Will prepare a
>> proper patch later, if we all can agree that this covers all cases.
>>
>> But the basic idea is to defer the kfree()'s to after the next RCU GP,
>> which also means we need to free the tg object itself later. Slightly
>> ugly. :/
> 
> How's this then?

Well, slightly more code churn, but looks cleaner indeed -- no tg_free()
hack. Just one bit's missing IMHO, see below.

> 
> ---
> diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
> index 2067080bb235..8629b37d118e 100644
> --- a/kernel/sched/autogroup.c
> +++ b/kernel/sched/autogroup.c
> @@ -31,7 +31,7 @@ static inline void autogroup_destroy(struct kref *kref)
>  	ag->tg->rt_se = NULL;
>  	ag->tg->rt_rq = NULL;
>  #endif
> -	sched_offline_group(ag->tg);
> +	sched_release_group(ag->tg);
>  	sched_destroy_group(ag->tg);
>  }
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9cb81ef8acc8..22528bd61ba5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9715,6 +9715,21 @@ static void sched_free_group(struct task_group *tg)
>  	kmem_cache_free(task_group_cache, tg);
>  }
>  
> +static void sched_free_group_rcu(struct rcu_head *rcu)
> +{
> +	sched_free_group(container_of(rcu, struct task_group, rcu_head));
                                                              ^^^^^^^^
This should be 'rcu'.

> +}
> +
> +static void sched_unregister_group(struct task_group *tg)
> +{

The timers need to be destroyed prior to unregister_fair_sched_group()
via destroy_cfs_bandwidth(tg_cfs_bandwidth(tg)), i.e. move it from
free_fair_sched_group() to here, as I did in my patch. Otherwise the tg
might still be messed with and we don't want that.

> +	unregister_fair_sched_group(tg);
> +	/*
> +	 * We have to wait for yet another RCU grace period to expire, as
> +	 * print_cfs_stats() might run concurrently.
> +	 */
> +	call_rcu(&tg->rcu, sched_free_group_rcu);
> +}
> +
>  /* allocate runqueue etc for a new task group */
>  struct task_group *sched_create_group(struct task_group *parent)
>  {
> @@ -9735,7 +9750,7 @@ struct task_group *sched_create_group(struct task_group *parent)
>  	return tg;
>  
>  err:
> -	sched_free_group(tg);
> +	sched_unregister_group(tg);
>  	return ERR_PTR(-ENOMEM);
>  }
>  
> @@ -9758,25 +9773,35 @@ void sched_online_group(struct task_group *tg, struct task_group *parent)
>  }
>  
>  /* rcu callback to free various structures associated with a task group */
> -static void sched_free_group_rcu(struct rcu_head *rhp)
> +static void sched_unregister_group_rcu(struct rcu_head *rhp)
>  {
>  	/* Now it should be safe to free those cfs_rqs: */
> -	sched_free_group(container_of(rhp, struct task_group, rcu));
> +	sched_unregister_group(container_of(rhp, struct task_group, rcu));
>  }
>  
>  void sched_destroy_group(struct task_group *tg)
>  {
>  	/* Wait for possible concurrent references to cfs_rqs complete: */
> -	call_rcu(&tg->rcu, sched_free_group_rcu);
> +	call_rcu(&tg->rcu, sched_unregister_group_rcu);
>  }
>  
> -void sched_offline_group(struct task_group *tg)
> +void sched_release_group(struct task_group *tg)
>  {
>  	unsigned long flags;
>  
> -	/* End participation in shares distribution: */
> -	unregister_fair_sched_group(tg);
> -
> +	/*
> +	 * Unlink first, to avoid walk_tg_tree_from() from finding us (via
> +	 * sched_cfs_period_timer()).
> +	 *
> +	 * For this to be effective, we have to wait for all pending users of
> +	 * this task group to leave their RCU critical section to ensure no new
> +	 * user will see our dying task group any more. Specifically ensure
> +	 * that tg_unthrottle_up() won't add decayed cfs_rq's to it.
> +	 *
> +	 * We therefore defer calling unregister_fair_sched_group() to
> +	 * sched_unregister_group() which is guarantied to get called only after the
> +	 * current RCU grace period has expired.
> +	 */
>  	spin_lock_irqsave(&task_group_lock, flags);
>  	list_del_rcu(&tg->list);
>  	list_del_rcu(&tg->siblings);
> @@ -9895,7 +9920,7 @@ static void cpu_cgroup_css_released(struct cgroup_subsys_state *css)
>  {
>  	struct task_group *tg = css_tg(css);
>  
> -	sched_offline_group(tg);
> +	sched_release_group(tg);
>  }
>  
>  static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
> @@ -9905,7 +9930,7 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
>  	/*
>  	 * Relies on the RCU grace period between css_released() and this.
>  	 */
> -	sched_free_group(tg);
> +	sched_unregister_group(tg);
>  }
>  
>  /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index f0b249ec581d..20038274c57b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -504,7 +504,7 @@ extern struct task_group *sched_create_group(struct task_group *parent);
>  extern void sched_online_group(struct task_group *tg,
>  			       struct task_group *parent);
>  extern void sched_destroy_group(struct task_group *tg);
> -extern void sched_offline_group(struct task_group *tg);
> +extern void sched_release_group(struct task_group *tg);
>  
>  extern void sched_move_task(struct task_struct *tsk);
>  

Beside that, looks good to me. Will you create a new proper patch or
should I do it?

Thanks,
Mathias

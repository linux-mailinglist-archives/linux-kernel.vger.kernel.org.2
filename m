Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D38400544
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350768AbhICSsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350757AbhICSsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:48:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DD8C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 11:47:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k24so6351493pgh.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4IRfq4bbS/e2zUOFnYjKltRLsxqimuT5KO8WNYzGrMo=;
        b=Ffhmog2KIMA1bxe/Kgb4i0x+6lz4vWflJ3Kdms4ZrwMsusiAlOcDJhiitsKKfLyOhN
         qEn+EiSmQjkb9dix2Hh+uyps1uOATwh7iWn8Nz6LHyKr6d+dhxswLSYj1ewnjlahhiG0
         vL/OtgFph75XvIvsFDWFMWCz+KAp/crmaLwr/BT3YPinWeH7LzhN03NT4flE+6QNSAq2
         ClsyDNjo4oneNV4WUPt+C6xWK3wi82HnOF6cFKzxojwwOmScZes1N/q4CTLNQjavZkpT
         uDP7TrCkR4v8Npmj+AxDPQheyZG8LaGafH8zg0+N2AGsdyfFAvlcWKKxEaEmGEQMhPcJ
         EWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=4IRfq4bbS/e2zUOFnYjKltRLsxqimuT5KO8WNYzGrMo=;
        b=HBbURzx6QGHeZQguk8FGp+AdqSmCC09M9jVbq3S6WZpNlLI2kBFiyWj4Rt3+PalpOB
         TzZSccQsflY21bPXFJq6XUhpcRJhlkfv89PoJJKtVHTome0jWUamJIHpAQ5x9tlFp/lG
         7K1KiFxaGAokm99hFDcioJczIoiMa5EpJSU76g/sAQAUcP/UEzcyp36Q0NUjBaW8Ju+j
         qYj+C8Y2dWZOoo68Knst5rYU3MRtrnosUfBuMK786L+5FWCdtUfP1OneG9QugAWGhreQ
         2wDU74eX8lF1GdlGnI5i3pN5aiu6ObKQLy7aqf3p3mdzCUHhWzzwYlBie1kEJ8ANmk2g
         57Yw==
X-Gm-Message-State: AOAM531RlYVo49ILuQLBN1DBjNFVWkfU9XF6FDH4kuZ17jNwVYRf0/Xf
        iLrrNvMynsGoEzANpMzBQ9DiYA==
X-Google-Smtp-Source: ABdhPJzsdRSeTU+v/AHGI2qWxQXFe1g1LCNGP//l7/uonVBbd43oRqzYL5bbAQJJSOZFefOJf/Dfcg==
X-Received: by 2002:a65:6251:: with SMTP id q17mr403972pgv.416.1630694842835;
        Fri, 03 Sep 2021 11:47:22 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id f9sm43342pjq.36.2021.09.03.11.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 11:47:21 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        anderson@cs.unc.edu, baruah@wustl.edu, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, luca.abeni@santannapisa.it,
        mgorman@suse.de, mingo@redhat.com, odin@uged.al, odin@ugedal.com,
        pauld@redhead.com, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, tj@kernel.org,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com, daniel.m.jordan@oracle.com
Subject: Re: [PATCH 1/2] sched/fair: Add cfs bandwidth burst statistics
References: <20210830032215.16302-1-changhuaixin@linux.alibaba.com>
        <20210830032215.16302-2-changhuaixin@linux.alibaba.com>
Date:   Fri, 03 Sep 2021 11:47:18 -0700
In-Reply-To: <20210830032215.16302-2-changhuaixin@linux.alibaba.com> (Huaixin
        Chang's message of "Mon, 30 Aug 2021 11:22:14 +0800")
Message-ID: <xm26fsulpkcp.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huaixin Chang <changhuaixin@linux.alibaba.com> writes:

> Two new statistics are introduced to show the internal of burst feature
> and explain why burst helps or not.
>
> nr_bursts:  number of periods bandwidth burst occurs
> burst_time: cumulative wall-time (in nanoseconds) that any cpus has
> 	    used above quota in respective periods
>
> Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
> Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
> Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>

Reviewed-by: Ben Segall <bsegall@google.com>

I know there's some worry about the overhead of a constantly increasing
amount of statistics, but as far as the implementation of this goes, it
looks good to me.

> ---
>  kernel/sched/core.c  | 13 ++++++++++---
>  kernel/sched/fair.c  |  9 +++++++++
>  kernel/sched/sched.h |  3 +++
>  3 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 20ffcc044134..d00b92712253 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10068,6 +10068,9 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
>  		seq_printf(sf, "wait_sum %llu\n", ws);
>  	}
>  
> +	seq_printf(sf, "nr_bursts %d\n", cfs_b->nr_burst);
> +	seq_printf(sf, "burst_time %llu\n", cfs_b->burst_time);
> +
>  	return 0;
>  }
>  #endif /* CONFIG_CFS_BANDWIDTH */
> @@ -10164,16 +10167,20 @@ static int cpu_extra_stat_show(struct seq_file *sf,
>  	{
>  		struct task_group *tg = css_tg(css);
>  		struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
> -		u64 throttled_usec;
> +		u64 throttled_usec, burst_usec;
>  
>  		throttled_usec = cfs_b->throttled_time;
>  		do_div(throttled_usec, NSEC_PER_USEC);
> +		burst_usec = cfs_b->burst_time;
> +		do_div(burst_usec, NSEC_PER_USEC);
>  
>  		seq_printf(sf, "nr_periods %d\n"
>  			   "nr_throttled %d\n"
> -			   "throttled_usec %llu\n",
> +			   "throttled_usec %llu\n"
> +			   "nr_bursts %d\n"
> +			   "burst_usec %llu\n",
>  			   cfs_b->nr_periods, cfs_b->nr_throttled,
> -			   throttled_usec);
> +			   throttled_usec, cfs_b->nr_burst, burst_usec);
>  	}
>  #endif
>  	return 0;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 44c452072a1b..464371f364f1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4655,11 +4655,20 @@ static inline u64 sched_cfs_bandwidth_slice(void)
>   */
>  void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>  {
> +	s64 runtime;
> +
>  	if (unlikely(cfs_b->quota == RUNTIME_INF))
>  		return;
>  
>  	cfs_b->runtime += cfs_b->quota;
> +	runtime = cfs_b->runtime_snap - cfs_b->runtime;
> +	if (runtime > 0) {
> +		cfs_b->burst_time += runtime;
> +		cfs_b->nr_burst++;
> +	}
> +
>  	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
> +	cfs_b->runtime_snap = cfs_b->runtime;
>  }
>  
>  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 14a41a243f7b..80e4322727b4 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -367,6 +367,7 @@ struct cfs_bandwidth {
>  	u64			quota;
>  	u64			runtime;
>  	u64			burst;
> +	u64			runtime_snap;
>  	s64			hierarchical_quota;
>  
>  	u8			idle;
> @@ -379,7 +380,9 @@ struct cfs_bandwidth {
>  	/* Statistics: */
>  	int			nr_periods;
>  	int			nr_throttled;
> +	int			nr_burst;
>  	u64			throttled_time;
> +	u64			burst_time;
>  #endif
>  };

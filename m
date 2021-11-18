Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8212455F43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 16:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhKRPYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 10:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhKRPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 10:23:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2973AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 07:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pMkBPh6t8+Vk94Ox+oIcHzPLe1Je++vi3h2wd3bMOM8=; b=lC9mZOLdlCmNg0G5TJgq+pKtbt
        +RNCTwioSJBmDtSZ70sxcQbzsg4go2pqHI4jyikgEgEUJJeGWB/1CNXwh1sRtC/rmgGbrrNlCWFHB
        zKrd+FNvL+5aqoBWeQBAr+f0NYj+3Kv3Y7D8wysqW6sH0gP/VFlWYdAKmz4KdqJxom78PNPzVqNNi
        x5RJXCHgJj5V1L8VFZYG/n1FUsOVeYeGfIzVleBT3L/zlgrFgxUXygv2/QdzVT5k1vGa+wGGOFBlM
        e0W4vPB2CpUhNR0HixT9IljRYaZLKL/+31PZA379G1Xjr90T9po3LOAgVYPY7nNp8mNrtcsyM1Zft
        1Q4vRXVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnjD0-008ZaL-9J; Thu, 18 Nov 2021 15:20:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96DDF30001B;
        Thu, 18 Nov 2021 16:20:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CDCA3028EEF2; Thu, 18 Nov 2021 16:20:17 +0100 (CET)
Date:   Thu, 18 Nov 2021 16:20:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Li Hua <hucool.lihua@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        yuehaibing@huawei.com, weiyongjun1@huawei.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, w.f@huawei.com,
        cj.chengjian@huawei.com, judy.chenhui@huawei.com
Subject: Re: [PATCH -next 1/1] sched/rt: Try to restart rt period timer when
 rt runtime exceeded
Message-ID: <YZZvMbX719ZKS0CQ@hirez.programming.kicks-ass.net>
References: <20211115014628.15017-1-hucool.lihua@huawei.com>
 <20211115014628.15017-2-hucool.lihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115014628.15017-2-hucool.lihua@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 01:46:28AM +0000, Li Hua wrote:
> When rt_runtime is modified from -1 to a valid control value, it may
> cause the task to be throttled all the time. Operations like the following
> will trigger the bug. E.g:
> 1. echo -1 > /proc/sys/kernel/sched_rt_runtime_us
> 2. Run a FIFO task named A that executes while(1)
> 3. echo 950000 > /proc/sys/kernel/sched_rt_runtime_us
> 
> When rt_runtime is -1, The rt period timer will not be activated when task A
> enqueued. And then the task will be throttled after setting rt_runtime to
> 950,000. The task will always be throttled because the rt period timer is not
> activated.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Li Hua <hucool.lihua@huawei.com>
> ---
>  kernel/sched/rt.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index bb945f8faeca..630f2cbe37d0 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -947,6 +947,23 @@ static inline int rt_se_prio(struct sched_rt_entity *rt_se)
>  	return rt_task_of(rt_se)->prio;
>  }
>  
> +static inline void try_start_rt_bandwidth(struct rt_bandwidth *rt_b)
> +{
> +	raw_spin_lock(&rt_b->rt_runtime_lock);
> +	if (!rt_bandwidth_enabled() || rt_b->rt_runtime == RUNTIME_INF) {
> +		raw_spin_unlock(&rt_b->rt_runtime_lock);
> +		return;
> +	}
> +
> +	if (!rt_b->rt_period_active) {
> +		rt_b->rt_period_active = 1;
> +		hrtimer_forward_now(&rt_b->rt_period_timer, rt_b->rt_period);
> +		hrtimer_start_expires(&rt_b->rt_period_timer,
> +				      HRTIMER_MODE_ABS_PINNED_HARD);
> +	}
> +	raw_spin_unlock(&rt_b->rt_runtime_lock);
> +}

This is almost a verbatim copy of start_rt_bandwidth() surely we can do
better.

> +
>  static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
>  {
>  	u64 runtime = sched_rt_runtime(rt_rq);
> @@ -1027,11 +1044,16 @@ static void update_curr_rt(struct rq *rq)
>  		struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
>  
>  		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
> +			int exceeded;
> +
>  			raw_spin_lock(&rt_rq->rt_runtime_lock);
>  			rt_rq->rt_time += delta_exec;
> -			if (sched_rt_runtime_exceeded(rt_rq))
> +			exceeded = sched_rt_runtime_exceeded(rt_rq);
> +			if (exceeded)
>  				resched_curr(rq);
>  			raw_spin_unlock(&rt_rq->rt_runtime_lock);
> +			if (exceeded)
> +				try_start_rt_bandwidth(sched_rt_bandwidth(rt_rq));
>  		}
>  	}
>  }
> @@ -2905,8 +2927,10 @@ static int sched_rt_global_validate(void)
>  
>  static void sched_rt_do_global(void)
>  {
> +	raw_spin_lock(&def_rt_bandwidth.rt_runtime_lock);
>  	def_rt_bandwidth.rt_runtime = global_rt_runtime();
>  	def_rt_bandwidth.rt_period = ns_to_ktime(global_rt_period());
> +	raw_spin_unlock(&def_rt_bandwidth.rt_runtime_lock);

And that's just wrong I think; did you test this with lockdep enabled?
IIRC this lock is irq-safe, it has to be if you're using it form a timer
context.



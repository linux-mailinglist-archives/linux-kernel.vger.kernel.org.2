Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D173645AE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 22:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbhKWVLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 16:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbhKWVLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:11:08 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C982FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 13:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GXpaNemCnFC8ht2JuQJCWh2b+ZgysnULCkNx6FKi5IQ=; b=q5jtrdUcL5aOe1PU2pXPvtPOm2
        +Spezig55ZwXzQWztpQqYLzKqiAeF0mCKfuUyyMClUNFlza/ZgZmM0IQCoL1QmCE9uOIRtrVsGjjB
        mepO4vflvk/nPBI47ujCz2uOMywG5AVuAJS5sWHMqgHbVBmtAdyCQG9MPPEUlxiDS1Y9GC1DdZI4D
        5x98zGQ2Ap4Bsp3oRc0nnfpGNP324IQaw8IGDZeAsxjF0xt+8Ngxi6ggUj5PCVcMSjmP3sd9CXFxy
        PVSgQsaB0sK5/SBE/KWzCzfRJcgTvct6+r5TUl1CsbhWx3pGFQ/N1AwT/jmW2VFnX6O6bCfN+mPru
        7F64lxRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpd0M-0008gr-Gx; Tue, 23 Nov 2021 21:07:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27225984951; Tue, 23 Nov 2021 22:07:05 +0100 (CET)
Date:   Tue, 23 Nov 2021 22:07:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] sched/fair: Remove the cost of a redundant
 cpumask_next_wrap in select_idle_cpu
Message-ID: <20211123210705.GD721624@worktop.programming.kicks-ass.net>
References: <20211123112229.7812-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123112229.7812-1-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 07:22:29PM +0800, Barry Song wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> This patch keeps the same scanning amount, but drops a redundant loop
> of cpumask_next_wrap.
> The original code did for_each_cpu_wrap(cpu, cpus, target + 1), then
> checked --nr; this patch does --nr before doing the next loop, thus,
> it can remove a cpumask_next_wrap() which costs a little bit.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  kernel/sched/fair.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff69f24..e2fb3e0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6298,9 +6298,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  
>  		span_avg = sd->span_weight * avg_idle;
>  		if (span_avg > 4*avg_cost)
> -			nr = div_u64(span_avg, avg_cost);
> +			nr = div_u64(span_avg, avg_cost) - 1;
>  		else
> -			nr = 4;
> +			nr = 3;
>  
>  		time = cpu_clock(this);
>  	}
> @@ -6312,11 +6312,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  				return i;
>  
>  		} else {
> -			if (!--nr)
> -				return -1;
>  			idle_cpu = __select_idle_cpu(cpu, p);
>  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
>  				break;
> +			if (!--nr)
> +				return -1;
>  		}
>  	}

That's just confusing code. Isn't it much clearer to write the whole
thing like so ?

	nr--;
	for_each_cpu_wrap(cpu, cpus, target+1) {
		...
		if (!nr--)
			return -1;
	}


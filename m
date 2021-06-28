Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B393B65EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbhF1PoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbhF1PoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:44:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B712C0527C1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kRDx85p4HU5gltVTcFkhvi9KGKM9mkjBLcdZpumiDfU=; b=pK2XkrZngfiYV6nzZJ08HwaxJk
        KP+/UY7d3lcv9nZJLA78zS0Z0FK1KiyARCLtkO5k4xsjvikMFudHxlt3bvw7WquAWE4HB7HiaGS85
        NLAtDBlfxcTx3E26jJBhbcogYAzR+ZYPU9meGXS/bb/i04GWEHT7w/hOjqF+MSgSma37iNos3cRX9
        93A+8MiCpzdhaE4S0tE3+RgU65CdAh0j65plf6q8ot6ov1vYWk1XjDnTr7pjMKs0PYfv625DxtqJN
        HPXgznr7OGQw/Q/T0wQAhSTpW/PaHwia14onkUVr90wB25plsLCMkV9B/MH2B4nMoxmMEdQYVZCGu
        lOKBEtFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxskX-00CaPA-9v; Mon, 28 Jun 2021 15:00:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 001EE3001DC;
        Mon, 28 Jun 2021 17:00:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD7F820D89373; Mon, 28 Jun 2021 17:00:30 +0200 (CEST)
Date:   Mon, 28 Jun 2021 17:00:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     luca.abeni@santannapisa.it, anderson@cs.unc.edu, baruah@wustl.edu,
        bsegall@google.com, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, odin@uged.al, odin@ugedal.com,
        pauld@redhead.com, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, tj@kernel.org,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v6 2/3] sched/fair: Add cfs bandwidth burst statistics
Message-ID: <YNnkDnJtliEInwTY@hirez.programming.kicks-ass.net>
References: <20210621092800.23714-1-changhuaixin@linux.alibaba.com>
 <20210621092800.23714-3-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621092800.23714-3-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 05:27:59PM +0800, Huaixin Chang wrote:
> The following statistics in cpu.stat file is added to show how much workload
> is making use of cfs_b burst:
> 
> nr_bursts:  number of periods bandwidth burst occurs
> burst_usec: cumulative wall-time that any cpus has
> 	    used above quota in respective periods
> 
> The larger nr_bursts is, the more bursty periods there are. And the larger
> burst_usec is, the more burst time is used by bursty workload.

That's what it does, but fails to explain why. How is this number
useful.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 53d7cc4d009b..62b73722e510 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4634,11 +4634,22 @@ static inline u64 sched_cfs_bandwidth_slice(void)
>   */
>  void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>  {
> +	u64 runtime;
> +
>  	if (unlikely(cfs_b->quota == RUNTIME_INF))
>  		return;
>  
> +	if (cfs_b->runtime_at_period_start > cfs_b->runtime) {
> +		runtime = cfs_b->runtime_at_period_start - cfs_b->runtime;

That comparison is the same as the subtraction; might as well write
this:

> +		if (runtime > cfs_b->quota) {
> +			cfs_b->burst_time += runtime - cfs_b->quota;

Same here.

> +			cfs_b->nr_burst++;
> +		}
> +	}


Perhaps we can write that like:

	s64 runtime = cfs_b->runtime_snapshot - cfs_b->runtime;
	if (runtime > 0) {
		s64 burstime = runtime - cfs_q->quota;
		if (burstime > 0) {
			cfs_b->bust_time += bursttime;
			cfs_b->nr_bursts++;
		}
	}

I was hoping we could get away with something simpler, like maybe:

	u64 old_runtim = cfs_b->runtime;

	cfs_b->runtime += cfs_b->quota
	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);

	if (cfs_b->runtime - old_runtime > cfs_b->quota)
		cfs_b->nr_bursts++;

Would that be good enough?


> +
>  	cfs_b->runtime += cfs_b->quota;
>  	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
> +	cfs_b->runtime_at_period_start = cfs_b->runtime;
>  }
>  
>  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d317ca74a48c..b770b553dfbb 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -367,6 +367,7 @@ struct cfs_bandwidth {
>  	u64			quota;
>  	u64			runtime;
>  	u64			burst;
> +	u64			runtime_at_period_start;
>  	s64			hierarchical_quota;

As per the above, I don't really like that name, runtime_snapshot or
perhaps runtime_snap is shorter and not less clear. But not having it at
all would be even better.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D360036D1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhD1GDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:03:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:54871 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235991AbhD1GDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:03:24 -0400
IronPort-SDR: Mvd/6S3qhaLL+977ne+pURZfMNkWqGMZxEDeFSh/Syni+C9nYWRFMnTvT6MZkw2mRkoNDUnr4U
 xlGUO7fOX+tA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="217379888"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="217379888"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 23:02:37 -0700
IronPort-SDR: nJHaoVclKESEC+CsnUdFyNFUBfdU+WL8FYVctNuWEDW8f6zgZkPW6FaoLi6wTnwBmSVl96aV/M
 JAn/dUqqjqbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="447852939"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 23:02:35 -0700
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Peter Zijlstra <peterz@infradead.org>, joel@joelfernandes.org,
        chris.hyser@oracle.com, joshdon@google.com, mingo@kernel.org,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <20210422120459.447350175@infradead.org>
 <20210422123308.196692074@infradead.org>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <339ef2c3-8de9-88b4-ce2e-4c8517240a25@linux.intel.com>
Date:   Wed, 28 Apr 2021 14:02:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210422123308.196692074@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/21 8:05 PM, Peter Zijlstra wrote:
> When switching on core-sched, CPUs need to agree which lock to use for
> their RQ.
> 
> The new rule will be that rq->core_enabled will be toggled while
> holding all rq->__locks that belong to a core. This means we need to
> double check the rq->core_enabled value after each lock acquire and
> retry if it changed.
> 
> This also has implications for those sites that take multiple RQ
> locks, they need to be careful that the second lock doesn't end up
> being the first lock.
> 
> Verify the lock pointer after acquiring the first lock, because if
> they're on the same core, holding any of the rq->__lock instances will
> pin the core state.
> 
> While there, change the rq->__lock order to CPU number, instead of rq
> address, this greatly simplifies the next patch.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c  |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/sched.h |   41 +++++++++++------------------------------
>  2 files changed, 57 insertions(+), 32 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -186,12 +186,37 @@ int sysctl_sched_rt_runtime = 950000;
>  
>  void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
>  {
> -	raw_spin_lock_nested(rq_lockp(rq), subclass);
> +	raw_spinlock_t *lock;
> +
> +	if (sched_core_disabled()) {
> +		raw_spin_lock_nested(&rq->__lock, subclass);
> +		return;
> +	}
> +
> +	for (;;) {
> +		lock = rq_lockp(rq);
> +		raw_spin_lock_nested(lock, subclass);
> +		if (likely(lock == rq_lockp(rq)))
> +			return;
> +		raw_spin_unlock(lock);
> +	}
>  }
>  
>  bool raw_spin_rq_trylock(struct rq *rq)
>  {
> -	return raw_spin_trylock(rq_lockp(rq));
> +	raw_spinlock_t *lock;
> +	bool ret;
> +
> +	if (sched_core_disabled())
> +		return raw_spin_trylock(&rq->__lock);
> +
> +	for (;;) {
> +		lock = rq_lockp(rq);
> +		ret = raw_spin_trylock(lock);
> +		if (!ret || (likely(lock == rq_lockp(rq))))
> +			return ret;
> +		raw_spin_unlock(lock);
> +	}
>  }
>  
>  void raw_spin_rq_unlock(struct rq *rq)
> @@ -199,6 +224,25 @@ void raw_spin_rq_unlock(struct rq *rq)
>  	raw_spin_unlock(rq_lockp(rq));
>  }
>  
> +#ifdef CONFIG_SMP
> +/*
> + * double_rq_lock - safely lock two runqueues
> + */
> +void double_rq_lock(struct rq *rq1, struct rq *rq2)
> +{
> +	lockdep_assert_irqs_disabled();
> +
> +	if (rq1->cpu > rq2->cpu)
> +		swap(rq1, rq2);

I'm not sure why swap rq here instead of rq lock? This swaps dst rq
and src rq and causes the subsequent logic wrong at least in try_steal_cookie().

Thanks,
-Aubrey

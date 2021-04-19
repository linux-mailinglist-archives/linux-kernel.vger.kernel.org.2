Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12485363F47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbhDSKEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbhDSKEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 06:04:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC27C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 03:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FK9hdoxUBF8nPujcTiXlMmfbOgCpUz5UFCS8Vw7GCMQ=; b=AEAmanYdHkEVqoMlSg3fqsqaGN
        qw7InlSK5CtUpWRhi8fgOY0+yc4NlTrzZnqRqDkMmFRVfzASv3kUxPFoGupBtCBuKwzpWpxN7z5ze
        otxAq2JMTV300jz/8XKpSZPu+/xWJz4faX3Aje7PpPuXep15tjbFR7ywdX8IR5hnsSnLaVhlnBPUH
        6oHeCGIiCe2UMLUISyTSbh1tdjCsGUaQxoIu/lxJ6T1cS44Qtx3Lt7kpNi+WciNiUh+JXo1lzI2gv
        8//kw1bahb89A/hy58+ccaeanXYg0xyHgme6zaSV1rzmLsQlHqWXj5o6peJ+ncxsAdrgH59UqvedX
        WoQcntbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYQk7-00DZK7-Kl; Mon, 19 Apr 2021 10:03:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40E52300212;
        Mon, 19 Apr 2021 12:02:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F090E2C23A969; Mon, 19 Apr 2021 12:02:56 +0200 (CEST)
Date:   Mon, 19 Apr 2021 12:02:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] sched,fair: skip newidle_balance if a wakeup is pending
Message-ID: <YH1VUETp9swK4Y6T@hirez.programming.kicks-ass.net>
References: <20210418221751.7edfc03b@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418221751.7edfc03b@imladris.surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 10:17:51PM -0400, Rik van Riel wrote:
> The try_to_wake_up function has an optimization where it can queue
> a task for wakeup on its previous CPU, if the task is still in the
> middle of going to sleep inside schedule().
> 
> Once schedule() re-enables IRQs, the task will be woken up with an
> IPI, and placed back on the runqueue.
> 
> If we have such a wakeup pending, there is no need to search other
> CPUs for runnable tasks. Just skip (or bail out early from) newidle
> balancing, and run the just woken up task.
> 
> For a memcache like workload test, this reduces total CPU use by
> about 2%, proportionally split between user and system time,
> and p99 and p95 application response time by 2-3% on average.
> The schedstats run_delay number shows a similar improvement.

Nice.

> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69680158963f..19a92c48939f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7163,6 +7163,14 @@ done: __maybe_unused;
>  	if (!rf)
>  		return NULL;
>  
> +	/*
> +	 * We have a woken up task pending here. No need to search for ones
> +	 * elsewhere. This task will be enqueued the moment we unblock irqs
> +	 * upon exiting the scheduler.
> +	 */
> +	if (rq->ttwu_pending)
> +		return NULL;

As reported by the robot, that needs an CONFIG_SMP guard of sorts,
#ifdef might work I suppose.

>  	new_tasks = newidle_balance(rq, rf);
>  
>  	/*
> @@ -10661,7 +10669,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  		 * Stop searching for tasks to pull if there are
>  		 * now runnable tasks on this rq.
>  		 */
> -		if (pulled_task || this_rq->nr_running > 0)
> +		if (pulled_task || this_rq->nr_running > 0 ||
> +						this_rq->ttwu_pending)

Either cino=(0:0 or just bust the limit and make it 84 chars.

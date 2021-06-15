Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF1A3A8A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhFOUh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 16:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhFOUh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:37:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E25CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y9Ixb/cYf5RX0Tp/tP70zOnE6mzcN4QC3xP7A4EcpOM=; b=psQSCREALaH4CR8APq/w7wq4ZT
        SDD6PylWn6G44+BiGmH+K1rw+0LYRxRo8TaSDCaoWUBbMVPqPhA2r82oYtpY3jrVWTWSkg1k5cBQ9
        Gv8IPuE50SnrrQ3ddZATNhlEQK+eUJkOSqXIIIwGmghgc/qdtBV86ng57rYRxO9iaiUFyle8iO8gi
        go+6+KLknvAYmWtgeT4b+joVSSwRgjXiqqr5A9kY56f33QwuHK3LrAU1cX7NQ1b7yByPzQMUbHNfF
        ljwrApZ1DaK1VX2v3QaoBQGBXL6huvM6zFsbucMFN634KyJxD1owN2Wu7zONxdRe+PTZnZwqwi8xn
        VKQ0HpZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltFmT-00865s-8r; Tue, 15 Jun 2021 20:35:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA61B9863C9; Tue, 15 Jun 2021 22:35:34 +0200 (CEST)
Date:   Tue, 15 Jun 2021 22:35:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     vincent.guittot@linaro.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched, fair: try to prevent migration thread from
 preempting non-cfs task
Message-ID: <20210615203534.GA4272@worktop.programming.kicks-ass.net>
References: <20210615121551.31138-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615121551.31138-1-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 08:15:51PM +0800, Yafang Shao wrote:
> ---
>  kernel/sched/fair.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3248e24a90b0..597c7a940746 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9797,6 +9797,20 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  			/* Record that we found at least one task that could run on this_cpu */
>  			env.flags &= ~LBF_ALL_PINNED;
>  
> +			/*
> +			 * There may be a race between load balance starting migration
> +			 * thread to pull the cfs running thread and the RT thread
> +			 * waking up and preempting cfs task before migration threads
> +			 * which then preempt the RT thread.
> +			 * We'd better do the last minute check before starting
> +			 * migration thread to avoid preempting latency-sensitive thread.
> +			 */
> +			if (busiest->curr->sched_class != &fair_sched_class) {
> +				raw_spin_unlock_irqrestore(&busiest->lock,
> +							   flags);

This won't apply.

Also, there's still a race window, you've just shrunk it, not fixed it.
Busiest can reschedule between the mandatory rq unlock and doing the
stopper wakeup.

An actual fix might be to have the active migration done by a FIFO-1
task, instead of stopper. The obvious down-side is that that would mean
spawning yet another per-cpu kthread.

How much do we care?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76537427B82
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 17:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbhJIP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhJIP5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:57:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA03C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 08:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BaJAUCjClYecxQc1UPNq1ARwrAK2TC7OhEGmPGg48ss=; b=fwh7dIO1KZWEgTkxAbewra7U4Z
        Uf5ppxbr3wf/egJnDn6+s2A4LdN5F4LiJJvQ/bG8gMt4oiB7tWQ8VvFKD8YoPC/BsuKg8dVbNoLRA
        mUgKnYHPZEXFIMtq9im+/WwZDSC95ROUGrxEKq9jIMpCJdrfjNkLVGBXdjVscUXu3gbXBWJAyh23N
        6Dg++F6PWKdWFY5pEN+H06Frj1GTIAPAuwj7HIrTHPWck5diUm/KSKsMRn2KfwWdhYTXcVh9sFGkn
        DH8bMH7UuDXdgHa0KKlzkjvjX8KGYLlDPKAQ6p2HBL3TG6UQhf9v7fKVboF5KzTvhe06rUNRd99r5
        9Zt7oFmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZEgF-004FDD-JP; Sat, 09 Oct 2021 15:54:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FB2D9811D4; Sat,  9 Oct 2021 17:54:35 +0200 (CEST)
Date:   Sat, 9 Oct 2021 17:54:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: forced idle accounting
Message-ID: <20211009155435.GW174703@worktop.programming.kicks-ass.net>
References: <20211008000825.1364224-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008000825.1364224-1-joshdon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 05:08:25PM -0700, Josh Don wrote:
> Adds accounting for "forced idle" time, which is time where a cookie'd
> task forces its SMT sibling to idle, despite the presence of runnable
> tasks.
> 
> Forced idle time is one means to measure the cost of enabling core
> scheduling (ie. the capacity lost due to the need to force idle).

It seems an excessive amount of code for what it says to do.

> +	smt_count = cpumask_weight(smt_mask);

That's a fairly expensive operation to find a number that's going the be
to same over and over and over...

> +	if (smt_count > 2) {
> +		unsigned int nr_forced_idle = 0, nr_running = 0;
> +
> +		for_each_cpu(i, smt_mask) {
> +			rq_i = cpu_rq(i);
> +			p = rq_i->core_pick ?: rq_i->curr;
> +
> +			if (p != rq_i->idle)
> +				nr_running++;
> +			else if (rq_i->nr_running)
> +				nr_forced_idle++;
> +		}
> +
> +		if (WARN_ON_ONCE(!nr_running)) {
> +			/* can't be forced idle without a running task */
> +		} else {
> +			delta *= nr_forced_idle;
> +			delta /= nr_running;
> +		}

Now the comment sayeth:

> +	/*
> +	 * For larger SMT configurations, we need to scale the charged
> +	 * forced idle amount since there can be more than one forced idle
> +	 * sibling and more than one running cookied task.
> +	 */

But why?

> +	}
> +
> +	for_each_cpu(i, smt_mask) {
> +		rq_i = cpu_rq(i);
> +		p = rq_i->core_pick ?: rq_i->curr;
> +
> +		if (!p->core_cookie)
> +			continue;
> +
> +		p->core_forceidle_sum += delta;
> +
> +		/* Optimize for common case. */
> +		if (smt_count == 2)
> +			break;
> +	}
> +}

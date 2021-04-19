Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B7736405B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbhDSLWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:22:43 -0400
Received: from foss.arm.com ([217.140.110.172]:40836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235872AbhDSLWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:22:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F07D631B;
        Mon, 19 Apr 2021 04:22:12 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2F043F792;
        Mon, 19 Apr 2021 04:22:11 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] sched,fair: skip newidle_balance if a wakeup is pending
In-Reply-To: <20210418221751.7edfc03b@imladris.surriel.com>
References: <20210418221751.7edfc03b@imladris.surriel.com>
Date:   Mon, 19 Apr 2021 12:22:06 +0100
Message-ID: <87lf9eldsx.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/21 22:17, Rik van Riel wrote:
> @@ -10661,7 +10669,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>                * Stop searching for tasks to pull if there are
>                * now runnable tasks on this rq.
>                */
> -		if (pulled_task || this_rq->nr_running > 0)
> +		if (pulled_task || this_rq->nr_running > 0 ||
> +						this_rq->ttwu_pending)
>                       break;

I thought newidle_balance() would already handle this by checking
idle_cpu(), but that can't work due to rq->curr never being rq->idle here
(we're trying very hard to prevent this!).

Would there be any point in bunching up these two checks from idle_cpu()
into an inline helper and reusing it here?

_nohz_idle_balance() "accidentally" already checks for that, but at the
head of the domain loop. What's the reason for doing it at the tail here?
It means we try at least one loop, but is there a point in that?

>       }
>       rcu_read_unlock();
> --
> 2.25.4

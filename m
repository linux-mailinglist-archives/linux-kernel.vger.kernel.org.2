Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18EF3EF97F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 06:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhHREfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 00:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhHREfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 00:35:01 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47992C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:34:27 -0700 (PDT)
Date:   Wed, 18 Aug 2021 12:35:13 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629261263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+43KjJ461Wnnntp1BMXUkH0siaYFPWBA0DWao3uueIE=;
        b=SmMYcnEYRIJRa95jl6aydqNRHSJ0Rq/o9NRlLaZXUVLP8e2HsdUV1jcqfuJ68K7jB96KzS
        iwUJx36enCawS0fmuIImhCCgKpOmMZl56pazGVB5Nm1RPXtIZ2Fao0SRDx/RhO1TBB8E6C
        nBOBnKh2CgOtDpmFF81PiFPzM4GWwWo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Subject: Re: [PATCH] sched/core: fix pick_next_task 'max' tracking
Message-ID: <YRyOAUGn7AplmHZW@geo.homenetwork>
References: <20210818005615.138527-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818005615.138527-1-joshdon@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Tue, Aug 17, 2021 at 05:56:15PM -0700, Josh Don wrote:
> For core-sched, pick_next_task will update the 'max' task if there is a
> cookie mismatch (since in this case the new task must be of higher
> priority than the current max). However, we fail to update 'max' if
> we've found a task with a matching cookie and higher priority than
> 'max'.
> 
> This can result in extra iterations on SMT-X machines, where X > 2.
> 
> As an example, on a machine with SMT=3, on core 0, SMT-0 might pick
> the following, in order:
> 
> - SMT-0: p1, with cookie A, and priority 10 (max = p1)
> - SMT-1: p2, with cookie A, and priority 30 (max not updated here)

Thanks for your illustration. Good catch.
The guilty is 'cookie_equals(class_pick, cookie))' condition in pick_task()

> - SMT-2: p3, with cookie B, and priority 20 (max = p2)
> 	> invalidate the other picks and retry
> 
> Here, we should have instead updated 'max' when picking for SMT-1. Note
> that this code would eventually have righted itself, since the retry
> loop would re-pick p2, and update 'max' accordingly. However, this patch
> avoids the extra round-trip.

This is correct then may increase the chance to retry. That means it is
more possible to filter the max first(not sure).

> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>  kernel/sched/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3431939699dc..110ea7582a33 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5623,6 +5623,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  					occ = 1;
>  					goto again;
>  				}
> +			} else if (prio_less(max, p, fi_before)) {
> +				max = p;
>  			}
>  		}
>  	}
> -- 
> 2.33.0.rc1.237.g0d66db33f3-goog
> 


Thanks,
Tao

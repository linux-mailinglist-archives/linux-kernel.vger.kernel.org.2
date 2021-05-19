Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F5938933E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355095AbhESQIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:08:02 -0400
Received: from foss.arm.com ([217.140.110.172]:46862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354270AbhESQIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:08:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2B9F1480;
        Wed, 19 May 2021 09:06:40 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9096D3F73D;
        Wed, 19 May 2021 09:06:39 -0700 (PDT)
Date:   Wed, 19 May 2021 17:06:34 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix util_est UTIL_AVG_UNCHANGED handling
Message-ID: <20210519160633.GA230499@e120877-lin.cambridge.arm.com>
References: <20210514103748.737809-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514103748.737809-1-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 12:37:48PM +0200, Dietmar Eggemann wrote:
> The util_est internal UTIL_AVG_UNCHANGED flag which is used to prevent
> unnecessary util_est updates uses the LSB of util_est.enqueued. It is
> exposed via _task_util_est() (and task_util_est()).
> 
> Commit 92a801e5d5b7 ("sched/fair: Mask UTIL_AVG_UNCHANGED usages")
> mentions that the LSB is lost for util_est resolution but
> find_energy_efficient_cpu() checks if task_util_est() returns 0 to
> return prev_cpu early.
> 
> _task_util_est() returns the max value of util_est.ewma and
> util_est.enqueued or'ed w/ UTIL_AVG_UNCHANGED.
> So task_util_est() returning the max of task_util() and
> _task_util_est() will never return 0 under the default
> SCHED_FEAT(UTIL_EST, true).
> 
> To fix this use the MSB of util_est.enqueued instead and keep the flag
> util_est internal, i.e. don't export it via _task_util_est().
> 
> The maximal possible util_avg value for a task is 1024 so the MSB of
> 'unsigned int util_est.enqueued' isn't used to store a util value.
> 
> As a caveat the code behind the util_est_se trace point has to filter
> UTIL_AVG_UNCHANGED to see the real util_est.enqueued value which should
> be easy to do.
> 
> This also fixes an issue report by Xuewen Yan that util_est_update()
> only used UTIL_AVG_UNCHANGED for the subtrahend of the equation:
> 
>   last_enqueued_diff = ue.enqueued - (task_util() | UTIL_AVG_UNCHANGED)
> 
> Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filtering
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

I don't believe this made it through our integration branch testing, so I gave a
try manually on my Hikey with LISA's UtilConvergence test. 20 iterations of that
test passed without any problem.

> ---
>  kernel/sched/fair.c |  5 +++--
>  kernel/sched/pelt.h | 13 +++++++------
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 161b92aa1c79..0150d440b0a2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3856,7 +3856,7 @@ static inline unsigned long _task_util_est(struct task_struct *p)
>  {
>  	struct util_est ue = READ_ONCE(p->se.avg.util_est);
>  
> -	return (max(ue.ewma, ue.enqueued) | UTIL_AVG_UNCHANGED);
> +	return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
>  }


Shall we also update proc_sched_show_task() to avoid reading this flag there?

-- 
Vincent

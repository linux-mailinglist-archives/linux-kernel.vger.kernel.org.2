Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14F13BA01D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 13:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhGBL46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 07:56:58 -0400
Received: from foss.arm.com ([217.140.110.172]:46106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhGBL45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 07:56:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77DA31FB;
        Fri,  2 Jul 2021 04:54:25 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B134F3F718;
        Fri,  2 Jul 2021 04:54:23 -0700 (PDT)
Date:   Fri, 2 Jul 2021 12:54:21 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>, valentin.schneider@arm.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, qperret@google.com
Subject: Re: [PATCH v2] sched/uclamp: Avoid getting unreasonable ucalmp value
 when rq is idle
Message-ID: <20210702115421.gcju2vluhof6rp6f@e107158-lin.cambridge.arm.com>
References: <20210630141204.8197-1-xuewen.yan94@gmail.com>
 <YN70sbUGh2pViWEQ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YN70sbUGh2pViWEQ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/21 13:12, Peter Zijlstra wrote:
> On Wed, Jun 30, 2021 at 10:12:04PM +0800, Xuewen Yan wrote:
> > From: Xuewen Yan <xuewen.yan@unisoc.com>
> > 
> > Now in uclamp_rq_util_with(), when the task != NULL, the uclamp_max as following:
> > uc_rq_max = rq->uclamp[UCLAMP_MAX].value;
> > uc_eff_max = uclamp_eff_value(p, UCLAMP_MAX);
> > uclamp_max = max{uc_rq_max, uc_eff_max};
> > 
> > Consider the following scenario:
> > (1)the rq is idle, the uc_rq_max is last runnable task's UCLAMP_MAX;
> > (2)the p's uc_eff_max < uc_rq_max.
> > 
> > As a result, the uclamp_max = uc_rq_max instead of uc_eff_max, it is unreasonable.
> > 
> > The scenario often happens in find_energy_efficient_cpu(), when the task has smaller UCLAMP_MAX.
> > 
> > When rq has UCLAMP_FLAG_IDLE flag, enqueuing the task will lift UCLAMP_FLAG_IDLE
> > and set the rq clamp as the task's via uclamp_idle_reset(). It doesn't need
> > to read the rq clamp. And it can also avoid the problems described above.
> > 
> > Fixes: 9d20ad7dfc9a ("sched/uclamp: Add uclamp_util_with()")
> > 
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> 
> Valentin, Qais, can either of you write a Changelog/comment for this, I
> can't seem to make any sense of it.

Err, yeah I think I've been staring at uclamp for too long. It could be
clearer.

> 
> Is this about wake-from-idle, where the first task's uclamp goes amis
> because the rq->uclamp values haven't been updated yet?

Yep. How about the below?

--->8---

sched/uclamp: Ignore max aggregation if rq is idle

When a task wakes up on an idle rq, uclamp_rq_util_with() would max
aggregate with rq value. But since there is no task enqueued yet, the
values are stale based on the last task that was running. When the new
task actually wakes up and enqueued, then the rq uclamp values should
reflect that of the newly woken up task effective uclamp values.

This is a problem particularly for uclamp_max because it default to
1024. If a task p with uclamp_max = 512 wakes up, then max aggregation
would ignore the capping that should apply when this task is enqueued,
which is wrong.

Fix that by ignoring max aggregation if the rq is idle since in that
case the effective uclamp value of the rq will be the ones of the task
that will wake up.

--->8---

Thanks

--
Qais Yousef

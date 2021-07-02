Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE003BA042
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhGBMWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:22:37 -0400
Received: from foss.arm.com ([217.140.110.172]:46518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232058AbhGBMWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:22:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E9541FB;
        Fri,  2 Jul 2021 05:12:47 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC1623F718;
        Fri,  2 Jul 2021 05:12:45 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, qperret@google.com
Subject: Re: [PATCH v2] sched/uclamp: Avoid getting unreasonable ucalmp value when rq is idle
In-Reply-To: <20210702115421.gcju2vluhof6rp6f@e107158-lin.cambridge.arm.com>
References: <20210630141204.8197-1-xuewen.yan94@gmail.com> <YN70sbUGh2pViWEQ@hirez.programming.kicks-ass.net> <20210702115421.gcju2vluhof6rp6f@e107158-lin.cambridge.arm.com>
Date:   Fri, 02 Jul 2021 13:12:41 +0100
Message-ID: <87wnq87w3q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/21 12:54, Qais Yousef wrote:
> sched/uclamp: Ignore max aggregation if rq is idle
>
> When a task wakes up on an idle rq, uclamp_rq_util_with() would max
> aggregate with rq value. But since there is no task enqueued yet, the
> values are stale based on the last task that was running. When the new

Nit: those values are "intentionally stale" for UCLAMP_MAX, per

  e496187da710 ("sched/uclamp: Enforce last task's UCLAMP_MAX")

for UCLAMP_MIN we'll set uclamp_none(UCLAMP_MIN) == 0 upon dequeueing the
last runnable task, which DTRT.

> task actually wakes up and enqueued, then the rq uclamp values should
> reflect that of the newly woken up task effective uclamp values.
>
> This is a problem particularly for uclamp_max because it default to
                    ^^^^^^^^^^^^
Per the above, it's "only" a problem for UCLAMP_MAX.

> 1024. If a task p with uclamp_max = 512 wakes up, then max aggregation
> would ignore the capping that should apply when this task is enqueued,
> which is wrong.
>
> Fix that by ignoring max aggregation if the rq is idle since in that
> case the effective uclamp value of the rq will be the ones of the task
> that will wake up.
>

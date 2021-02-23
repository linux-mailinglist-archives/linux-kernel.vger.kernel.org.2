Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE3322FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhBWRe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhBWReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:34:24 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE211C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:33:39 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id v30so12458389lfq.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucIMA16Ia1ta00f/ORt+SVfhiEmO9kzx7JvEbe3PkvQ=;
        b=OwvyIgXBV7uI6L/jcCDzSIelrDcqrsOYU/JIGWDqfB9Dxx9hhKqpP2xUtj1KEXBUrX
         Ri5pzED4hYEqJUhS+pfkTQOpXP+TgtoXC9muDxiY9PX9PmhfzM8r+BQ8/6RnT/SOkToP
         6J8qOB01qiJc0o3f+2Cvvlc+Xyi0Uam+8cx2kOXjoqjb/PZB57JLx0ZaZO2wiA0QErqo
         o7nBLI9w3G2P+vfRCJpdX2Us7AaKy3w0VHnGHn3irEGw9PA3/coUkB7u9MUk/yzabsVZ
         aclvZmYA+LMWj28YzqvefYb0GBRJPwb5q8LwKlw5aWJXaGi5j7b83WDWIyROhlBNIkCx
         VrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucIMA16Ia1ta00f/ORt+SVfhiEmO9kzx7JvEbe3PkvQ=;
        b=ko/CGbvRqYRNTcT1ybJMhxf27ZyUVwGJX68q4Jqd+vevV55E2945WTbSgIEhpFSMAF
         tNkOFQITWYmst2jO08tpSyR/E0Aq6dSwhc/GTn4xSFZ+N6sdISZLrPkN0GpBw1eGXGbh
         9zwAzTHAyCJTXTZ4rPMRBMUmrzDoz5Pt8+fT/wOZu5jdNuTgauuTi0W8WmR/Pz312fuB
         F+aehQj+Nq31zLX0yCPDSUu/zsamNpFJg5auvhrSvPCuJ0qng0ehxzMzE/bLGJOoygvo
         s3XDmJ2W5zGgQHgygHVjECoQ4/oPnyRB3i5RqUgciHgselIBLH8UNBrRTB2k9X0Oq7mg
         50ew==
X-Gm-Message-State: AOAM531E/Lz2G0dUhbKDqwBUyHNxsC96AGTVTTvcRM2KEqoQTwuEQFT8
        Dk6unbAl5/OnsY0YCljDwqd4la0thLZRJW/NmHWauFvBnP8H/g==
X-Google-Smtp-Source: ABdhPJzZgtB5U4x22zJU50yrFhXvq7b4PdBhU53KG3XGJQq+tvz3pOsQo4cKAbwXBBNNJ0ziz/MxXEZVa/DHlYIJ+iU=
X-Received: by 2002:a05:6512:11cd:: with SMTP id h13mr1277350lfr.233.1614101618096;
 Tue, 23 Feb 2021 09:33:38 -0800 (PST)
MIME-Version: 1.0
References: <1611554578-6464-1-git-send-email-aubrey.li@intel.com>
 <CAKfTPtAxnsEDL436zUypLj2XyMQyhgPvJ8q_23835sQxWzGtxw@mail.gmail.com>
 <a99d59c3-2023-1e8f-83cd-d964e156ffd6@linux.intel.com> <CAKfTPtCCzy5keKcEOUX6D1+wty0dtYEfA5=oezWRgKY_beO5NQ@mail.gmail.com>
 <c7932851-c162-b77f-2802-9b5f46038a9f@linux.intel.com>
In-Reply-To: <c7932851-c162-b77f-2802-9b5f46038a9f@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 Feb 2021 18:33:26 +0100
Message-ID: <CAKfTPtAJ7Lcj0mckc6XRGpD54LOEJkSSLxvz-1JeTdeDwdvBtw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] sched/fair: limit load balance redo times at the
 same sched_domain level
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Aubrey Li <aubrey.li@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 at 06:41, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> Hi Vincent,
>
> Sorry for the delay, I just returned from Chinese New Year holiday.
>
> On 2021/1/25 22:51, Vincent Guittot wrote:
> > On Mon, 25 Jan 2021 at 15:00, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
> >>
> >> On 2021/1/25 18:56, Vincent Guittot wrote:
> >>> On Mon, 25 Jan 2021 at 06:50, Aubrey Li <aubrey.li@intel.com> wrote:
> >>>>
> >>>> A long-tail load balance cost is observed on the newly idle path,
> >>>> this is caused by a race window between the first nr_running check
> >>>> of the busiest runqueue and its nr_running recheck in detach_tasks.
> >>>>
> >>>> Before the busiest runqueue is locked, the tasks on the busiest
> >>>> runqueue could be pulled by other CPUs and nr_running of the busiest
> >>>> runqueu becomes 1, this causes detach_tasks breaks with LBF_ALL_PINNED
> >>>
> >>> We should better detect that when trying to detach task like below
> >>
> >> This should be a compromise from my understanding. If we give up load balance
> >> this time due to the race condition, we do reduce the load balance cost on the
> >> newly idle path, but if there is an imbalance indeed at the same sched_domain
> >
> > Redo path is there in case, LB has found an imbalance but it can't
> > move some loads from this busiest rq to dest rq because of some cpu
> > affinity. So it tries to fix the imbalance by moving load onto another
> > rq of the group. In your case, the imbalance has disappeared because
> > it has already been pulled by another rq so you don't have to try to
> > find another imbalance. And I would even say you should not in order
> > to let other level to take a chance to spread the load
> >
> >> level, we have to wait the next softirq entry to handle that imbalance. This
> >> means the tasks on the second busiest runqueue have to stay longer, which could
> >> introduce tail latency as well. That's why I introduced a variable to control
> >> the redo loops. I'll send this to the benchmark queue to see if it makes any
> >
> > TBH, I don't like multiplying the number of knobs
>
> Sure, I can take your approach, :)
>
> >>>
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -7688,6 +7688,16 @@ static int detach_tasks(struct lb_env *env)
> >>>
> >>>         lockdep_assert_held(&env->src_rq->lock);
> >>>
> >>> +       /*
> >>> +        * Another CPU has emptied this runqueue in the meantime.
> >>> +        * Just return and leave the load_balance properly.
> >>> +        */
> >>> +       if (env->src_rq->nr_running <= 1 && !env->loop) {
>
> May I know why !env->loop is needed here? IIUC, if detach_tasks is invoked

IIRC,  my point was to do the test only when trying to detach the 1st
task. A lot of things can happen when a break is involved but TBH I
can't remember a precise UC. It may be over cautious

> from LBF_NEED_BREAK, env->loop could be non-zero, but as long as src_rq's
> nr_running <=1, we should return immediately with LBF_ALL_PINNED flag cleared.
>
> How about the following change?
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce20da67..1761d33accaa 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7683,8 +7683,11 @@ static int detach_tasks(struct lb_env *env)
>                  * We don't want to steal all, otherwise we may be treated likewise,
>                  * which could at worst lead to a livelock crash.
>                  */
> -               if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
> +               if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1) {

IMO, we must do the test before:  while (!list_empty(tasks)) {

because src_rq might have become empty if waiting tasks have been
pulled by another cpu and the running one became idle in the meantime

> +                       /* Clear the flag as we will not test any task */
> +                       env->flag &= ~LBF_ALL_PINNED;
>                         break;
> +               }
>
>                 p = list_last_entry(tasks, struct task_struct, se.group_node);
>
> Thanks,
> -Aubrey

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEC539E741
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhFGTMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:12:37 -0400
Received: from foss.arm.com ([217.140.110.172]:40704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhFGTMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:12:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41D8D143D;
        Mon,  7 Jun 2021 12:10:43 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E0D63F73D;
        Mon,  7 Jun 2021 12:10:40 -0700 (PDT)
Date:   Mon, 7 Jun 2021 20:10:32 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: iowait boost is broken
Message-ID: <20210607191031.GA12489@e120325.cambridge.arm.com>
References: <CAEXW_YTcO=hbmdq3nOx2RJfT2yPyoFnQx5niB38R2Lzpsp38bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTcO=hbmdq3nOx2RJfT2yPyoFnQx5niB38R2Lzpsp38bA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

Thanks for sending this out.

On Mon, Jun 07, 2021 at 12:19:01PM -0400, Joel Fernandes wrote:
> Hi all,
> Looks like iowait boost is completely broken upstream. Just
> documenting my findings of iowait boost issues:
> 
I wouldn't go as far to state that it is completely broken. Rather that
the current sugov implementation for iowait boosting is not meeting
the expectations and I believe this should be clarified first. More on those
expectations below.
> 1. If a CPU requests iowait boost in a cluster, another CPU can go
> ahead and reset very quickly it since it thinks there's no new request
> for the iowait boosting CPU
So the 'boosting' value is being tracked per CPU, so each core in a cluster
will have it's own variant of that. When calculating the shared freq for
the cluster, sugov will use max utilization reported on each core, including
I/O boost. Now, if there is no pending request for boosting on a given core
at the time of calling sugov_iowait_apply, the current 'boost' will be
reduced, but only this one and that will not affect boost values on remaining
CPUs. It means that there was no task waking up on that particular CPU after
waiting on I/O request. So I would say it's fine. Unless I am misunderstanding
your case ?
> 2. If the iowait is longer than a tick, then successive iowait boost
> doubling does not happen. So heavy I/O waiting code never gets a
> boost.
This might indeed be an issue. What's more: the fact that boosting is applied
per core, any migration will disregard the boosting applied so far, so
it might start increasing the freq on 'new' CPU from scratch.
Might, as sugov (and the I/O boosting) has no notion of the source of boosting
request so it might end up on a core that has already lifted I/O boost.
This also means, that having different small tasks, waking up from
I/O within the mentioned TICK_NSEC time window might drive the frequency to max
even though those would be sporadic wakeups. Things get slightly
cumbersome as increasing the boost does not necessarily result in the freq
change, so the above mentioned case would need proper timing but it is possible.
Also the boost value will not get doubled unless previous one has been applied.
This might result in misalignment between task wake-ups/placement and sugov's
freq changes.
> 3. update_load_avg() is triggered right after the the iowait boost
> request which makes another cpufreq update request, this request is a
> non-iowait boost one so it ends up resetting the iowait boost request
> (in the same path!).
Not necessarily - this is guarded by the TICK_NSEC you have mentioned:
in
    sugov_iowait_reset {
         ...
         if (delta_ns <= TICK_NSEC)
             return;
         ...
    }
So for the particular call sequence the boost should not get reset.
Another problem is when the non-I/O bound tasks triggers the update
after the TICK_NSEC has elapsed and before the frequency change is done.
(see sugov_should_update_freq )
> 4. Same as #3 but due the update_blocked_averages from new idle balance path.
> 
> Here is a patch that tries to address these problems and I see better
> cpufreq boosting happening, however it is just a test broken patch to
> highlight the issues:
> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=sched/5.4/iowait-boost-debug-1&id=3627d896d499d168fef9a388e5d6b3359acc3423
> 
> I think we ought to rewrite the whole mess instead of fixing it since
> a lot has changed in scheduler code over time it feels. Beata is
> working on rewriting the whole iowait boost infra, I am glad she has
> started the work on this and looking forward to helping with the
> patches.
> 
So back to the expectations.
The main problem, as I see it, is what do we actually want to achieve with
the I/O boosting? Is it supposed to compensate the time lost while waiting
for the I/O request to be completed or is is supposed to optimize the rate
at which I/O requests are being made. Do we want to boost I/O bound tasks by
default, no limits applied  or should we care about balancing performance
vs power ? And unless those expectations are clearly stated, we might not
get too far with any changes, really.

Smth that I do agree with is what has been suggested few times by Quentin,
to make the I/O boosting being a per-task feature, not per-core, and that is
smth I have been experimenting with. This would help with maintaining the boost
level upon migration and could potentially improve task placement. It would also
eliminate sugov's misfires: currently the boost might be applied when the task
on behalf of which the boost has been triggered, has been migrated or is not
runnable at that point. Also sugov's boosting is completely unaware of
uclamp restrictions,and I guess it should be. This could also be fixed with
per-task boosting.

There are few tricky bits though:
- current implementation (sugov's) makes sure the boost will not get doubled
unless the current level of boosting has been applied -> there is no notion
for that when moving the boosting as a per-task feature (considered as an
optimization for too frequent freq changes)
- guarding ramping up the frequency with TICK_NSEC & freq_update_delay_ns
is also out of the equation (same as above)

The above two means we might be boosting faster that this is currently expected.
On the other hand we might lose the boosting as currently sugov does not care
whether that is a single or multiple tasks waking up from I/O.

I've been trying to come up with some heuristics that would help to decide
whether boosting makes sense or not (like don't boost too much if most of the
time the task is being blocked or when despite boosting the sleep time keeps
getting longer). But that seems slightly counter intuitive, to place that sort
of decision making in schedulers generic code (without having all the info at
hand) and I would expect this to be handled by other, more suited mechanisms.
On the other hand, boosting upon each wake-up (from I/O) seems slightly
excessive. But again: it all comes down to the expectations on the actually
desired behaviour. We could potentially add another PELT-like signal to track
the time spent waiting on I/O request alongside the task utilization, but that
means more messing with signals on the rq level and losing some performance
points due to needed calculations. Alternative of blindly increasing boost
for each relevant wake-up means that small tasks could drive the freq to its
max values - which I am not sure is so desired for power-aware scenarios.
So all in all - still in progress.

Any comments are more than welcomed.

---
BR
B.


> thanks,
>  - Joel

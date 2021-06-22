Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BEE3B08F7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhFVP33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhFVP31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:29:27 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0020C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:27:11 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id i68so40538902qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+WSvgKA/jjyL54BPWCWRwmueYGagsZLbucIcvs/JCU=;
        b=iHMk69BaCN0kKiHXVqyKgzKC9f/iMYHJwKeCPFhe/T0OZjFp98P/7ar6AJOBbqrJZF
         czF1Dymt/E4I718ijY3hMxrW++/IDoUmNeDZ1FEOe4FQsZ2geo8R6zeCuTDO92u/YpC8
         M7ApmcTGV5xAOZ3yishb2Jssp6/+rKO97ywBJH9Q05TfDg21IjXqK+NVjQKDbcHAVC9Y
         gpswCp65wRpwvx7uH0E8knv9jkdKQGBkF8RRrJDYG5ZHonn8ZZQzcn5/3+NXCYY9sZ5A
         iqk5xyr27VgaL4ZUmr5U4eshS3B2lV+mP2rATiekTHkfhCAMR22yV10Lv5wcz0UJ99+V
         y27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+WSvgKA/jjyL54BPWCWRwmueYGagsZLbucIcvs/JCU=;
        b=cDnF/Yubvpej6C4QqJquSCpuJZlJ6Omqd2IMdCT6zIlBycPY4GBaapWjYbW3yDUonS
         5Sgd1SlDa6MaiDe2VgRz8OxXmb7a/qmyXqRKto9ilFncNu72JKVisBXshaXkQqPgeY3k
         pitvWy2/mgqPWguyMeIrYq+b4FkBfL6B3HFJ9YqhBJp+CMH42TvrquCp/6SS/EhOZ46g
         Bs9+c3VM9f++TKR8GtSV4uCXZr1MphJWFaxcmahWmrD6Rsok9aIqeh+0SVaggkX/JNb0
         jMJ2ncxlNwIkhjIxR5rVHCh6rLCngdVdAnNTNoa5w9tSSWzrpupENb1cOzFCaWdXR4+h
         OCKw==
X-Gm-Message-State: AOAM533ehMc2kRgiaOAaFtQaDo1WTTlqyCY4z4pQe6rRumPwz0KrW9rq
        X2m+F/jK8e/pjo9u+aR7sOtrIblyCsklSRFvNCPPqA==
X-Google-Smtp-Source: ABdhPJywZ3FYxlLCkFmcuhnZhpSIYURdlN+by05PuvtHmL+8UwGS5B1bCklc6uZe3ayyUqK7fXaoQpVVu3xO8r4S5HY=
X-Received: by 2002:a37:8b47:: with SMTP id n68mr4786889qkd.209.1624375630731;
 Tue, 22 Jun 2021 08:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210621092800.23714-1-changhuaixin@linux.alibaba.com> <20210621092800.23714-4-changhuaixin@linux.alibaba.com>
In-Reply-To: <20210621092800.23714-4-changhuaixin@linux.alibaba.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Tue, 22 Jun 2021 17:26:34 +0200
Message-ID: <CAFpoUr1rQBDQo0_NEEmg8eeGY3ESjpe7dH=qV289wpMWPmcM8w@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] sched/fair: Add document for burstable CFS bandwidth
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     luca.abeni@santannapisa.it, anderson@cs.unc.edu, baruah@wustl.edu,
        Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Odin Ugedal <odin@uged.al>, pauld@redhead.com,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, tommaso.cucinotta@santannapisa.it,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

man. 21. jun. 2021 kl. 11:28 skrev Huaixin Chang
<changhuaixin@linux.alibaba.com>:
>
> Basic description of usage and effect for CFS Bandwidth Control Burst.
>
> Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
> Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
> Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  8 +++
>  Documentation/scheduler/sched-bwc.rst   | 91 +++++++++++++++++++++++++++++----
>  2 files changed, 89 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index b1e81aa8598a..3d0a86a065a1 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1000,6 +1000,8 @@ All time durations are in microseconds.
>         - nr_periods
>         - nr_throttled
>         - throttled_usec
> +       - nr_bursts
> +       - burst_usec
>
>    cpu.weight
>         A read-write single value file which exists on non-root
> @@ -1031,6 +1033,12 @@ All time durations are in microseconds.
>         $PERIOD duration.  "max" for $MAX indicates no limit.  If only
>         one number is written, $MAX is updated.
>
> +  cpu.max.burst
> +       A read-write single value file which exists on non-root
> +       cgroups.  The default is "0".
> +
> +       The burst in the range [0, $PERIOD].

Is this supposed to be $PERIOD or $QUOTA?

> +
>    cpu.pressure
>         A read-write nested-keyed file.
>
> diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
> index 845eee659199..b1a67fee1d46 100644
> --- a/Documentation/scheduler/sched-bwc.rst
> +++ b/Documentation/scheduler/sched-bwc.rst
> @@ -22,39 +22,89 @@ cfs_quota units at each period boundary. As threads consume this bandwidth it
>  is transferred to cpu-local "silos" on a demand basis. The amount transferred
>  within each of these updates is tunable and described as the "slice".
>
> +Burst feature
> +-------------
> +This feature borrows time now against our future underrun, at the cost of
> +increased interference against the other system users. All nicely bounded.
> +
> +Traditional (UP-EDF) bandwidth control is something like:
> +
> +  (U = \Sum u_i) <= 1
> +
> +This guaranteeds both that every deadline is met and that the system is
> +stable. After all, if U were > 1, then for every second of walltime,
> +we'd have to run more than a second of program time, and obviously miss
> +our deadline, but the next deadline will be further out still, there is
> +never time to catch up, unbounded fail.
> +
> +The burst feature observes that a workload doesn't always executes the full
> +quota; this enables one to describe u_i as a statistical distribution.
> +
> +For example, have u_i = {x,e}_i, where x is the p(95) and x+e p(100)
> +(the traditional WCET). This effectively allows u to be smaller,
> +increasing the efficiency (we can pack more tasks in the system), but at
> +the cost of missing deadlines when all the odds line up. However, it
> +does maintain stability, since every overrun must be paired with an
> +underrun as long as our x is above the average.
> +
> +That is, suppose we have 2 tasks, both specify a p(95) value, then we
> +have a p(95)*p(95) = 90.25% chance both tasks are within their quota and
> +everything is good. At the same time we have a p(5)p(5) = 0.25% chance
> +both tasks will exceed their quota at the same time (guaranteed deadline
> +fail). Somewhere in between there's a threshold where one exceeds and
> +the other doesn't underrun enough to compensate; this depends on the
> +specific CDFs.
> +
> +At the same time, we can say that the worst case deadline miss, will be
> +\Sum e_i; that is, there is a bounded tardiness (under the assumption
> +that x+e is indeed WCET).
> +
> +The interferenece when using burst is valued by the possibilities for
> +missing the deadline and the average WCET. Test results showed that when
> +there many cgroups or CPU is under utilized, the interference is
> +limited. More details are shown in:
> +https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alibaba.com/
> +
>  Management
>  ----------
> -Quota and period are managed within the cpu subsystem via cgroupfs.
> +Quota, period and burst are managed within the cpu subsystem via cgroupfs.
>
>  .. note::
>     The cgroupfs files described in this section are only applicable
>     to cgroup v1. For cgroup v2, see
>     :ref:`Documentation/admin-guide/cgroupv2.rst <cgroup-v2-cpu>`.
>
> -- cpu.cfs_quota_us: the total available run-time within a period (in
> -  microseconds)
> +- cpu.cfs_quota_us: run-time replenished within a period (in microseconds)
>  - cpu.cfs_period_us: the length of a period (in microseconds)
>  - cpu.stat: exports throttling statistics [explained further below]
> +- cpu.cfs_burst_us: the maximum accumulated run-time (in microseconds)
>
>  The default values are::
>
>         cpu.cfs_period_us=100ms
> -       cpu.cfs_quota=-1
> +       cpu.cfs_quota_us=-1
> +       cpu.cfs_burst_us=0
>
>  A value of -1 for cpu.cfs_quota_us indicates that the group does not have any
>  bandwidth restriction in place, such a group is described as an unconstrained
>  bandwidth group. This represents the traditional work-conserving behavior for
>  CFS.
>
> -Writing any (valid) positive value(s) will enact the specified bandwidth limit.
> -The minimum quota allowed for the quota or period is 1ms. There is also an
> -upper bound on the period length of 1s. Additional restrictions exist when
> -bandwidth limits are used in a hierarchical fashion, these are explained in
> -more detail below.
> +Writing any (valid) positive value(s) no smaller than cpu.cfs_burst_us will
> +enact the specified bandwidth limit. The minimum quota allowed for the quota or
> +period is 1ms. There is also an upper bound on the period length of 1s.
> +Additional restrictions exist when bandwidth limits are used in a hierarchical
> +fashion, these are explained in more detail below.
>
>  Writing any negative value to cpu.cfs_quota_us will remove the bandwidth limit
>  and return the group to an unconstrained state once more.
>
> +A value of 0 for cpu.cfs_burst_us indicates that the group can not accumulate
> +any unused bandwidth. It makes the traditional bandwidth control behavior for
> +CFS unchanged. Writing any (valid) positive value(s) no larger than
> +cpu.cfs_quota_us into cpu.cfs_burst_us will enact the cap on unused bandwidth
> +accumulation.
> +
>  Any updates to a group's bandwidth specification will result in it becoming
>  unthrottled if it is in a constrained state.
>
> @@ -72,9 +122,15 @@ This is tunable via procfs::
>  Larger slice values will reduce transfer overheads, while smaller values allow
>  for more fine-grained consumption.
>
> +There is also a global switch to turn off burst for all groups::
> +       /proc/sys/kernel/sched_cfs_bw_burst_enabled (default=1)
> +
> +By default it is enabled. Writing a 0 value means no accumulated CPU time can be
> +used for any group, even if cpu.cfs_burst_us is configured.
> +

nit: This was removed now, or?

>  Statistics
>  ----------
> -A group's bandwidth statistics are exported via 3 fields in cpu.stat.
> +A group's bandwidth statistics are exported via 5 fields in cpu.stat.
>
>  cpu.stat:
>
> @@ -82,6 +138,9 @@ cpu.stat:
>  - nr_throttled: Number of times the group has been throttled/limited.
>  - throttled_time: The total time duration (in nanoseconds) for which entities
>    of the group have been throttled.
> +- nr_bursts: Number of periods burst occurs.
> +- burst_usec: Cumulative wall-time that any CPUs has used above quota in
> +  respective periods
>
>  This interface is read-only.
>
> @@ -179,3 +238,15 @@ Examples
>
>     By using a small period here we are ensuring a consistent latency
>     response at the expense of burst capacity.
> +
> +4. Limit a group to 40% of 1 CPU, and allow accumulate up to 20% of 1 CPU
> +   additionally, in case accumulation has been done.
> +
> +   With 50ms period, 20ms quota will be equivalent to 40% of 1 CPU.
> +   And 10ms burst will be equivalent to 20% of 1 CPU.
> +
> +       # echo 20000 > cpu.cfs_quota_us /* quota = 20ms */
> +       # echo 50000 > cpu.cfs_period_us /* period = 50ms */
> +       # echo 10000 > cpu.cfs_burst_us /* burst = 10ms */
> +
> +   Larger buffer setting (no larger than quota) allows greater burst capacity.
> --
> 2.14.4.44.g2045bb6
>

Thanks
Odin

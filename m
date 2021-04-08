Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B0235877C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhDHOvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDHOv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:51:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AFDC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 07:51:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j18so4518934lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AoYbM1NiuCPawvKYbOvZh1c7cjbCpDrK9QqAqU+mWa0=;
        b=rC6po2bA5/Bg2Y186Yz9smMcSQS+K3BUjUpG53Zk5P1wtpqYuauV88Jp6ScIcDS+iY
         rxgqiJhrXya+BU2seCRWvKrHAwzcB/kencQ5O0KmWm5PvGTRoFHcGvo5biEkPmo0NUEf
         Vm/bidVcMhLnW6/3CfEGqYu8xOPDtsLnH8eyxBNBQiAlj2s2iAwuDQouj5PodiKrQBMK
         Qo39tWpnCJTJf4zRFdVa9VYoV/MMmJb/8n5ybaTUM/MrFhL0gKd8GAMKPoo2G8yxENai
         474CV2nogLzO51WDK4mgykOE7HTCdPa0uGAMQS1NZMHyef8bHIWecpzCAlWQE7XjVRNU
         5YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AoYbM1NiuCPawvKYbOvZh1c7cjbCpDrK9QqAqU+mWa0=;
        b=eP71UVl74WBqC0zno2W/70XP16LVjPNCBdiDNnhZYITl3Jq1D6WGiKyzlc3K7CIdD+
         WcPJBPj+vJcflvZ2gR42+4efN25R2Jm/0oG0AeTl908WYRjK5NYT2Q1p8pONIvW8JBgE
         VfqpAoYE+xvuSENdRDV/s8qgIqTQXA7W1ATvObH6Ho5xxwOTMWJcbFrbDTLj6aDNPld4
         pa/kl4zJ3NxryDonlX1zem25SdrRyRN6HAP1WDPCsHiROzzymXeLfM7Wqgu2/e6wqGDx
         znjhbgTqH7O4R7AI4VZOu6JBcJNiQo3+QgSYXwa8iQHIdTalNdF3/c2gLzQnNUD/I1hX
         2U4A==
X-Gm-Message-State: AOAM5331LcQqqHnG8MahM4BDUstSsaMkxuAdmyHaabDUE9YCM2dBuYfw
        g3EzMMqH0dCRUx9h+GMQsFckggRVF/qW6WUlrr6+8A==
X-Google-Smtp-Source: ABdhPJxArsYbLLcHjSdSXzdBLm2GkVVDR5ETQT1CF7Wxa3Xb3KzXilEHXzpjc3vmDD1Uoe6RL6WxaAUft+lBOUbRQqI=
X-Received: by 2002:a19:dc0b:: with SMTP id t11mr6889106lfg.233.1617893476063;
 Thu, 08 Apr 2021 07:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com> <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com> <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book> <274d8ae5-8f4d-7662-0e04-2fbc92b416fc@linux.intel.com>
 <20210324134437.GA17675@vingu-book> <efad4771-c9d1-5103-de9c-0ec5fa78ee24@linux.intel.com>
 <CAKfTPtDsya_zdUB1ARmoxQs5xWS8o-XrrzyNx5R1iSNrchUXtg@mail.gmail.com> <fc0efe4e-0a81-03b8-08cb-029468c57782@linux.intel.com>
In-Reply-To: <fc0efe4e-0a81-03b8-08cb-029468c57782@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 8 Apr 2021 16:51:04 +0200
Message-ID: <CAKfTPtCKavGWja42NdTmb+95ppG-WxYzoTJMmtgkCQcA-btfBw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 at 19:19, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
>
>
> On 4/7/21 7:02 AM, Vincent Guittot wrote:
> > Hi Tim,
> >
> > On Wed, 24 Mar 2021 at 17:05, Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 3/24/21 6:44 AM, Vincent Guittot wrote:
> >>> Hi Tim,
> >>
> >>>
> >>> IIUC your problem, we call update_blocked_averages() but because of:
> >>>
> >>>               if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
> >>>                       update_next_balance(sd, &next_balance);
> >>>                       break;
> >>>               }
> >>>
> >>> the for_each_domain loop stops even before running load_balance on the 1st
> >>> sched domain level which means that update_blocked_averages() was called
> >>> unnecessarily.
> >>>
> >>
> >> That's right
> >>
> >>> And this is even more true with a small sysctl_sched_migration_cost which allows newly
> >>> idle LB for very small this_rq->avg_idle. We could wonder why you set such a low value
> >>> for sysctl_sched_migration_cost which is lower than the max_newidle_lb_cost of the
> >>> smallest domain but that's probably because of task_hot().
> >>>
> >>> if avg_idle is lower than the sd->max_newidle_lb_cost of the 1st sched_domain, we should
> >>> skip spin_unlock/lock and for_each_domain() loop entirely
> >>>
> >>> Maybe something like below:
> >>>
> >>
> >> The patch makes sense.  I'll ask our benchmark team to queue this patch for testing.
> >
> > Do you have feedback from your benchmark team ?
> >
>
> Vincent,
>
> Thanks for following up. I just got some data back from the benchmark team.
> The performance didn't change with your patch.  And the overall cpu% of update_blocked_averages
> also remain at about the same level.  My first thought was perhaps this update
> still didn't catch all the calls to update_blocked_averages
>
>         if (this_rq->avg_idle < sysctl_sched_migration_cost ||
> -           !READ_ONCE(this_rq->rd->overload)) {
> +           !READ_ONCE(this_rq->rd->overload) ||
> +           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>
> To experiment, I added one more check on the next_balance to further limit
> the path to actually do idle load balance with the next_balance time.
>
>         if (this_rq->avg_idle < sysctl_sched_migration_cost ||
> -           !READ_ONCE(this_rq->rd->overload)) {
> +           time_before(jiffies, this_rq->next_balance) ||
> +           !READ_ONCE(this_rq->rd->overload) ||
> +           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>
> I was suprised to find the overall cpu% consumption of update_blocked_averages
> and throughput of the benchmark still didn't change much.  So I took a
> peek into the profile and found the update_blocked_averages calls shifted to the idle load balancer.
> The call to update_locked_averages was reduced in newidle_balance so the patch did
> what we intended.  But the overall rate of calls to

At least , we have removed the useless call to update_blocked_averages
in newidle_balance when we will not perform any newly idle load
balance

> update_blocked_averages remain roughly the same, shifting from
> newidle_balance to run_rebalance_domains.
>
>    100.00%  (ffffffff810cf070)
>             |
>             ---update_blocked_averages
>                |
>                |--95.47%--run_rebalance_domains
>                |          __do_softirq
>                |          |
>                |          |--94.27%--asm_call_irq_on_stack
>                |          |          do_softirq_own_stack

The call of  update_blocked_averages mainly comes from SCHED_SOFTIRQ.
And as a result, not from the new path
do_idle()->nohz_run_idle_balance() which has been added by this patch
to defer the call to update_nohz_stats() after newlyidle_balance and
before entering idle.

>                |          |          |
>                |          |          |--93.74%--irq_exit_rcu
>                |          |          |          |
>                |          |          |          |--88.20%--sysvec_apic_timer_interrupt
>                |          |          |          |          asm_sysvec_apic_timer_interrupt
>                |          |          |          |          |
>                ...
>                |
>                |
>                 --4.53%--newidle_balance
>                           pick_next_task_fair
>
> I was expecting idle load balancer to be rate limited to 60 Hz, which

Why 60Hz ?

> should be 15 jiffies apart on the test system with CONFIG_HZ_250.
> When I did a trace on a single CPU, I see that update_blocked_averages
> are often called between 1 to 4 jiffies apart, which is at a much higher
> rate than I expected.  I haven't taken a closer look yet.  But you may

2 things can trigger a SCHED_SOFTIRQ/run_rebalance_domains:
- the need for an update of blocked load which should not happen more
than once every 32ms which means a rate of around 30Hz
- the need for a load balance of a sched_domain. The min interval for
a sched_domain is its weight when the CPU is idle which is usually few
jiffies

The only idea that I have for now is that we spend less time in
newidle_balance which changes the dynamic of your system.

In your trace, could you check if update_blocked_averages is called
during the tick ? and Is the current task idle task ?

Vincent

> have a better idea.  I won't have access to the test system and workload
> till probably next week.
>
> Thanks.
>
> Tim

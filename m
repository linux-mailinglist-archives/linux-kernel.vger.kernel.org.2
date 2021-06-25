Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56643B3FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhFYIwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:52:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D82C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:50:25 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r16so11497619ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpCOlWk3vKWnUnsPZTBmvx+1pyqIKsgkj5HKTtcGYP0=;
        b=dLvIKi7/XUStuXGU0YbkzxykAcFpHdqB2wSAOdfJTPIqRO+Csa/GF5sHMyTU4RQwx1
         sDqdCqsWA1rKGDtUnrmHvrGzknRnjJC5NrrKAUiKaIhOYcLL1lWqDfF0/lCen7gB+jFH
         pDUIkTB0Pemz1E7uP5aePPv+3jBqgr4ml/Do0j1pV5Bw94019cPDHEHhLZHIVDzq70B0
         RjN3xYe6sPmejKNYzOl+D80R1Jt34K767Q8irxmuNrtQL++X9NzHV4lypZAqq7gwEOv+
         b3Fd+++yd43rvvJMwXgY95YBor1476h6P+AdVDDt/q74GfQVDJwtGwNNrCsdh/ICiD0/
         h0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpCOlWk3vKWnUnsPZTBmvx+1pyqIKsgkj5HKTtcGYP0=;
        b=Gs38iINfZn2LCNWOdpQTrr2QTnkeGbU/6B0sLi+RXDtwMrhbO6nqPIcChMz7t2Zm/J
         RGQfCExGGmXIm4IrDhHkEfxROSwXEad3FpyeWn3UqBVkh/M0vNVvlwTfabVdz3/QeCd6
         XhCSg69WBqACUm1m/SQFkK/VA7lZxSBAGbqGtzEs1gICvwBjf7hyr82CL4J9awODescg
         45DPE4e5g55LBd2ueCSWg6fqVenaVbjgG63rR17cuYzPJL7+EBKFLcGbDor/CN0QAbmn
         iGmb7jaCRwyDPDQhQjVqj3l2BXebhGht9WuJhct9F98Fat+AsYPYnrtuNqD10yjIX3zJ
         nkRA==
X-Gm-Message-State: AOAM533UfogvRrfihU94zaGbdCVu5fXGcdtr34EwSKQ8BeqXSUZ6LjfI
        tbsx4DwmG6a3U26mIF0jMA9GBHmKW1XFEWfi70wJLA==
X-Google-Smtp-Source: ABdhPJwTRBmiR0FvqO0X6rrlb/CZlN18HS8p4BRLy4c5OSXbfE8aldbtagWqzj3SnsS/Dd2qxqHMILG7WvSAMsJdN4Y=
X-Received: by 2002:a2e:8941:: with SMTP id b1mr7486483ljk.284.1624611024055;
 Fri, 25 Jun 2021 01:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <efad4771-c9d1-5103-de9c-0ec5fa78ee24@linux.intel.com>
 <CAKfTPtDsya_zdUB1ARmoxQs5xWS8o-XrrzyNx5R1iSNrchUXtg@mail.gmail.com>
 <fc0efe4e-0a81-03b8-08cb-029468c57782@linux.intel.com> <CAKfTPtCKavGWja42NdTmb+95ppG-WxYzoTJMmtgkCQcA-btfBw@mail.gmail.com>
 <4aa674d9-db49-83d5-356f-a20f9e2a7935@linux.intel.com> <CAKfTPtDJaTr_HR2t=9CQ-9x6keu-qzx6okci92AdW5cJG8J9zg@mail.gmail.com>
 <2d2294ce-f1d1-f827-754b-4541c1b43be8@linux.intel.com> <ade18978-cd67-6215-28f0-4857c66a99fb@linux.intel.com>
 <CAKfTPtA8nr-fgt4Nw6XqQyT_TEx4uL3nK-ba0xGfkONO+BPG3Q@mail.gmail.com>
 <577b0aae-0111-97aa-0c99-c2a2fcfb5e2e@linux.intel.com> <20210512135955.suzvxxfilvwg33y2@e107158-lin.cambridge.arm.com>
 <729718fd-bd2c-2e0e-46f5-8027281e5821@linux.intel.com> <CAKfTPtCYU2AW3sJ-=QJ=hE+tFHS8wUBZ9vSsZp8q2AozxeA5mQ@mail.gmail.com>
 <366aa93b-ecbf-ac0f-cd9e-3376b20d4929@linux.intel.com>
In-Reply-To: <366aa93b-ecbf-ac0f-cd9e-3376b20d4929@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 25 Jun 2021 10:50:12 +0200
Message-ID: <CAKfTPtC157Z2vsnW3MLqKcMBYB-0D255rYr1Y-vD5xYDLBNoVQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
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

On Fri, 18 Jun 2021 at 18:14, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
>
>
> On 6/18/21 3:28 AM, Vincent Guittot wrote:
>
> >>
> >> The current logic is when a CPU becomes idle, next_balance occur very
> >> shortly (usually in the next jiffie) as get_sd_balance_interval returns
> >> the next_balance in the next jiffie if the CPU is idle.  However, in
> >> reality, I saw most CPUs are 95% busy on average for my workload and
> >> a task will wake up on an idle CPU shortly.  So having frequent idle
> >> balancing towards shortly idle CPUs is counter productive and simply
> >> increase overhead and does not improve performance.
> >
> > Just to make sure that I understand your problem correctly:  Your problem is:
> > - that we have an ilb happening on the idle CPU and consume cycle
>
> That's right.  The cycles are consumed heavily in update_blocked_averages()
> when cgroup is enabled.

But they are normally consumed on an idle CPU and the ILB checks
need_resched()  before running load balance for the next idle CPU.

Does it mean that your problem is coming from update_blocked_average()
spending a long time with rq_lock_irqsave and increasing the wakeup
latency of your short running task ?

>
> > - or that the ilb will pull a task on an idle CPU on which a task will
> > shortly wakeup which ends to 2 tasks competing for the same CPU.
> >
>
> Because for the OLTP workload I'm looking at, we have tasks that sleep
> for a short while and wake again very shortly (i.e. the CPU actually
> is ~95% busy on average), pulling tasks to such a CPU is really not
> helpful to improve overall CPU utilization in the system.  So my
> intuition is for such almost fully busy CPU, we should defer load
> balancing to it (see prototype patch 3).

Note that this is at the opposite of what you said earlier:
"
Though in our test environment, sysctl_sched_migration_cost was kept
much lower (25000) compared to the default (500000), to encourage
migrations to idle cpu
and reduce latency.
"

But, it will be quite hard to find a value that fits to requirements
for everybody and some will have UCs for which they want to pull tasks
even if the CPU is 95% busy; You can have 2ms of idle time but having
a utilization above 95% and an ILB inside a Core or at LLC is somewhat
cheap and would take advantage of those 2ms

>
> Tim
>
>
>
>

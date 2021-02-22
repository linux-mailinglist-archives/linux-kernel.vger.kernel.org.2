Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9839321AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhBVPCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:02:46 -0500
Received: from foss.arm.com ([217.140.110.172]:51650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230240AbhBVPCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:02:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6B94D6E;
        Mon, 22 Feb 2021 07:01:54 -0800 (PST)
Received: from e124901.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F01F3F73B;
        Mon, 22 Feb 2021 07:01:53 -0800 (PST)
Date:   Mon, 22 Feb 2021 15:01:51 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: Fix task utilization accountability in
 cpu_util_next()
Message-ID: <20210222150151.GA124800@e124901.cambridge.arm.com>
References: <20210222095401.37158-1-vincent.donnefort@arm.com>
 <YDODN1rnTqfTQOug@google.com>
 <20210222113602.GA286874@e120877-lin.cambridge.arm.com>
 <YDOiKH/XQDUKcrPU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDOiKH/XQDUKcrPU@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 12:23:04PM +0000, Quentin Perret wrote:
> On Monday 22 Feb 2021 at 11:36:03 (+0000), Vincent Donnefort wrote:
> > Here's with real life numbers.
> > 
> > The task: util_avg=3 (1) util_est=11 (2)
> > 
> > pd0 (CPU-0, CPU-1, CPU-2)
> > 
> >  cpu_util_next(CPU-0, NULL): 7
> >  cpu_util_next(CPU-1, NULL): 3
> >  cpu_util_next(CPU-2, NULL): 0 <- Most capacity, try to place task here.
> > 
> >  cpu_util_next(CPU-2, task): 0 + 11 (2)
> > 
> > 
> > pd1 (CPU-3):
> > 
> >  cpu_util_next(CPU-3, NULL): 77
> > 
> >  cpu_util_next(CPU-3, task): 77 + 3 (1)
> > 
> > 
> > On pd0, the task contribution is 11. On pd1, it is 3.
> 
> Yes but that accurately reflects what the task's impact on frequency
> selection of those CPUs if it was enqueued there, right?
> 
> This is an important property we should aim to keep, the frequency
> prediction needs to be in sync with the actual frequency request, or
> the energy estimate will be off.

You mean that it could lead to a wrong frequency estimation when doing
freq = map_util_freq() in em_cpu_energy()?

But in any case, the computed energy, being the product of sum_util with the
OPP's cost, it is directly affected by this util_avg/util_est difference.

In the case where the task placement doesn't change the OPP, which is often the
case, we can simplify the comparison and end-up with the following:

  delta_energy(CPU-3): OPP3 cost * (cpu_util_avg + task_util_avg - cpu_util_avg)
  delta_energy(CPU-2): OPP2 cost * (cpu_util_est + task_util_est - cpu_util_est)

  => OPP3 cost * task_util_avg < task_util_est * OPP2 cost

With the same example I described previously, if you add the scaled OPP cost of
0.76 for CPU-3 and 0.65 for CPU-2 (real life OPP scaled costs), we have:

  2.3 (CPU-3) < 7.15 (CPU-2)

The task is placed on CPU-3, while it would have been much more efficient to use
CPU-2.

> 
> > When computing the energy
> > deltas, pd0's is likely to be higher than pd1's, only because the task
> > contribution is higher for one comparison than the other.
> 
> You mean the contribution to sum_util right? I think I see what you mean
> but I'm still not sure if this really is an issue. This is how util_est
> works, and the EM stuff is just consistent with that.
> 
> The issue you describe can only happen (I think) when a rq's util_avg is
> larger than its util-est emwa by some margin (that has to do with the
> ewma-util_avg delta for the task?). But that means the ewma is not to be
> trusted to begin with, so ...

cfs_rq->avg.util_est.ewma is not used. cpu_util() will only return the max
between ue.enqueued and util_avg.


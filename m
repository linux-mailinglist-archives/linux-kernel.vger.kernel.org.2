Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB9321530
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBVLg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:36:59 -0500
Received: from foss.arm.com ([217.140.110.172]:42598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230042AbhBVLgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:36:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29B061FB;
        Mon, 22 Feb 2021 03:36:09 -0800 (PST)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC5D73F73B;
        Mon, 22 Feb 2021 03:36:07 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:36:03 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: Fix task utilization accountability in
 cpu_util_next()
Message-ID: <20210222113602.GA286874@e120877-lin.cambridge.arm.com>
References: <20210222095401.37158-1-vincent.donnefort@arm.com>
 <YDODN1rnTqfTQOug@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDODN1rnTqfTQOug@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Mon, Feb 22, 2021 at 10:11:03AM +0000, Quentin Perret wrote:
> Hey Vincent,
> 
> On Monday 22 Feb 2021 at 09:54:01 (+0000), vincent.donnefort@arm.com wrote:
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > 
> > Currently, cpu_util_next() estimates the CPU utilization as follows:
> > 
> >   max(cpu_util + task_util,
> >       cpu_util_est + task_util_est)
> 
> s/task_util_est/_task_util_est
> 
> This is an important difference.
> 
> > 
> > This is an issue when making a comparison between CPUs, as the task
> > contribution can be either:
> > 
> >   (1) task_util_est, on a mostly idle CPU, where cpu_util is close to 0
> >       and task_util_est > cpu_util.
> >   (2) task_util, on a mostly busy CPU, where cpu_util > task_util_est.
> 
> I don't understand how this is an issue, this is by design with util-est
> no?
> 
> Note that cpu_util_next() tries to accurately predict what cpu_util(@cpu)
> will be once @p is enqueued on @dst_cpu. There should be no policy
> decision here, we just reproduce the enqueue aggreagation -- see
> util_est_enqueue() and cpu_util().
> 
> Could you please give an example where you think cpu_util_next()
> computes the wrong value?

Here's with real life numbers.

The task: util_avg=3 (1) util_est=11 (2)

pd0 (CPU-0, CPU-1, CPU-2)

 cpu_util_next(CPU-0, NULL): 7
 cpu_util_next(CPU-1, NULL): 3
 cpu_util_next(CPU-2, NULL): 0 <- Most capacity, try to place task here.

 cpu_util_next(CPU-2, task): 0 + 11 (2)


pd1 (CPU-3):

 cpu_util_next(CPU-3, NULL): 77

 cpu_util_next(CPU-3, task): 77 + 3 (1)


On pd0, the task contribution is 11. On pd1, it is 3. When computing the energy
deltas, pd0's is likely to be higher than pd1's, only because the task
contribution is higher for one comparison than the other.

-- 
Vincent

> 
> Thanks,
> Quentin


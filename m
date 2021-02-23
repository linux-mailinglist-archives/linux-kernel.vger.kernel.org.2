Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08209322CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhBWOst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:48:49 -0500
Received: from foss.arm.com ([217.140.110.172]:53836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232553AbhBWOsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:48:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F4961FB;
        Tue, 23 Feb 2021 06:47:53 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29A643F73B;
        Tue, 23 Feb 2021 06:47:52 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Fix task utilization accountability in
 cpu_util_next()
To:     Quentin Perret <qperret@google.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com
References: <20210222095401.37158-1-vincent.donnefort@arm.com>
 <YDODN1rnTqfTQOug@google.com>
 <20210222113602.GA286874@e120877-lin.cambridge.arm.com>
 <YDOiKH/XQDUKcrPU@google.com>
 <20210222150151.GA124800@e124901.cambridge.arm.com>
 <YDPUwKKYgZfzzCJm@google.com> <YDPajlnvgkonocpp@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c101892b-157c-0074-12cb-9651d1c4c4e6@arm.com>
Date:   Tue, 23 Feb 2021 15:47:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YDPajlnvgkonocpp@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2021 17:23, Quentin Perret wrote:
> On Monday 22 Feb 2021 at 15:58:56 (+0000), Quentin Perret wrote:
>> But in any case, if we're going to address this, I'm still not sure this
>> patch will be what we want. As per my first comment we need to keep the
>> frequency estimation right.
> 
> Totally untested, but I think in principle you would like something like
> the snippet below. Would that work?
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce20da67..6594d875c6ac 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6534,8 +6534,13 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>          * its pd list and will not be accounted by compute_energy().
>          */
>         for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
> -               unsigned long cpu_util, util_cfs = cpu_util_next(cpu, p, dst_cpu);
> +               unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
> +               unsigned long util_running = cpu_util_without(cpu, p);

Wouldn't this be the same as:

                 unsigned long util_running = cpu_util_next(cpu, p, -1);

except some different handling of !last_update_time and
'task_on_rq_queued(p) || current == p)' in cpu_util_without() which
shouldn't happen in EAS.

We have quite a lot of util related functions!

[...]

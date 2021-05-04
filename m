Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EAB372814
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 11:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhEDJ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 05:28:18 -0400
Received: from foss.arm.com ([217.140.110.172]:56158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhEDJ2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 05:28:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B177ED1;
        Tue,  4 May 2021 02:27:22 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D042B3F73B;
        Tue,  4 May 2021 02:27:20 -0700 (PDT)
Date:   Tue, 4 May 2021 10:27:15 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Pierre.Gondois@arm.com
Cc:     linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        qperret@qperret.net, dietmar.eggemann@arm.com, Lukasz.Luba@arm.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Subject: Re: [PATCH v2 2/2] sched/fair: Fix negative energy delta in
 find_energy_efficient_cpu()
Message-ID: <20210504092714.GA100203@e120877-lin.cambridge.arm.com>
References: <20210429101948.31224-1-Pierre.Gondois@arm.com>
 <20210429101948.31224-3-Pierre.Gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429101948.31224-3-Pierre.Gondois@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 11:19:48AM +0100, Pierre.Gondois@arm.com wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> find_energy_efficient_cpu() (feec()) searches the best energy CPU
> to place a task on. To do so, compute_energy() estimates the energy
> impact of placing the task on a CPU, based on CPU and task utilization
> signals.
> 
> Utilization signals can be concurrently updated while evaluating a
> performance domain (pd). In some cases, this leads to having a
> 'negative delta', i.e. placing the task in the pd is seen as an
> energy gain. Thus, any further energy comparison is biased.
> 
> In case of a 'negative delta', return prev_cpu since:
> 1. a 'negative delta' happens in less than 0.5% of feec() calls,
>    on a Juno with 6 CPUs (4 little, 2 big)
> 2. it is unlikely to have two consecutive 'negative delta' for
>    a task, so if the first call fails, feec() will correctly
>    place the task in the next feec() call
> 3. EAS current behavior tends to select prev_cpu if the task
>    doesn't raise the OPP of its current pd. prev_cpu is EAS's
>    generic decision
> 4. prev_cpu should be preferred to returning an error code.
>    In the latter case, select_idle_sibling() would do the placement,
>    selecting a big (and not energy efficient) CPU. As 3., the task
>    would potentially reside on the big CPU for a long time
> 
> Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Suggested-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> ---

I've been testing this patch on the Google's Pixel4, with a modified kernel that
we are using to evalute mailine performance and energy consumption for a
"real-life" mobile usage.

As always, I ran the Work2.0 workload from PCMark on Android. With that setup I
haven't observed any statistically significant performance change neither any CPU
Idle residency modification. Nevertheless, this code protected against ~600 bad
computations (and by extent bad placements) during a single PCMark iteration
and by looking at the traces, this is saving from spurious wake-ups that would
otherwise happen on the biggest CPUs of the system.

+ Reviewed-by: Vincent Donnefort <vincent.donnefort@arm.com>

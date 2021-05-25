Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB538FDA3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhEYJWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:22:15 -0400
Received: from foss.arm.com ([217.140.110.172]:53688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232495AbhEYJWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:22:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AE5A6D;
        Tue, 25 May 2021 02:20:40 -0700 (PDT)
Received: from e124901.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C18F3F73D;
        Tue, 25 May 2021 02:20:38 -0700 (PDT)
Date:   Tue, 25 May 2021 10:21:37 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
Message-ID: <20210525092137.GA369979@e124901.cambridge.arm.com>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
 <YKy516IKPfsZj3cY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKy516IKPfsZj3cY@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 10:48:23AM +0200, Peter Zijlstra wrote:
> On Fri, May 21, 2021 at 05:54:24PM +0100, Vincent Donnefort wrote:
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 4f09afd..5a91a2b 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -10,6 +10,7 @@
> >  
> >  #include "sched.h"
> >  
> > +#include <linux/energy_model.h>
> >  #include <linux/sched/cpufreq.h>
> >  #include <trace/events/power.h>
> >  
> > @@ -153,6 +154,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >  
> >  	freq = map_util_freq(util, freq, max);
> >  
> > +	/* Avoid inefficient performance states */
> > +	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);
> > +
> >  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> >  		return sg_policy->next_freq;
> >  
> 
> This seems somewhat unfortunate, it adds a loop over the OPPs only to
> then call into cpufreq to do the exact same thing again :/

Indeed, but it would be complicated to avoid the double loop:

It is possible to register OPPs (and by extension perf_states) for a
frequency for which, the cpufreq table entry is marked with
CPUFREQ_ENTRY_INVALID. It would probably be an issue that would have to be
fixed in the driver, but it is currently allowed.

More importantly, while resolving the frequency, we also cache the index in
cached_resolved_idx. Some drivers, such as qcom-cpufreq-hw rely on this
value for their fastswitch support.

Notice though, we would iterate over the EM only in the case where the
performance state has found inefficiencies.


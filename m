Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D1B396F53
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhFAItW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:49:22 -0400
Received: from foss.arm.com ([217.140.110.172]:43640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233680AbhFAItR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:49:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93F731FB;
        Tue,  1 Jun 2021 01:47:36 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CADA3F73D;
        Tue,  1 Jun 2021 01:47:35 -0700 (PDT)
Date:   Tue, 1 Jun 2021 09:47:25 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
Message-ID: <20210601084725.GA223449@e120877-lin.cambridge.arm.com>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
 <YKy516IKPfsZj3cY@hirez.programming.kicks-ass.net>
 <20210528050934.muji5bv7ed4k4t6j@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528050934.muji5bv7ed4k4t6j@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 10:39:34AM +0530, Viresh Kumar wrote:
> On 25-05-21, 10:48, Peter Zijlstra wrote:
> > On Fri, May 21, 2021 at 05:54:24PM +0100, Vincent Donnefort wrote:
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 4f09afd..5a91a2b 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -10,6 +10,7 @@
> > >  
> > >  #include "sched.h"
> > >  
> > > +#include <linux/energy_model.h>
> > >  #include <linux/sched/cpufreq.h>
> > >  #include <trace/events/power.h>
> > >  
> > > @@ -153,6 +154,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> > >  
> > >  	freq = map_util_freq(util, freq, max);
> > >  
> > > +	/* Avoid inefficient performance states */
> > > +	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);
> > > +
> > >  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> > >  		return sg_policy->next_freq;
> > >  
> > 
> > This seems somewhat unfortunate, it adds a loop over the OPPs only to
> > then call into cpufreq to do the exact same thing again :/
> 
> And that's why I feel it needs to be done at a single place, either disable the
> OPP (which seems like a bad option based on what Lukasz and Vincent said
> earlier), or make changes in the cpufreq core itself to search for the best
> frequency (like adding another API to mark some frequencies as inefficient, and
> take that into account while selecting next freq).
> 
> There is a potential of ending up selecting the wrong frequency here because
> there are too many decision making bodies here and so corner cases.
> 
> -- 
> viresh

Hi Viresh,

Seems like no one has been really convinced about the arguments in favor of
keeping inefficiencies into EM :) Let me then give a shot with marking the OPPs
for the next version.

-- 
Vincent

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08DC360EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhDOPR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:17:59 -0400
Received: from foss.arm.com ([217.140.110.172]:48866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236724AbhDOPPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:15:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22208106F;
        Thu, 15 Apr 2021 08:14:50 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEF823FA35;
        Thu, 15 Apr 2021 08:14:48 -0700 (PDT)
Date:   Thu, 15 Apr 2021 16:14:46 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <20210415151446.GC391924@e120877-lin.cambridge.arm.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
 <YHg8s4VTQdiBNOpr@google.com>
 <20210415143453.GB391924@e120877-lin.cambridge.arm.com>
 <YHhU6pb8E5W2eeCX@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHhU6pb8E5W2eeCX@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 02:59:54PM +0000, Quentin Perret wrote:
> On Thursday 15 Apr 2021 at 15:34:53 (+0100), Vincent Donnefort wrote:
> > On Thu, Apr 15, 2021 at 01:16:35PM +0000, Quentin Perret wrote:
> > > On Thursday 08 Apr 2021 at 18:10:29 (+0100), Vincent Donnefort wrote:
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -10,6 +10,7 @@
> > > >  
> > > >  #include "sched.h"
> > > >  
> > > > +#include <linux/energy_model.h>
> > > >  #include <linux/sched/cpufreq.h>
> > > >  #include <trace/events/power.h>
> > > >  
> > > > @@ -164,6 +165,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> > > >  
> > > >  	freq = map_util_freq(util, freq, max);
> > > >  
> > > > +	/* Avoid inefficient performance states */
> > > > +	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);
> > > 
> > > I remember this was discussed when Douglas sent his patches some time
> > > ago, but I still find it sad we index the EM table here but still
> > > re-index the cpufreq frequency table later :/
> > > 
> > > Yes in your case this lookup is very inexpensive, but still. EAS relies
> > > on the EM's table matching cpufreq's accurately, so this second lookup
> > > still feels rather unnecessary ...
> > 
> > To get only a single lookup, we would need to bring the inefficiency knowledge
> > directly to the cpufreq framework. But it has its own limitations: 
> > 
> >   The cpufreq driver can have its own resolve_freq() callback, which means that
> >   not all the drivers would benefit from that feature.
> > 
> >   The cpufreq_table can be ordered and accessed in several ways which brings
> >   many combinations that would need to be supported, ending-up with something
> >   much more intrusive. (We can though decide to limit the feature to the low to
> >   high access that schedutil needs).
> > 
> > As the EM needs schedutil to exist anyway, it seemed to be the right place for
> > this code. It allows any cpufreq driver to benefit from the feature, simplify a
> > potential extension for a usage by devfreq devices and as a bonus it speeds-up
> > energy computing, allowing a more complex Energy Model.
> 
> I was thinking of something a bit simpler. cpufreq_driver_resolve_freq
> appears to be used only from schedutil (why is it even then?), so we
> could just pull it into cpufreq_schedutil.c and just plain skip the call
> to cpufreq_frequency_table_target if the target freq has been indexed in
> the EM table -- it should already be matching a real OPP.
> 
> Thoughts?
> Quentin

Can try that for a V2. That means em_pd_get_efficient_freq() would have to
know about policy clamping (but I don't think that's an issue) and probably
we still have to do the frequency resolution if the driver declared the
resolve_freq callback?

-- 
Vincent

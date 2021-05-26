Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34339391341
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhEZJDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:03:22 -0400
Received: from foss.arm.com ([217.140.110.172]:41914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233245AbhEZJDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:03:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD43D1516;
        Wed, 26 May 2021 02:01:49 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51293F73D;
        Wed, 26 May 2021 02:01:48 -0700 (PDT)
Date:   Wed, 26 May 2021 10:01:42 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 0/3] EM / PM: Inefficient OPPs
Message-ID: <20210526090141.GA408481@e120877-lin.cambridge.arm.com>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <20210526034751.5fl4kekq73gqy2wq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526034751.5fl4kekq73gqy2wq@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 09:17:51AM +0530, Viresh Kumar wrote:
> On 21-05-21, 17:54, Vincent Donnefort wrote:
> > We (Power team in Arm) are working with an experimental kernel for the
> > Google's Pixel4 to evaluate and improve the current mainline performance
> > and energy consumption on a real life device with Android.
> > 
> > The SD855 SoC found in this phone has several OPPs that are inefficient.
> > I.e. despite a lower frequency, they have a greater cost. (That cost being 
> > fmax * OPP power / OPP freq). This issue is twofold. First of course,
> > running a specific workload at an inefficient OPP is counterproductive
> > since it wastes wasting energy. But also, inefficient OPPs make a
> > performance domain less appealing for task placement than it really is.
> > 
> > We evaluated the change presented here by running 30 iterations of Android 
> > PCMark "Work 2.0 Performance". While we did not see any statistically
> > significant performance impact, this change allowed to drastically improve 
> > the idle time residency.   
> >  
> > 
> >                            |   Running   |  WFI [1]  |    Idle   |
> >    ------------------------+-------------+-----------+-----------+
> >    Little cluster (4 CPUs) |    -0.35%   |   +0.35%  |   +0.79%  |
> >    ------------------------+-------------+-----------+-----------+
> >    Medium cluster (3 CPUs) |    -6.3%    |    -18%   |    +12%   |
> >    ------------------------+-------------+-----------+-----------+
> >    Big cluster    (1 CPU)  |    -6.4%    |    -6.5%  |    +2.8%  |
> >    ------------------------+-------------+-----------+-----------+
> > 
> > On the SD855, the inefficient OPPs are found on the little cluster. By
> > removing them from the Energy Model, we make the most efficient CPUs more
> > appealing for task placement, helping to reduce the running time for the
> > medium and big CPUs. Increasing idle time is crucial for this platform due 
> > to the substantial energy cost differences among the clusters. Also,
> > despite not appearing in the statistics (the idle driver used here doesn't 
> > report it), we can speculate that we also improve the cluster idle time.
> 
> First of all, sorry about not replying earlier. I have seen this earlier and was
> shying away to receive some feedback from Rafael/Peter instead :(

No worries at all, thanks for your comments!

> 
> I think the problem you mention is genuine, I have realized it in the past,
> discussed with Vincent Guittot (cc'd) but never was able to get to a proper
> solution as the EM model wasn't there then.
> 
> I have seen your approach (from top level) and I feel maybe we can improve upon
> the whole idea a bit, lemme know what you think. The problem I see with this
> approach is the unnecessary updates to schedutil that this series makes, which
> IMHO is the wrong thing to do. Schedutil isn't the only governor and such
> changes will end up making the performance delta between ondemand and schedutil
> even more (difference based on their core design philosophy is fine, but these
> are improvements which each of them should enjoy). And if another governor wants
> these smart decisions to be added there, then it is trouble again.

I originally considered to add the inefficient knowledge into the CPUFreq table.
But I then gave up the idea for two reasons:

  * The EM depends on having schedutil enabled. I don't think that any
    other governor would then manage to rely on the inefficient OPPs. (also I
    believe Peter had a plan to keep schedutil as the one and only governor)

  * The CPUfreq driver doesn't have to rely on the CPUfreq table, if the
    knowledge about inefficient OPPs is into the latter, some drivers might not
    be able to rely on the feature (you might say 'their loss' though :)) 

For those reasons, I thought that adding inefficient support into the
CPUfreq table would complexify a lot the patchset for no functional gain. 

> 
> Since the whole thing depends on EM and OPPs, I think we can actually do this.
> 
> When the cpufreq driver registers with the EM core, lets find all the
> Inefficient OPPs and disable them once and for all. Of course, this must be done
> on voluntarily basis, a flag from the drivers will do. With this, we won't be
> required to update any thing at any of the governors end.

We still need to keep the inefficient OPPs for thermal reason. But if we go with
the inefficiency support into the CPUfreq table, we could enable or disable
them, depending on the thermal pressure. Or add a flag to read the table with or
without inefficient OPPs?


> 
> Will that work ?
> 
> -- 
> viresh


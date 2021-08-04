Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81163DFF5E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 12:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbhHDKWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 06:22:52 -0400
Received: from outbound-smtp61.blacknight.com ([46.22.136.249]:33327 "EHLO
        outbound-smtp61.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235522AbhHDKWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 06:22:51 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id 0E485FAA38
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 11:22:38 +0100 (IST)
Received: (qmail 3488 invoked from network); 4 Aug 2021 10:22:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Aug 2021 10:22:37 -0000
Date:   Wed, 4 Aug 2021 11:22:36 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        yangyicong <yangyicong@huawei.com>
Subject: Re: [PATCH 7/9] sched/fair: Enforce proportional scan limits when
 scanning for an idle core
Message-ID: <20210804102236.GB6464@techsingularity.net>
References: <20210726102247.21437-1-mgorman@techsingularity.net>
 <20210726102247.21437-8-mgorman@techsingularity.net>
 <58167022b9074ed9951b09ab6ba1983e@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <58167022b9074ed9951b09ab6ba1983e@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 10:52:01AM +0000, Song Bao Hua (Barry Song) wrote:
> > @@ -6265,30 +6265,35 @@ static int select_idle_cpu(struct task_struct *p, struct
> > sched_domain *sd, bool
> >  		if (has_idle_core) {
> >  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >  			if ((unsigned int)i < nr_cpumask_bits)
> > -				return i;
> > +				break;
> > 
> > +			nr -= sched_smt_weight;
> >  		} else {
> > -			if (!--nr)
> > -				return -1;
> >  			idle_cpu = __select_idle_cpu(cpu, p);
> >  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >  				break;
> > +			nr--;
> >  		}
> > +
> > +		if (nr < 0)
> > +			break;
> >  	}
> > 
> > -	if (has_idle_core)
> > -		set_idle_cores(target, false);
> > +	if ((unsigned int)idle_cpu < nr_cpumask_bits) {
> > +		if (has_idle_core)
> > +			set_idle_cores(target, false);
> > 
> 
> For example, if we have 16 cpus(8 SMT2 cores). In case core7 is idle,
> we only have scanned core0+core1(cpu0-cpu3) and if these two cores
> are not idle, but here we set has_idle_cores to false while core7 is
> idle. It seems incorrect.
> 

Yep, that block needs to be revisited.

-- 
Mel Gorman
SUSE Labs

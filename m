Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6377B388066
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244434AbhERTUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:20:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:30432 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231236AbhERTUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:20:36 -0400
IronPort-SDR: yefRBjB4Gbezpq9sYsNq1XZ3C/kB67bmXikZPC+hRbXx69HbN+bxABpW3DHYePEiGiO/QFIFqZ
 optvH9Qlq0yw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200853058"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200853058"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 12:19:17 -0700
IronPort-SDR: DJy+dG4acGWZ/pnQcyj4vW8vSg7laDG1idsQ1fvp2o9yqUG9G6x5lbtntzhh5D16eMTKhD+Zw5
 OBkgG9CTg2mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="473959059"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 18 May 2021 12:19:17 -0700
Date:   Tue, 18 May 2021 12:18:28 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 4/6] sched/fair: Carve out logic to mark a group for
 asymmetric packing
Message-ID: <20210518191828.GC15251@ranerica-svr.sc.intel.com>
References: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
 <20210513154909.6385-5-ricardo.neri-calderon@linux.intel.com>
 <51599adc-d7e6-9d29-9c17-a49e0c2e315e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51599adc-d7e6-9d29-9c17-a49e0c2e315e@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 04:21:36PM +0200, Dietmar Eggemann wrote:
> On 13/05/2021 17:49, Ricardo Neri wrote:
> 
> [...]
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c8c04e9d0d3b..c8b66a5d593e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8447,6 +8447,20 @@ group_type group_classify(unsigned int imbalance_pct,
> >  	return group_has_spare;
> >  }
> >  
> > +static inline bool
> > +sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
> > +	   struct sched_group *group)
> > +{
> > +	/*
> > +	 * Because sd->groups starts with the local group, anything that isn't
> > +	 * the local group will have access to the local state.
> > +	 */
> > +	if (group == sds->local)
> > +		return false;
> 
> sched_asym() is called under if(!local_group ...) from
> update_sg_lb_stats(). So why checking this here again?

This is true. It looks to me that this check is not needed. I makes
sense to me to keep the check in update_sg_lb_stats() so that we can
avoid the extra checks, right?

Thanks and BR,
Ricardo

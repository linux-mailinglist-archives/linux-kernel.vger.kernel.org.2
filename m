Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F751407DA7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbhILNaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 09:30:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:45139 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235178AbhILNae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 09:30:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10104"; a="243776836"
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="scan'208";a="243776836"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 06:29:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="scan'208";a="542372164"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Sep 2021 06:29:15 -0700
Date:   Sun, 12 Sep 2021 21:29:14 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [memcg] 45208c9105: aim7.jobs-per-min -14.0% regression
Message-ID: <20210912132914.GA56674@shbuild999.sh.intel.com>
References: <20210902215504.dSSfDKJZu%akpm@linux-foundation.org>
 <20210905124439.GA15026@xsang-OptiPlex-9020>
 <CALvZod77aP7qdwc5FkaZJf4FikeD0NwSuoJB4N94Uf0yqZFQpQ@mail.gmail.com>
 <20210907033000.GA88160@shbuild999.sh.intel.com>
 <CALvZod6M_sySPM1KaWzb=tkLxXJksVDrSheckXaiBpMC3cNeqw@mail.gmail.com>
 <20210912111756.4158-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912111756.4158-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 07:17:56PM +0800, Hillf Danton wrote:
[...]
> > +//	if (!(__this_cpu_inc_return(stats_flush_threshold) % MEMCG_CHARGE_BATCH))
> > +	if (!(__this_cpu_inc_return(stats_flush_threshold) % 128))
> >  		queue_work(system_unbound_wq, &stats_flush_work);
> >  }
> 
> Hi Feng,
> 
> Would you please check if it helps fix the regression to avoid queuing a
> queued work by adding and checking an atomic counter.
 
Hi Hillf,

I just tested your patch, and it didn't recover the regression, but
just reduced it from -14% to around -13%, similar to the patch
increasing the batch charge number.

Thanks,
Feng


> Hillf
> 
> --- x/mm/memcontrol.c
> +++ y/mm/memcontrol.c
> @@ -108,6 +108,7 @@ static void flush_memcg_stats_dwork(stru
>  static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
>  static void flush_memcg_stats_work(struct work_struct *w);
>  static DECLARE_WORK(stats_flush_work, flush_memcg_stats_work);
> +static atomic_t sfwork_queued;
>  static DEFINE_PER_CPU(unsigned int, stats_flush_threshold);
>  static DEFINE_SPINLOCK(stats_flush_lock);
>  
> @@ -660,8 +661,13 @@ void __mod_memcg_lruvec_state(struct lru
>  
>  	/* Update lruvec */
>  	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
> -	if (!(__this_cpu_inc_return(stats_flush_threshold) % MEMCG_CHARGE_BATCH))
> -		queue_work(system_unbound_wq, &stats_flush_work);
> +	if (!(__this_cpu_inc_return(stats_flush_threshold) %
> +	      MEMCG_CHARGE_BATCH)) {
> +		int queued = atomic_read(&sfwork_queued);
> +
> +		if (!queued && atomic_try_cmpxchg(&sfwork_queued, &queued, 1))
> +			queue_work(system_unbound_wq, &stats_flush_work);
> +	}
>  }
>  
>  /**
> @@ -5376,6 +5382,7 @@ static void flush_memcg_stats_dwork(stru
>  static void flush_memcg_stats_work(struct work_struct *w)
>  {
>  	mem_cgroup_flush_stats();
> +	atomic_dec(&sfwork_queued);
>  }
>  
>  static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)

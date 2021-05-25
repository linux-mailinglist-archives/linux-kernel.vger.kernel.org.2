Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9273906FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhEYQ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:59:10 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62602 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232245AbhEYQ7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:59:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621961859; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=rwuOErPk0jcYAwuz28Xy2MczIBvEFHpne+OTclHoSeA=;
 b=iQMxP8I2LO3+lRn906ojJeiRb4du0BO0yeBNJBIA8e3xL0Mm79dXnBK3ll7KWm+7ZMUkUAcQ
 StgNTrkiyGSjcvp151l48QPsL9sKjYaEtgFtW22Ot18+UT+DdPOwk6045xw/MtNhOPotL/0U
 8NMhZW6T2lPzuFe4XXipjDZI1mc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60ad2c7e7b5af81b5cd1eaf3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 May 2021 16:57:34
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C404BC433F1; Tue, 25 May 2021 16:57:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 823BFC4338A;
        Tue, 25 May 2021 16:57:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 May 2021 09:57:32 -0700
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Laura Abbott <labbott@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [mm]  8cc621d2f4:  fio.write_iops -21.8% regression
In-Reply-To: <YK0oQ76zX0uVZCwQ@google.com>
References: <20210520083144.GD14190@xsang-OptiPlex-9020>
 <YKasEeXCr9R5yzCr@google.com>
 <45f761de51d514f77cc48214846c5f8f@codeaurora.org>
 <YK0Us01mBTRWOQIw@google.com> <YK0oQ76zX0uVZCwQ@google.com>
Message-ID: <5abc4469d16535119818e8e72173398d@codeaurora.org>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-25 09:39, Minchan Kim wrote:
> On Tue, May 25, 2021 at 08:16:03AM -0700, Minchan Kim wrote:
> 
> < snip >
> 
>> > > On Thu, May 20, 2021 at 04:31:44PM +0800, kernel test robot wrote:
>> > > >
>> > > >
>> > > > Greeting,
>> > > >
>> > > > FYI, we noticed a -21.8% regression of fio.write_iops due to commit:
>> > > >
>> > > >
>> > > > commit: 8cc621d2f45ddd3dc664024a647ee7adf48d79a5 ("mm: fs:
>> > > > invalidate BH LRU during page migration")
>> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>> > > >
>> > > >
>> > > > in testcase: fio-basic
>> > > > on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU
>> > > > @ 2.10GHz with 256G memory
>> > > > with following parameters:
>> > > >
>> > > > 	disk: 2pmem
>> > > > 	fs: ext4
>> > > > 	runtime: 200s
>> > > > 	nr_task: 50%
>> > > > 	time_based: tb
>> > > > 	rw: randwrite
>> > > > 	bs: 4k
>> > > > 	ioengine: libaio
>> > > > 	test_size: 200G
>> > > > 	cpufreq_governor: performance
>> > > > 	ucode: 0x5003006
>> > > >
>> > > > test-description: Fio is a tool that will spawn a number of threads
>> > > > or processes doing a particular type of I/O action as specified by
>> > > > the user.
>> > > > test-url: https://github.com/axboe/fio
>> > > >
>> > > >
>> > > >
>> > > > If you fix the issue, kindly add following tag
>> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
>> > > >
>> > > >
>> > > > Details are as below:
>> > > > -------------------------------------------------------------------------------------------------->
>> > > >
>> > > >
>> > > > To reproduce:
>> > > >
>> > > >         git clone https://github.com/intel/lkp-tests.git
>> > > >         cd lkp-tests
>> > > >         bin/lkp install                job.yaml  # job file is
>> > > > attached in this email
>> > > >         bin/lkp split-job --compatible job.yaml  # generate the yaml
>> > > > file for lkp run
>> > > >         bin/lkp run                    generated-yaml-file
>> > >
>> > > Hi,
>> > >
>> > > I tried to insall the lkp-test in my machine by following above guide
>> > > but failed
>> > > due to package problems(I guess it's my problem since I use something
>> > > particular
>> > > environement). However, I guess it comes from increased miss ratio of
>> > > bh_lrus
>> > > since the patch caused more frequent invalidation of the bh_lrus calls
>> > > compared
>> > > to old. For example, lru_add_drain could be called from several hot
>> > > places(e.g.,
>> > > unmap and pagevec_release from several path) and it could keeps
>> > > invalidating
>> > > bh_lrus.
>> > >
>> > > IMO, we should move the overhead from such hot path to cold one. How
>> > > about this?
>> > >
>> > > From ebf4ede1cf32fb14d85f0015a3693cb8e1b8dbfe Mon Sep 17 00:00:00 2001
>> > > From: Minchan Kim <minchan@kernel.org>
>> > > Date: Thu, 20 May 2021 11:17:56 -0700
>> > > Subject: [PATCH] invalidate bh_lrus only at lru_add_drain_all
>> > >
>> > > Not-Yet-Signed-off-by: Minchan Kim <minchan@kernel.org>
>> > > ---
>> > >  mm/swap.c | 15 +++++++++++++--
>> > >  1 file changed, 13 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/mm/swap.c b/mm/swap.c
>> > > index dfb48cf9c2c9..d6168449e28c 100644
>> > > --- a/mm/swap.c
>> > > +++ b/mm/swap.c
>> > > @@ -642,7 +642,6 @@ void lru_add_drain_cpu(int cpu)
>> > >  		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
>> > >
>> > >  	activate_page_drain(cpu);
>> > > -	invalidate_bh_lrus_cpu(cpu);
>> > >  }
>> > >
>> > >  /**
>> > > @@ -725,6 +724,17 @@ void lru_add_drain(void)
>> > >  	local_unlock(&lru_pvecs.lock);
>> > >  }
>> > >
>> > > +void lru_and_bh_lrus_drain(void)
>> > > +{
>> > > +	int cpu;
>> > > +
>> > > +	local_lock(&lru_pvecs.lock);
>> > > +	cpu = smp_processor_id();
>> > > +	lru_add_drain_cpu(cpu);
>> > > +	local_unlock(&lru_pvecs.lock);
>> > > +	invalidate_bh_lrus_cpu(cpu);
>> > > +}
>> > > +
>> >
>> > Nit: drop int cpu?
>> 
>> Do you mean to suggest using smp_processor_id at both places
>> instead of local varaible? Since the invalidate_bh_lrus_cpu
>> is called out of the lru_pvecs.lock, I wanted to express
>> the draining happens at the same CPU via storing the CPU.
>> 
>> >
>> > >  void lru_add_drain_cpu_zone(struct zone *zone)
>> > >  {
>> > >  	local_lock(&lru_pvecs.lock);
>> > > @@ -739,7 +749,7 @@ static DEFINE_PER_CPU(struct work_struct,
>> > > lru_add_drain_work);
>> > >
>> > >  static void lru_add_drain_per_cpu(struct work_struct *dummy)
>> > >  {
>> > > -	lru_add_drain();
>> > > +	lru_and_bh_lrus_drain();
>> > >  }
>> > >
>> > >  /*
>> > > @@ -881,6 +891,7 @@ void lru_cache_disable(void)
>> > >  	__lru_add_drain_all(true);
>> > >  #else
>> > >  	lru_add_drain();
>> > > +	invalidate_bh_lrus_cpu(smp_processor_id());
>> > >  #endif
>> > >  }
>> >
>> > Can't we replace the call to lru_add_drain() and
>> > invalidate_bh_lrus_cpu(smp_processor_id()) with a single call to
>> > lru_and_bh_lrus_drain()?
>> 
>> Good idea.
> 
> From 8caadeb49d82403a08643dfbdb0b7749017c00bb Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Tue, 25 May 2021 08:19:17 -0700
> Subject: [PATCH] mm: fs: invalidate bh_lrus for only cold path
> 
> kernel test robot reported the regression of fio.write_iops[1]
> with [2].
> 
> Since lru_add_drain is called frequently, invalidate bh_lrus
> there could increase bh_lrus cache miss ratio, which needs
> more IO in the end.
> 
> This patch moves the bh_lrus invalidation from the hot path(
> e.g., zap_page_range, pagevec_release) to cold path(i.e.,
> lru_add_drain_all, lru_cache_disable).
> 
> [1] 
> https://lore.kernel.org/lkml/20210520083144.GD14190@xsang-OptiPlex-9020/
> [2] 8cc621d2f45d, mm: fs: invalidate BH LRU during page migration
> Cc: Xing, Zhengjun <zhengjun.xing@intel.com>
> Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/swap.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 1958d5feb148..3e25d99a9dbb 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -642,7 +642,6 @@ void lru_add_drain_cpu(int cpu)
>  		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
> 
>  	activate_page_drain(cpu);
> -	invalidate_bh_lrus_cpu(cpu);
>  }
> 
>  /**
> @@ -725,6 +724,17 @@ void lru_add_drain(void)
>  	local_unlock(&lru_pvecs.lock);
>  }
> 
> +static void lru_add_and_bh_lrus_drain(void)
> +{
> +	int cpu;
> +
> +	local_lock(&lru_pvecs.lock);
> +	cpu = smp_processor_id();
> +	lru_add_drain_cpu(cpu);
> +	local_unlock(&lru_pvecs.lock);
> +	invalidate_bh_lrus_cpu(cpu);
> +}
> +
>  void lru_add_drain_cpu_zone(struct zone *zone)
>  {
>  	local_lock(&lru_pvecs.lock);
> @@ -739,7 +749,7 @@ static DEFINE_PER_CPU(struct work_struct,
> lru_add_drain_work);
> 
>  static void lru_add_drain_per_cpu(struct work_struct *dummy)
>  {
> -	lru_add_drain();
> +	lru_add_and_bh_lrus_drain();
>  }
> 
>  /*
> @@ -880,7 +890,7 @@ void lru_cache_disable(void)
>  	 */
>  	__lru_add_drain_all(true);
>  #else
> -	lru_add_drain();
> +	lru_add_and_bh_lrus_drain();
>  #endif
>  }

Feel free to add:
Reviewed-by: Chris Goldsworthy <cgoldswo@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FA23D081C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 07:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhGUEbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 00:31:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42959 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232877AbhGUEaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 00:30:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626844283; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=6/tzE+Rdvx7qE2xKE4duh7usV101nQNMue6qbv72j+4=;
 b=Ftyc19hTUiyLuNY43iL6PI8HJCXowPKKV9s792KHm/MUqrRWYjWCPi6/I6hw3IlLIXAlusfz
 Usu4KZx8cwiKJyTz7pohdtAahOHHAfRti1eMklzla8RtS+JaNt34y/teyHmmgGzXWIAVfn5k
 QS+EZlKU549crZGQBQ/zu45oZIo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60f7ac6de31d882d182c90af (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 05:11:09
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 174D9C43217; Wed, 21 Jul 2021 05:11:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1779C433D3;
        Wed, 21 Jul 2021 05:11:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Jul 2021 22:11:03 -0700
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Laura Abbott <labbott@kernel.org>,
        Oliver Sang <oliver.sang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, linux-mm <linux-mm@kvack.org>,
        Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [PATCH v2] mm: fs: invalidate bh_lrus for only cold path
In-Reply-To: <YM0YjgpBpSqnrWQH@google.com>
References: <20210601145425.1396981-1-minchan@kernel.org>
 <20210601161540.9f449314965bd94c84725481@linux-foundation.org>
 <YLgKI4CdGDKOCDHU@google.com>
 <e126cd8c99440b100c61c4a792aeccd0@codeaurora.org>
 <YM0YjgpBpSqnrWQH@google.com>
Message-ID: <996ee883ce7644e0238b37799f025f16@codeaurora.org>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-18 15:05, Minchan Kim wrote:
> On Wed, Jun 09, 2021 at 01:52:46PM -0700, Chris Goldsworthy wrote:
>> On 2021-06-02 15:45, Minchan Kim wrote:
>> > On Tue, Jun 01, 2021 at 04:15:40PM -0700, Andrew Morton wrote:
>> > > On Tue,  1 Jun 2021 07:54:25 -0700 Minchan Kim <minchan@kernel.org>
>> > > wrote:
>> > >
>> > > > kernel test robot reported the regression of fio.write_iops[1]
>> > > > with [2].
>> > > >
>> > > > Since lru_add_drain is called frequently, invalidate bh_lrus
>> > > > there could increase bh_lrus cache miss ratio, which needs
>> > > > more IO in the end.
>> > > >
>> > > > This patch moves the bh_lrus invalidation from the hot path(
>> > > > e.g., zap_page_range, pagevec_release) to cold path(i.e.,
>> > > > lru_add_drain_all, lru_cache_disable).
>> > >
>> > > This code is starting to hurt my brain.
>> > >
>> > > What are the locking/context rules for invalidate_bh_lrus_cpu()?
>> >
>> >
>> > > AFAICT it offers no protection against two CPUs concurrently running
>> > > __invalidate_bh_lrus() against the same bh_lru.
>> >
>> > The lru_add_drain_per_cpu will run on per-cpu since it's per-cpu work
>> > and invalidate_bh_lrus_cpu will run under bh_lru_lock so I couldn't
>> > imagine that race can happen.
>> >
>> > >
>> > > So when CONFIG_SMP=y, invalidate_bh_lrus_cpu() must always and only be
>> > > run on the cpu which owns the bh_lru.  In which case why does it have
>> > > the `cpu' arg?
>> >
>> > I just wanted to express both lru_add_drain_cpu and
>> > invalidate_bh_lrus_cpu
>> > in lru_add_and_bh_lrus_drain run in the same cpu but look like a bad
>> > idea
>> > since it makes people confused. Let me remove the cpu argument from
>> > invalidate_bh_lrus_cpu.
>> >
>> > >
>> > > Your new lru_add_and_bh_lrus_drain() follows these rules by calling
>> > > invalidate_bh_lrus_cpu() from a per-cpu worker or when CONFIG_SMP=n.
>> > >
>> > > I think.  It's all as clear as mud and undocumented.  Could you please
>> > > take a look at this?  Comment the locking/context rules thoroughly and
>> > > check that they are being followed?  Not forgetting cpu hotplug...
>> > > See if
>> > > there's a way of simplifying/clarifying the code?
>> > >
>> > > The fact that swap.c has those #ifdef CONFIG_SMPs in there is a hint
>> > > that we're doing something wrong (or poorly) in there.  Perhaps that's
>> > > unavoidable because of all the fancy footwork in
>> > > __lru_add_drain_all().
>> > >
>> >
>> > Hopefully, this is better.
>> >
>> > From 8d58e7ade3ed6c080995dec1395b1e130b3d16b3 Mon Sep 17 00:00:00 2001
>> > From: Minchan Kim <minchan@kernel.org>
>> > Date: Tue, 25 May 2021 08:19:17 -0700
>> > Subject: [PATCH] mm: fs: invalidate bh_lrus for only cold path
>> >
>> > kernel test robot reported the regression of fio.write_iops[1]
>> > with [2].
>> >
>> > Since lru_add_drain is called frequently, invalidate bh_lrus
>> > there could increase bh_lrus cache miss ratio, which needs
>> > more IO in the end.
>> >
>> > This patch moves the bh_lrus invalidation from the hot path(
>> > e.g., zap_page_range, pagevec_release) to cold path(i.e.,
>> > lru_add_drain_all, lru_cache_disable).
>> >
>> > [1]
>> > https://lore.kernel.org/lkml/20210520083144.GD14190@xsang-OptiPlex-9020/
>> > [2] 8cc621d2f45d, mm: fs: invalidate BH LRU during page migration
>> > Reported-by: kernel test robot <oliver.sang@intel.com>
>> > Signed-off-by: Minchan Kim <minchan@kernel.org>
>> > ---
>> >  fs/buffer.c                 |  8 ++++++--
>> >  include/linux/buffer_head.h |  4 ++--
>> >  mm/swap.c                   | 19 ++++++++++++++++---
>> >  3 files changed, 24 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/fs/buffer.c b/fs/buffer.c
>> > index 673cfbef9eec..bdaffed39030 100644
>> > --- a/fs/buffer.c
>> > +++ b/fs/buffer.c
>> > @@ -1487,12 +1487,16 @@ void invalidate_bh_lrus(void)
>> >  }
>> >  EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
>> >
>> > -void invalidate_bh_lrus_cpu(int cpu)
>> > +/*
>> > + * It's called from workqueue context so we need a bh_lru_lock to close
>> > + * the race with preemption/irq.
>> > + */
>> > +void invalidate_bh_lrus_cpu(void)
>> >  {
>> >  	struct bh_lru *b;
>> >
>> >  	bh_lru_lock();
>> > -	b = per_cpu_ptr(&bh_lrus, cpu);
>> > +	b = this_cpu_ptr(&bh_lrus);
>> >  	__invalidate_bh_lrus(b);
>> >  	bh_lru_unlock();
>> >  }
>> > diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
>> > index e7e99da31349..b04d34bab124 100644
>> > --- a/include/linux/buffer_head.h
>> > +++ b/include/linux/buffer_head.h
>> > @@ -194,7 +194,7 @@ void __breadahead_gfp(struct block_device *,
>> > sector_t block, unsigned int size,
>> >  struct buffer_head *__bread_gfp(struct block_device *,
>> >  				sector_t block, unsigned size, gfp_t gfp);
>> >  void invalidate_bh_lrus(void);
>> > -void invalidate_bh_lrus_cpu(int cpu);
>> > +void invalidate_bh_lrus_cpu(void);
>> >  bool has_bh_in_lru(int cpu, void *dummy);
>> >  struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
>> >  void free_buffer_head(struct buffer_head * bh);
>> > @@ -408,7 +408,7 @@ static inline int inode_has_buffers(struct inode
>> > *inode) { return 0; }
>> >  static inline void invalidate_inode_buffers(struct inode *inode) {}
>> >  static inline int remove_inode_buffers(struct inode *inode) { return 1;
>> > }
>> >  static inline int sync_mapping_buffers(struct address_space *mapping)
>> > { return 0; }
>> > -static inline void invalidate_bh_lrus_cpu(int cpu) {}
>> > +static inline void invalidate_bh_lrus_cpu(void) {}
>> >  static inline bool has_bh_in_lru(int cpu, void *dummy) { return 0; }
>> >  #define buffer_heads_over_limit 0
>> >
>> > diff --git a/mm/swap.c b/mm/swap.c
>> > index 1958d5feb148..4d9ec3c3c5a9 100644
>> > --- a/mm/swap.c
>> > +++ b/mm/swap.c
>> > @@ -642,7 +642,6 @@ void lru_add_drain_cpu(int cpu)
>> >  		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
>> >
>> >  	activate_page_drain(cpu);
>> > -	invalidate_bh_lrus_cpu(cpu);
>> >  }
>> >
>> >  /**
>> > @@ -725,6 +724,20 @@ void lru_add_drain(void)
>> >  	local_unlock(&lru_pvecs.lock);
>> >  }
>> >
>> > +/*
>> > + * It's called from per-cpu workqueue context in SMP case so
>> > + * lru_add_drain_cpu and invalidate_bh_lrus_cpu should run on
>> > + * the same cpu. It shouldn't be a problem in !SMP case since
>> > + * the core is only one and the locks will disable preemption.
>> > + */
>> > +static void lru_add_and_bh_lrus_drain(void)
>> > +{
>> > +	local_lock(&lru_pvecs.lock);
>> > +	lru_add_drain_cpu(smp_processor_id());
>> > +	local_unlock(&lru_pvecs.lock);
>> > +	invalidate_bh_lrus_cpu();
>> > +}
>> > +
>> >  void lru_add_drain_cpu_zone(struct zone *zone)
>> >  {
>> >  	local_lock(&lru_pvecs.lock);
>> > @@ -739,7 +752,7 @@ static DEFINE_PER_CPU(struct work_struct,
>> > lru_add_drain_work);
>> >
>> >  static void lru_add_drain_per_cpu(struct work_struct *dummy)
>> >  {
>> > -	lru_add_drain();
>> > +	lru_add_and_bh_lrus_drain();
>> >  }
>> >
>> >  /*
>> > @@ -880,7 +893,7 @@ void lru_cache_disable(void)
>> >  	 */
>> >  	__lru_add_drain_all(true);
>> >  #else
>> > -	lru_add_drain();
>> > +	lru_add_and_bh_lrus_drain();
>> >  #endif
>> >  }
>> 
>> Hi Minchan,
>> 
>> This looks good to me.  Feel free to add:
>> 
>> Reviewed-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
> 
> Thanks for the review, Chris.
> 
> Andrew, could you take a look?

Hi Andrew,

Have you been able to look over the second version of Minchan's patch?

Thanks,

Chris.

-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2526D3AD4C8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 00:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhFRWHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 18:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbhFRWHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 18:07:17 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83698C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 15:05:06 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id u190so5126416pgd.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 15:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zeWNXtlTtZVbgTH3kogn8dA4F3kwdNm0zCJhzUMhEdc=;
        b=O0vOpXIEHlTXLKdS7Q75XgfYnBHVEihPNwJwoC7H90emumVJgJLaBYFCoLDqfVT614
         MzJc8l/HhU/bGVXPI42QQmHbtEXeEAzrbsfNl1wf3oZNxQHkLAejpzhr6IV/voWabFv4
         nnagflqOXiyWZzPahFcRCUyoqEdGqoljrHGCegGdq77NWVEixG88vMkOoGHJZQcw0N6f
         jiYaENifTubpop1k5ED1GKSfsz2r2HlnCeni/3xCdLbl64vI4Uq/LMo7scVJ1OLn6Jyq
         DqjOcE23pNeFHpRx8Iga8gVFy2cZv1/K2B38mfkB5ehL2V1zwZRNeZBQkJ7DZrj6keN/
         UoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zeWNXtlTtZVbgTH3kogn8dA4F3kwdNm0zCJhzUMhEdc=;
        b=gugpaqS6Fsinto+c3Uf8ccGGxSteyXKFDTcZ3POnuiIzqBKtICXXs052vtqeHHYACv
         hR4ngi3ah9/k+WA+QPi2jSyQ7ksV33bIf3e4v0CnPsbm3312iC0mYng12gGqxWGZXiOf
         5UbEQco8te9sJnW0qDHtxWdwTzX+qVCEIZK81eUadxgBxb0W+0dVtvyMH8eoTSe5zzZc
         /MP5pMsOOOoHaotqvqAddgtXpLBiCc8M3avwB5LWWZsLzGeu9K+1WvSI7H8hAvrJR2PF
         UzW9PZ9pO2EY4MxKwCiCRtQ3YGn3MKXoG0h/3VTszz4LDP89GZJgZMvLOSYYX/rvxhAr
         QVRg==
X-Gm-Message-State: AOAM531j5JIRQS8FIf3WlwyB7WqVI8gmy8a+8IPUB4fkPh83Yefg147L
        JyNDPkt+NNGq6GCe8EAbwDs=
X-Google-Smtp-Source: ABdhPJzXWePpKNhUsT6cqLx3OpOY3mFMosIe/IVnStdXWsVoGlf3kWJSlVQMAEacX2OudaFmd4wcdQ==
X-Received: by 2002:aa7:8202:0:b029:2d8:c24d:841d with SMTP id k2-20020aa782020000b02902d8c24d841dmr7102633pfi.57.1624053906063;
        Fri, 18 Jun 2021 15:05:06 -0700 (PDT)
Received: from google.com (c-67-188-94-199.hsd1.ca.comcast.net. [67.188.94.199])
        by smtp.gmail.com with ESMTPSA id a9sm8653648pfo.69.2021.06.18.15.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 15:05:05 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 18 Jun 2021 15:05:02 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>
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
Message-ID: <YM0YjgpBpSqnrWQH@google.com>
References: <20210601145425.1396981-1-minchan@kernel.org>
 <20210601161540.9f449314965bd94c84725481@linux-foundation.org>
 <YLgKI4CdGDKOCDHU@google.com>
 <e126cd8c99440b100c61c4a792aeccd0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e126cd8c99440b100c61c4a792aeccd0@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 01:52:46PM -0700, Chris Goldsworthy wrote:
> On 2021-06-02 15:45, Minchan Kim wrote:
> > On Tue, Jun 01, 2021 at 04:15:40PM -0700, Andrew Morton wrote:
> > > On Tue,  1 Jun 2021 07:54:25 -0700 Minchan Kim <minchan@kernel.org>
> > > wrote:
> > > 
> > > > kernel test robot reported the regression of fio.write_iops[1]
> > > > with [2].
> > > >
> > > > Since lru_add_drain is called frequently, invalidate bh_lrus
> > > > there could increase bh_lrus cache miss ratio, which needs
> > > > more IO in the end.
> > > >
> > > > This patch moves the bh_lrus invalidation from the hot path(
> > > > e.g., zap_page_range, pagevec_release) to cold path(i.e.,
> > > > lru_add_drain_all, lru_cache_disable).
> > > 
> > > This code is starting to hurt my brain.
> > > 
> > > What are the locking/context rules for invalidate_bh_lrus_cpu()?
> > 
> > 
> > > AFAICT it offers no protection against two CPUs concurrently running
> > > __invalidate_bh_lrus() against the same bh_lru.
> > 
> > The lru_add_drain_per_cpu will run on per-cpu since it's per-cpu work
> > and invalidate_bh_lrus_cpu will run under bh_lru_lock so I couldn't
> > imagine that race can happen.
> > 
> > > 
> > > So when CONFIG_SMP=y, invalidate_bh_lrus_cpu() must always and only be
> > > run on the cpu which owns the bh_lru.  In which case why does it have
> > > the `cpu' arg?
> > 
> > I just wanted to express both lru_add_drain_cpu and
> > invalidate_bh_lrus_cpu
> > in lru_add_and_bh_lrus_drain run in the same cpu but look like a bad
> > idea
> > since it makes people confused. Let me remove the cpu argument from
> > invalidate_bh_lrus_cpu.
> > 
> > > 
> > > Your new lru_add_and_bh_lrus_drain() follows these rules by calling
> > > invalidate_bh_lrus_cpu() from a per-cpu worker or when CONFIG_SMP=n.
> > > 
> > > I think.  It's all as clear as mud and undocumented.  Could you please
> > > take a look at this?  Comment the locking/context rules thoroughly and
> > > check that they are being followed?  Not forgetting cpu hotplug...
> > > See if
> > > there's a way of simplifying/clarifying the code?
> > > 
> > > The fact that swap.c has those #ifdef CONFIG_SMPs in there is a hint
> > > that we're doing something wrong (or poorly) in there.  Perhaps that's
> > > unavoidable because of all the fancy footwork in
> > > __lru_add_drain_all().
> > > 
> > 
> > Hopefully, this is better.
> > 
> > From 8d58e7ade3ed6c080995dec1395b1e130b3d16b3 Mon Sep 17 00:00:00 2001
> > From: Minchan Kim <minchan@kernel.org>
> > Date: Tue, 25 May 2021 08:19:17 -0700
> > Subject: [PATCH] mm: fs: invalidate bh_lrus for only cold path
> > 
> > kernel test robot reported the regression of fio.write_iops[1]
> > with [2].
> > 
> > Since lru_add_drain is called frequently, invalidate bh_lrus
> > there could increase bh_lrus cache miss ratio, which needs
> > more IO in the end.
> > 
> > This patch moves the bh_lrus invalidation from the hot path(
> > e.g., zap_page_range, pagevec_release) to cold path(i.e.,
> > lru_add_drain_all, lru_cache_disable).
> > 
> > [1]
> > https://lore.kernel.org/lkml/20210520083144.GD14190@xsang-OptiPlex-9020/
> > [2] 8cc621d2f45d, mm: fs: invalidate BH LRU during page migration
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  fs/buffer.c                 |  8 ++++++--
> >  include/linux/buffer_head.h |  4 ++--
> >  mm/swap.c                   | 19 ++++++++++++++++---
> >  3 files changed, 24 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 673cfbef9eec..bdaffed39030 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -1487,12 +1487,16 @@ void invalidate_bh_lrus(void)
> >  }
> >  EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
> > 
> > -void invalidate_bh_lrus_cpu(int cpu)
> > +/*
> > + * It's called from workqueue context so we need a bh_lru_lock to close
> > + * the race with preemption/irq.
> > + */
> > +void invalidate_bh_lrus_cpu(void)
> >  {
> >  	struct bh_lru *b;
> > 
> >  	bh_lru_lock();
> > -	b = per_cpu_ptr(&bh_lrus, cpu);
> > +	b = this_cpu_ptr(&bh_lrus);
> >  	__invalidate_bh_lrus(b);
> >  	bh_lru_unlock();
> >  }
> > diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> > index e7e99da31349..b04d34bab124 100644
> > --- a/include/linux/buffer_head.h
> > +++ b/include/linux/buffer_head.h
> > @@ -194,7 +194,7 @@ void __breadahead_gfp(struct block_device *,
> > sector_t block, unsigned int size,
> >  struct buffer_head *__bread_gfp(struct block_device *,
> >  				sector_t block, unsigned size, gfp_t gfp);
> >  void invalidate_bh_lrus(void);
> > -void invalidate_bh_lrus_cpu(int cpu);
> > +void invalidate_bh_lrus_cpu(void);
> >  bool has_bh_in_lru(int cpu, void *dummy);
> >  struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
> >  void free_buffer_head(struct buffer_head * bh);
> > @@ -408,7 +408,7 @@ static inline int inode_has_buffers(struct inode
> > *inode) { return 0; }
> >  static inline void invalidate_inode_buffers(struct inode *inode) {}
> >  static inline int remove_inode_buffers(struct inode *inode) { return 1;
> > }
> >  static inline int sync_mapping_buffers(struct address_space *mapping)
> > { return 0; }
> > -static inline void invalidate_bh_lrus_cpu(int cpu) {}
> > +static inline void invalidate_bh_lrus_cpu(void) {}
> >  static inline bool has_bh_in_lru(int cpu, void *dummy) { return 0; }
> >  #define buffer_heads_over_limit 0
> > 
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 1958d5feb148..4d9ec3c3c5a9 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -642,7 +642,6 @@ void lru_add_drain_cpu(int cpu)
> >  		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
> > 
> >  	activate_page_drain(cpu);
> > -	invalidate_bh_lrus_cpu(cpu);
> >  }
> > 
> >  /**
> > @@ -725,6 +724,20 @@ void lru_add_drain(void)
> >  	local_unlock(&lru_pvecs.lock);
> >  }
> > 
> > +/*
> > + * It's called from per-cpu workqueue context in SMP case so
> > + * lru_add_drain_cpu and invalidate_bh_lrus_cpu should run on
> > + * the same cpu. It shouldn't be a problem in !SMP case since
> > + * the core is only one and the locks will disable preemption.
> > + */
> > +static void lru_add_and_bh_lrus_drain(void)
> > +{
> > +	local_lock(&lru_pvecs.lock);
> > +	lru_add_drain_cpu(smp_processor_id());
> > +	local_unlock(&lru_pvecs.lock);
> > +	invalidate_bh_lrus_cpu();
> > +}
> > +
> >  void lru_add_drain_cpu_zone(struct zone *zone)
> >  {
> >  	local_lock(&lru_pvecs.lock);
> > @@ -739,7 +752,7 @@ static DEFINE_PER_CPU(struct work_struct,
> > lru_add_drain_work);
> > 
> >  static void lru_add_drain_per_cpu(struct work_struct *dummy)
> >  {
> > -	lru_add_drain();
> > +	lru_add_and_bh_lrus_drain();
> >  }
> > 
> >  /*
> > @@ -880,7 +893,7 @@ void lru_cache_disable(void)
> >  	 */
> >  	__lru_add_drain_all(true);
> >  #else
> > -	lru_add_drain();
> > +	lru_add_and_bh_lrus_drain();
> >  #endif
> >  }
> 
> Hi Minchan,
> 
> This looks good to me.  Feel free to add:
> 
> Reviewed-by: Chris Goldsworthy <cgoldswo@codeaurora.org>

Thanks for the review, Chris.

Andrew, could you take a look?

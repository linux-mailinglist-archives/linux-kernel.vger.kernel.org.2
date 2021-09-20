Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD329412B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbhIUCHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbhIUBvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD4C0DBA83
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:33:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r2so18837715pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z/W28/NoerbBQeyCW5fxWKF6vPu8l+mZANS4s2mFBUA=;
        b=YJp0BPv31UMzb/Ww6YcXbs5SenM+vjgKWv/e8kK0F7u1Z4t4w9MNv3IBJEUOttxzEc
         3Nt9VaTsCUUpf0oJradi4GcWOhrFzomZd06ZAFRznrNgtCdT9OStoyXBN2cWmNDhOBCN
         9RxWn007H82+9Xnzvv+Sr/HM3nidtcBHLW1UPCKSKJyxZqdt+CC3eVJMi3IBE76QgUjL
         E1vckwvr7nlgrt8Q2MB6UF9lUD1M38xIVVGJoS+X+NxQQC06yVmNZLiEWavtscm7+f1G
         7ulD/xcY2ii5VRKy5WgqzENjjst2mg6BoXysM8LamYZmFn5HM6LrIZRhwT7gFb+wLZv1
         rNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=z/W28/NoerbBQeyCW5fxWKF6vPu8l+mZANS4s2mFBUA=;
        b=wXxm9XoXHFTGhsHjFjht2fjSFiQrTNGU1hvPVtQEbVXjQwUhG/aY1YdM8FqNiQQs7z
         eSWs99FqsBusHgfky9c3dNN3HHh8qfdAqwBmCp1I+Et8vkbI1HEEYvSTuMpBRTb0BHZn
         Md/ghGqCcca0tdyRvpADyXAAElwZJ4Mn8YNV8bvFc11kDROcDK0meUF6fr3IinTQbwku
         1Qd+TUy1kcX2pJz+ciA0tCd37dLUnLIiPLhlnsI3QeY//Tfaarn6Jdee2IAygQRnTH1v
         CJeYZ2oC3FdLiBIH39VN19PcyZoj4qEMwkMF3GDMNKvzP9+usV9d82jJLOXA7N/qAOG9
         BOzA==
X-Gm-Message-State: AOAM5301TvbS+hIluR4VyDTtMFWmxThYpYmm0pfW6+pY5OAShqnJzjeB
        vh/r2elXxiCb5gqkBDJiK49r1lharTc=
X-Google-Smtp-Source: ABdhPJxQHVwtxgX9LJzjyHiAI215JLOAyi20GxWxTk6mBna7iaZKmXcY0ChyXinntuGCpvbHqeT1Tw==
X-Received: by 2002:aa7:959a:0:b0:43b:adeb:ef58 with SMTP id z26-20020aa7959a000000b0043badebef58mr27276778pfj.19.1632177228676;
        Mon, 20 Sep 2021 15:33:48 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:9a49:e1f0:6fe9:6fd9])
        by smtp.gmail.com with ESMTPSA id a11sm14929035pfo.31.2021.09.20.15.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:33:48 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 20 Sep 2021 15:33:45 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Laura Abbott <labbott@kernel.org>,
        Oliver Sang <oliver.sang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: Re: [PATCH v3] mm: fs: invalidate bh_lrus for only cold path
Message-ID: <YUkMSftSkXeroAxl@google.com>
References: <20210907212347.1977686-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907212347.1977686-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Could you take a look?

On Tue, Sep 07, 2021 at 02:23:47PM -0700, Minchan Kim wrote:
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
> [1] https://lore.kernel.org/lkml/20210520083144.GD14190@xsang-OptiPlex-9020/
> [2] 8cc621d2f45d, mm: fs: invalidate BH LRU during page migration
> Reviewed-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> * v2: https://lore.kernel.org/lkml/20210601145425.1396981-1-minchan@kernel.org/
> * v1: https://lore.kernel.org/lkml/YK0oQ76zX0uVZCwQ@google.com/
>  fs/buffer.c                 |  8 ++++++--
>  include/linux/buffer_head.h |  4 ++--
>  mm/swap.c                   | 19 ++++++++++++++++---
>  3 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ab7573d72dd7..c615387aedca 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1425,12 +1425,16 @@ void invalidate_bh_lrus(void)
>  }
>  EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
>  
> -void invalidate_bh_lrus_cpu(int cpu)
> +/*
> + * It's called from workqueue context so we need a bh_lru_lock to close
> + * the race with preemption/irq.
> + */
> +void invalidate_bh_lrus_cpu(void)
>  {
>  	struct bh_lru *b;
>  
>  	bh_lru_lock();
> -	b = per_cpu_ptr(&bh_lrus, cpu);
> +	b = this_cpu_ptr(&bh_lrus);
>  	__invalidate_bh_lrus(b);
>  	bh_lru_unlock();
>  }
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 6486d3c19463..36f33685c8c0 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -194,7 +194,7 @@ void __breadahead_gfp(struct block_device *, sector_t block, unsigned int size,
>  struct buffer_head *__bread_gfp(struct block_device *,
>  				sector_t block, unsigned size, gfp_t gfp);
>  void invalidate_bh_lrus(void);
> -void invalidate_bh_lrus_cpu(int cpu);
> +void invalidate_bh_lrus_cpu(void);
>  bool has_bh_in_lru(int cpu, void *dummy);
>  struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
>  void free_buffer_head(struct buffer_head * bh);
> @@ -408,7 +408,7 @@ static inline int inode_has_buffers(struct inode *inode) { return 0; }
>  static inline void invalidate_inode_buffers(struct inode *inode) {}
>  static inline int remove_inode_buffers(struct inode *inode) { return 1; }
>  static inline int sync_mapping_buffers(struct address_space *mapping) { return 0; }
> -static inline void invalidate_bh_lrus_cpu(int cpu) {}
> +static inline void invalidate_bh_lrus_cpu(void) {}
>  static inline bool has_bh_in_lru(int cpu, void *dummy) { return false; }
>  #define buffer_heads_over_limit 0
>  
> diff --git a/mm/swap.c b/mm/swap.c
> index 897200d27dd0..af3cad4e5378 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -620,7 +620,6 @@ void lru_add_drain_cpu(int cpu)
>  		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
>  
>  	activate_page_drain(cpu);
> -	invalidate_bh_lrus_cpu(cpu);
>  }
>  
>  /**
> @@ -703,6 +702,20 @@ void lru_add_drain(void)
>  	local_unlock(&lru_pvecs.lock);
>  }
>  
> +/*
> + * It's called from per-cpu workqueue context in SMP case so
> + * lru_add_drain_cpu and invalidate_bh_lrus_cpu should run on
> + * the same cpu. It shouldn't be a problem in !SMP case since
> + * the core is only one and the locks will disable preemption.
> + */
> +static void lru_add_and_bh_lrus_drain(void)
> +{
> +	local_lock(&lru_pvecs.lock);
> +	lru_add_drain_cpu(smp_processor_id());
> +	local_unlock(&lru_pvecs.lock);
> +	invalidate_bh_lrus_cpu();
> +}
> +
>  void lru_add_drain_cpu_zone(struct zone *zone)
>  {
>  	local_lock(&lru_pvecs.lock);
> @@ -717,7 +730,7 @@ static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
>  
>  static void lru_add_drain_per_cpu(struct work_struct *dummy)
>  {
> -	lru_add_drain();
> +	lru_add_and_bh_lrus_drain();
>  }
>  
>  /*
> @@ -858,7 +871,7 @@ void lru_cache_disable(void)
>  	 */
>  	__lru_add_drain_all(true);
>  #else
> -	lru_add_drain();
> +	lru_add_and_bh_lrus_drain();
>  #endif
>  }
>  
> -- 
> 2.33.0.309.g3052b89438-goog
> 

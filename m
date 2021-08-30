Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6EF3FBCB1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 20:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhH3SvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 14:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhH3Su4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:50:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA260C0613D9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 11:50:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so132010pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P62fvwT02TyK11IkBj6mBOVw+h3+xC9wlW5DTnnDcjE=;
        b=T0aLe5J4vN1c9os11e+gd8IQCxDmq7ZaXxeA9DW6Vqrmy4gc2jHuuWEXQnSjwc92EU
         fMwRSN3rZEYbuZZe74HlLon3IUbA1ZWyi5uOqKwqxNLFh00ZzX0UkO/25WE0rgNy15YW
         IoORlAqp4Howf3pPJ7YnjxQcaAqxJReI728QskFraCmEEZpFy3yutPLu1hywZOYoLh2d
         TQi+sprGtBuYCS1Du8f7V4iAEtYAdb5F/4MiZ1FSef9B86c7+W4QlzJwDmixSwWO8LBf
         Dv9AqBQtfWNyzk1ysPn+AfMAr2oPFtIhMcOQkYa5gTIPEzjtZvwOk5iyu7CubxmzXEjq
         /mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=P62fvwT02TyK11IkBj6mBOVw+h3+xC9wlW5DTnnDcjE=;
        b=KfuK9QuK1uNkdQ+X1x8Ze8oDiBAaoxTxRiuFwNFPv4V/D8KnmRa+aoE+VcsYcc5Rwx
         CIzGMZvYLXsDGSCVJMoPz841tfSGnnWFjcJwklIcBMBLLOh1VCcRkepJ0rrIoZL5VGnf
         z2XFBJMvTYYkGHVlq4AlSIB2eZfjUNNtY4NM4w29TM4j/0FaPQ7P6TwmKABiSh7oDMbi
         W/8r1Gi1FWF8Ry5v9tWQSUxwtPG6v9/oiy20vbahf9HKMIF49Ji3Atj+es5iEFKnMjUH
         gbb+uWlzFIcHHCg9GsEBDC8u6FcNJjzFkxRPs7s6xZXzmjeePgU5vzK32wwTXWieMtjm
         i5ZQ==
X-Gm-Message-State: AOAM5301YMn3peO/GuQe1omFsclag7MlsLUoIMubrWheGSYY5u1GHLSy
        tghNdbpu7yy9CxKWPW5IEnJxjqBm3Fc=
X-Google-Smtp-Source: ABdhPJymtzNr84utWduJTUA7SO1d4QBrU05txt4yn+5ysoVdcJDC06eC1ZyLlJH0p9ps3UiC8AcvcQ==
X-Received: by 2002:a17:90a:19da:: with SMTP id 26mr567013pjj.198.1630349402032;
        Mon, 30 Aug 2021 11:50:02 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:68f5:6f6:b355:2de8])
        by smtp.gmail.com with ESMTPSA id gc20sm199846pjb.17.2021.08.30.11.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 11:50:01 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 30 Aug 2021 11:49:59 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] mm: zswap: add basic meminfo and vmstat coverage
Message-ID: <YS0oV23m5NfyMcJJ@google.com>
References: <20210819195533.211756-1-hannes@cmpxchg.org>
 <20210819195533.211756-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819195533.211756-4-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Thu, Aug 19, 2021 at 03:55:33PM -0400, Johannes Weiner wrote:
> Currently it requires poking at debugfs to figure out the size of the
> zswap cache size on a host. There are no counters for reads and writes
> against the cache. This makes it difficult to understand behavior on
> production systems.
> 
> Print zswap memory consumption in /proc/meminfo, count zswapouts and
> zswapins in /proc/vmstat.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  fs/proc/meminfo.c             |  4 ++++
>  include/linux/swap.h          |  4 ++++
>  include/linux/vm_event_item.h |  4 ++++
>  mm/vmstat.c                   |  4 ++++
>  mm/zswap.c                    | 11 +++++------
>  5 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6fa761c9cc78..2dc474940691 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -86,6 +86,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  
>  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
>  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> +#ifdef CONFIG_ZSWAP
> +	seq_printf(m,  "Zswap:          %8lu kB\n",
> +		   (unsigned long)(zswap_pool_total_size >> 10));

Since we have zram as well as zswap, it would be great if
we can abstract both at once without introducing another
"Zram: " stuff in meminfo. A note: zram can support fs based on
on zram blk device as well as swap. Thus, term would be better
to say "compressed" rather than "swap".

How about this?

"Compressed: xx kB"

unsigined long total_compressed_memory(void) {
    return zswap_compressed_mem() + zram_comporessed_mem();
}

> +#endif
>  	show_val_kb(m, "Dirty:          ",
>  		    global_node_page_state(NR_FILE_DIRTY));
>  	show_val_kb(m, "Writeback:      ",
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 144727041e78..3b23c88b6a8d 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -696,6 +696,10 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
>  }
>  #endif
>  
> +#ifdef CONFIG_ZSWAP
> +extern u64 zswap_pool_total_size;
> +#endif
> +
>  #if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
>  extern void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask);
>  #else
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index ae0dd1948c2b..9dbebea09c69 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -125,6 +125,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		SWAP_RA,
>  		SWAP_RA_HIT,
>  #endif
> +#ifdef CONFIG_ZSWAP
> +		ZSWPIN,
> +		ZSWPOUT,

INMEM_SWP[IN|OUT] to represent both zram and zswap ?
Feel free to suggest better word.

> +#endif
>  #ifdef CONFIG_X86
>  		DIRECT_MAP_LEVEL2_SPLIT,
>  		DIRECT_MAP_LEVEL3_SPLIT,
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index cccee36b289c..31aada15c571 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1369,6 +1369,10 @@ const char * const vmstat_text[] = {
>  	"swap_ra",
>  	"swap_ra_hit",
>  #endif
> +#ifdef CONFIG_ZSWAP
> +	"zswpin",
> +	"zswpout",
> +#endif
>  #ifdef CONFIG_X86
>  	"direct_map_level2_splits",
>  	"direct_map_level3_splits",
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 20763267a219..f93a7c715f76 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -40,7 +40,7 @@
>  * statistics
>  **********************************/
>  /* Total bytes used by the compressed storage */
> -static u64 zswap_pool_total_size;
> +u64 zswap_pool_total_size;
>  /* The number of compressed pages currently stored in zswap */
>  static atomic_t zswap_stored_pages = ATOMIC_INIT(0);
>  /* The number of same-value filled pages currently stored in zswap */
> @@ -1231,6 +1231,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>  	/* update stats */
>  	atomic_inc(&zswap_stored_pages);
>  	zswap_update_total_size();
> +	count_vm_event(ZSWAPOUT);
>  
>  	return 0;
>  
> @@ -1273,11 +1274,10 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>  		zswap_fill_page(dst, entry->value);
>  		kunmap_atomic(dst);
>  		ret = 0;
> -		goto freeentry;
> +		goto stats;
>  	}
>  
>  	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> -
>  		tmp = kmalloc(entry->length, GFP_ATOMIC);
>  		if (!tmp) {
>  			ret = -ENOMEM;
> @@ -1292,10 +1292,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>  		src += sizeof(struct zswap_header);
>  
>  	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> -
>  		memcpy(tmp, src, entry->length);
>  		src = tmp;
> -
>  		zpool_unmap_handle(entry->pool->zpool, entry->handle);
>  	}
>  
> @@ -1314,7 +1312,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>  		kfree(tmp);
>  
>  	BUG_ON(ret);
> -
> +stats:
> +	count_vm_event(ZSWAPIN);
>  freeentry:
>  	spin_lock(&tree->lock);
>  	zswap_entry_put(tree, entry);
> -- 
> 2.32.0
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D593F5D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbhHXMGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:06:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51168 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbhHXMGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:06:20 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 270961FD86;
        Tue, 24 Aug 2021 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629806736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zUPVSBcud+gzOTw04yXk5XOOMYkzc05hyUllk//sOPM=;
        b=pazybL2Mbq6uYiClEMdxGkMtEwJjfFNCfn/KZsKHOXKuZRf3wxbS4dL2qxw6/4Om4u/PcH
        5OeBGFHKxNqmxwWv0KE5CBhqN9LGPxY5eHxe/szS80uWpuyXHc7mhvj5OTwoqjpsYqopvy
        GN7xWIeuXXz0CEovtQNi+22Uo4acXA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629806736;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zUPVSBcud+gzOTw04yXk5XOOMYkzc05hyUllk//sOPM=;
        b=iM1VMuV91gntwCdozJJVRnpNEWle4fYod5NwqfZX/A+KKp3fuvPYLIFDCoP+cicShXmgNY
        p5vlJZpvDk6BTjBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0300513A50;
        Tue, 24 Aug 2021 12:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id oOcGAJDgJGEFIwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 24 Aug 2021 12:05:35 +0000
Message-ID: <81405692-d2ae-8b79-f27a-2803c5632717@suse.cz>
Date:   Tue, 24 Aug 2021 14:05:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 4/4] mm: zswap: add basic meminfo and vmstat coverage
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitalywool@gmail.com>
References: <20210819195533.211756-1-hannes@cmpxchg.org>
 <20210819195533.211756-4-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210819195533.211756-4-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC zswap maintainers

On 8/19/21 21:55, Johannes Weiner wrote:
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
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6433629F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbhDPVJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:09:18 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:38561 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbhDPVJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:09:17 -0400
Received: by mail-il1-f176.google.com with SMTP id c3so18094816ils.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=meQ/nFCSVfgCvCBsW0MHfcVkN8/GFWG8nCSaUoG29Is=;
        b=s9YTGkJ1PVj4iyiEOEQhDDfOpdmzSH5O5+0PgYpI6Odkx3LaxaXx7AHbcwflLWhnkN
         w8W+FhmDH0lnOM7879QuDSiewu4pSpricqSTYwrtHeHD7EDpXzPQB2U+5+NukXe3LidN
         t2FnfM0FaKubfgNSzlcHrIQmN+FrXQmKMoysXJ3cqP1gAKNRJuKb9Qg3M+/ebSZ8Kzb0
         XB8S+hYNQ2mailddyUIW1ry6maNgaIbNdMaw5CkJZdkYAsIxNjshgftBpfYHTq3rGc5b
         Z7jNYCdtboNefBbJPHTGH+sH7PXYQn3aw7H1+Y7QH0MCvjAABZHu6cW7FDfleAzNNsKL
         jJFQ==
X-Gm-Message-State: AOAM530HcrfX8d3bJdtM3nRPaVHwEtNn07npG33tos0NFFd2CVGY0nH3
        JWKORs9BuSgjECKGw2soqNdcij7t6N1bMw==
X-Google-Smtp-Source: ABdhPJyW5tsLpLlSyXpC/DzAfK/igHKXqQsZMuWNnkuYj6DLg1K+DquC0pbtEPEgrguhUcYWjNLQyg==
X-Received: by 2002:a92:8e4f:: with SMTP id k15mr8309514ilh.16.1618607331695;
        Fri, 16 Apr 2021 14:08:51 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id d2sm3236573ilm.7.2021.04.16.14.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:08:51 -0700 (PDT)
Date:   Fri, 16 Apr 2021 21:08:50 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] percpu: make pcpu_nr_empty_pop_pages per chunk
 type
Message-ID: <YHn84qGdDlO+MPzV@google.com>
References: <20210408035736.883861-1-guro@fb.com>
 <20210408035736.883861-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408035736.883861-4-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 07, 2021 at 08:57:33PM -0700, Roman Gushchin wrote:
> nr_empty_pop_pages is used to guarantee that there are some free
> populated pages to satisfy atomic allocations. Accounted and
> non-accounted allocations are using separate sets of chunks,
> so both need to have a surplus of empty pages.
> 
> This commit makes pcpu_nr_empty_pop_pages and the corresponding logic
> per chunk type.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/percpu-internal.h |  2 +-
>  mm/percpu-stats.c    |  9 +++++++--
>  mm/percpu.c          | 14 +++++++-------
>  3 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> index 18b768ac7dca..095d7eaa0db4 100644
> --- a/mm/percpu-internal.h
> +++ b/mm/percpu-internal.h
> @@ -87,7 +87,7 @@ extern spinlock_t pcpu_lock;
>  
>  extern struct list_head *pcpu_chunk_lists;
>  extern int pcpu_nr_slots;
> -extern int pcpu_nr_empty_pop_pages;
> +extern int pcpu_nr_empty_pop_pages[];
>  
>  extern struct pcpu_chunk *pcpu_first_chunk;
>  extern struct pcpu_chunk *pcpu_reserved_chunk;
> diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
> index c8400a2adbc2..f6026dbcdf6b 100644
> --- a/mm/percpu-stats.c
> +++ b/mm/percpu-stats.c
> @@ -145,6 +145,7 @@ static int percpu_stats_show(struct seq_file *m, void *v)
>  	int slot, max_nr_alloc;
>  	int *buffer;
>  	enum pcpu_chunk_type type;
> +	int nr_empty_pop_pages;
>  
>  alloc_buffer:
>  	spin_lock_irq(&pcpu_lock);
> @@ -165,7 +166,11 @@ static int percpu_stats_show(struct seq_file *m, void *v)
>  		goto alloc_buffer;
>  	}
>  
> -#define PL(X) \
> +	nr_empty_pop_pages = 0;
> +	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
> +		nr_empty_pop_pages += pcpu_nr_empty_pop_pages[type];
> +
> +#define PL(X)								\
>  	seq_printf(m, "  %-20s: %12lld\n", #X, (long long int)pcpu_stats_ai.X)
>  
>  	seq_printf(m,
> @@ -196,7 +201,7 @@ static int percpu_stats_show(struct seq_file *m, void *v)
>  	PU(nr_max_chunks);
>  	PU(min_alloc_size);
>  	PU(max_alloc_size);
> -	P("empty_pop_pages", pcpu_nr_empty_pop_pages);
> +	P("empty_pop_pages", nr_empty_pop_pages);
>  	seq_putc(m, '\n');
>  
>  #undef PU
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 7e31e1b8725f..61339b3d9337 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -176,10 +176,10 @@ struct list_head *pcpu_chunk_lists __ro_after_init; /* chunk list slots */
>  static LIST_HEAD(pcpu_map_extend_chunks);
>  
>  /*
> - * The number of empty populated pages, protected by pcpu_lock.  The
> - * reserved chunk doesn't contribute to the count.
> + * The number of empty populated pages by chunk type, protected by pcpu_lock.
> + * The reserved chunk doesn't contribute to the count.
>   */
> -int pcpu_nr_empty_pop_pages;
> +int pcpu_nr_empty_pop_pages[PCPU_NR_CHUNK_TYPES];
>  
>  /*
>   * The number of populated pages in use by the allocator, protected by
> @@ -559,7 +559,7 @@ static inline void pcpu_update_empty_pages(struct pcpu_chunk *chunk, int nr)
>  {
>  	chunk->nr_empty_pop_pages += nr;
>  	if (chunk != pcpu_reserved_chunk)
> -		pcpu_nr_empty_pop_pages += nr;
> +		pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] += nr;
>  }
>  
>  /*
> @@ -1835,7 +1835,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  		mutex_unlock(&pcpu_alloc_mutex);
>  	}
>  
> -	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> +	if (pcpu_nr_empty_pop_pages[type] < PCPU_EMPTY_POP_PAGES_LOW)
>  		pcpu_schedule_balance_work();
>  
>  	/* clear the areas and return address relative to base address */
> @@ -2013,7 +2013,7 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
>  		pcpu_atomic_alloc_failed = false;
>  	} else {
>  		nr_to_pop = clamp(PCPU_EMPTY_POP_PAGES_HIGH -
> -				  pcpu_nr_empty_pop_pages,
> +				  pcpu_nr_empty_pop_pages[type],
>  				  0, PCPU_EMPTY_POP_PAGES_HIGH);
>  	}
>  
> @@ -2595,7 +2595,7 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  
>  	/* link the first chunk in */
>  	pcpu_first_chunk = chunk;
> -	pcpu_nr_empty_pop_pages = pcpu_first_chunk->nr_empty_pop_pages;
> +	pcpu_nr_empty_pop_pages[PCPU_CHUNK_ROOT] = pcpu_first_chunk->nr_empty_pop_pages;
>  	pcpu_chunk_relocate(pcpu_first_chunk, -1);
>  
>  	/* include all regions of the first chunk */
> -- 
> 2.30.2
> 

This turns out to have been a more pressing issue. Thanks for fixing
this. I ran this to Linus for v5.12-rc7 [1].

https://lore.kernel.org/lkml/YHHs618ESvKhYeeM@google.com/

Thanks,
Dennis

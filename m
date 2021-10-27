Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF39E43CC4A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbhJ0OfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:35:19 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:39785 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhJ0OfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:35:15 -0400
Received: by mail-qt1-f170.google.com with SMTP id t40so2610110qtc.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jTcENcPs+130OX96IeygczwXP7ucKv79ToeMUvXMykQ=;
        b=ic1JQdVQyb5ypdFHpsu9bC4gRL3mQe8Ob0MDN70HygU1JEODyWnt9H28U2J1pVHnMy
         LBI4hzbYl2YKqUTtXnQTV7IjTUGc4+ZAWeLRBghzum5fLpmegppuGLPUl/t9BduVRTL2
         SGsroQAMitVln6Hha4jRmVfndIy5esYtL92fvzb86tXJYWP9nsLaEbLsUGnzFaOwaMs9
         FqusrvHnutIXOClsQNwgR4OsiKvmDc/Ngr+M/VDBOl2XJ4YN9lIY1cipdIxo/OB10qyo
         TszBaIWBTp5xFVN5uJi5iWLVgMJNilKhk3X6k9YOyjMOWXCru2b7l9AmIBq+lNqv+C7t
         VYpw==
X-Gm-Message-State: AOAM531RahjI672ihYun/CxMij5UuZTA7rhworig6E3OO5jCh3cFB+PJ
        LMYs3vQr6v/eo6D7QYxDyE8=
X-Google-Smtp-Source: ABdhPJxPqPuGbnaojmQkRitj9E3vgU3hxN3rx0BlNrqW+0dZtvpyQNxsunL9YEQOELc6KpROJ5PK5w==
X-Received: by 2002:a05:622a:49:: with SMTP id y9mr32159631qtw.301.1635345169301;
        Wed, 27 Oct 2021 07:32:49 -0700 (PDT)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id i22sm114654qkn.80.2021.10.27.07.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:32:48 -0700 (PDT)
Date:   Wed, 27 Oct 2021 10:32:46 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Yuanzheng Song <songyuanzheng@huawei.com>
Cc:     akpm@linux-foundation.org, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, cl@gentwo.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm/percpu: fix data-race with
 pcpu_nr_empty_pop_pages
Message-ID: <YXljDt5VfNpyxSww@fedora>
References: <20211026084312.2138852-1-songyuanzheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026084312.2138852-1-songyuanzheng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 26, 2021 at 08:43:12AM +0000, Yuanzheng Song wrote:
> When reading the pcpu_nr_empty_pop_pages in pcpu_alloc()
> and writing the pcpu_nr_empty_pop_pages in
> pcpu_update_empty_pages() at the same time,
> the data-race occurs.
> 
> ===========
> read-write to 0xffffffff882fdd4c of 4 bytes by task 9424 on cpu 0:
>  pcpu_update_empty_pages
>  pcpu_chunk_populated
>  pcpu_balance_populated
>  pcpu_balance_workfn
>  process_one_work
>  worker_thread
>  kthread
>  ret_from_fork
> 
> read to 0xffffffff882fdd4c of 4 bytes by task 9386 on cpu 3:
>  pcpu_alloc
>  __alloc_percpu_gfp
>  fib_nh_common_init
>  fib_nh_init
>  fib_create_info
>  fib_table_insert
>  fib_magic
>  ......
>  sock_sendmsg_nosec
>  sock_sendmsg
>  __sys_sendto
>  __do_sys_sendto
>  __se_sys_sendto
>  __x64_sys_sendto
>  do_syscall_64
>  entry_SYSCALL_64_after_hwframe
> ============
> 
> The same problem will occur in these functions:
> pcpu_reclaim_populated(), pcpu_update_empty_pages(),
> pcpu_isolate_chunk().
> 

This isn't true. pcpu_nr_empty_pop_pages is write protected by the
pcpu_lock. Both pcpu_reclaim_populated() and pcpu_isolate_chunk()
require holding the pcpu_lock. pcpu_update_empty_pages() doesn't require
holding the lock because it is called by first chunk init code. The
other callers of the function do hold pcpu_lock.

> Using atomic variable operations to slove this
> concurrent access problem.

I apologize, but it takes me a little bit of time to think about these
changes. In this case, I think it's overkill to make it an atomic for a
read only access that doesn't actually matter.

I think a simpler solution is to move the access up after the area_found
label and do this logic behind the pcpu_lock. The code that follows to
populate non-atomic not-backed allocations will never add to the empty
page count. So something like a `bool need_balance` in free_percpu().

The atomic change I think would make more sense if we had a use case of
someone not in the percpu subsystem reading this value, which wouldn't
be good.

Thanks,
Dennis

> 
> Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
> ---
> Changes since v1:
> - Change the pcpu_nr_empty_pop_pages to atomic variable
>   suggested by Christoph Lameter
> 
>  mm/percpu-internal.h |  2 +-
>  mm/percpu-stats.c    |  2 +-
>  mm/percpu-vm.c       |  2 +-
>  mm/percpu.c          | 18 ++++++++++--------
>  4 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> index 639662c20c82..02fbc11ef68a 100644
> --- a/mm/percpu-internal.h
> +++ b/mm/percpu-internal.h
> @@ -72,7 +72,7 @@ extern struct list_head *pcpu_chunk_lists;
>  extern int pcpu_nr_slots;
>  extern int pcpu_sidelined_slot;
>  extern int pcpu_to_depopulate_slot;
> -extern int pcpu_nr_empty_pop_pages;
> +extern atomic_t pcpu_nr_empty_pop_pages;
>  
>  extern struct pcpu_chunk *pcpu_first_chunk;
>  extern struct pcpu_chunk *pcpu_reserved_chunk;
> diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
> index c6bd092ff7a3..7bd601fd3b6b 100644
> --- a/mm/percpu-stats.c
> +++ b/mm/percpu-stats.c
> @@ -188,7 +188,7 @@ static int percpu_stats_show(struct seq_file *m, void *v)
>  	PU(nr_max_chunks);
>  	PU(min_alloc_size);
>  	PU(max_alloc_size);
> -	P("empty_pop_pages", pcpu_nr_empty_pop_pages);
> +	P("empty_pop_pages", atomic_read(&pcpu_nr_empty_pop_pages));
>  	seq_putc(m, '\n');
>  
>  #undef PU
> diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> index 2054c9213c43..12b2342448f4 100644
> --- a/mm/percpu-vm.c
> +++ b/mm/percpu-vm.c
> @@ -404,7 +404,7 @@ static bool pcpu_should_reclaim_chunk(struct pcpu_chunk *chunk)
>  	 * chunk, move it to the to_depopulate list.
>  	 */
>  	return ((chunk->isolated && chunk->nr_empty_pop_pages) ||
> -		(pcpu_nr_empty_pop_pages >
> +		(atomic_read(&pcpu_nr_empty_pop_pages) >
>  		 (PCPU_EMPTY_POP_PAGES_HIGH + chunk->nr_empty_pop_pages) &&
>  		 chunk->nr_empty_pop_pages >= chunk->nr_pages / 4));
>  }
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 293009cc03ef..0c55a25059a2 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -181,7 +181,7 @@ static LIST_HEAD(pcpu_map_extend_chunks);
>   * The number of empty populated pages, protected by pcpu_lock.
>   * The reserved chunk doesn't contribute to the count.
>   */
> -int pcpu_nr_empty_pop_pages;
> +atomic_t pcpu_nr_empty_pop_pages = ATOMIC_INIT(0);
>  
>  /*
>   * The number of populated pages in use by the allocator, protected by
> @@ -574,7 +574,7 @@ static void pcpu_isolate_chunk(struct pcpu_chunk *chunk)
>  
>  	if (!chunk->isolated) {
>  		chunk->isolated = true;
> -		pcpu_nr_empty_pop_pages -= chunk->nr_empty_pop_pages;
> +		atomic_sub(chunk->nr_empty_pop_pages, &pcpu_nr_empty_pop_pages);
>  	}
>  	list_move(&chunk->list, &pcpu_chunk_lists[pcpu_to_depopulate_slot]);
>  }
> @@ -585,7 +585,7 @@ static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
>  
>  	if (chunk->isolated) {
>  		chunk->isolated = false;
> -		pcpu_nr_empty_pop_pages += chunk->nr_empty_pop_pages;
> +		atomic_add(chunk->nr_empty_pop_pages, &pcpu_nr_empty_pop_pages);
>  		pcpu_chunk_relocate(chunk, -1);
>  	}
>  }
> @@ -603,7 +603,7 @@ static inline void pcpu_update_empty_pages(struct pcpu_chunk *chunk, int nr)
>  {
>  	chunk->nr_empty_pop_pages += nr;
>  	if (chunk != pcpu_reserved_chunk && !chunk->isolated)
> -		pcpu_nr_empty_pop_pages += nr;
> +		atomic_add(nr, &pcpu_nr_empty_pop_pages);
>  }
>  
>  /*
> @@ -1874,7 +1874,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  		mutex_unlock(&pcpu_alloc_mutex);
>  	}
>  
> -	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> +	if (atomic_read(&pcpu_nr_empty_pop_pages) < PCPU_EMPTY_POP_PAGES_LOW)
>  		pcpu_schedule_balance_work();
>  
>  	/* clear the areas and return address relative to base address */
> @@ -2062,7 +2062,7 @@ static void pcpu_balance_populated(void)
>  		pcpu_atomic_alloc_failed = false;
>  	} else {
>  		nr_to_pop = clamp(PCPU_EMPTY_POP_PAGES_HIGH -
> -				  pcpu_nr_empty_pop_pages,
> +				  atomic_read(&pcpu_nr_empty_pop_pages),
>  				  0, PCPU_EMPTY_POP_PAGES_HIGH);
>  	}
>  
> @@ -2163,7 +2163,8 @@ static void pcpu_reclaim_populated(void)
>  				break;
>  
>  			/* reintegrate chunk to prevent atomic alloc failures */
> -			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
> +			if (atomic_read(&pcpu_nr_empty_pop_pages) <
> +			    PCPU_EMPTY_POP_PAGES_HIGH) {
>  				reintegrate = true;
>  				goto end_chunk;
>  			}
> @@ -2765,7 +2766,8 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  
>  	/* link the first chunk in */
>  	pcpu_first_chunk = chunk;
> -	pcpu_nr_empty_pop_pages = pcpu_first_chunk->nr_empty_pop_pages;
> +	atomic_set(&pcpu_nr_empty_pop_pages,
> +		   pcpu_first_chunk->nr_empty_pop_pages);
>  	pcpu_chunk_relocate(pcpu_first_chunk, -1);
>  
>  	/* include all regions of the first chunk */
> -- 
> 2.25.1
> 

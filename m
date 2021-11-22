Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3C7458779
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 01:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhKVAxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 19:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKVAxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 19:53:50 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84405C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 16:50:44 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id c32so72812358lfv.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 16:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iop0zFXukl0T1HERRvTdNZUCzIsBjJa6pjhtaIM25R0=;
        b=N0Mw7g8KjmbWWGollngUAJ8tzEzkmqMP7CdPxPYvZFOtZltUSdLcTlsEOEaFPOpYJC
         FRNGwnzh8vDopfzeK1HnXO4kSqm68BPlO5b7BW91oabp2Ozk3cLAmJYyZfWjFrSxoixn
         cGwpCljtKBT5BSMn32nApWvnxyjG+MVaRFXL9gnC7IW7fnUoCD/K3UoL18pqvGDz3CWQ
         mv5/FxDGro/bk/tzrv/iBqNOSZsDXhedZU+0IZwiCft/CR1ZmtsgTOrQhfvXFChRQEM0
         q5E+cc5GzwsrA4SinGelGfEc+dswUfqUXapfiBhP0zmOhgnmeZMZTJbhIIotsTTbTInR
         itoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iop0zFXukl0T1HERRvTdNZUCzIsBjJa6pjhtaIM25R0=;
        b=EB50TpcR0CMjk+yjaHxKzizHK0m8xuArDv2rtbJyBy1SLe9YfAT5lawv05mCqoJjQH
         YnVOG4exGaDe/VTQPvmr8EkNix9L1IPvCZfesYW4SDMtOtV8RRvQ1SPLU1b1YmJbldK9
         v3NxGibB7iqCf0Ut37S3uN7e8xq9XNSs5iDhZx4t3iae4OHZLxhV1k4KGixVQrF8IUVV
         SNt5tvUy5N8+XLXfGQkyuTYaR+/Xp32td6KxE1uOd66YuVsf6ZjdTu9N18Av2vu8973w
         YH4JxG+GI90Nj7GmUwzLc7bVMXxayMw5dDHGDpCCakDeXVejUZdXkrA/lBWPpx5dnlWP
         uKoA==
X-Gm-Message-State: AOAM533lss4tlr0OIdGklSFqlUK6Y64yosEm6WIyqL8X1ny4Xdi1QPBE
        wAGif4XenZtrRhHm+IP5v4RyPA==
X-Google-Smtp-Source: ABdhPJxpbs7Uii+3o0hrtuSW3LlYVSow+pou20+rQV2vHDOZqOjJarHc+meZAffH7EVgLFkgqjYnMA==
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr54023042lfq.254.1637542242667;
        Sun, 21 Nov 2021 16:50:42 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y32sm792317lfa.171.2021.11.21.16.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 16:50:42 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 538941034BF; Mon, 22 Nov 2021 03:50:47 +0300 (+03)
Date:   Mon, 22 Nov 2021 03:50:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
Message-ID: <20211122005047.ufnyvqlqu55c5trt@box>
References: <20211120201230.920082-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120201230.920082-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 12:12:30PM -0800, Shakeel Butt wrote:
> Many applications do sophisticated management of their heap memory for
> better performance but with low cost. We have a bunch of such
> applications running on our production and examples include caching and
> data storage services. These applications keep their hot data on the
> THPs for better performance and release the cold data through
> MADV_DONTNEED to keep the memory cost low.
> 
> The kernel defers the split and release of THPs until there is memory
> pressure. This causes complicates the memory management of these
> sophisticated applications which then needs to look into low level
> kernel handling of THPs to better gauge their headroom for expansion. In
> addition these applications are very latency sensitive and would prefer
> to not face memory reclaim due to non-deterministic nature of reclaim.
> 
> This patch let such applications not worry about the low level handling
> of THPs in the kernel and splits the THPs synchronously on
> MADV_DONTNEED.

Have you considered impact on short-living tasks where paying splitting
tax would hurt performace without any benefits? Maybe a sparete madvise
opration needed? I donno.

> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  include/linux/mmzone.h   |  5 ++++
>  include/linux/sched.h    |  4 ++++
>  include/linux/sched/mm.h | 11 +++++++++
>  kernel/fork.c            |  3 +++
>  mm/huge_memory.c         | 50 ++++++++++++++++++++++++++++++++++++++++
>  mm/madvise.c             |  8 +++++++
>  6 files changed, 81 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 58e744b78c2c..7fa0035128b9 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -795,6 +795,11 @@ struct deferred_split {
>  	struct list_head split_queue;
>  	unsigned long split_queue_len;
>  };
> +void split_local_deferred_list(struct list_head *defer_list);
> +#else
> +static inline void split_local_deferred_list(struct list_head *defer_list)
> +{
> +}
>  #endif
>  
>  /*
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9d27fd0ce5df..a984bb6509d9 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1412,6 +1412,10 @@ struct task_struct {
>  	struct mem_cgroup		*active_memcg;
>  #endif
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	struct list_head		*deferred_split_list;
> +#endif
> +
>  #ifdef CONFIG_BLK_CGROUP
>  	struct request_queue		*throttle_queue;
>  #endif

It looks dirty. We really don't have options to pass it down?

Maybe passdown the list via zap_details and call a new rmap remove helper
if the list is present?

>  
> +void split_local_deferred_list(struct list_head *defer_list)
> +{
> +	struct list_head *pos, *next;
> +	struct page *page;
> +
> +	/* First iteration for split. */
> +	list_for_each_safe(pos, next, defer_list) {
> +		page = list_entry((void *)pos, struct page, deferred_list);
> +		page = compound_head(page);
> +
> +		if (!trylock_page(page))
> +			continue;
> +
> +		if (split_huge_page(page)) {
> +			unlock_page(page);
> +			continue;
> +		}
> +		/* split_huge_page() removes page from list on success */
> +		unlock_page(page);
> +
> +		/* corresponding get in deferred_split_huge_page. */
> +		put_page(page);
> +	}
> +
> +	/* Second iteration to putback failed pages. */
> +	list_for_each_safe(pos, next, defer_list) {
> +		struct deferred_split *ds_queue;
> +		unsigned long flags;
> +
> +		page = list_entry((void *)pos, struct page, deferred_list);
> +		page = compound_head(page);
> +		ds_queue = get_deferred_split_queue(page);
> +
> +		spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> +		list_move(page_deferred_list(page), &ds_queue->split_queue);
> +		spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> +
> +		/* corresponding get in deferred_split_huge_page. */
> +		put_page(page);
> +	}
> +}

Looks like a lot of copy-paste from deferred_split_scan(). Can we get them
consolidated?

-- 
 Kirill A. Shutemov

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A06532C40D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381695AbhCDAKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:10:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380750AbhCCW5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:57:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D01A64EEF;
        Wed,  3 Mar 2021 22:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614811490;
        bh=2rtpPwzLJHVHIJnLXsKsmJg32BkCVjuDiTmHOHM5K7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vBNagQ9lTfWPruGCNNpnKngmPSpHpbBdsY6OHavrWAHrdGZcdo1YlOiSZJ8r+bqZs
         KQWi/SuQ/y/4yBAUAuau3/EbKod66NclsVLGFZ+7iCshfF4KavbJ3gHRH2j3OVKaA2
         gWDTXrsgBhzNEbGxMBncnOzqEvaUpcfihlOPWuE0=
Date:   Wed, 3 Mar 2021 14:44:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, willy@infradead.org, surenb@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3] mm: cma: support sysfs
Message-Id: <20210303144449.aa69518bfbaec9c71f799dc7@linux-foundation.org>
In-Reply-To: <20210303205053.2906924-1-minchan@kernel.org>
References: <20210303205053.2906924-1-minchan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Mar 2021 12:50:53 -0800 Minchan Kim <minchan@kernel.org> wrote:

> Since CMA is getting used more widely, it's more important to
> keep monitoring CMA statistics for system health since it's
> directly related to user experience.
> 
> This patch introduces sysfs statistics for CMA, in order to provide
> some basic monitoring of the CMA allocator.
> 
>  * the number of CMA page allocation attempts
>  * the number of CMA page allocation failures
> 
> These two values allow the user to calcuate the allocation
> failure rate for each CMA area.
> 
> e.g.)
>   /sys/kernel/mm/cma/WIFI/cma_alloc_pages_[attempts|fails]
>   /sys/kernel/mm/cma/SENSOR/cma_alloc_pages_[attempts|fails]
>   /sys/kernel/mm/cma/BLUETOOTH/cma_alloc_pages_[attempts|fails]
> 
> ...
>
> --- a/mm/cma.h
> +++ b/mm/cma.h
> @@ -3,6 +3,14 @@
>  #define __MM_CMA_H__
>  
>  #include <linux/debugfs.h>
> +#include <linux/kobject.h>
> +
> +struct cma_stat {
> +	spinlock_t lock;
> +	unsigned long pages_attempts;	/* the number of CMA page allocation attempts */
> +	unsigned long pages_fails;	/* the number of CMA page allocation failures */
> +	struct kobject kobj;
> +};
>  
>  struct cma {
>  	unsigned long   base_pfn;
> @@ -16,6 +24,9 @@ struct cma {
>  	struct debugfs_u32_array dfs_bitmap;
>  #endif
>  	char name[CMA_MAX_NAME];
> +#ifdef CONFIG_CMA_SYSFS
> +	struct cma_stat	*stat;
> +#endif
>  };

Why aren't the stat fields simply placed directly into struct cma_stat?

> ...
>
> +static int __init cma_sysfs_init(void)
> +{
> +	int i = 0;
> +	struct cma *cma;
> +
> +	cma_kobj = kobject_create_and_add("cma", mm_kobj);
> +	if (!cma_kobj) {
> +		pr_err("failed to create cma kobject\n");
> +		return -ENOMEM;
> +	}
> +
> +	cma_stats = kzalloc(array_size(sizeof(struct cma_stat),
> +				cma_area_count), GFP_KERNEL);

kmalloc_array(..., GFP_KERNEL|__GFP_ZERO);

?

> +	if (!cma_stats) {
> +		pr_err("failed to create cma_stats\n");

Probably unneeded - the ENOMEM stack backtrace will point straight here.

> +		goto out;
> +	}
> +
> +	do {
> +		cma = &cma_areas[i];
> +		cma->stat = &cma_stats[i];
> +		spin_lock_init(&cma->stat->lock);
> +		if (kobject_init_and_add(&cma->stat->kobj, &cma_ktype,
> +					cma_kobj, "%s", cma->name)) {
> +			kobject_put(&cma->stat->kobj);
> +			goto out;
> +		}
> +	} while (++i < cma_area_count);
> +
> +	return 0;
> +out:
> +	while (--i >= 0) {
> +		cma = &cma_areas[i];
> +		kobject_put(&cma->stat->kobj);
> +	}
> +
> +	kfree(cma_stats);
> +	kobject_put(cma_kobj);
> +
> +	return -ENOMEM;
> +}
> +subsys_initcall(cma_sysfs_init);


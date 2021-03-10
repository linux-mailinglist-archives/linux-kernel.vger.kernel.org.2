Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CCF334937
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhCJU47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:56:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhCJU4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:56:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9997564EE8;
        Wed, 10 Mar 2021 20:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615409771;
        bh=VVx5ZS51pRRZ4Kk2g9iYDAMVtDpyywK24kFljFq/lUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pzd+NJwuI3bJfWQoBjUnXiggyLHtJjbt1dV+HJlQTLJ5cOrrBcNgrYCW4N6QeG6kb
         AbnC9hY/E8KQY6uIupWFP1khFCouvNWf7Du3EzMJ7L1cJzMLPWUq1vTqGvDz/W9aE0
         YVWQBNKZSu7dU3x+Gbcprv7XSNRkDkzPdiAMTtM4=
Date:   Wed, 10 Mar 2021 12:56:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v3] mm: page_alloc: dump migrate-failed pages
Message-Id: <20210310125609.359888dc65562fbed4b1f088@linux-foundation.org>
In-Reply-To: <20210310180104.517886-1-minchan@kernel.org>
References: <20210310180104.517886-1-minchan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 10:01:04 -0800 Minchan Kim <minchan@kernel.org> wrote:

> Currently, debugging CMA allocation failures is quite limited.
> The most commong source of these failures seems to be page
> migration which doesn't provide any useful information on the
> reason of the failure by itself. alloc_contig_range can report
> those failures as it holds a list of migrate-failed pages.
> 
> page refcount, mapcount with page flags on dump_page are
> helpful information to deduce the culprit. Furthermore,
> dump_page_owner was super helpful to find long term pinner
> who initiated the page allocation.
> 
> The reason it approach with dynamic debug is the debug message
> could emit lots of noises as alloc_contig_range calls more
> frequently since it's a best effort allocator.
> 
> There are two ifdefery conditions to support common dyndbg options:
> 
> - CONFIG_DYNAMIC_DEBUG_CORE && DYNAMIC_DEBUG_MODULE
> It aims for supporting the feature with only specific file
> with adding ccflags.
> 
> - CONFIG_DYNAMIC_DEBUG
> It aims for supporting the feature with system wide globally.
> 
> A simple example to enable the feature:
> 
> Admin could enable the dump like this(by default, disabled)
> 
> 	echo "func dump_migrate_failure_pages +p" > control
> 
> Admin could disable it.
> 
> 	echo "func dump_migrate_failure_pages =_" > control

I think the changelog is out of sync.  Did you mean
"alloc_contig_dump_pages" here?

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8453,6 +8453,27 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
>  				pageblock_nr_pages));
>  }

> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> +	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
> +static void alloc_contig_dump_pages(struct list_head *page_list)
> +{
> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> +			"migrate failure");
> +
> +	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {
> +		struct page *page;
> +
> +		WARN(1, "failed callstack");
> +		list_for_each_entry(page, page_list, lru)
> +			dump_page(page, "migration failure");
> +	}
> +}

I doubt if everyone is familiar with dynamic debug.  It might be kind
to add a little comment over this, telling people how to turn it on and
off.


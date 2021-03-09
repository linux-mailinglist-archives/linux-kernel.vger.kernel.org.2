Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFEF331B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhCIAVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:21:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231864AbhCIAVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:21:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD52C64FFD;
        Tue,  9 Mar 2021 00:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615249289;
        bh=DlBHQTYx7AJjClppLF+twkS9JNHiruHKDw5scvY5BrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bz4V75JpPXo1KIN+GkM4xn8NkmqewhCdNlKTr+cJK/BdQsFf98dTcK+7z1R+DP81R
         5AcnE/X7h1rlyY07XBIzIE5udXa8itnYRkvfj664sPVLvixjCHP8yGtmg8unzPvWRJ
         7F5c0pCJiBLFkS8nUwozNkTIWnPsmhTZRudFJFfA=
Date:   Mon, 8 Mar 2021 16:21:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-Id: <20210308162128.9b4a7d4c1576a72fd4878bdb@linux-foundation.org>
In-Reply-To: <20210308202047.1903802-1-minchan@kernel.org>
References: <20210308202047.1903802-1-minchan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Mar 2021 12:20:47 -0800 Minchan Kim <minchan@kernel.org> wrote:

> alloc_contig_range is usually used on cma area or movable zone.
> It's critical if the page migration fails on those areas so
> dump more debugging message.
> 
> page refcount, mapcount with page flags on dump_page are
> helpful information to deduce the culprit. Furthermore,
> dump_page_owner was super helpful to find long term pinner
> who initiated the page allocation.
> 
> Admin could enable the dump like this(by default, disabled)
> 
> 	echo "func dump_migrate_failure_pages +p" > control
> 
> Admin could disable it.
> 
> 	echo "func dump_migrate_failure_pages =_" > control
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8453,6 +8453,34 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
>  				pageblock_nr_pages));
>  }
>  
> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> +	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
> +static DEFINE_RATELIMIT_STATE(alloc_contig_ratelimit_state,
> +		DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> +int alloc_contig_ratelimit(void)
> +{
> +	return __ratelimit(&alloc_contig_ratelimit_state);
> +}

Wow, that's an eyesore.  We're missing helpers in the ratelimit code. 
Can we do something like

/* description goes here */
#define RATELIMIT2(interval, burst)
({
	static DEFINE_RATELIMIT_STATE(_rs, interval, burst);

	__ratelimit(_rs);
})

#define RATELIMIT()
	RATELIMIT2(DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST)

> +void dump_migrate_failure_pages(struct list_head *page_list)
> +{
> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> +			"migrate failure");
> +	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&
> +			alloc_contig_ratelimit()) {
> +		struct page *page;
> +
> +		WARN(1, "failed callstack");
> +		list_for_each_entry(page, page_list, lru)
> +			dump_page(page, "migration failure");
> +	}
> +}

Then we can simply do

	if (DYNAMIC_DEBUG_BRANCH(descriptor) && RATELIMIT())



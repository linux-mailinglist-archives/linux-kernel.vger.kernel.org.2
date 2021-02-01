Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F9A30A52A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhBAKOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:14:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:52352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhBAKOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:14:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E901BACB0;
        Mon,  1 Feb 2021 10:13:32 +0000 (UTC)
Subject: Re: [PATCH] mm/page_owner: Record the timestamp of all pages during
 free
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210129234548.10054-1-georgi.djakov@linaro.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <735983e1-f439-8e77-7959-135164c517ed@suse.cz>
Date:   Mon, 1 Feb 2021 11:13:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129234548.10054-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/21 12:45 AM, Georgi Djakov wrote:
> Collect the time when each allocation is freed, to help with memory
> analysis with kdump/ramdump.
> 
> Having another timestamp when we free the page helps for debugging
> page migration issues. For example both alloc and free timestamps
> being the same can gave hints that there is an issue with migrating
> memory, as opposed to a page just being dropped during migration.

Besides crash dump analysis, we should also provide this timestamp in the
page_owner file and dump_page()?

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  Documentation/vm/page_owner.rst | 2 +-
>  mm/page_owner.c                 | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index 4e67c2e9bbed..5d7a62c2be28 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -47,7 +47,7 @@ size change due to this facility.
>  
>     text    data     bss     dec     hex filename
>     48800   2445     644   51889    cab1 mm/page_alloc.o
> -   6574     108      29    6711    1a37 mm/page_owner.o
> +   6644     108      29    6777    1a79 mm/page_owner.o
>     1025       8       8    1041     411 mm/page_ext.o
>  
>  Although, roughly, 8 KB code is added in total, page_alloc.o increase by
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index d15c7c4994f5..fbdf064e7494 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -27,6 +27,7 @@ struct page_owner {
>  	depot_stack_handle_t handle;
>  	depot_stack_handle_t free_handle;
>  	u64 ts_nsec;
> +	u64 free_ts_nsec;
>  	pid_t pid;
>  };
>  
> @@ -148,6 +149,7 @@ void __reset_page_owner(struct page *page, unsigned int order)
>  	struct page_ext *page_ext;
>  	depot_stack_handle_t handle = 0;
>  	struct page_owner *page_owner;
> +	u64 free_ts_nsec = local_clock();
>  
>  	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
>  
> @@ -158,6 +160,7 @@ void __reset_page_owner(struct page *page, unsigned int order)
>  		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
>  		page_owner = get_page_owner(page_ext);
>  		page_owner->free_handle = handle;
> +		page_owner->free_ts_nsec = free_ts_nsec;
>  		page_ext = page_ext_next(page_ext);
>  	}
>  }
> @@ -177,6 +180,7 @@ static inline void __set_page_owner_handle(struct page *page,
>  		page_owner->last_migrate_reason = -1;
>  		page_owner->pid = current->pid;
>  		page_owner->ts_nsec = local_clock();
> +		page_owner->free_ts_nsec = 0;

Might be more useful not to reset the time of previous free when the page is
reallocated?

>  		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
>  		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
>  
> @@ -243,6 +247,7 @@ void __copy_page_owner(struct page *oldpage, struct page *newpage)
>  	new_page_owner->handle = old_page_owner->handle;
>  	new_page_owner->pid = old_page_owner->pid;
>  	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
> +	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
>  
>  	/*
>  	 * We don't clear the bit on the oldpage as it's going to be freed
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5580634ECF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhC3PzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:55:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:45704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232201AbhC3Pyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:54:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44DADAF10;
        Tue, 30 Mar 2021 15:54:34 +0000 (UTC)
Subject: Re: [PATCH mm] mm, kasan: fix for "integrate page_alloc init with
 HW_TAGS"
To:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <2e5e80481533e73876d5d187d1f278f9656df73a.1617118134.git.andreyknvl@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <115c3cd4-a5ec-ea4c-fdc8-a17a0990bd30@suse.cz>
Date:   Tue, 30 Mar 2021 17:54:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2e5e80481533e73876d5d187d1f278f9656df73a.1617118134.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/21 5:31 PM, Andrey Konovalov wrote:
> My commit "integrate page_alloc init with HW_TAGS" changed the order of
> kernel_unpoison_pages() and kernel_init_free_pages() calls. This leads
> to __GFP_ZERO allocations being incorrectly poisoned when page poisoning
> is enabled.

Correction: This leads to check_poison_mem() complain about memory corruption
because the poison pattern has already been overwritten by zeroes.

> Fix by restoring the initial order. Also add a warning comment.
> 
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Reported-by: Sergei Trofimovich <slyfox@gentoo.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

I expect this will be folded to your patch in mmotm anyway, so the changelog is
not as important...

> ---
>  mm/page_alloc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 033bd92e8398..1fc5061f8ca1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2328,6 +2328,12 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  	arch_alloc_page(page, order);
>  	debug_pagealloc_map_pages(page, 1 << order);
>  
> +	/*
> +	 * Page unpoisoning must happen before memory initialization.
> +	 * Otherwise, a __GFP_ZERO allocation will not be initialized.

... but the comment should be corrected too:
"Otherwise, a __GFP_ZERO allocation will trigger a memory corruption report
during unpoisoning."

Thanks.

> +	 */
> +	kernel_unpoison_pages(page, 1 << order);
> +
>  	/*
>  	 * As memory initialization might be integrated into KASAN,
>  	 * kasan_alloc_pages and kernel_init_free_pages must be
> @@ -2338,7 +2344,6 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  	if (init && !kasan_has_integrated_init())
>  		kernel_init_free_pages(page, 1 << order);
>  
> -	kernel_unpoison_pages(page, 1 << order);
>  	set_page_owner(page, order, gfp_flags);
>  }
>  
> 


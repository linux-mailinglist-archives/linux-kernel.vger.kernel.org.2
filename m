Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D718E34EE24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhC3Qom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:44:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:46308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231532AbhC3Qo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:44:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 207D0B02D;
        Tue, 30 Mar 2021 16:44:10 +0000 (UTC)
Subject: Re: [PATCH mm v2] mm, kasan: fix for "integrate page_alloc init with
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
References: <65b6028dea2e9a6e8e2cb779b5115c09457363fc.1617122211.git.andreyknvl@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <404ad944-ab46-cffb-5fbb-3dd7ae25caaa@suse.cz>
Date:   Tue, 30 Mar 2021 18:44:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <65b6028dea2e9a6e8e2cb779b5115c09457363fc.1617122211.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/21 6:37 PM, Andrey Konovalov wrote:
> My commit "integrate page_alloc init with HW_TAGS" changed the order of
> kernel_unpoison_pages() and kernel_init_free_pages() calls. This leads
> to complaints from the page unpoisoning code, as the poison pattern gets
> overwritten for __GFP_ZERO allocations.
> 
> Fix by restoring the initial order. Also add a warning comment.
> 
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Reported-by: Sergei Trofimovich <slyfox@gentoo.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Tested that the bug indeed occurs in -next and is fixed by this. Thanks.

> ---
>  mm/page_alloc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 033bd92e8398..d2c020563c0b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2328,6 +2328,13 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  	arch_alloc_page(page, order);
>  	debug_pagealloc_map_pages(page, 1 << order);
>  
> +	/*
> +	 * Page unpoisoning must happen before memory initialization.
> +	 * Otherwise, the poison pattern will be overwritten for __GFP_ZERO
> +	 * allocations and the page unpoisoning code will complain.
> +	 */
> +	kernel_unpoison_pages(page, 1 << order);
> +
>  	/*
>  	 * As memory initialization might be integrated into KASAN,
>  	 * kasan_alloc_pages and kernel_init_free_pages must be
> @@ -2338,7 +2345,6 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  	if (init && !kasan_has_integrated_init())
>  		kernel_init_free_pages(page, 1 << order);
>  
> -	kernel_unpoison_pages(page, 1 << order);
>  	set_page_owner(page, order, gfp_flags);
>  }
>  
> 


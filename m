Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA92369515
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbhDWOu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:50:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231274AbhDWOuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:50:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 337BBB140;
        Fri, 23 Apr 2021 14:49:48 +0000 (UTC)
Subject: Re: [PATCH 1/6] mm: Make __dump_page static
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210416231531.2521383-1-willy@infradead.org>
 <20210416231531.2521383-2-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b54d29a1-4dcb-d3d3-e992-616e1da05d72@suse.cz>
Date:   Fri, 23 Apr 2021 16:49:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210416231531.2521383-2-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/21 1:15 AM, Matthew Wilcox (Oracle) wrote:
> The only caller of __dump_page() now opencodes dump_page(), so
> remove it as an externally visible symbol.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mmdebug.h | 3 +--
>  mm/debug.c              | 2 +-
>  mm/page_alloc.c         | 3 +--
>  3 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> index 5d0767cb424a..1935d4c72d10 100644
> --- a/include/linux/mmdebug.h
> +++ b/include/linux/mmdebug.h
> @@ -9,8 +9,7 @@ struct page;
>  struct vm_area_struct;
>  struct mm_struct;
>  
> -extern void dump_page(struct page *page, const char *reason);
> -extern void __dump_page(struct page *page, const char *reason);
> +void dump_page(struct page *page, const char *reason);
>  void dump_vma(const struct vm_area_struct *vma);
>  void dump_mm(const struct mm_struct *mm);
>  
> diff --git a/mm/debug.c b/mm/debug.c
> index 0bdda8407f71..84cdcd0f7bd3 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -42,7 +42,7 @@ const struct trace_print_flags vmaflag_names[] = {
>  	{0, NULL}
>  };
>  
> -void __dump_page(struct page *page, const char *reason)
> +static void __dump_page(struct page *page, const char *reason)
>  {
>  	struct page *head = compound_head(page);
>  	struct address_space *mapping;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5a35f21b57c6..0152670c6f04 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -658,8 +658,7 @@ static void bad_page(struct page *page, const char *reason)
>  
>  	pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
>  		current->comm, page_to_pfn(page));
> -	__dump_page(page, reason);
> -	dump_page_owner(page);
> +	dump_page(page, reason);
>  
>  	print_modules();
>  	dump_stack();
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496C4369526
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhDWOyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:54:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:33346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231219AbhDWOyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:54:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF934B14D;
        Fri, 23 Apr 2021 14:53:36 +0000 (UTC)
Subject: Re: [PATCH 3/6] mm/page_owner: Constify dump_page_owner
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210416231531.2521383-1-willy@infradead.org>
 <20210416231531.2521383-4-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d1ab316f-4a94-ee99-0828-dbb017c929ef@suse.cz>
Date:   Fri, 23 Apr 2021 16:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210416231531.2521383-4-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/21 1:15 AM, Matthew Wilcox (Oracle) wrote:
> dump_page_owner() only uses struct page to find the page_ext, and
> lookup_page_ext() already takes a const argument.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/page_owner.h | 6 +++---
>  mm/page_owner.c            | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
> index 3468794f83d2..719bfe5108c5 100644
> --- a/include/linux/page_owner.h
> +++ b/include/linux/page_owner.h
> @@ -14,7 +14,7 @@ extern void __set_page_owner(struct page *page,
>  extern void __split_page_owner(struct page *page, unsigned int nr);
>  extern void __copy_page_owner(struct page *oldpage, struct page *newpage);
>  extern void __set_page_owner_migrate_reason(struct page *page, int reason);
> -extern void __dump_page_owner(struct page *page);
> +extern void __dump_page_owner(const struct page *page);
>  extern void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>  					pg_data_t *pgdat, struct zone *zone);
>  
> @@ -46,7 +46,7 @@ static inline void set_page_owner_migrate_reason(struct page *page, int reason)
>  	if (static_branch_unlikely(&page_owner_inited))
>  		__set_page_owner_migrate_reason(page, reason);
>  }
> -static inline void dump_page_owner(struct page *page)
> +static inline void dump_page_owner(const struct page *page)
>  {
>  	if (static_branch_unlikely(&page_owner_inited))
>  		__dump_page_owner(page);
> @@ -69,7 +69,7 @@ static inline void copy_page_owner(struct page *oldpage, struct page *newpage)
>  static inline void set_page_owner_migrate_reason(struct page *page, int reason)
>  {
>  }
> -static inline void dump_page_owner(struct page *page)
> +static inline void dump_page_owner(const struct page *page)
>  {
>  }
>  #endif /* CONFIG_PAGE_OWNER */
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index adfabb560eb9..f51a57e92aa3 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -392,7 +392,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  	return -ENOMEM;
>  }
>  
> -void __dump_page_owner(struct page *page)
> +void __dump_page_owner(const struct page *page)
>  {
>  	struct page_ext *page_ext = lookup_page_ext(page);
>  	struct page_owner *page_owner;
> 


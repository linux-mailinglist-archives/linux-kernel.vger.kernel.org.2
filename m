Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD0F36BDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 05:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhD0DaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 23:30:09 -0400
Received: from foss.arm.com ([217.140.110.172]:43350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhD0DaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 23:30:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AFA3D6E;
        Mon, 26 Apr 2021 20:29:25 -0700 (PDT)
Received: from [10.163.75.249] (unknown [10.163.75.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C18FB3F694;
        Mon, 26 Apr 2021 20:29:23 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 1/6] mm: Make __dump_page static
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210416231531.2521383-1-willy@infradead.org>
 <20210416231531.2521383-2-willy@infradead.org>
Message-ID: <10b90e32-972a-2a55-082c-b576aa5c569d@arm.com>
Date:   Tue, 27 Apr 2021 09:00:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210416231531.2521383-2-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/21 4:45 AM, Matthew Wilcox (Oracle) wrote:
> The only caller of __dump_page() now opencodes dump_page(), so
> remove it as an externally visible symbol.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

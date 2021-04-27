Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8879E36BDC2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 05:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhD0Dbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 23:31:39 -0400
Received: from foss.arm.com ([217.140.110.172]:43400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234573AbhD0Dbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 23:31:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13B34D6E;
        Mon, 26 Apr 2021 20:30:54 -0700 (PDT)
Received: from [10.163.75.249] (unknown [10.163.75.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4F383F694;
        Mon, 26 Apr 2021 20:30:52 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 4/6] mm: Make compound_head const-preserving
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210416231531.2521383-1-willy@infradead.org>
 <20210416231531.2521383-5-willy@infradead.org>
Message-ID: <8c1f9169-5da5-0f1b-14cd-942f54b30ff9@arm.com>
Date:   Tue, 27 Apr 2021 09:01:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210416231531.2521383-5-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/21 4:45 AM, Matthew Wilcox (Oracle) wrote:
> If you pass a const pointer to compound_head(), you get a const pointer
> back; if you pass a mutable pointer, you get a mutable pointer back.
> Also remove an unnecessary forward definition of struct page; we're about
> to dereference page->compound_head, so it must already have been defined.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/page-flags.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 04a34c08e0a6..d8e26243db25 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -177,17 +177,17 @@ enum pageflags {
>  
>  #ifndef __GENERATING_BOUNDS_H
>  
> -struct page;	/* forward declaration */
> -
> -static inline struct page *compound_head(struct page *page)
> +static inline unsigned long _compound_head(const struct page *page)
>  {
>  	unsigned long head = READ_ONCE(page->compound_head);
>  
>  	if (unlikely(head & 1))
> -		return (struct page *) (head - 1);
> -	return page;
> +		return head - 1;
> +	return (unsigned long)page;
>  }
>  
> +#define compound_head(page)	((typeof(page))_compound_head(page))
> +
>  static __always_inline int PageTail(struct page *page)
>  {
>  	return READ_ONCE(page->compound_head) & 1;
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

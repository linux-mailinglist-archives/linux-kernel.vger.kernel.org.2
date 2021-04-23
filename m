Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C580536953E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbhDWO6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:58:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:36382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhDWO6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:58:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 500AFAF17;
        Fri, 23 Apr 2021 14:58:15 +0000 (UTC)
Subject: Re: [PATCH 4/6] mm: Make compound_head const-preserving
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210416231531.2521383-1-willy@infradead.org>
 <20210416231531.2521383-5-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <228b6174-5fa7-23d8-5a17-f85f6725068b@suse.cz>
Date:   Fri, 23 Apr 2021 16:58:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210416231531.2521383-5-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/21 1:15 AM, Matthew Wilcox (Oracle) wrote:
> If you pass a const pointer to compound_head(), you get a const pointer
> back; if you pass a mutable pointer, you get a mutable pointer back.

Hmm, nice trick.

> Also remove an unnecessary forward definition of struct page; we're about
> to dereference page->compound_head, so it must already have been defined.

Right.

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

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


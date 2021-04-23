Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C75369585
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243681AbhDWPCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:02:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:39278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243310AbhDWPCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:02:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01D15B14D;
        Fri, 23 Apr 2021 15:01:28 +0000 (UTC)
Subject: Re: [PATCH 6/6] mm: Constify page_count and page_ref_count
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210416231531.2521383-1-willy@infradead.org>
 <20210416231531.2521383-7-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <960066da-c982-f6c7-ddce-73c054a6a843@suse.cz>
Date:   Fri, 23 Apr 2021 17:01:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210416231531.2521383-7-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/21 1:15 AM, Matthew Wilcox (Oracle) wrote:
> Now that compound_head() accepts a const struct page pointer, these two
> functions can be marked as not modifying the page pointer they are passed.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/page_ref.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index f3318f34fc54..7ad46f45df39 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -62,12 +62,12 @@ static inline void __page_ref_unfreeze(struct page *page, int v)
>  
>  #endif
>  
> -static inline int page_ref_count(struct page *page)
> +static inline int page_ref_count(const struct page *page)
>  {
>  	return atomic_read(&page->_refcount);
>  }
>  
> -static inline int page_count(struct page *page)
> +static inline int page_count(const struct page *page)
>  {
>  	return atomic_read(&compound_head(page)->_refcount);
>  }
> 


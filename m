Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F4736BDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 05:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhD0Dcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 23:32:32 -0400
Received: from foss.arm.com ([217.140.110.172]:43432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232295AbhD0Dcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 23:32:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E125FD6E;
        Mon, 26 Apr 2021 20:31:48 -0700 (PDT)
Received: from [10.163.75.249] (unknown [10.163.75.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57C483F694;
        Mon, 26 Apr 2021 20:31:47 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 6/6] mm: Constify page_count and page_ref_count
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210416231531.2521383-1-willy@infradead.org>
 <20210416231531.2521383-7-willy@infradead.org>
Message-ID: <708b4f1f-950f-c266-3067-b8f71b432266@arm.com>
Date:   Tue, 27 Apr 2021 09:02:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210416231531.2521383-7-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/21 4:45 AM, Matthew Wilcox (Oracle) wrote:
> Now that compound_head() accepts a const struct page pointer, these two
> functions can be marked as not modifying the page pointer they are passed.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

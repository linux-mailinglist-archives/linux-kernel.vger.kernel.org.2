Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3401B34D5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 19:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhC2RPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhC2RO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:14:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B8FC061574;
        Mon, 29 Mar 2021 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qFjG2sAenIACloeegredFO6bNxng6P7GkaqFjdUrTIE=; b=H1S47WOi3yw9L3md+Wm5LfUZH7
        N1hnN7TFFXJorN8+d5wU/uROq47wNZKSkNknrpPBf3MO5HPUU05AbNhEL3StMmAHFCYmDYDNK8PHg
        PPp3aVFpbtDaEvTiG50hvl1jIYqWgrycuhD4mo/5Zj2NxRozi/PSaBpWSGKqssyy1TE2Iy6rRv1fU
        Kt1qUPVVo2I7ZSBtpBGm23QQwu1W8fVmNzIbGzw9oSaLl8pIBQoTfRgEQjUqA3g4LLDTO0tIEuqkw
        I2HSSsjAxgKDHcHeGoHQcP6coJW/TIAHcwSzB5ipRkvK3VDFEj4iTTzhAZ5rP9VXzxnkGn2MAdtMZ
        uZHlgyCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQvTG-001sAs-Jl; Mon, 29 Mar 2021 17:14:39 +0000
Date:   Mon, 29 Mar 2021 18:14:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm/vmalloc: Fix read of pointer area after it has
 been free'd
Message-ID: <20210329171434.GH351017@casper.infradead.org>
References: <20210329170730.121943-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329170730.121943-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 06:07:30PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the memory pointed to by area is being freed by the
> free_vm_area call and then area->nr_pages is referencing the
> free'd object. Fix this swapping the order of the warn_alloc
> message and the free.
> 
> Addresses-Coverity: ("Read from pointer after free")
> Fixes: 014ccf9b888d ("mm/vmalloc: improve allocation failure error messages")

i don't have this git sha.  if this is -next, the sha ids aren't stable
and shouldn't be referenced in commit logs, because these fixes should
just be squashed into the not-yet-upstream commits.

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b73e4e715e0d..7936405749e4 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2790,11 +2790,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	}
>  
>  	if (!pages) {
> -		free_vm_area(area);
>  		warn_alloc(gfp_mask, NULL,
>  			   "vmalloc size %lu allocation failure: "
>  			   "page array size %lu allocation failed",
>  			   area->nr_pages * PAGE_SIZE, array_size);
> +		free_vm_area(area);
>  		return NULL;

this fix looks right to me.


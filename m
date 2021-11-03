Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7C9444A71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 22:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhKCVqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 17:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhKCVq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 17:46:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D481AC061714;
        Wed,  3 Nov 2021 14:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6fB7Iv/vTAGVpFaMyL4RC5bfNZ1EkOgkaTbl7yf+osU=; b=rAaAhiBgZ/s/ebe2VxmLb/GcAa
        6j8WBKDdATe866nlwbwsA6v+eQAU2hoXeuKIVN6TedPPfh1bDu4MW4AfOapoaFSDgz7kr9ZNrk8kG
        GvYY7i4RY7/lFdEwR6dTG6KhUhONoma0/A4x3L+lDjw1b7CTRLKAfoD2D/crOc3TMvBp7nQlW9JgL
        L0I14fkcRwwNQHnF+NSxXJu32zCVZ+jObzNTcQ9oe1K/tBbN5yAuQXVDpN/NgfHhMLwckVa5YtxDt
        xBJZD+eFUYrqLrkp44NacZL6RnnmnOb4afQz4CQJtRUxKnGYkdsY4zISw3uGwuq4XIA7lnrxScmaO
        PXQEeIAw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miO15-005U8D-LY; Wed, 03 Nov 2021 21:42:24 +0000
Date:   Wed, 3 Nov 2021 21:41:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm/mremap_pages: Save a few cycles in 'get_dev_pagemap()'
Message-ID: <YYMCI2S03+azi7nK@casper.infradead.org>
References: <b4a47154877853cc64be3a35dcfd594d40cc2bce.1635975283.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a47154877853cc64be3a35dcfd594d40cc2bce.1635975283.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 10:35:34PM +0100, Christophe JAILLET wrote:
> Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
> save a few cycles when it is known that the rcu lock is already
> taken/released.

If this is really important, we can add an __xa_load() which doesn't
take the RCU read lock.

I honestly think that the xarray is the wrong data structure here,
and we'd be better off with a simple array of (start, pointer)
tuples.

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  mm/memremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 84de22c14567..012e8d23d365 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -506,7 +506,7 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>  	/* fall back to slow path lookup */
>  	rcu_read_lock();
>  	pgmap = xa_load(&pgmap_array, PHYS_PFN(phys));
> -	if (pgmap && !percpu_ref_tryget_live(pgmap->ref))
> +	if (pgmap && !percpu_ref_tryget_live_rcu(pgmap->ref))
>  		pgmap = NULL;
>  	rcu_read_unlock();
>  
> -- 
> 2.30.2
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C268F3F0937
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhHRQft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbhHRQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:35:44 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0C0C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 09:35:09 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id b25-20020a4ac2990000b0290263aab95660so858993ooq.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=FsOxk8xEX3Y2k9eBNIFeNmSd4j8BBkPPy3JPmJxj3/A=;
        b=U6Cdj7fZ/XePCbSUaZ7pv7n0S7sZkSrrOrA9PbU1L8v/HM8wLDGFAtzaqmhZeRCQga
         j1SiL+lfuclQI80WNGXNb0vfYzs3GYQj/RJ4tWupVUBJHspqZqwi9kU88AP6qTfMHIDg
         /vIsALWorZO51q+BwrYTeQspOrHLJ5bBrTfawtFk3TR1fTrpcuMJTjXy2KumNBCw3k3X
         bIIAVYo2uhL/IO/3MbQK6Wh0OQd+7F+Rb9lhAvbbSrQa4EvJwpTW+rgsD/KHC5i+Jk8A
         ffiUGP1m/lge6y90sUevzKZJtzTSL9d2yvVoskChXQCqkKBDR2kx5Fxpapho1Hi2TfG9
         wvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=FsOxk8xEX3Y2k9eBNIFeNmSd4j8BBkPPy3JPmJxj3/A=;
        b=KodZjBAemnQL47oYusFWhJtB2OQ2Vy0T8/Brxt2OupMIKNGmkQQKjLM9Xh8xDl6fqS
         L/BDRc/opWWBn/eqnHkMb+LIwJGK5zvZI6RuEFOkn7qq5Dut28P9gXVKFXb+fF5QZEQZ
         GKX9Y6YEWCZgRN09IXiVuAqEAVXfRpszsxp893XwcJwJt14xHHXHdGkeFoWQS/7sJQAq
         hZQnwnhqulrs9FYgwZeB04QKYJzmGjhGdqkq1HNn9Iire/o8WnJUC1Tv9Aw9erNduN6o
         9tID/L2mQ6X2X6/rDGILB72jXL/9AXM2c/HdIEosOKdqkHjGTIBD1l+j4bEWpkpRcNqB
         dM0w==
X-Gm-Message-State: AOAM531MTVkBoAu+8nirpW9ZZPXhgwVBRtX1c1i6m0xt6ziTtTrAEDCi
        3oc0mVST9zZNMANyTgm4L3sB0nysBIA9cg==
X-Google-Smtp-Source: ABdhPJxVQCjOlNDLHatSHn/5DyaB1NIFWcKsb6VB8oS9/r0EckuXMuKL0P7R99uExi1pgZo6aBpaYQ==
X-Received: by 2002:a4a:3393:: with SMTP id q141mr1269993ooq.48.1629304508535;
        Wed, 18 Aug 2021 09:35:08 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k21sm98571ots.53.2021.08.18.09.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:35:07 -0700 (PDT)
Date:   Wed, 18 Aug 2021 09:34:51 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Remove bogus VM_BUG_ON
In-Reply-To: <20210818144932.940640-1-willy@infradead.org>
Message-ID: <2197941-297c-f820-aa57-fb5167794fb1@google.com>
References: <20210818144932.940640-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021, Matthew Wilcox (Oracle) wrote:

> It is not safe to check page->index without holding the page lock.
> It can be changed if the page is moved between the swap cache and the
> page cache for a shmem file, for example.  There is a VM_BUG_ON below
> which checks page->index is correct after taking the page lock.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5c211ba29deb ("mm: add and use find_lock_entries")

I don't mind that VM_BUG_ON_PAGE() being removed, but question whether
this Fixes anything, and needs to go to stable. Or maybe it's just that
the shmem example is wrong - moving shmem from page to swap cache does
not change page->index. Or maybe you have later changes in your tree
which change that and do require this. Otherwise, I'll have to worry
why my testing has missed it for six months.

Hugh

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d1458ecf2f51..34de0b14aaa9 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2033,17 +2033,16 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
>  	XA_STATE(xas, &mapping->i_pages, start);
>  	struct page *page;
>  
>  	rcu_read_lock();
>  	while ((page = find_get_entry(&xas, end, XA_PRESENT))) {
>  		if (!xa_is_value(page)) {
>  			if (page->index < start)
>  				goto put;
> -			VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
>  			if (page->index + thp_nr_pages(page) - 1 > end)
>  				goto put;
>  			if (!trylock_page(page))
>  				goto put;
>  			if (page->mapping != mapping || PageWriteback(page))
>  				goto unlock;
>  			VM_BUG_ON_PAGE(!thp_contains(page, xas.xa_index),
>  					page);
> -- 
> 2.30.2

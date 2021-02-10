Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F053171DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhBJVD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhBJVDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:03:24 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8C9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:02:44 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id a1so1563951qvd.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ENOzr6xjO3GQpgbSD6bbLoPeXooC9WGlpjJfzIMnDjU=;
        b=eWPMQlwJx9FTsLZHopk9ic4CJOMfVy3EdaxI75SqMMnZ/MxXgBVmjq/OPVeLGBEPNG
         FRdM9uQJSDBFKKarZP4bsuSFLUGonS5KRxViNDNMoajXRxTuZfdLAbU4YL3YSjQ0mCQj
         3MzMo7HB7dpMk4wL0gzf9EFbddo1bHTFff3XXe5FyPujiKDO1i2Tp4MsC+bi8t/Mp1dQ
         XGVXud+7jAEtKajVRBkq/QObcZ3J+WtlW71TJzMm/Vzjwmy8K55Lpj1gJA03omHlRggS
         sZgOeI/eJbA18a5U7epZJGvq1TMS+EcRAEmoBF6SNMjaBGaX6EgjnV0PDDhsBD2IFnMT
         Z7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ENOzr6xjO3GQpgbSD6bbLoPeXooC9WGlpjJfzIMnDjU=;
        b=d1K4aIlZYv3N81bNbJ/5ZCRydXvfi1VpQtQigL0OC0iZhcUwIFrxaMUFGHQiNM620a
         bjaRS8f3Fdnp3wHoVlF5RF7UXl4B62FtmPA6CWZqNRB2EIfKnCtPbV/CkGi16VVEqkXO
         B+33JvGVMLXFHhyNkJcrSoc0XfN8iMDNyF9cv4DW8fTLueuC16rZVsdqgTPEmDCK47qa
         vF0cUSsrWVcxcuzTiDmoqjdQgUGGdYm1CsEgRHbsNabxz+1Z8MvfWfXw4hvXc8tiDSwQ
         NaGObOagJvMKh0ZUUWvvLRN4K4YDzubZuzxkUe4gOzPtAd9fcoi4PH7UHtKvpb3ue9vY
         VuXw==
X-Gm-Message-State: AOAM5338IrwKjvA8u8S04lBAQv+bFc84g4p6+RbbkGuZWfEFoJA7XF/D
        hKzxGozH4MTyelYuE/gKzeFRrQ==
X-Google-Smtp-Source: ABdhPJxVTu0NNc1dwqHKIru9SwFEsfLYBP8IqwNRyyTs4tByZCvQcnCyYHh3gdu9CycqQtlKhrtn6A==
X-Received: by 2002:a05:6214:c27:: with SMTP id a7mr4541393qvd.54.1612990963899;
        Wed, 10 Feb 2021 13:02:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id 14sm2304346qkr.70.2021.02.10.13.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 13:02:43 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9wdG-006F9X-H8; Wed, 10 Feb 2021 17:02:42 -0400
Date:   Wed, 10 Feb 2021 17:02:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 2/4] mm/gup: decrement head page once for group of
 subpages
Message-ID: <20210210210242.GQ4718@ziepe.ca>
References: <20210205204127.29441-1-joao.m.martins@oracle.com>
 <20210205204127.29441-3-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205204127.29441-3-joao.m.martins@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 08:41:25PM +0000, Joao Martins wrote:
> Rather than decrementing the head page refcount one by one, we
> walk the page array and checking which belong to the same
> compound_head. Later on we decrement the calculated amount
> of references in a single write to the head page. To that
> end switch to for_each_compound_head() does most of the work.
> 
> set_page_dirty() needs no adjustment as it's a nop for
> non-dirty head pages and it doesn't operate on tail pages.
> 
> This considerably improves unpinning of pages with THP and
> hugetlbfs:
> 
> - THP
> gup_test -t -m 16384 -r 10 [-L|-a] -S -n 512 -w
> PIN_LONGTERM_BENCHMARK (put values): ~87.6k us -> ~23.2k us
> 
> - 16G with 1G huge page size
> gup_test -f /mnt/huge/file -m 16384 -r 10 [-L|-a] -S -n 512 -w
> PIN_LONGTERM_BENCHMARK: (put values): ~87.6k us -> ~27.5k us
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)

Looks fine

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I was wondering why this only touches the FOLL_PIN path, it would make
sense to also use this same logic for release_pages()

        for (i = 0; i < nr; i++) {
                struct page *page = pages[i];
                page = compound_head(page);
                if (is_huge_zero_page(page))
                        continue; 

Jason

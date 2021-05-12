Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB05537B468
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhELDP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:15:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D679C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 20:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ikQ41RlJwrGMcA091zj9/uV4xrqM2kq1Y5GRuRy1/n4=; b=Z/blpsXJZSz93O3+ZclMM7GD+m
        i5SWNkKM3phfo9jPdppT/b2MgSSKrI//Q8iUqs6zwHUifxCzhl0qszp2wWntQVsWLYd9qLcBhVGw6
        4KtkG4ZrlF+QC2TxAv1BsjAf93n9zWbQzXugCSj5dBvwUE7lh7wJPbBbY19nMzj9J6DrcX4WKEDSg
        5ken6jREJqN5Lz81EWAOr46wwuaGGPPbwmUI3qaKycnfAtwEg//sxXCyy4+KSzXW8JsBmlHyFhOgD
        3BLBq9jjErdc4a5aVgZHyDOnrgEqjfaIiPZgK2UqtxKQqn6hPtlh3UAUHOBbwrCu5U8qoK977Otp0
        VqjBhjFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgfKH-007tYD-8D; Wed, 12 May 2021 03:14:25 +0000
Date:   Wed, 12 May 2021 04:14:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/page_alloc: Use dump_page() directly
Message-ID: <YJtIDeb+Y2eNu0bs@casper.infradead.org>
References: <20210512031057.13580-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512031057.13580-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 11:10:55AM +0800, Kefeng Wang wrote:
> Simplfy use dump_page().

https://lore.kernel.org/linux-mm/20210430145549.2662354-3-willy@infradead.org/

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/page_alloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a2fe714aed93..f23702e7c564 100644
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
> -- 
> 2.26.2
> 

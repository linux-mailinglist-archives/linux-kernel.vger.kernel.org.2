Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2315E3792F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhEJPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhEJPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:46:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23705C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Flo9l/jYDkRKwx0f14g3k6U8nqbHT13bVIHshVunBVM=; b=gujTuZIsMzIdK8d25Kl1FvLEEb
        nlA8vBvFfU8SvSQhTMVA2CmdHJffyObUCHMeV+VywGbf0oHAjVxz9s4/F9Eg03L50I8ud0n8GLdFn
        xkss71KzHy1YbzOB8Pz69/AqtkgkDugtVNPhcKce4+WXDxqIv1IL9BG/8NdBbwmV+Pz5IfdwVHXXS
        u4xcakk04MW9kx0dZ3CHLm9e37hqI08KFVG0BM32h7oajOtKIb25WDP5dYUYrsSk0iKO/SvGsIqq2
        Xr5biMYWvey86Dp/R5reHBkDbLw/ZAHvsm20rwi1b+IgVIaK064zKvdvuIyNeVs3OCXefoNkOuik5
        +8q+vX0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lg84n-006KCh-T2; Mon, 10 May 2021 15:44:25 +0000
Date:   Mon, 10 May 2021 16:44:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: kmalloc_index: make compiler break when size is
 not supported
Message-ID: <YJlUyc8t7MoGTFTe@casper.infradead.org>
References: <20210508221328.7338-1-42.hyeyoo@gmail.com>
 <YJccjBMBiwLqFrB8@casper.infradead.org>
 <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
 <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz>
 <20210510135857.GA3594@hyeyoo>
 <9d0ffe49-a2e2-6c81-377b-4c8d2147dff8@suse.cz>
 <20210510150230.GA74915@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510150230.GA74915@hyeyoo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 12:02:30AM +0900, Hyeonggon Yoo wrote:
> @@ -382,8 +385,8 @@ static __always_inline unsigned int kmalloc_index(size_t size)
>  	if (size <=  8 * 1024 * 1024) return 23;
>  	if (size <=  16 * 1024 * 1024) return 24;
>  	if (size <=  32 * 1024 * 1024) return 25;
> -	if (size <=  64 * 1024 * 1024) return 26;
> -	BUG();
> +
> +	BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");

we're being encouraged to use static_assert() these days.
https://en.cppreference.com/w/c/language/_Static_assert


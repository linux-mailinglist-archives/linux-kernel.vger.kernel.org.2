Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F058B3397F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhCLUGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbhCLUFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:05:51 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918E8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:05:50 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v15so5478506wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QGcOUOWYrtlGEtGtp6CRhZz9BsHqr4gvekeyWTQX/+U=;
        b=qXjLpE1SzOwXL9eMZ4sVgx+Ho7QAI/X5+cU88dH2+5FstbM+imrk9OxnjbVeUcR6YI
         rx0szxhQCI8AwDfNdyCzkSp6a+z9FHIl/SnJa9covZXzclAP8CNUjmxCgD7/534BDM6l
         D5x0bFj0S+9CccUOvMiSnHZUhUyL4Nt9dfbwP5yvfRMnIxL7OfxWIDZJJgqN5xGHElo3
         TzGsWFTFsxG3nrEYYJI+xiF1cTm5NaPZ7HLpKzP+u5x/paqU7X6VgvZCJ0OZpm/IBXfF
         6pwmLJN2F3lsXuNQqTo21sTgShG48HUbToep4zwaSQVJ3Y5HPCcjdZGdYD0SEp5qRrJg
         IczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QGcOUOWYrtlGEtGtp6CRhZz9BsHqr4gvekeyWTQX/+U=;
        b=QI+mCb/uSJC+cpusfI1WlMti7m6if1TobR9M/KZZPIEpUAaS4gXq4Rty4GPw6IxEiZ
         hpYURsSzfK8eYSJXFX0cEYh6bmbRzcFFmTjAYoQybA/rj4Saah09N/B2YizB0F077HSr
         jSkaFmFjkWhiUIPW8P8wK/B4Ibwx06U/szBweYBT33Q1R9f1zWkL9k+BnA8HLm6VM0S1
         NBrwdLVJUB7sK3B+6W71/j1LK7YhmBKZlUiMrhXQxGlKEVWo0q4hPzNpU/B034///UNU
         Q1H7EUWgAlyzdI2YBN5kQJKexsm8TJ7Tw2004kyIum+eb30zkh7j3xwOi02sMjnP/oJ0
         FEGg==
X-Gm-Message-State: AOAM530Nt3oviwz8wN04VKNQ++xAoICeZ3ROTVkaIPbFsod3Fghd8yuH
        vv3NqYyPwq2Lvs+XWy+7nNKjf0j/uZku6n9hm0Y=
X-Google-Smtp-Source: ABdhPJw8cRrGcaQUUVnqA8Tyww1Pzpw79qa1UHk7Y7H/248bMIaCPg9pzS91Nl7GhXEgRhZp4++izQ==
X-Received: by 2002:adf:f04e:: with SMTP id t14mr15854532wro.100.1615579549084;
        Fri, 12 Mar 2021 12:05:49 -0800 (PST)
Received: from apalos.home (ppp-94-64-113-158.home.otenet.gr. [94.64.113.158])
        by smtp.gmail.com with ESMTPSA id i11sm9148238wro.53.2021.03.12.12.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:05:48 -0800 (PST)
Date:   Fri, 12 Mar 2021 22:05:45 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Net <netdev@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-NFS <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 7/7] net: page_pool: use alloc_pages_bulk in refill code
 path
Message-ID: <YEvJmVrnTzKT1XAY@apalos.home>
References: <20210312154331.32229-1-mgorman@techsingularity.net>
 <20210312154331.32229-8-mgorman@techsingularity.net>
 <CAKgT0UebK=mMwDV+UH8CqBRt0E0Koc7EB42kwgf0hYHDT_2OfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UebK=mMwDV+UH8CqBRt0E0Koc7EB42kwgf0hYHDT_2OfQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> 6. return last_page
> 
> > +       /* Remaining pages store in alloc.cache */
> > +       list_for_each_entry_safe(page, next, &page_list, lru) {
> > +               list_del(&page->lru);
> > +               if ((pp_flags & PP_FLAG_DMA_MAP) &&
> > +                   unlikely(!page_pool_dma_map(pool, page))) {
> > +                       put_page(page);
> > +                       continue;
> > +               }
> 
> So if you added a last_page pointer what you could do is check for it
> here and assign it to the alloc cache. If last_page is not set the
> block would be skipped.
> 
> > +               if (likely(pool->alloc.count < PP_ALLOC_CACHE_SIZE)) {
> > +                       pool->alloc.cache[pool->alloc.count++] = page;
> > +                       pool->pages_state_hold_cnt++;
> > +                       trace_page_pool_state_hold(pool, page,
> > +                                                  pool->pages_state_hold_cnt);
> > +               } else {
> > +                       put_page(page);
> 
> If you are just calling put_page here aren't you leaking DMA mappings?
> Wouldn't you need to potentially unmap the page before you call
> put_page on it?

Oops, I completely missed that. Alexander is right here.

> 
> > +               }
> > +       }
> > +out:
> >         if ((pp_flags & PP_FLAG_DMA_MAP) &&
> > -           unlikely(!page_pool_dma_map(pool, page))) {
> > -               put_page(page);
> > +           unlikely(!page_pool_dma_map(pool, first_page))) {
> > +               put_page(first_page);
> 
> I would probably move this block up and make it a part of the pp_order
> block above. Also since you are doing this in 2 spots it might make
> sense to look at possibly making this an inline function.
> 
> >                 return NULL;
> >         }
> >
> >         /* Track how many pages are held 'in-flight' */
> >         pool->pages_state_hold_cnt++;
> > -       trace_page_pool_state_hold(pool, page, pool->pages_state_hold_cnt);
> > +       trace_page_pool_state_hold(pool, first_page, pool->pages_state_hold_cnt);
> >
> >         /* When page just alloc'ed is should/must have refcnt 1. */
> > -       return page;
> > +       return first_page;
> >  }
> >
> >  /* For using page_pool replace: alloc_pages() API calls, but provide
> > --
> > 2.26.2
> >

Cheers
/Ilias

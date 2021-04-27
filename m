Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E9E36BEE7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 07:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhD0FcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 01:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhD0FcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 01:32:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DB6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 22:31:17 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z13so10820318lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 22:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jLMeSiD6Y5YsMzqdnzEiur6mPosjCpX1GBqmXNpNtw=;
        b=S2vrtE4NPlJkvLXARFdUv7pWBArnN+pP4X+Xq/14n8oW49uUvqGrNrC+YRfecR75gx
         lC4UW9HmEIg5kubGyZz8652u9F5Z8r3qfL/0O2o4PQMdsqwcxZ2+fetvrKAe6C+Pudn0
         WWSYOQzIX2Op2sjXDFKAAX7nWEJaobKfq1bQMeV8tquAsyd26woo/lhAu7tyCxiXybUm
         1zkdEVYYq965SnYjCGl3a9d7pAjNdazFcL8PwgTG0rHWdsvH2d9+1Oa3fXPIJW2Ah9Pt
         VngLuiZCQWoFkCg+ZG5++P3xCDwEDI5SAbz/rhEitPjANO7Mfw3R0rmUUYXQ++JR7Ydy
         Rx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jLMeSiD6Y5YsMzqdnzEiur6mPosjCpX1GBqmXNpNtw=;
        b=mHv2LwxGORacvRjPDb1Alkk5NCbEWJDrWz6rpCrOqX5jAQnluL8qZc/M/IydekVdQq
         h8Npxrm1MMrwpQSxfjKNPJP+16RWq/AObz3JmoLME3rAuHkp7xHLwjrGuPLsbjbLF3tG
         tbMYLpx21n+QAqmLtoL74ohJOyWWM7wG6AQzcQPp3+TJjTv31JvwPTdErgvWSRU4MStb
         dB+U0GBbxzv9Aj1p9IzpATwTpOM6JwrVSzSUgtpHja8cTggrE480rhAzfGiSRNRtgFTi
         DxaGPxbXwynUj8PEGAy80Gba4v2FOyCRbZTeNw3w6nw6k97RjvULrszgyrjLfFdOhQ3g
         qG9Q==
X-Gm-Message-State: AOAM533bj1VuMtQ7OU2IneDAmPS9iqP1dtpZsC4WD9/ixN5HBmatPDmy
        Id8Dre7UXLBksQJNgN1SEhe52fWylHFUGNWfObU=
X-Google-Smtp-Source: ABdhPJyrbZfZM2SHQIqhG6K8SX3CtUI/adyr+X7KIXKFEJ49Z3LSNWLgqP47lpNbqOnme1Whu5m4aRfaryAvGsLBRT0=
X-Received: by 2002:a19:f504:: with SMTP id j4mr2400245lfb.307.1619501475555;
 Mon, 26 Apr 2021 22:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <1619491400-1904-1-git-send-email-sxwjean@me.com>
 <20210427025358.GV235567@casper.infradead.org> <CAEVVKH_wZJvNAgFEF1OxThxN3AC4mopZ+Pu2GC0Hn_-2JOfC5Q@mail.gmail.com>
 <20210427033632.GW235567@casper.infradead.org> <CAEVVKH8ZOt3XSPy1VA1n+MKmqucgcnxjusfhoTbwkitOkErrrw@mail.gmail.com>
In-Reply-To: <CAEVVKH8ZOt3XSPy1VA1n+MKmqucgcnxjusfhoTbwkitOkErrrw@mail.gmail.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 27 Apr 2021 13:30:48 +0800
Message-ID: <CAEVVKH-7qRVRKsFmzc9NnhS8Lae5Yq=WhSparOmR3dZmD3PkAw@mail.gmail.com>
Subject: Re: [PATCH] mm: append __GFP_COMP flag for trace_malloc
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xiongwei Song <sxwjean@me.com>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mattew,

One more thing I should explain, the kmalloc_order() appends the
__GFP_COMP flags,
not by the caller.

void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
{
...........................................................

flags |= __GFP_COMP;
page = alloc_pages(flags, order);
...........................................................
return ret;
}
EXPORT_SYMBOL(kmalloc_order);

#ifdef CONFIG_TRACING
void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
{
void *ret = kmalloc_order(size, flags, order);
trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
return ret;
}
EXPORT_SYMBOL(kmalloc_order_trace);
#endif


Regards,
Xiongwei

On Tue, Apr 27, 2021 at 12:11 PM Xiongwei Song <sxwjean@gmail.com> wrote:
>
> On Tue, Apr 27, 2021 at 11:36 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Apr 27, 2021 at 11:29:32AM +0800, Xiongwei Song wrote:
> > > On Tue, Apr 27, 2021 at 10:54 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Tue, Apr 27, 2021 at 10:43:20AM +0800, Xiongwei Song wrote:
> > > > > From: Xiongwei Song <sxwjean@gmail.com>
> > > > >
> > > > > When calling kmalloc_order, the flags should include __GFP_COMP here,
> > > > > so that trace_malloc can trace the precise flags.
> > > >
> > > > I suppose that depends on your point of view.
> > > Correct.
> > >
> > > Should we report the
> > > > flags used by the caller, or the flags that we used to allocate memory?
> > > > And why does it matter?
> > > When I capture kmem:kmalloc events on my env with perf:
> > > (perf record -p my_pid -e kmem:kmalloc)
> > > I got the result below:
> > >      0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a4ca0000
> > > bytes_req=10176 bytes_alloc=16384
> > > gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC
> >
> > Hmm ... if you have a lot of allocations about this size, that would
> > argue in favour of adding a kmem_cache of 10880 [*] bytes.  That way,
> > we'd get 3 allocations per 32kB instead of 2.
> I understand you. But I don't think our process needs this size. This size
> may be a bug in our code or somewhere, I don't know the RC for now.
>
> > [*] 32768 / 3, rounded down to a 64 byte cacheline
> >
> > But I don't understand why this confused you.  Your caller at
> > ffffffff851d0cb0 didn't specify __GFP_COMP.  I'd be more confused if
> > this did report __GFP_COMP.
> >
> I just wanted to save some time when debugging.
>
> Regards

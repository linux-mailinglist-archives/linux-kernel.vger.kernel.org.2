Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD9136D0BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 05:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbhD1DGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 23:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhD1DGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 23:06:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02584C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 20:05:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m7so59723624ljp.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 20:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7mo3cbfs0/nbqRuNxTuOd0tFgN99mJ+mVJmHvq4QgM=;
        b=IsoWwKy04IZcM7ZiXZK2wMxIKKYXWODj2QfPfFJ6H++i11iyqoBTUOAK5MdZkp7XT0
         4p6t6XMWmccCi8/kqiLQiqXnj5mLXSfmvrwivJ51WaeW7JZxH8xgWCHsuyZxZRe+EAym
         dhqWRJPfpgXOAS0cEuXZaNXRHze2NAOgKN3zFKmAK78GAeYXlKgOQPCLJs/em5OGyPbX
         Okjs9muuYzsGLd+1SHyRtK3KXhUwmdokP/lZiFOJ6Z69laZh0sq+xpaFnxHzwyNXHajv
         J1vrWHhd3WufsTOcGssFQft0KoE9bgzO3iZw48isweiHUOwHdvBhQaaLhXmRtcMJcyOZ
         upeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7mo3cbfs0/nbqRuNxTuOd0tFgN99mJ+mVJmHvq4QgM=;
        b=N8ufTJIuo47qKN6GNiX4/Rn73EUS4Ji2DwxBnIC52TZMhKJzj5NDMraBAZTZx5jaAY
         SJRPBKmWZAWOCQoFoHmPe8MkS8VRX7bFnEhRciH93zxclsv8hwt1nYxm64O/v/BDRr8P
         BSTV6nRUe75gPryLQf3qhqLkr6iPs175sMQMTjWH97O8pfuqazT4PfiCzReMgLJU6MNG
         fr6ylysRVt/VE5ZFITCt3kzOx8kiprkOBwh5njcQH0rXf90EbMfhYjzBbx5RX/ZwlB7J
         dhEmsKboD3ac2x6lGPP/r6YIBFHyiTk+2Gtr0UezTxxotuq3nj4KUjob0KXTh13irE07
         vsZw==
X-Gm-Message-State: AOAM531/0rzU7wbXOxOR8Qbx20X1y0aI/NZk9+gSVjsCZOFfTkx00ruf
        HnEWifPjVAVMqVIZDxwOKAHXHfvRwqm1hXP12Zc=
X-Google-Smtp-Source: ABdhPJxstYbonXua48xMw6fE3OUm7rGM+t6V4Pthc7kWFYVz94TWzKfW1TBFD5e/rCFgb3R4rW/Z6MYE9zAvvkhc2kY=
X-Received: by 2002:a2e:bb8f:: with SMTP id y15mr19085886lje.86.1619579144266;
 Tue, 27 Apr 2021 20:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <1619491400-1904-1-git-send-email-sxwjean@me.com>
 <20210427025358.GV235567@casper.infradead.org> <CAEVVKH_wZJvNAgFEF1OxThxN3AC4mopZ+Pu2GC0Hn_-2JOfC5Q@mail.gmail.com>
 <20210427033632.GW235567@casper.infradead.org> <CAEVVKH8ZOt3XSPy1VA1n+MKmqucgcnxjusfhoTbwkitOkErrrw@mail.gmail.com>
 <CAEVVKH-7qRVRKsFmzc9NnhS8Lae5Yq=WhSparOmR3dZmD3PkAw@mail.gmail.com> <20210427112527.GX235567@casper.infradead.org>
In-Reply-To: <20210427112527.GX235567@casper.infradead.org>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Wed, 28 Apr 2021 11:05:18 +0800
Message-ID: <CAEVVKH8AFMqwEcpp=7h7k-_BYqwU+gutoUMNM93pnGPiW=u+gg@mail.gmail.com>
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

On Tue, Apr 27, 2021 at 7:26 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Apr 27, 2021 at 01:30:48PM +0800, Xiongwei Song wrote:
> > Hi Mattew,
> >
> > One more thing I should explain, the kmalloc_order() appends the
> > __GFP_COMP flags,
> > not by the caller.
> >
> > void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
> > {
> > ...........................................................
> >
> > flags |= __GFP_COMP;
> > page = alloc_pages(flags, order);
> > ...........................................................
> > return ret;
> > }
> > EXPORT_SYMBOL(kmalloc_order);
> >
> > #ifdef CONFIG_TRACING
> > void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
> > {
> > void *ret = kmalloc_order(size, flags, order);
> > trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
> > return ret;
> > }
> > EXPORT_SYMBOL(kmalloc_order_trace);
> > #endif
>
> Yes, I understood that.  What I don't understand is why appending the
> __GFP_COMP to the trace would have been less confusing for you.
>
> Suppose I have some code which calls:
>
>         kmalloc(10 * 1024, GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC);
>
> and I see in my logs
>
>      0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a4ca0000 bytes_req=10176 bytes_alloc=16384 gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC|__GFP_COMP
>
> That seems to me _more_ confusing because I would wonder "Where did that
> __GFP_COMP come from?"

Thank you for the comments. But I disagree.

When I use trace, I hope I can get the precise data rather than something
changed that I don't know , then I can get the correct conclusion or
direction on my issue.

Here my question is what the trace events are for if they don't provide the
real situation? I think that's not graceful and friendly.

From my perspective, it'd be better to know my flags changed before checking
code lines one by one. In other words, I need a warning to reminder me on this,
then I can know quickly my process might do some incorrect things.

Regards,
Xiongwei

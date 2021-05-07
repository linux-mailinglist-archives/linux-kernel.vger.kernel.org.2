Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6F5375FD3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 07:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhEGFnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 01:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhEGFnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 01:43:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8AAC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 22:42:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j10so11065856lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 22:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUwArXt1iCdXIwHhFgryf7iwp6cge2eaeiWsAF4dcRo=;
        b=Uk4nH6KS+LeFUC6YRrxgumdVC1SGPzSFqA20jxE/bTyDxq4csREcr4Y+AqI61VtKAi
         vfPNPB1YSENtEnCfhH1XU/zOIqJpN6mRAw5Q0xGsO2DxvhEbRxbo5UGxRIMe0pgToyzA
         WHpeMvgwN0hOXM0VUS2AjwVoTX5kAKBCnlvFCIc/4ZmsYVP+AfVhHgjpGo9CU2OScGAI
         cqNCqW/gq4yrlcWrzgozxZ18SErsQnemoKw8XFeXPIzTcZBZq+yVA1vpItln38T2OQpX
         9aLG/V1m16W9UxiXhr2wXx5fIiDgrqqF/LdnJp+YU/A4Zf4vtxib9jDD9ODdHGaGOMc4
         etuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUwArXt1iCdXIwHhFgryf7iwp6cge2eaeiWsAF4dcRo=;
        b=PWvNE0sRvHTs1E0JRJTmRPq0dlRi7OhJk3ca3fw5TF/p3K8qdmB1Cq5iGdedlxBlx0
         5sCOnZuBF4gTEpdPitBJv+BCp8CvYGTpu98Qj5IWDtuij7GGhDyVZ1VFja1v7DM8zoFl
         RGqQBHiJ6qljBfTnVA6fN/0wmYdc5d5cKtEgX8chGbAr5SUjHRySrh5Zx6RyuVCRZX3p
         4MRRiDnmcWxGztlvFPH/WIBmt3sORWzUFA2LfM+fCYEQVGME3+xditd7YxY+EzEQmv4X
         sePT4Yo98xNeqO51tCKfCu6Eh3ez27q9h0v4zg0XVaDfPpmeHkjvmlfTn8sBQbHyd0er
         qRCg==
X-Gm-Message-State: AOAM5317m5zsSCxpHf0t+p0hRQrc6x1Gta2C7oZoRHMuGtvQ/JuYGuHy
        2LgAPDSizVkroBMSozKOHnop0ciq9AJ82cXc2sg=
X-Google-Smtp-Source: ABdhPJyDk0FNvTIUXdXE+nCjY54cKktl1JwQNERc3u38PcT+xPgRYthrW2MW/Cdr8sgKiTAWkUpW9t09PCHGGLwhKuk=
X-Received: by 2002:a05:6512:5d6:: with SMTP id o22mr5343267lfo.587.1620366130789;
 Thu, 06 May 2021 22:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <1619491400-1904-1-git-send-email-sxwjean@me.com>
 <20210427025358.GV235567@casper.infradead.org> <CAEVVKH_wZJvNAgFEF1OxThxN3AC4mopZ+Pu2GC0Hn_-2JOfC5Q@mail.gmail.com>
 <20210427033632.GW235567@casper.infradead.org> <CAEVVKH8ZOt3XSPy1VA1n+MKmqucgcnxjusfhoTbwkitOkErrrw@mail.gmail.com>
 <CAEVVKH-7qRVRKsFmzc9NnhS8Lae5Yq=WhSparOmR3dZmD3PkAw@mail.gmail.com>
 <20210427112527.GX235567@casper.infradead.org> <CAEVVKH8AFMqwEcpp=7h7k-_BYqwU+gutoUMNM93pnGPiW=u+gg@mail.gmail.com>
 <c08e5e63-f66c-211c-5a9b-03ea12ee10bf@suse.cz>
In-Reply-To: <c08e5e63-f66c-211c-5a9b-03ea12ee10bf@suse.cz>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Fri, 7 May 2021 13:41:44 +0800
Message-ID: <CAEVVKH_4zDY8umsM+7B0GXbCTqipGwBmA92akPeum-kBZfrD8g@mail.gmail.com>
Subject: Re: [PATCH] mm: append __GFP_COMP flag for trace_malloc
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <sxwjean@me.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 8:35 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 4/28/21 5:05 AM, Xiongwei Song wrote:
> > On Tue, Apr 27, 2021 at 7:26 PM Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >> On Tue, Apr 27, 2021 at 01:30:48PM +0800, Xiongwei Song wrote:
> >> > Hi Mattew,
> >> >
> >> > One more thing I should explain, the kmalloc_order() appends the
> >> > __GFP_COMP flags,
> >> > not by the caller.
> >> >
> >> > void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
> >> > {
> >> > ...........................................................
> >> >
> >> > flags |= __GFP_COMP;
> >> > page = alloc_pages(flags, order);
> >> > ...........................................................
> >> > return ret;
> >> > }
> >> > EXPORT_SYMBOL(kmalloc_order);
> >> >
> >> > #ifdef CONFIG_TRACING
> >> > void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
> >> > {
> >> > void *ret = kmalloc_order(size, flags, order);
> >> > trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
> >> > return ret;
> >> > }
> >> > EXPORT_SYMBOL(kmalloc_order_trace);
> >> > #endif
> >>
> >> Yes, I understood that.  What I don't understand is why appending the
> >> __GFP_COMP to the trace would have been less confusing for you.
> >>
> >> Suppose I have some code which calls:
> >>
> >>         kmalloc(10 * 1024, GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC);
> >>
> >> and I see in my logs
> >>
> >>      0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a4ca0000 bytes_req=10176 bytes_alloc=16384 gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC|__GFP_COMP
> >>
> >> That seems to me _more_ confusing because I would wonder "Where did that
> >> __GFP_COMP come from?"
> >
> > Thank you for the comments. But I disagree.
>
> FTR, I agree with Matthew. This is a tracepoint for kmalloc() so I would expect
> to see what flags were passed to kmalloc().
> If I wanted to see how the flags translated to page allocator's flags, I would
> have used a page allocator's tracepoint which would show me that.

Make sense. Thank you.

> > When I use trace, I hope I can get the precise data rather than something
> > changed that I don't know , then I can get the correct conclusion or
> > direction on my issue.
>
> It's precise from the point of the caller.
>
> > Here my question is what the trace events are for if they don't provide the
> > real situation? I think that's not graceful and friendly.
> >
> > From my perspective, it'd be better to know my flags changed before checking
> > code lines one by one. In other words, I need a warning to reminder me on this,
> > then I can know quickly my process might do some incorrect things.
>
> Your process should not care about __GFP_COMP if you use properly
> kmalloc()+kfree(). Once you start caring about __GFP_COMP, you should be using
> page allocator's API, not kmalloc().
>
> > Regards,
> > Xiongwei
> >
>

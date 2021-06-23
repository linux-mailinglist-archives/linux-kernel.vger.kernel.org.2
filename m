Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0B83B135B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 07:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFWFtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 01:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhFWFtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 01:49:07 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36178C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 22:46:50 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id r7so1206688qta.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 22:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJCJPM1T+JXjSw+98p9nEe1sEcMGGWaPNFa6+pVTHQc=;
        b=gKkAOFZSLlVRKZqWTrHI1yJ3jaHZ+WsJtJSI8tyzZJtCHqOSiI/pMI+m/JrZIM2KbU
         fVxxh8dkQpDPFwer2yJJsuTIUOn0zxzHFgHF6J6OrHQLD90Lrtbvc6xABVDCF66nagM8
         Uu2MtQm1Icnl1hw/WBMvHE68Cmj+SiFPlGcXKxjdGFQc1ACn42OOUmB8GKJ5UWbxEVoB
         U6qb1EjhstbWxxkcDVcE378OTr3uqp/VMZDsljLsUPnOnqjhRWjOfZssQaRMP1R9g2fK
         oiWSkUylQ2fKPwLLbbl/fCc0bsV1NffW82CHJD9PJHr/q+xTJgwOkU03VGtQiXsArY+L
         UPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJCJPM1T+JXjSw+98p9nEe1sEcMGGWaPNFa6+pVTHQc=;
        b=GudXwPzADZE/4dNIB+/hMDeHSXLdnqLB03YsuLfH4aaeHuWqEEs+2Ax9x3RLEUTTGb
         m23tEKzd/g29xzkXGSdmbJlhQNexkh2AF47Th67pHI5oAa+RqYiJltr1L/zWksiXuIOl
         J8mQHmnAgXxm2vVCJoRereeij3GhV4O6nXr0DYDcHqBCdyQNes7dtgS4KDGec3J4GLTC
         Y84uOmqEd2+35H119zKBqzmd7BXSFFWiZsmbjs9aWKSNrpt+VFRdm44+ATd5blM6Z02w
         X9MVs+NoA3+j6G+tfEp7sCzWv3PHtZBPPZCkKN5AbuYDI0Ix8L/VzUZfTlgn3cxeWrP0
         E8iA==
X-Gm-Message-State: AOAM533ULZJW+l/esc2FPnw/2dkmrPdYLmc/nPH38oCDj5gvvDomnnPZ
        p38c4yHfdl6xaCRrpnx7j63JxUy4Ol1s9UzcoWI=
X-Google-Smtp-Source: ABdhPJwe8yykHuEfrbZwWaQH6/EI7lURKWK3xJr1de6PjOlJBufA0sx/I2Rlg20i0ZbmTkWdFsRpfOPuQsthXCKRSQw=
X-Received: by 2002:ac8:682:: with SMTP id f2mr2271909qth.55.1624427209362;
 Tue, 22 Jun 2021 22:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <1623137297-29685-1-git-send-email-huangzhaoyang@gmail.com>
 <YM0YB6p2i346Zzhz@google.com> <CAGWkznEcXmb5tFs+Dd=Q13UE440OkaSzbS4NB_fX_bhjhM2X4g@mail.gmail.com>
 <YNJ0gBerIy3k+l7H@google.com>
In-Reply-To: <YNJ0gBerIy3k+l7H@google.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 23 Jun 2021 13:46:37 +0800
Message-ID: <CAGWkznG5yj2qs+pr=ZXueYVn7PENWyfvQxz3AJgLO+g9RiMnAQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zram: amend SLAB_RECLAIM_ACCOUNT on zspage_cachep
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 7:38 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Mon, Jun 21, 2021 at 10:35:26AM +0800, Zhaoyang Huang wrote:
> > On Sat, Jun 19, 2021 at 6:02 AM Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > On Tue, Jun 08, 2021 at 03:28:17PM +0800, Huangzhaoyang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Zspage_cachep is found be merged with other kmem cache during test, which
> > > > is not good for debug things(zs_pool->zspage_cachep present to be another
> > > > kmem cache in memory dumpfile). It is also neccessary to do so as shrinker has
> > >
> > > It's not a only problem of zsmalloc because slab want to minimize
> > > fragmentation so try to merge several objects if it's allowed.
> > > So I don't think it's particular problem of zsmalloc.
> > > I guess slub has some option maybe "nomerge" if you want it.
> >
> > >
> > > > been registered for zspage. Amending this flag can help kernel to calculate
> > > > SLAB_RECLAIMBLE correctly.
> > > >
> > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > ---
> > > >  mm/zsmalloc.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > > > index 19b563b..0b0addd 100644
> > > > --- a/mm/zsmalloc.c
> > > > +++ b/mm/zsmalloc.c
> > > > @@ -328,7 +328,7 @@ static int create_cache(struct zs_pool *pool)
> > > >               return 1;
> > > >
> > > >       pool->zspage_cachep = kmem_cache_create("zspage", sizeof(struct zspage),
> > > > -                                     0, 0, NULL);
> > > > +                                     0, SLAB_RECLAIM_ACCOUNT, NULL);
> > >
> > > How does zspage become SLAB_RECLAIM_ACCOUNT?
> > >
> > > I took the flag as "cacheable" object. IOW, when the shrinker
> > > ask to reclaim the object, it should reclaim(e.g., discarding)
> > > those objects for reclaming. However, that's not the case
> > > in zsmalloc.
> > alloc_slab will take the allocated object into account as
> > SLAB_RECLAIMABLE when this flag set on the kmem_cache
>
> My point is zspage_cachep is not an reclimable slab cache.
> Please describe why you believe it's reclaimable slab.
zspage registered slab shrinker via zs_register_shrinker, in which the
zspage be freed to cache

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60B53AE1AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 04:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhFUChx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 22:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhFUChw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 22:37:52 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9E9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 19:35:38 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id e3so12431345qte.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 19:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KVuKt6/Acd5sh2MXrhLbdYillpVA4Z1LuBqycxXY+g=;
        b=BZH21ZVppIAge/3bfEeZWpYeOi3wbY7BofQ1+E/+OtmY2keBKUz2kCWc0ImPOHTrci
         9NEdJ+y02KQNqcGk/7s/OAyXkMChYDLN8UNFZwhUmQRZ4neMS1yPTbejt9YN0cJDvbka
         DdzPxn8B0/+vOmvIsHN1CRknUzPYVEt3V1fZY391dIOcwO4C3PPLyOwc0Lsx3WGhxV7z
         GGMj1cYLHkKRBg1+kGIsOjJ32/0VjMzZTLMatv1a+8tc8SP37knn0/tsYfB0eTzsEZBr
         0OVByAcm6pCmBNUfaaAvXzR9qikQ/xZAHvHpy9iLeF7B4JGtSKjfsGaUnmnViEK1Afyo
         215g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KVuKt6/Acd5sh2MXrhLbdYillpVA4Z1LuBqycxXY+g=;
        b=VrTlyBbj3/bXg9urN2QFmMwS3vC+UP9iOnun6cCFfamg4MYopAsxJfvkVqnallvDpm
         grZxY1CbsVPEXka23Xy68GTNjFX7FVg/GmfoJnJ8NA/8VTqgiUlTHQCvwdYVX2Pw0cwy
         MWwH/b4Qstl0x8St9v+ee0XqutAlfEA9DdY9jLvsysF67Zm0ClOnmTbM2NdwwcFNRYw1
         z0c10YJiSwevi82LZcf/lABUqp2wswp3MrAy0NVMn11oz8P37q/Dj4S1a5oLTA4iiQUC
         QJ3A/bDSjXfN0ynx+MmHsWJa0KDfryrcZRUqFBWFs707vq9zSdsaLrj+3mWjmK1GHlk0
         ByoA==
X-Gm-Message-State: AOAM5320W7rIkHDMAN7hdJ1AM0hgmPi0XPpmypqYuIU0KggRh1++oiS2
        6I53INBH4N5hP8/UxKNHJhStMnACc20hNMgt2Pc=
X-Google-Smtp-Source: ABdhPJzAFv+FO3dzmLwaH3YLTggpMfuJuQMJ6Reoo5QP04ulG83hLRPwxTEaUdzfefytoOHwuIGl5ulcs8XE4i3eLJk=
X-Received: by 2002:a05:622a:11c3:: with SMTP id n3mr21506013qtk.63.1624242937598;
 Sun, 20 Jun 2021 19:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <1623137297-29685-1-git-send-email-huangzhaoyang@gmail.com> <YM0YB6p2i346Zzhz@google.com>
In-Reply-To: <YM0YB6p2i346Zzhz@google.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 21 Jun 2021 10:35:26 +0800
Message-ID: <CAGWkznEcXmb5tFs+Dd=Q13UE440OkaSzbS4NB_fX_bhjhM2X4g@mail.gmail.com>
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

On Sat, Jun 19, 2021 at 6:02 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Tue, Jun 08, 2021 at 03:28:17PM +0800, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Zspage_cachep is found be merged with other kmem cache during test, which
> > is not good for debug things(zs_pool->zspage_cachep present to be another
> > kmem cache in memory dumpfile). It is also neccessary to do so as shrinker has
>
> It's not a only problem of zsmalloc because slab want to minimize
> fragmentation so try to merge several objects if it's allowed.
> So I don't think it's particular problem of zsmalloc.
> I guess slub has some option maybe "nomerge" if you want it.

>
> > been registered for zspage. Amending this flag can help kernel to calculate
> > SLAB_RECLAIMBLE correctly.
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  mm/zsmalloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index 19b563b..0b0addd 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -328,7 +328,7 @@ static int create_cache(struct zs_pool *pool)
> >               return 1;
> >
> >       pool->zspage_cachep = kmem_cache_create("zspage", sizeof(struct zspage),
> > -                                     0, 0, NULL);
> > +                                     0, SLAB_RECLAIM_ACCOUNT, NULL);
>
> How does zspage become SLAB_RECLAIM_ACCOUNT?
>
> I took the flag as "cacheable" object. IOW, when the shrinker
> ask to reclaim the object, it should reclaim(e.g., discarding)
> those objects for reclaming. However, that's not the case
> in zsmalloc.
alloc_slab will take the allocated object into account as
SLAB_RECLAIMABLE when this flag set on the kmem_cache

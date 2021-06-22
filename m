Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700EC3B10B0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 01:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFVXlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 19:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFVXlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 19:41:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13571C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 16:38:44 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so2686897pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 16:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M/6m21CIeeLekhwSUDpdwzXlcRZjjnme98V1uMVwYaQ=;
        b=oBixoQUOrEbqMLzMlyMWJm1ZV1ShFluEpoGu/t4mCDE7pRiriXXy1j+ci8fcpOZsPU
         8daj4s7bQrBf44GEnZpuM/TqQRpvYlyGrJjS10o0Wpw9ZJTd3tnEbRemCcSbqPMTcPaq
         4iug9g3B5OH2eAVqHBIH0uTvtPQfwUVrDmXtVXpHJOQeBGIRyQZlf27XLC65pK/4zmBY
         OMrUS/crvLyJzsjpOpTmGeBd9GNh1e93mH3jnMSqXZLTSap9Rvw6kHLEVG99eS32rLHD
         3z3JiurCOBYLGE2MhdtJQ8QeN3/VHugNLqrsxsagjUhyroCkNt8NyfFjFMjiYBSFLoVX
         mLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=M/6m21CIeeLekhwSUDpdwzXlcRZjjnme98V1uMVwYaQ=;
        b=gnRx8jAsxX737tEiaAeTnpMLGZBXVShZdX2P2rsLOu+ZsVqxd0jJ55XqsBtQKTul4U
         /HbTy7KBZwgJnuUXpA0yvkdTLHcMyV7WyRl0NzglmmL5dK5IYPvivEYv4rUJ6SqGUCK6
         OrL6BbpTwPaQSfan/K+MUp8enO9VU8OAF+MmUJtimcbfMuhbR8+vmLeqk3VZd4nfHJvv
         T4Evg3QJetlXCIXLo8IYTcohQlXUqVFiecpPr8O+PbPB1zty1DWdwyJp00zUHMA5GQzW
         +1Pv3Ds9KKV+F5/xUulPG8VL3uJWz2m2QUzCeNm60FqWfmgpqTgIS6GrSjDBn2uMDWSB
         KePA==
X-Gm-Message-State: AOAM530qIyEFblifARnNEv7Xt5r3QTadzqALRhZp0KEUMYkm0LYoHBQv
        Mno7ei3sn4ch1oIElcLKmK4=
X-Google-Smtp-Source: ABdhPJyeOhNsg2K3/x/qL9r1vg1bUYIKL1J6ODi4GdIG5hHpwuQvx4zAYhOW0RuU+Ob0Ke7T/fB9MA==
X-Received: by 2002:a17:902:d489:b029:126:60a0:4797 with SMTP id c9-20020a170902d489b029012660a04797mr6339404plg.5.1624405123634;
        Tue, 22 Jun 2021 16:38:43 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:21b:31e:65b3:d681])
        by smtp.gmail.com with ESMTPSA id y2sm352455pfa.195.2021.06.22.16.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 16:38:42 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 22 Jun 2021 16:38:40 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm: zram: amend SLAB_RECLAIM_ACCOUNT on zspage_cachep
Message-ID: <YNJ0gBerIy3k+l7H@google.com>
References: <1623137297-29685-1-git-send-email-huangzhaoyang@gmail.com>
 <YM0YB6p2i346Zzhz@google.com>
 <CAGWkznEcXmb5tFs+Dd=Q13UE440OkaSzbS4NB_fX_bhjhM2X4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEcXmb5tFs+Dd=Q13UE440OkaSzbS4NB_fX_bhjhM2X4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 10:35:26AM +0800, Zhaoyang Huang wrote:
> On Sat, Jun 19, 2021 at 6:02 AM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Tue, Jun 08, 2021 at 03:28:17PM +0800, Huangzhaoyang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Zspage_cachep is found be merged with other kmem cache during test, which
> > > is not good for debug things(zs_pool->zspage_cachep present to be another
> > > kmem cache in memory dumpfile). It is also neccessary to do so as shrinker has
> >
> > It's not a only problem of zsmalloc because slab want to minimize
> > fragmentation so try to merge several objects if it's allowed.
> > So I don't think it's particular problem of zsmalloc.
> > I guess slub has some option maybe "nomerge" if you want it.
> 
> >
> > > been registered for zspage. Amending this flag can help kernel to calculate
> > > SLAB_RECLAIMBLE correctly.
> > >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > >  mm/zsmalloc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > > index 19b563b..0b0addd 100644
> > > --- a/mm/zsmalloc.c
> > > +++ b/mm/zsmalloc.c
> > > @@ -328,7 +328,7 @@ static int create_cache(struct zs_pool *pool)
> > >               return 1;
> > >
> > >       pool->zspage_cachep = kmem_cache_create("zspage", sizeof(struct zspage),
> > > -                                     0, 0, NULL);
> > > +                                     0, SLAB_RECLAIM_ACCOUNT, NULL);
> >
> > How does zspage become SLAB_RECLAIM_ACCOUNT?
> >
> > I took the flag as "cacheable" object. IOW, when the shrinker
> > ask to reclaim the object, it should reclaim(e.g., discarding)
> > those objects for reclaming. However, that's not the case
> > in zsmalloc.
> alloc_slab will take the allocated object into account as
> SLAB_RECLAIMABLE when this flag set on the kmem_cache

My point is zspage_cachep is not an reclimable slab cache.
Please describe why you believe it's reclaimable slab.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8016743C448
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbhJ0HtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240554AbhJ0HtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:49:06 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E08BC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:46:41 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id n2so1671976qta.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9q/ALGYqDwdhLtPZsbnRWyuardQKJ35TGG4OW1DjCZA=;
        b=iSsc5HR+fsiNxzOXfw6h8SVZvp/HbeWKB5a5myra8kgMEaeuKZoibwAnmJBqzgBi0G
         1m1qjpOhXnQDXh3LhYvEbcEjb82ou3ArwduzbYcyvwPSsGF5V9yGkf+b9Nnch+BmDOMO
         uHllxmrRxPmnrXD49Pkxd/rrskiTt3mMr4j6PllfIyBi5IKzwb95YckztDT/iGfwfvF/
         xn7HcTniSBS73kB1dk19exUmQDzL9LFhpM4yyUMvItDdauW4wnrfVUjYBn5SU1F0Kq4U
         lJI/ObmeGm9PEk+LI4VFQew+oSggms8jYpeGS4YCT24d7BUEtqoHAk0dhNXhFrhJhZKH
         0izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9q/ALGYqDwdhLtPZsbnRWyuardQKJ35TGG4OW1DjCZA=;
        b=E5S1yHnvhFmND+dfgKZviSIydJyLuGMAE2LucliwKOCWcdXnsfaZVE4o1bUpDWqubd
         gCehG83ooS91F+qiFYoQI/LBpT5MnoEdpj1Jisk5lXy3E84Vd3eWECeIgZy1/w3eO1Cn
         9XjhSilsuKYMPFJ+D+ifloXmxwYWZID+UDXD3088Ed0vIL3RwaskOzwuv83qUDo05Y5w
         v1a3B6U/HHM6V+yLQxGEjo+yo5P9ohgdWV1kInkecrZ8qqsJNh7Q2iXlskQrpNYJXT5w
         sHHPWP2JIH+FcdmtO310zMQLQ91z75FuHTbePsse9FvJpGXSIbRThj3PNcZ/xxXYbZOv
         IfIg==
X-Gm-Message-State: AOAM533wn83cc/Ar5I61O2dvQCtMoRji0Wqpqs0EpqLmBJ9IXFs1WTHc
        VJwsjTNsCCFCwMw8ht1LXwhQVICu/LC0te+rXQw=
X-Google-Smtp-Source: ABdhPJysjhJbIsbdrypKts8I/ECzzs1+FWwmDNja+0mcj/JDHnm26m1OvpQDFMySjZVbRCoTkSFhLyQsvVN2X+BSCBY=
X-Received: by 2002:a05:622a:11c5:: with SMTP id n5mr29694457qtk.232.1635320800710;
 Wed, 27 Oct 2021 00:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <1635318110-1905-1-git-send-email-huangzhaoyang@gmail.com> <YXj9w+8Bwlkz5PRy@dhcp22.suse.cz>
In-Reply-To: <YXj9w+8Bwlkz5PRy@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 27 Oct 2021 15:46:19 +0800
Message-ID: <CAGWkznHVHVBrQEiO32p2uX_5BDUMc1fE64KuV34WJfpwC_23Pw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: have kswapd only reclaiming use min protection on memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 3:20 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 27-10-21 15:01:50, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > For the kswapd only reclaiming, there is no chance to try again on
> > this group while direct reclaim has. fix it by judging gfp flag.
>
> There is no problem description (same as in your last submissions. Have
> you looked at the patch submission documentation as recommended
> previously?).
>
> Also this patch doesn't make any sense. Both direct reclaim and kswapd
> use a gfp mask which contains __GFP_DIRECT_RECLAIM (see balance_pgdat
> for the kswapd part)..
ok, but how does the reclaiming try with memcg's min protection on the
alloc without __GFP_DIRECT_RECLAIM?
>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Nacked-by: Michal Hocko <mhocko@suse.com>
>
> > ---
> >  mm/vmscan.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 74296c2..41f5776 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2704,7 +2704,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
> >                       unsigned long protection;
> >
> >                       /* memory.low scaling, make sure we retry before OOM */
> > -                     if (!sc->memcg_low_reclaim && low > min) {
> > +                     if (!sc->memcg_low_reclaim && low > min
> > +                             && sc->gfp_mask & __GFP_DIRECT_RECLAIM) {
> >                               protection = low;
> >                               sc->memcg_low_skipped = 1;
> >                       } else {
> > --
> > 1.9.1
>
> --
> Michal Hocko
> SUSE Labs

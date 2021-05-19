Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E539A3885DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhESEG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhESEG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:06:28 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA3DC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:05:09 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so2715434ool.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MQA7/cq456d1sxLzbZtrmQ5JtgLhRNVtq75eilKgSM=;
        b=IzBfRCSL6S3V1beY4be3eQ/ArujBd9leOulz7621X967qbL7gxwgL8ur3gnaMMp7ku
         L84WzhWkRGgfP/Bls9X7329o+aH2RmNzbfxOLrYtVZpz6ia/13/2/W+lqnv7swAz03wz
         5tVhJ3QnSMJX6f5IzM0ZmjE5vv8PAlapg9PpQPHuHE/fvndKMsoGtTCI37kH3M1SFTqy
         RY2cWjVfVuDjILPhy2HLXTIkdk33vB3aGfaawVVXCjgw9FY+gqGemHXej3uOCoULJ4WG
         DLScsOPp2gGzObiI7JHDwiyWlzidZQwaDY6pEVuUAW7JZLXiqnwNdUJsanNoiBOm+KMq
         4OZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MQA7/cq456d1sxLzbZtrmQ5JtgLhRNVtq75eilKgSM=;
        b=g3QbwMQU3ieW4rp5vlS6ERn+7mw4zxRgelpD7YWyV1aWPJVe5eGJApDKzpn/ddG8Yg
         3pPUuI8+KWezO36rHSVfO7//r5ENE1od8dcWaZD2g2WySyqoUqnCZJc6NpMBVaMt0kEu
         Xio0KNrOY5j9CavtMxlV6eprn1s97f6XPPWgQDjO7gMr6aeCcMRYdj3nXoj+kKZd1PRl
         DNUQFFYwm2iCpYZSmx3n7jzsXr02ZGfL7J3ErsO81Hw/EixK4nhwAp9BIcckM/ydv7+s
         n/4jMPNWGf7OP9LttxAcF9PKPc7dXOwxDGiRV67asxsvGQMWe/3oQKK5Grw6t7G0M5Jb
         2E+A==
X-Gm-Message-State: AOAM530JdcFK6T+BZE3Cw8urZDfaPDxVDCs5EfXv9sO301mVW734eL4v
        294m9Hsu/Zp+Sebg+2XMm/+AcR2g149YbOrtGgP0jB8F
X-Google-Smtp-Source: ABdhPJysxZpkcygDHH21kkq/yV4SFakKqK0rIT0xIP7zpokB8Z5e5ZjA/wT1gErxLEEECSePW3jWGNckwZW8FdxXwB0=
X-Received: by 2002:a4a:270d:: with SMTP id l13mr7119274oof.11.1621397108504;
 Tue, 18 May 2021 21:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210517112044.233138-1-aisheng.dong@nxp.com> <20210517112044.233138-3-aisheng.dong@nxp.com>
 <YKOSZELQWd6o7cva@kernel.org> <CAA+hA=QcNWo3brs4HvdBb+QHHOiBHgF3hdbfJ1ivaGHiBXM4EQ@mail.gmail.com>
 <YKOoU7GjZ6cDogiH@kernel.org>
In-Reply-To: <YKOoU7GjZ6cDogiH@kernel.org>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 19 May 2021 12:04:05 +0800
Message-ID: <CAA+hA=TBCsNcb=ZX+WMyMbZt+oUD0pOxWZ4rZJc8C31HwQ-c1Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/sparse: free section usage memory in case
 populate_section_memmap failed
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 7:43 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Tue, May 18, 2021 at 06:25:28PM +0800, Dong Aisheng wrote:
> > On Tue, May 18, 2021 at 6:09 PM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > On Mon, May 17, 2021 at 07:20:41PM +0800, Dong Aisheng wrote:
> > > > Free section usage memory in case populate_section_memmap failed.
> > > > We use map_count to track the remain unused memory to be freed.
> > > >
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > ---
> > > >  mm/sparse.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > > index 7ac481353b6b..98bfacc763da 100644
> > > > --- a/mm/sparse.c
> > > > +++ b/mm/sparse.c
> > > > @@ -549,12 +549,14 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> > > >                              __func__, nid);
> > > >                       pnum_begin = pnum;
> > > >                       sparse_buffer_fini();
> > > > +                     memblock_free_early(__pa(usage), map_count * mem_section_usage_size());
> > >
> > > I'd move both sparse_buffer_fini() and freeing of 'usage' memory after the
> > > failed label.
> > >
> >
> > Doing that needs to introduce another 'failed' label.
> > Do you think if it's necessary?
>
> In general, it's preferred way of error handling:
>

Okay, if no objections, i will do it in V2.
Thanks

Regards
Aisheng

> https://www.kernel.org/doc/html/latest/process/coding-style.html#centralized-exiting-of-functions
>
> > e.g.
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 7ac481353b6b..408b737e168e 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -533,7 +533,7 @@ static void __init sparse_init_nid(int nid,
> > unsigned long pnum_begin,
> >                         mem_section_usage_size() * map_count);
> >         if (!usage) {
> >                 pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
> > -               goto failed;
> > +               goto failed1;
> >         }
> >         sparse_buffer_init(map_count * section_map_size(), nid);
> >         for_each_present_section_nr(pnum_begin, pnum) {
> > @@ -548,17 +548,20 @@ static void __init sparse_init_nid(int nid,
> > unsigned long pnum_begin,
> >                         pr_err("%s: node[%d] memory map backing
> > failed. Some memory will not be available.",
> >                                __func__, nid);
> >                         pnum_begin = pnum;
> > -                       sparse_buffer_fini();
> > -                       goto failed;
> > +                       goto failed2;
> >                 }
> >                 check_usemap_section_nr(nid, usage);
> >                 sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
> >                                 SECTION_IS_EARLY);
> >                 usage = (void *) usage + mem_section_usage_size();
> > +               map_count--;
> >         }
> >         sparse_buffer_fini();
> >         return;
> > -failed:
> > +failed2:
> > +       sparse_buffer_fini();
> > +       memblock_free_early(__pa(usage), map_count * mem_section_usage_size());
> > +failed1:
> >         /* We failed to allocate, mark all the following pnums as not present */
> >         for_each_present_section_nr(pnum_begin, pnum) {
> >                 struct mem_section *ms;
> >
> > Regards
> > Aisheng
> > > >                       goto failed;
> > > >               }
> > > >               check_usemap_section_nr(nid, usage);
> > > >               sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
> > > >                               SECTION_IS_EARLY);
> > > >               usage = (void *) usage + mem_section_usage_size();
> > > > +             map_count--;
> > > >       }
> > > >       sparse_buffer_fini();
> > > >       return;
> > > > --
> > > > 2.25.1
> > > >
> > > >
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
>
> --
> Sincerely yours,
> Mike.

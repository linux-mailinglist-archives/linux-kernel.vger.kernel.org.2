Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDAC3877F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348840AbhERLol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231655AbhERLoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:44:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3636C61261;
        Tue, 18 May 2021 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621338202;
        bh=hSDZmeB3bFHh9sE177qrXSwEZgivmC7vh546m9pMj4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ww/NVqKc2p89Utb5UgfC5d+mql3pgtcMCtsth4+in37DTHP9YhsKZ+6BcuX438kiM
         m2+0719/MLhE2NKXGOgEWdKpIwhjz8nLpg7Px8y6GK26qaepEpHa+M6wiJTiyqiDxg
         kSrvxTTQ4vdbn02RHCpt6DY/eYx+nQCh//LzytQdy0Xi+ZTtviE2M8SSygNV0L7SET
         dJoxERfemRrunn/pX7a4R781HoxpFof76Qbeeqxu7Yf9eefmEjQrb5UJGqXFyB94In
         l//xOt0fzhxxoo2JXOuhvB9CS0Ynzbp2FSs5lG7STj9fmUBk5Z75lN2Y2gQTQOjsw6
         q3qnqI0Tgxj5Q==
Date:   Tue, 18 May 2021 14:43:15 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/5] mm/sparse: free section usage memory in case
 populate_section_memmap failed
Message-ID: <YKOoU7GjZ6cDogiH@kernel.org>
References: <20210517112044.233138-1-aisheng.dong@nxp.com>
 <20210517112044.233138-3-aisheng.dong@nxp.com>
 <YKOSZELQWd6o7cva@kernel.org>
 <CAA+hA=QcNWo3brs4HvdBb+QHHOiBHgF3hdbfJ1ivaGHiBXM4EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+hA=QcNWo3brs4HvdBb+QHHOiBHgF3hdbfJ1ivaGHiBXM4EQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 06:25:28PM +0800, Dong Aisheng wrote:
> On Tue, May 18, 2021 at 6:09 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Mon, May 17, 2021 at 07:20:41PM +0800, Dong Aisheng wrote:
> > > Free section usage memory in case populate_section_memmap failed.
> > > We use map_count to track the remain unused memory to be freed.
> > >
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > ---
> > >  mm/sparse.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > index 7ac481353b6b..98bfacc763da 100644
> > > --- a/mm/sparse.c
> > > +++ b/mm/sparse.c
> > > @@ -549,12 +549,14 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> > >                              __func__, nid);
> > >                       pnum_begin = pnum;
> > >                       sparse_buffer_fini();
> > > +                     memblock_free_early(__pa(usage), map_count * mem_section_usage_size());
> >
> > I'd move both sparse_buffer_fini() and freeing of 'usage' memory after the
> > failed label.
> >
> 
> Doing that needs to introduce another 'failed' label.
> Do you think if it's necessary?

In general, it's preferred way of error handling:

https://www.kernel.org/doc/html/latest/process/coding-style.html#centralized-exiting-of-functions
 
> e.g.
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 7ac481353b6b..408b737e168e 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -533,7 +533,7 @@ static void __init sparse_init_nid(int nid,
> unsigned long pnum_begin,
>                         mem_section_usage_size() * map_count);
>         if (!usage) {
>                 pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
> -               goto failed;
> +               goto failed1;
>         }
>         sparse_buffer_init(map_count * section_map_size(), nid);
>         for_each_present_section_nr(pnum_begin, pnum) {
> @@ -548,17 +548,20 @@ static void __init sparse_init_nid(int nid,
> unsigned long pnum_begin,
>                         pr_err("%s: node[%d] memory map backing
> failed. Some memory will not be available.",
>                                __func__, nid);
>                         pnum_begin = pnum;
> -                       sparse_buffer_fini();
> -                       goto failed;
> +                       goto failed2;
>                 }
>                 check_usemap_section_nr(nid, usage);
>                 sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
>                                 SECTION_IS_EARLY);
>                 usage = (void *) usage + mem_section_usage_size();
> +               map_count--;
>         }
>         sparse_buffer_fini();
>         return;
> -failed:
> +failed2:
> +       sparse_buffer_fini();
> +       memblock_free_early(__pa(usage), map_count * mem_section_usage_size());
> +failed1:
>         /* We failed to allocate, mark all the following pnums as not present */
>         for_each_present_section_nr(pnum_begin, pnum) {
>                 struct mem_section *ms;
> 
> Regards
> Aisheng
> > >                       goto failed;
> > >               }
> > >               check_usemap_section_nr(nid, usage);
> > >               sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
> > >                               SECTION_IS_EARLY);
> > >               usage = (void *) usage + mem_section_usage_size();
> > > +             map_count--;
> > >       }
> > >       sparse_buffer_fini();
> > >       return;
> > > --
> > > 2.25.1
> > >
> > >
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.

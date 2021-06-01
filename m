Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805E9396B79
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhFACkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhFACkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:40:46 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE09C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:39:05 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id v13-20020a4aa40d0000b02902052145a469so3174030ool.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvVZjz2gRnjw/PQviXkm4XEh9QvnrEhyd6R5TbtOdh8=;
        b=R/C8i9ZvzNPIueQAgqTnooe76qYDKhUMqUI8TqWZFB15tCKPRG+TQJ4v9J7KxVhyOb
         WY6IvTgWrGkIOZsmQqkGdl0fNsJzBmR/5BqevIggtqaWD/aGNOG6ftrZ76g2x4cnudve
         y6wYb6mJnRAIMKhCZW+tDnjEVeJHo2nuwMyn6jmDy98fctDgIt9pQ19B01qxzUuqaTYF
         tAJ79plQZFLNOsJfdkHcm+jp1tX9MGAuN7YDu/LxGvXvOJZXbWBSAN5eKwzzkEccL8X+
         3evBtt+XSMPpiIlMzlRlZmPF8ZjEKTuZjUgS64bgC0G9Sfh8oY13kMacYbbd+fmnDFa1
         jYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvVZjz2gRnjw/PQviXkm4XEh9QvnrEhyd6R5TbtOdh8=;
        b=rJKhhl/Zq45V2+3mNEA1mQaXvGDsKroAjRpN0NN6Stdlb95qvvlGA6vL4NunpiBRPD
         oiLyNpb/bSW/abC5y2o++3IVSelDZsFcwuqtjQLPlDHiby0X2OTfO8sd1qeMcXpSWtfZ
         8rqF46Vkz+WVo/UHofvwbV6towkMPB3WFlXNqV0clMfCV+15m0wAgQFYghgzvOkJJtvI
         9L4EnUZKzUeBaaMZKRAieQq//lAS8Qs34VGK0sdLoRpWeiqctmHgmrZ9GVZ+yK/cP9Zd
         dgRGoPcTk9LiUYHR3cPSXfHnjrX04eGpQHSuLe3uwm1+HM85iLONpiBlCYvamkKMknXI
         +39g==
X-Gm-Message-State: AOAM531pTYAF4L6RFs7siRnQYM/6deSya1xiJgsuTZsn9N3E9kMihVBR
        opVgCZv0mLGQcmpahH3bXzRdRTp9uugnBh6f7fw=
X-Google-Smtp-Source: ABdhPJy0p6Mc57vuZNCBsAynS+dABjULFi0fEVZA62qwqVWKmYq9FgI3sBmIsxdRhZWyIY1TSkJx0xw/2XXDNzuvhHI=
X-Received: by 2002:a4a:d89a:: with SMTP id b26mr18347712oov.11.1622515145156;
 Mon, 31 May 2021 19:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-3-aisheng.dong@nxp.com> <20210531150542.inopmezthosooy5u@revolver>
In-Reply-To: <20210531150542.inopmezthosooy5u@revolver>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 1 Jun 2021 10:37:54 +0800
Message-ID: <CAA+hA=SyzhHyU5SMgz2Y29YahOut9WUZEs6h5cXrsBCj_YZ9iw@mail.gmail.com>
Subject: Re: [PATCH V2 2/6] mm/sparse: free section usage memory in case
 populate_section_memmap failed
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 11:06 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Dong Aisheng <aisheng.dong@nxp.com> [210531 05:20]:
> > Free section usage memory in case populate_section_memmap failed.
> > We use map_count to track the remain unused memory to be freed.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > ChangeLog:
> > v1->v2:
> >  * using goto + lable according to Mike's suggestion
> > ---
> >  mm/sparse.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 7ac481353b6b..408b737e168e 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -533,7 +533,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> >                       mem_section_usage_size() * map_count);
> >       if (!usage) {
> >               pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
> > -             goto failed;
> > +             goto failed1;
>
> Please use better labels for goto statements.  Perhaps usemap_failed ?
>

Thanks, I will improve it.

Regards
Aisheng

>
> >       }
> >       sparse_buffer_init(map_count * section_map_size(), nid);
> >       for_each_present_section_nr(pnum_begin, pnum) {
> > @@ -548,17 +548,20 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> >                       pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
> >                              __func__, nid);
> >                       pnum_begin = pnum;
> > -                     sparse_buffer_fini();
> > -                     goto failed;
> > +                     goto failed2;
>
> Again, this goto label is not descriptive.
>
> >               }
> >               check_usemap_section_nr(nid, usage);
> >               sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
> >                               SECTION_IS_EARLY);
> >               usage = (void *) usage + mem_section_usage_size();
> > +             map_count--;
> >       }
> >       sparse_buffer_fini();
> >       return;
> > -failed:
> > +failed2:
> > +     sparse_buffer_fini();
> > +     memblock_free_early(__pa(usage), map_count * mem_section_usage_size());
> > +failed1:
> >       /* We failed to allocate, mark all the following pnums as not present */
> >       for_each_present_section_nr(pnum_begin, pnum) {
> >               struct mem_section *ms;
> > --
> > 2.25.1
> >
> >

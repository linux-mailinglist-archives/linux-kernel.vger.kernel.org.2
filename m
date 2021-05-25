Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2638838FC81
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhEYISi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhEYISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:18:36 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB52C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:17:05 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id c3so29519415oic.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHxyz17p2ZXeKQZplPbgBWJclFvSNiYWUobJtjVd2b8=;
        b=oMXs+07ESuQex86kh1Ni6ZiuW7ZpqCJzj5jbmNHsgSiMV3NzmC9f+86NI0/l4zWWpf
         2zfx7FlvJ4EZ64tTlBS8DW4MB59X9+Uib4USjcm+fNoOv+fr0fantDE08a0oHgy84d3O
         pj0lv94wchKlyuGVkNh2olLV5N/yZTbRz403uElUR97D0xqHmLTbck8PZCtmZr/a/lPT
         3suwuRw3hCBuNG0WW6ArWSDoGlS/bqRpgIvG4v6ewV/ASymO268cSlXt0D/mKZapcZzE
         fFGxb34jupaJiNZx0bBPSnJ4QCB3aQ+8M9OfLOAJwIg1xyDukN+9lXIfPF7hcWQERpvX
         V71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHxyz17p2ZXeKQZplPbgBWJclFvSNiYWUobJtjVd2b8=;
        b=qVTbE8iJajWMGbhAmOMlwB5kDf7TLUkZX9xUrVteA99DwUpJULrh5dKEwSQVjiLFhO
         ET4LekN0c5KHFvQP7q1oZ//Ipzy6IIO0NeUR8ohBa8QUkdCFJz9dixbHn0PujDDsHDw1
         1xsBrRc3cKIz5879E60+fAauPE/YXXhzQMld2IV9n9f59fLG1ff2U6UyZy8bNjshZqzh
         h/ysW9CU0YdzP3VQsyuE95nkGOonWBuUWfwVsXwO3UWiS5MtNM7rNZ0VjDx+JnLyJXU8
         zQQodtI5BtjD0NaDr/3tqM8jykwUERpMfzdNuxLeU/e9MsdhOmykSLaYwLQdQWht2TN6
         VHCw==
X-Gm-Message-State: AOAM532/TQNrlo29pF3i0GT2ozy+acQ7PTT72lnWSe1lAMft1yPCRDx5
        AjWATYzBoRU5MNAZQ1/rtMK6q9qxzYgkY2X72UTm/rDvB3w=
X-Google-Smtp-Source: ABdhPJzuS5AkmgLnuJd9ZUeOPOgxZTEbVykKwunae9GlQWX2Atb59IdLVG06N6TjcRFJUkGXgx5X87RJohtL/H5arnI=
X-Received: by 2002:a05:6808:1304:: with SMTP id y4mr2119053oiv.20.1621930625363;
 Tue, 25 May 2021 01:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210517112044.233138-1-aisheng.dong@nxp.com> <20210517112044.233138-3-aisheng.dong@nxp.com>
 <01356cc7-61c3-fb15-1c85-939b6366a636@redhat.com>
In-Reply-To: <01356cc7-61c3-fb15-1c85-939b6366a636@redhat.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 25 May 2021 16:15:59 +0800
Message-ID: <CAA+hA=TQ6ZzJcBkBju2OyxNGhUHSnm-MHED5GTzsYECKh2PEzA@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/sparse: free section usage memory in case
 populate_section_memmap failed
To:     David Hildenbrand <david@redhat.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 3:52 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 17.05.21 13:20, Dong Aisheng wrote:
> > Free section usage memory in case populate_section_memmap failed.
> > We use map_count to track the remain unused memory to be freed.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   mm/sparse.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 7ac481353b6b..98bfacc763da 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -549,12 +549,14 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> >                              __func__, nid);
> >                       pnum_begin = pnum;
> >                       sparse_buffer_fini();
> > +                     memblock_free_early(__pa(usage), map_count * mem_section_usage_size());
> >                       goto failed;
> >               }
> >               check_usemap_section_nr(nid, usage);
> >               sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
> >                               SECTION_IS_EARLY);
> >               usage = (void *) usage + mem_section_usage_size();
> > +             map_count--;
> >       }
> >       sparse_buffer_fini();
> >       return;
> >
>
> Why care about optimizing something that literally never fails, and if
> it would fail, leave the system in a sub-optimal, mostly unusable state?
>

It just fixes the code logic.
I'm going to listen to more comments, if everyone thinks it's not needed.
I may drop in V2.

Regards
Aisheng

> --
> Thanks,
>
> David / dhildenb
>

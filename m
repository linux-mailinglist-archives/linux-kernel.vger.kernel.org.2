Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17138FD06
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhEYImZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhEYImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:42:22 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D9EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:40:52 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so27881134otp.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ET8TH4a7icyzqhz8XmbF4WtAKB0L7qzDzL0Lz6SbV0=;
        b=PdYbSrbhEiB/6UsfOFN9mEke6zkgUYRAl7Hsx5O0I+lScAu7KVTzuNWWGeaBbJy0ID
         r2uM+CN2FlnTLULqzDffOZJ7jsLAOXe3pIBULS4LEVQdnfbtdIK7ov+lwMUY8FfQy9gQ
         FIuBVVdHaTKvbVBXxQ8PYD+S6zFor4KtWU08Ndusr7rcxUIhaMilbQPrFtcwcGjefkS/
         a3Ka6yj+6896f/dQoIOdKuxrNvYAI7HtoQ3LrWllwqISOMeYtOb6tSUSaZE8zWpXMopy
         5Rea1fKdNUNHdu0Qx2/PC6mrJr1bqbpt3czRmva8ptscX8UcyiVltHS69gVO8jzDY4+w
         3qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ET8TH4a7icyzqhz8XmbF4WtAKB0L7qzDzL0Lz6SbV0=;
        b=r3FMpxvTFGNeWHzqyJDyvP5A6QedDiOVBkj0RO9LsYkbw+YsPCm09DOevhlC2RlmY4
         wmKTFtN3rkPwo2NgHlGgKktRoVkm46xTHM5rwwzrxhzRBvt7mKlwCGZ89kXPcpk6GXLK
         zpDrkfgDPgOoe4JyxRmDXEEgqQaZayhlAqlNoja0Xt4fhTs3wzQpO3UzqssIpuC0iBog
         PaWuOtdoWWJnIGE8e7/W5Sm1manIbqxiuoZN12RYAdPcJTmHJMtcSWYMH4msJRJCAw4w
         /G0s0NXNM/F7jfBk7dhjrQSNOtKyiCR+aZe9U9+gbGIQ5ZXicKk7vmyT9yyWiRKDD7+e
         aLdA==
X-Gm-Message-State: AOAM532pVjnJZozTLvCBAeGbqZb4PsVJjVzs77fk5tHYlAb6eaG1Zz7q
        D3O1RWhimjQ0eYMZPq3VMIQmxFZyCngYu8iqvqs=
X-Google-Smtp-Source: ABdhPJzlheYhN78NwTb8+1mxjOpGFYfJQS1zrtf3mbG2zBzuuzfK2O1mcYCS9AqXChGNsM5/0xFPY+md9fpUyPTbrfc=
X-Received: by 2002:a05:6830:812:: with SMTP id r18mr11481269ots.248.1621932052205;
 Tue, 25 May 2021 01:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210517112044.233138-1-aisheng.dong@nxp.com> <20210517112044.233138-6-aisheng.dong@nxp.com>
 <69b5a56c-e9a0-01e7-5fd5-78c6e656fa68@redhat.com>
In-Reply-To: <69b5a56c-e9a0-01e7-5fd5-78c6e656fa68@redhat.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 25 May 2021 16:39:45 +0800
Message-ID: <CAA+hA=Rp-vGaLKO+diaGr5UqZTMEOM-ED0++NWzih8MgD3z9=A@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/page_alloc: improve memmap_pages and dma_reserve
 dbg msg
To:     David Hildenbrand <david@redhat.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 4:01 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 17.05.21 13:20, Dong Aisheng wrote:
> > Make debug message more accurately.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   mm/page_alloc.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3100fcb08500..16f494352f58 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7263,14 +7263,15 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
> >                                       pr_debug("  %s zone: %lu pages used for memmap\n",
> >                                                zone_names[j], memmap_pages);
> >                       } else
> > -                             pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
> > +                             pr_warn("  %s zone: %lu memmap pages exceeds freesize %lu\n",
> >                                       zone_names[j], memmap_pages, freesize);
> >               }
> >
> >               /* Account for reserved pages */
> >               if (j == 0 && freesize > dma_reserve) {
> >                       freesize -= dma_reserve;
> > -                     pr_debug("  %s zone: %lu pages reserved\n", zone_names[0], dma_reserve);
> > +                     pr_debug("  %s zone: %lu pages reserved for dma\n",
> > +                              zone_names[0], dma_reserve);
>
> ... which is not really correct I think. See the comment above
> set_dma_reserve(). It's called dma_reserve because it involves the first
> zone -- where many unfreeable allocations like the kernel image end up.
>
> Memory is not reserved for dma purposes ... and the zone name should be
> sufficient.

You're right. I will drop this line of change.
Thanks

Regards
Aisheng

>
> --
> Thanks,
>
> David / dhildenb
>
>

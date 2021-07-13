Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDA33C7441
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbhGMQWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhGMQWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:22:03 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F079C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:19:13 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id m18so1848906oie.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=huy3A4ZQsPTRZT7tGhT5kIwuh7my/p/nRbdB9PmgvzM=;
        b=W1uGwlOEfvG+vtbgUVE8EKwQtXKNJzS98MbwXZbFrPG/G2iZ0gFWmM0UOk7T3Jb8ZN
         DZ4QMNoTmsOtt/lSKdJCwG2SF10O1R/jw4fLknzhlJVMUj+Y0qOeiwmGv+3yBIE2Rf+d
         hHzVt4oDElWdFCf+WMiAXyCat6mDvZle/4q0QUKElOt3C+fJ85vEwbqQdCBEQPjoe+eF
         9kIcbTW6ww33ZLYHKwNF5EcevIK68CVW6AC1IoiJE7Qls0LBNV6TRPGbXEGCkbD6VKZo
         /9bChu8a56PgQ1TH/U+9nCbVtF0Ww3drfo+aQ/Wvux+y2WG8NrMj9a69kinEEX5JOm9n
         QuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huy3A4ZQsPTRZT7tGhT5kIwuh7my/p/nRbdB9PmgvzM=;
        b=uO3R5fJlwJz6QrUhRvlJJVuZ+o1WknLFFFPY0jAnTutQOt1ETdxjtGbKrBG16+bA/m
         TYlMQVafvQyEpaLQK5nc0hs03AqHmysTGcPXXSxisNnuXCIL9R1/6Anxg5DLRvCy9J4G
         DPF2YIEyGuwXifhVzpH6stzyCHvvzv+syYwxoLKfRuvNJfmm6AeNI+jdAHvKp3FWNuoO
         zyBl0Y8fyvC+8Tdd71II3WBWr+v7bqnDODk3KgH63Y0qfRMfAckRbNIOGGD5P6Pw1dcL
         wht6oIxQxWsAEtieJJWT32O1yzVJtbLyYf/ahwb5aYaMa3c+0QeZTydPfEyvZj1BkHKM
         OkTw==
X-Gm-Message-State: AOAM531nx3iJr+37+Ifwkfh+fhq3v2TthdO6Zwb2R0DbemHBBPMCwK79
        ZfUxSxKCTe6OmwOe1XzfBMxsK3rmi3DUvAOFTCy1GQ==
X-Google-Smtp-Source: ABdhPJytAg3oPcgS+rfsoNfJ9pnVekMsJ3OtPlYEx+2kTpu5b2aTtBF4uluKr0tmXbqltD7U54Jjj8lVJu7wecnRsLs=
X-Received: by 2002:a05:6808:284:: with SMTP id z4mr3800835oic.70.1626193152621;
 Tue, 13 Jul 2021 09:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210630150234.1109496-1-glider@google.com> <20210630150234.1109496-2-glider@google.com>
 <CANpmjNNvBWER=zjie544Eq6o_ZSMD6rDYb7mqDcUFtYutDSpWw@mail.gmail.com>
In-Reply-To: <CANpmjNNvBWER=zjie544Eq6o_ZSMD6rDYb7mqDcUFtYutDSpWw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 13 Jul 2021 18:19:01 +0200
Message-ID: <CANpmjNNu8xRwG6nCOgiuidWKenQ2X+BTBTuTjhZCaGptyN8nhw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kfence: skip all GFP_ZONEMASK allocations
To:     akpm@linux-foundation.org
Cc:     dvyukov@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org, jrdr.linux@gmail.com,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2021 at 16:05, Marco Elver <elver@google.com> wrote:
> Andrew,
>
> This series is ready to be picked up.
>
> If possible, kindly consider including it in an upcoming batch of
> mainline fixes.
>
> Thank you!

It'd be good to get this sorted -- please take another look.

Many thanks,
-- Marco

> On Wed, 30 Jun 2021 at 17:02, Alexander Potapenko <glider@google.com> wrote:
> > Allocation requests outside ZONE_NORMAL (MOVABLE, HIGHMEM or DMA) cannot
> > be fulfilled by KFENCE, because KFENCE memory pool is located in a
> > zone different from the requested one.
> >
> > Because callers of kmem_cache_alloc() may actually rely on the
> > allocation to reside in the requested zone (e.g. memory allocations done
> > with __GFP_DMA must be DMAable), skip all allocations done with
> > GFP_ZONEMASK and/or respective SLAB flags (SLAB_CACHE_DMA and
> > SLAB_CACHE_DMA32).
> >
> > Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: stable@vger.kernel.org # 5.12+
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Reviewed-by: Marco Elver <elver@google.com>
> >
> > ---
> >
> > v2:
> >  - added parentheses around the GFP clause, as requested by Marco
> > v3:
> >  - ignore GFP_ZONEMASK, which also covers __GFP_HIGHMEM and __GFP_MOVABLE
> >  - move the flag check at the beginning of the function, as requested by
> >    Souptick Joarder
> > v4:
> >  - minor fixes to description and comment formatting
> > ---
> >  mm/kfence/core.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > index 33bb20d91bf6a..1cbdb62e6d0fb 100644
> > --- a/mm/kfence/core.c
> > +++ b/mm/kfence/core.c
> > @@ -740,6 +740,15 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
> >         if (size > PAGE_SIZE)
> >                 return NULL;
> >
> > +       /*
> > +        * Skip allocations from non-default zones, including DMA. We cannot
> > +        * guarantee that pages in the KFENCE pool will have the requested
> > +        * properties (e.g. reside in DMAable memory).
> > +        */
> > +       if ((flags & GFP_ZONEMASK) ||
> > +           (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32)))
> > +               return NULL;
> > +
> >         /*
> >          * allocation_gate only needs to become non-zero, so it doesn't make
> >          * sense to continue writing to it and pay the associated contention
> > --
> > 2.32.0.93.g670b81a890-goog
> >

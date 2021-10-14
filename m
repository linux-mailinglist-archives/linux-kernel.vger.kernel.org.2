Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADEF42CFFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 03:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhJNBl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 21:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNBl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:41:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFE3C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 18:39:54 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t11so3034520plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 18:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ygn1/So2L6NrJcd5boRzqswYyFbg2B+I40MS8TYVpNs=;
        b=IIdRmLJFQRavjMw2MWCGuzvN3Cehb4IG454gJu1GIkzZvm4m0z4ZnV77W4Jx2fZa+K
         u0w6H43zkHZeg7ZNaGgenLgMEtLP2B9wQNG1QCk2dLOurbCG090ncA5dJ1GlF/4AeXKJ
         1rHBPDF38+xVZKXlx9VTdKDnedmdrg1QIyVu0xMX2TwRb7V4UpiohhbH2BxMUVg2dXd7
         gasIxI1rOV6PPIe/BQJKzb6GaFi3HiozPliZP3gYFCCK4VXxJUrztaCxF4MCkU3IQ2t1
         8Y6FyJOYqBQLZHMXMOggW7fRqvAb2z6l9nQbvJANvcDD06v1I9yrFoV3BYCvWn9FrUQQ
         C/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ygn1/So2L6NrJcd5boRzqswYyFbg2B+I40MS8TYVpNs=;
        b=jp32K5f+2gtBCE39Wk09lI+CqkmfRWwZEvwXZRaTTW947vaF8y41Kxoa2zZeZoq/Xk
         6EdsjP5v58PRG1BTU1CGeCZ/H7jCGABfUQYue5J/GMaQuW2Q03McPHHSSr6MHth3vLfh
         VUlQq9BZ9xcMTXzv9q0ExIbz6SaYFtYP7Bn0PC6bPYjW9rGfhfU/ZBFH5+kUAXbAp+h3
         /2h8jotEEzOgaNFY1Yo/OlHzoqMnJDe7H+PpWKwaeKVcrrligA2tNWYn5NTHFl4yTqsQ
         gFkHgpsKlPEni3Zo4/+HtnUw4YNWP/eItL9RGNcRH9yWZwrevDAO8DPvSkKj7sMwbf4o
         tY2Q==
X-Gm-Message-State: AOAM533EuWylmOoqyIl5fCpc9DIHR6iMxT0T/l5PvCIyXKoRY8dy/kRd
        +NFdRctwR3z2fyVUmOO4Ezw5SIX4EdRzMwnWYJ+uPQ==
X-Google-Smtp-Source: ABdhPJx0XyqHhqBedtXtJCc7cOWvTPEJY72lmuJ34Y4BZz3NHKVX9OvnOWrxG4rLhIOGtKD+Gn6ogONfGz9q8Cg7O58=
X-Received: by 2002:a17:90b:4a81:: with SMTP id lp1mr3140101pjb.124.1634175593356;
 Wed, 13 Oct 2021 18:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210923170908.2184404-1-kaleshsingh@google.com> <20211013180834.73e2653e@gandalf.local.home>
In-Reply-To: <20211013180834.73e2653e@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 13 Oct 2021 18:39:42 -0700
Message-ID: <CAC_TJverUnJVTGRw1pg1ughJ5YDA8Yo-fkpAm=_fWq9fdAgqTw@mail.gmail.com>
Subject: Re: [PATCH] tracing/cfi: Fix cmp_entries_* functions signature mismatch
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 3:08 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 23 Sep 2021 17:09:07 +0000
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
>
> This finally popped up into my queue (from all my traveling and running of
> conferences :-p )
>
>
> > If CONFIG_CFI_CLANG=y, attempting to read an event histogram will cause
> > the kernel to panic due to failed CFI check.
> >
> >     1. echo 'hist:keys=common_pid' >> events/sched/sched_switch/trigger
> >     2. cat >> events/sched/sched_switch/hist
>
> Do you mean:
>
>           2. cat events/sched/sched_switch/hist
>
> ?
>
> Small nits below.

Thanks Steve, v2 posted at
https://lore.kernel.org/r/20211014013704.2854890-1-kaleshsingh@google.com/

- Kalesh
>
> >     3. kernel panices on attempting to read hist
> >
> > This happens because the sort() function expects a generic
> > int (*)(const void *, const void *) pointer for the compare function.
> > To prevent this CFI failure, change tracing map cmp_entries_* function
> > signatures to match this.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  kernel/trace/tracing_map.c | 40 ++++++++++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 17 deletions(-)
> >
> > diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> > index d6bddb157ef2..a8c80ebbf9da 100644
> > --- a/kernel/trace/tracing_map.c
> > +++ b/kernel/trace/tracing_map.c
> > @@ -834,19 +834,21 @@ int tracing_map_init(struct tracing_map *map)
> >       return err;
> >  }
> >
> > -static int cmp_entries_dup(const struct tracing_map_sort_entry **a,
> > -                        const struct tracing_map_sort_entry **b)
> > +static int cmp_entries_dup(const void *__a, const void *__b)
>
> Instead of __a and __b, have it as:
>
>         const void *A, const void *B
>
>
> >  {
> >       int ret = 0;
> > +     const struct tracing_map_sort_entry *a
> > +             = *(const struct tracing_map_sort_entry **)__a;
> > +     const struct tracing_map_sort_entry *b
> > +             = *(const struct tracing_map_sort_entry **)__b;
>
> Please put these before the ret, we like to have a "upside down xmas tree"
> type of declaration, where longer lines come before shorter ones. Also,
> this can be "prettified" as:
>
>         const struct tracing_map_sort_entry **pa = A;
>         const struct tracing_map_sort_entry **pb = B;
>         const struct tracing_map_sort_entry *a = *pa;
>         const struct tracing_map_sort_entry *b = *pb;
>         int ret = 0;
>
> >
> > -     if (memcmp((*a)->key, (*b)->key, (*a)->elt->map->key_size))
> > +     if (memcmp(a->key, b->key, a->elt->map->key_size))
> >               ret = 1;
> >
> >       return ret;
> >  }
> >
> > -static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
> > -                        const struct tracing_map_sort_entry **b)
> > +static int cmp_entries_sum(const void *__a, const void *__b)
> >  {
> >       const struct tracing_map_elt *elt_a, *elt_b;
> >       struct tracing_map_sort_key *sort_key;
> > @@ -854,9 +856,13 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
> >       tracing_map_cmp_fn_t cmp_fn;
> >       void *val_a, *val_b;
> >       int ret = 0;
> > +     const struct tracing_map_sort_entry *a
> > +             = *(const struct tracing_map_sort_entry **)__a;
> > +     const struct tracing_map_sort_entry *b
> > +             = *(const struct tracing_map_sort_entry **)__b;
>
> Same here.
>
> >
> > -     elt_a = (*a)->elt;
> > -     elt_b = (*b)->elt;
> > +     elt_a = a->elt;
> > +     elt_b = b->elt;
> >
> >       sort_key = &elt_a->map->sort_key;
> >
> > @@ -873,8 +879,7 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
> >       return ret;
> >  }
> >
> > -static int cmp_entries_key(const struct tracing_map_sort_entry **a,
> > -                        const struct tracing_map_sort_entry **b)
> > +static int cmp_entries_key(const void *__a, const void *__b)
> >  {
> >       const struct tracing_map_elt *elt_a, *elt_b;
> >       struct tracing_map_sort_key *sort_key;
> > @@ -882,9 +887,13 @@ static int cmp_entries_key(const struct tracing_map_sort_entry **a,
> >       tracing_map_cmp_fn_t cmp_fn;
> >       void *val_a, *val_b;
> >       int ret = 0;
> > +     const struct tracing_map_sort_entry *a
> > +             = *(const struct tracing_map_sort_entry **)__a;
> > +     const struct tracing_map_sort_entry *b
> > +             = *(const struct tracing_map_sort_entry **)__b;
>
> And here.
>
> Thanks, and sorry for the long delay.
>
> -- Steve
>
> >
> > -     elt_a = (*a)->elt;
> > -     elt_b = (*b)->elt;
> > +     elt_a = a->elt;
> > +     elt_b = b->elt;
> >
> >       sort_key = &elt_a->map->sort_key;
> >
> > @@ -989,10 +998,8 @@ static void sort_secondary(struct tracing_map *map,
> >                          struct tracing_map_sort_key *primary_key,
> >                          struct tracing_map_sort_key *secondary_key)
> >  {
> > -     int (*primary_fn)(const struct tracing_map_sort_entry **,
> > -                       const struct tracing_map_sort_entry **);
> > -     int (*secondary_fn)(const struct tracing_map_sort_entry **,
> > -                         const struct tracing_map_sort_entry **);
> > +     int (*primary_fn)(const void *, const void *);
> > +     int (*secondary_fn)(const void *, const void *);
> >       unsigned i, start = 0, n_sub = 1;
> >
> >       if (is_key(map, primary_key->field_idx))
> > @@ -1061,8 +1068,7 @@ int tracing_map_sort_entries(struct tracing_map *map,
> >                            unsigned int n_sort_keys,
> >                            struct tracing_map_sort_entry ***sort_entries)
> >  {
> > -     int (*cmp_entries_fn)(const struct tracing_map_sort_entry **,
> > -                           const struct tracing_map_sort_entry **);
> > +     int (*cmp_entries_fn)(const void *, const void *);
> >       struct tracing_map_sort_entry *sort_entry, **entries;
> >       int i, n_entries, ret;
> >
> >
> > base-commit: 58e2cf5d794616b84f591d4d1276c8953278ce24
>

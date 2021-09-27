Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD050419DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhI0SQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbhI0SQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:16:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD356C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:15:12 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k24so18568922pgh.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NCTL+GkFcHJppp9EC1SmQtFoGIBu5+0m2/FwLTOnDy8=;
        b=VJxOzKAb1Lyhe6rLoEGSyu3SDBfj/nfG95Oe1MNkzTsZo8Lwn9VbKGj5y8O2VYrvZk
         jcGxola9iyq+R+lmJBNMoG90g8GbTzrkrTuaTcPnHRG0pfdOG5LYbFj2F7QktncDx+gQ
         UuC1/ki+u8TdzFWdDuWv8ei3xSMq+e9YFfrLZ+lCouKBXJcKQDZI9y/pXrrAkpav++4I
         hXpJoGZDM3hSTcbnZrv5uHn4iKLLzwXfgqO4ucWUllIm0vlS6+T+Z7Swtx/96F2bmbv5
         ylBoP9gMjQQGJTP/GxMYd/gORWR0H8hq/chIyT5VDD946Rb5kjKYhSpe5phiXNLEZ2Ft
         hsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCTL+GkFcHJppp9EC1SmQtFoGIBu5+0m2/FwLTOnDy8=;
        b=UMM/MY8fNCziNRypmjBBd5M2tUH29m48EOpbcUM+/n7AmfCnnfdInRdNC0m3IHzXS9
         ONGbpVsSJxzoq0ZruWhcnpxzXP7yR+Sqvgy3s9WnUi3chH8Fb9QEl7OL9yXG7MDFc5fO
         TgxXdgVIe1LwaZbWhs32Rl/broTV/pHi0THggaYuIBTEqwpHNYMKVaP729RGeCnSjFVm
         0k32r9Sodff0WxSVkiSIPv4PDJEM+lvEoiNFCOtJVe3drNR3X8FQmzEr104c94eFGaNZ
         Mo6MZxlQ3pLZCWrqyBQC33sQFpqaAPHbBj6ougsIkNo7eUO1vU3m5nePwpnOxe6YBlcD
         IGVw==
X-Gm-Message-State: AOAM533Bo1ZayQDjbXNHi+fUIedEjmRsRG70Y8N6zNu85r5M2VdAXTos
        LnLtoMa3ljJimgdpFQ7Pa+fL4V9EJetqztEqIzgzYg==
X-Google-Smtp-Source: ABdhPJyzFB0sgGo233U9WVRjhQx6vdhiFA22uPP/2aPHxvV74P1nCuZ3PssQcQXOms938mEloRglKKjrw6nTavtmrZU=
X-Received: by 2002:aa7:8246:0:b0:44b:4870:1b09 with SMTP id
 e6-20020aa78246000000b0044b48701b09mr1282894pfn.82.1632766512066; Mon, 27 Sep
 2021 11:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210923170908.2184404-1-kaleshsingh@google.com> <CABCJKucTiHDitevf1U97eCV1KdxAyui+fWvD1i7c8piVMnmjoQ@mail.gmail.com>
In-Reply-To: <CABCJKucTiHDitevf1U97eCV1KdxAyui+fWvD1i7c8piVMnmjoQ@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 27 Sep 2021 11:15:01 -0700
Message-ID: <CAC_TJve2aS_tHfmMCsayPFrAPaMid5DU3NK82KXC3dB9vhPdpw@mail.gmail.com>
Subject: Re: [PATCH] tracing/cfi: Fix cmp_entries_* functions signature mismatch
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>, namhyung@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 8:20 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Hi Kalesh,
>
> On Thu, Sep 23, 2021 at 10:09 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > If CONFIG_CFI_CLANG=y, attempting to read an event histogram will cause
> > the kernel to panic due to failed CFI check.
> >
> >     1. echo 'hist:keys=common_pid' >> events/sched/sched_switch/trigger
> >     2. cat >> events/sched/sched_switch/hist
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
> >         return err;
> >  }
> >
> > -static int cmp_entries_dup(const struct tracing_map_sort_entry **a,
> > -                          const struct tracing_map_sort_entry **b)
> > +static int cmp_entries_dup(const void *__a, const void *__b)
> >  {
> >         int ret = 0;
> > +       const struct tracing_map_sort_entry *a
> > +               = *(const struct tracing_map_sort_entry **)__a;
> > +       const struct tracing_map_sort_entry *b
> > +               = *(const struct tracing_map_sort_entry **)__b;
> >
> > -       if (memcmp((*a)->key, (*b)->key, (*a)->elt->map->key_size))
> > +       if (memcmp(a->key, b->key, a->elt->map->key_size))
> >                 ret = 1;
> >
> >         return ret;
> >  }
> >
> > -static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
> > -                          const struct tracing_map_sort_entry **b)
> > +static int cmp_entries_sum(const void *__a, const void *__b)
> >  {
> >         const struct tracing_map_elt *elt_a, *elt_b;
> >         struct tracing_map_sort_key *sort_key;
> > @@ -854,9 +856,13 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
> >         tracing_map_cmp_fn_t cmp_fn;
> >         void *val_a, *val_b;
> >         int ret = 0;
> > +       const struct tracing_map_sort_entry *a
> > +               = *(const struct tracing_map_sort_entry **)__a;
> > +       const struct tracing_map_sort_entry *b
> > +               = *(const struct tracing_map_sort_entry **)__b;
> >
> > -       elt_a = (*a)->elt;
> > -       elt_b = (*b)->elt;
> > +       elt_a = a->elt;
> > +       elt_b = b->elt;
> >
> >         sort_key = &elt_a->map->sort_key;
> >
> > @@ -873,8 +879,7 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
> >         return ret;
> >  }
> >
> > -static int cmp_entries_key(const struct tracing_map_sort_entry **a,
> > -                          const struct tracing_map_sort_entry **b)
> > +static int cmp_entries_key(const void *__a, const void *__b)
> >  {
> >         const struct tracing_map_elt *elt_a, *elt_b;
> >         struct tracing_map_sort_key *sort_key;
> > @@ -882,9 +887,13 @@ static int cmp_entries_key(const struct tracing_map_sort_entry **a,
> >         tracing_map_cmp_fn_t cmp_fn;
> >         void *val_a, *val_b;
> >         int ret = 0;
> > +       const struct tracing_map_sort_entry *a
> > +               = *(const struct tracing_map_sort_entry **)__a;
> > +       const struct tracing_map_sort_entry *b
> > +               = *(const struct tracing_map_sort_entry **)__b;
> >
> > -       elt_a = (*a)->elt;
> > -       elt_b = (*b)->elt;
> > +       elt_a = a->elt;
> > +       elt_b = b->elt;
> >
> >         sort_key = &elt_a->map->sort_key;
> >
> > @@ -989,10 +998,8 @@ static void sort_secondary(struct tracing_map *map,
> >                            struct tracing_map_sort_key *primary_key,
> >                            struct tracing_map_sort_key *secondary_key)
> >  {
> > -       int (*primary_fn)(const struct tracing_map_sort_entry **,
> > -                         const struct tracing_map_sort_entry **);
> > -       int (*secondary_fn)(const struct tracing_map_sort_entry **,
> > -                           const struct tracing_map_sort_entry **);
> > +       int (*primary_fn)(const void *, const void *);
> > +       int (*secondary_fn)(const void *, const void *);
> >         unsigned i, start = 0, n_sub = 1;
> >
> >         if (is_key(map, primary_key->field_idx))
> > @@ -1061,8 +1068,7 @@ int tracing_map_sort_entries(struct tracing_map *map,
> >                              unsigned int n_sort_keys,
> >                              struct tracing_map_sort_entry ***sort_entries)
> >  {
> > -       int (*cmp_entries_fn)(const struct tracing_map_sort_entry **,
> > -                             const struct tracing_map_sort_entry **);
> > +       int (*cmp_entries_fn)(const void *, const void *);
> >         struct tracing_map_sort_entry *sort_entry, **entries;
> >         int i, n_entries, ret;
> >
> >
>
> Thanks for the patch! This looks correct to me and fixes the function
> type mismatch that trips CFI.
>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Thanks for the review Sami.

Steve, will this get picked up for your tree?

>
> Sami

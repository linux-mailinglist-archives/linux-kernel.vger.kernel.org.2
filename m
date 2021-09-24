Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160B2417766
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbhIXPWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 11:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346995AbhIXPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 11:22:21 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3D5C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:20:47 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id s16so6475127ybe.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJczbxCTLgMN762FoZK7X7EA0STDgnqYogdOaHtE9u8=;
        b=QhlCin+yArkYZSWzZFKZqB8RGHyWfqjFekguOJfvRv/YwbcIGWM+4VAedrIQUheoFM
         sMvZYJldiRa0+JN7esyHyy191nNcor49uWafVWFXV/B1jhSzwKUR9fKq/qcrqTpIbhXO
         3zzHuMk4xz+JdibriRjhnZBmJx2r1PMaJfC/xsfDliXCgGirAH0l9FuF8kSWj8SG4u6n
         PDQnuddYbriIP4CAj7I2jPTaHL00nj6Mumwa2Ogqxgq4Zd74uTGqR4+B8JP1dKnY0mz+
         1MSiCbGwycjDZ2W4vcV8Enhf7G60h2caNrRtgh637c3H4tjy7KPIUD5RzYCG8Ml6u7rv
         Xlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJczbxCTLgMN762FoZK7X7EA0STDgnqYogdOaHtE9u8=;
        b=JI4ZTd2mPO5UmtEl+r5tOaA4qwXgPChQzb8iX65xXkwZx+4v56VMrooZ1oCFUKQdx2
         3lIkuqnskvrPBj6ok3LnMlcC664Jxkz4P9r0F/7hoASOaOn8G+hmWOgui7m/zXIuZoQ6
         pDHdg4A0krb9dSUKyi2gAFUC3dn/2vLmTynLlfkKmWhJ6VJ224LKHWAoIvdVw92jZ0Oa
         y9PmZ/7P/LHfnsV7LbM5xPPMFugeFvI1tOWdEZwOpvvb1HWMVOof/Rgmfp8T0aObepTV
         cRVIK9l4N44yqz2vsvupII4t10xuLIcpuQ3HNIZS23n1PqUhoiR8SeijTGgT4FQ0ReCm
         BgjQ==
X-Gm-Message-State: AOAM530GMUVxQk4p3RhOQ/kYL/xck0Y6laAKcjwWWwSAawgwdW36gbJ2
        Z9diNzD5E88VU/kQafiRiN29ERUMd9gNcRnZlnDNYA==
X-Google-Smtp-Source: ABdhPJyW+soE/vaScO/YpE8pprQf8Ce57Qx9ho4y22I2gY4sVqkgOf7gKmmsaCQkX+tTZROZ26YBKj5dOdcys9GSC6w=
X-Received: by 2002:a25:d2ce:: with SMTP id j197mr14249240ybg.160.1632496846776;
 Fri, 24 Sep 2021 08:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210923170908.2184404-1-kaleshsingh@google.com>
In-Reply-To: <20210923170908.2184404-1-kaleshsingh@google.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 24 Sep 2021 08:20:35 -0700
Message-ID: <CABCJKucTiHDitevf1U97eCV1KdxAyui+fWvD1i7c8piVMnmjoQ@mail.gmail.com>
Subject: Re: [PATCH] tracing/cfi: Fix cmp_entries_* functions signature mismatch
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, Hridya Valsaraju <hridya@google.com>,
        namhyung@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Thu, Sep 23, 2021 at 10:09 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> If CONFIG_CFI_CLANG=y, attempting to read an event histogram will cause
> the kernel to panic due to failed CFI check.
>
>     1. echo 'hist:keys=common_pid' >> events/sched/sched_switch/trigger
>     2. cat >> events/sched/sched_switch/hist
>     3. kernel panices on attempting to read hist
>
> This happens because the sort() function expects a generic
> int (*)(const void *, const void *) pointer for the compare function.
> To prevent this CFI failure, change tracing map cmp_entries_* function
> signatures to match this.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  kernel/trace/tracing_map.c | 40 ++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> index d6bddb157ef2..a8c80ebbf9da 100644
> --- a/kernel/trace/tracing_map.c
> +++ b/kernel/trace/tracing_map.c
> @@ -834,19 +834,21 @@ int tracing_map_init(struct tracing_map *map)
>         return err;
>  }
>
> -static int cmp_entries_dup(const struct tracing_map_sort_entry **a,
> -                          const struct tracing_map_sort_entry **b)
> +static int cmp_entries_dup(const void *__a, const void *__b)
>  {
>         int ret = 0;
> +       const struct tracing_map_sort_entry *a
> +               = *(const struct tracing_map_sort_entry **)__a;
> +       const struct tracing_map_sort_entry *b
> +               = *(const struct tracing_map_sort_entry **)__b;
>
> -       if (memcmp((*a)->key, (*b)->key, (*a)->elt->map->key_size))
> +       if (memcmp(a->key, b->key, a->elt->map->key_size))
>                 ret = 1;
>
>         return ret;
>  }
>
> -static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
> -                          const struct tracing_map_sort_entry **b)
> +static int cmp_entries_sum(const void *__a, const void *__b)
>  {
>         const struct tracing_map_elt *elt_a, *elt_b;
>         struct tracing_map_sort_key *sort_key;
> @@ -854,9 +856,13 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
>         tracing_map_cmp_fn_t cmp_fn;
>         void *val_a, *val_b;
>         int ret = 0;
> +       const struct tracing_map_sort_entry *a
> +               = *(const struct tracing_map_sort_entry **)__a;
> +       const struct tracing_map_sort_entry *b
> +               = *(const struct tracing_map_sort_entry **)__b;
>
> -       elt_a = (*a)->elt;
> -       elt_b = (*b)->elt;
> +       elt_a = a->elt;
> +       elt_b = b->elt;
>
>         sort_key = &elt_a->map->sort_key;
>
> @@ -873,8 +879,7 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
>         return ret;
>  }
>
> -static int cmp_entries_key(const struct tracing_map_sort_entry **a,
> -                          const struct tracing_map_sort_entry **b)
> +static int cmp_entries_key(const void *__a, const void *__b)
>  {
>         const struct tracing_map_elt *elt_a, *elt_b;
>         struct tracing_map_sort_key *sort_key;
> @@ -882,9 +887,13 @@ static int cmp_entries_key(const struct tracing_map_sort_entry **a,
>         tracing_map_cmp_fn_t cmp_fn;
>         void *val_a, *val_b;
>         int ret = 0;
> +       const struct tracing_map_sort_entry *a
> +               = *(const struct tracing_map_sort_entry **)__a;
> +       const struct tracing_map_sort_entry *b
> +               = *(const struct tracing_map_sort_entry **)__b;
>
> -       elt_a = (*a)->elt;
> -       elt_b = (*b)->elt;
> +       elt_a = a->elt;
> +       elt_b = b->elt;
>
>         sort_key = &elt_a->map->sort_key;
>
> @@ -989,10 +998,8 @@ static void sort_secondary(struct tracing_map *map,
>                            struct tracing_map_sort_key *primary_key,
>                            struct tracing_map_sort_key *secondary_key)
>  {
> -       int (*primary_fn)(const struct tracing_map_sort_entry **,
> -                         const struct tracing_map_sort_entry **);
> -       int (*secondary_fn)(const struct tracing_map_sort_entry **,
> -                           const struct tracing_map_sort_entry **);
> +       int (*primary_fn)(const void *, const void *);
> +       int (*secondary_fn)(const void *, const void *);
>         unsigned i, start = 0, n_sub = 1;
>
>         if (is_key(map, primary_key->field_idx))
> @@ -1061,8 +1068,7 @@ int tracing_map_sort_entries(struct tracing_map *map,
>                              unsigned int n_sort_keys,
>                              struct tracing_map_sort_entry ***sort_entries)
>  {
> -       int (*cmp_entries_fn)(const struct tracing_map_sort_entry **,
> -                             const struct tracing_map_sort_entry **);
> +       int (*cmp_entries_fn)(const void *, const void *);
>         struct tracing_map_sort_entry *sort_entry, **entries;
>         int i, n_entries, ret;
>
>

Thanks for the patch! This looks correct to me and fixes the function
type mismatch that trips CFI.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

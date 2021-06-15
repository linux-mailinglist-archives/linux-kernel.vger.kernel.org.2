Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2AD3A7B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhFOKLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhFOKLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:11:17 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3935CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 03:09:12 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso13727069otu.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 03:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/L9M46eaaH0QBqlJTDr9j5/a1oRGHp298rEoHobuSk=;
        b=W/lfR0zLReQdc7PHjJRVB6Z9hn6GJnOFkroA8pyiE5Y0liNQOgHCt87KS4/bkAX7eE
         ruHOuoF3srORlhSJjFmg2JbJjF5kGBzDUdqoQ0xbY3+7U7KDtUEKQoFIW1wmxShxQmod
         7IyMraVpNr1qagN5T38H67gQWcRWPStkYlkY11tL5rOY+XXsGhRyP8nZUCYVpimFgaQE
         TDDfZ1AGYIcueALqYy5l63YjogRbXNbuef49nv3KDRdF0RjbjFT7pI243T186J46J90u
         GYwjsGeX4c5nDZ3pG35tX5Es3IqFrw8pDn67QjzsbdqHfe/JYmQpn0mp/7J6DK3wRnbU
         rLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/L9M46eaaH0QBqlJTDr9j5/a1oRGHp298rEoHobuSk=;
        b=hLcuH17v7hXrjPwC7mcy7OeyNu5IBz4O9BYl+Kb1fuwtWg0Dyh1Kvf5RfR2+rZ5wzV
         rg/C7nBOHAC8/i0f/DCRLYxNgpxxpEHp2j91RWkElZRmbXQNDjDHvlv3/877tdhQAE9q
         ezjDndWZvkqcW/2se1dERZ8p3IQeiaRheh2JDBKUrWW1l7DsRuGQbCOuAxaJd1Kx9gQK
         Sd/VjZJJnSrGEVu+koqSuFkTDRaSpKv1bUGcjmOLM8gM2hyta19iTAJTUOJNnPIj6nrt
         +nvncQzbihjIeqGYT+jDyVZeUwfnEjKvPsadA5GS3gYuikyy9a6l6qkTcVwP4lw+kzwl
         GIwA==
X-Gm-Message-State: AOAM530K/+B6HzGWJsPEYDt2YSErgeya7tVmUpfGybDAR29Yzkf3CC6f
        EvYMDvqoVauE4uBGQkeU30PFzWvyDW1wpeuJoe5SmA==
X-Google-Smtp-Source: ABdhPJxoyp0dtnWruW4n6Mt2ds9c4qUeqUilzebp8wuisHioo9OHuACmSktOGVx8KTei3SgLqyvF0y6ZD0IXk1FVzz0=
X-Received: by 2002:a05:6830:1c7b:: with SMTP id s27mr17651144otg.233.1623751751394;
 Tue, 15 Jun 2021 03:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210615014705.2234866-1-dja@axtens.net> <20210615014705.2234866-3-dja@axtens.net>
In-Reply-To: <20210615014705.2234866-3-dja@axtens.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 15 Jun 2021 12:08:59 +0200
Message-ID: <CANpmjNN2=gdDBPzYQYsmOtLQVVjSz2qFcwcTMEqB=s_ZWndJLg@mail.gmail.com>
Subject: Re: [PATCH v12 2/6] kasan: allow architectures to provide an outline
 readiness check
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        aneesh.kumar@linux.ibm.com, Balbir Singh <bsingharora@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 at 03:47, Daniel Axtens <dja@axtens.net> wrote:
>
> Allow architectures to define a kasan_arch_is_ready() hook that bails
> out of any function that's about to touch the shadow unless the arch
> says that it is ready for the memory to be accessed. This is fairly
> uninvasive and should have a negligible performance penalty.
>
> This will only work in outline mode, so an arch must specify
> ARCH_DISABLE_KASAN_INLINE if it requires this.
>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
>
> --
>
> I discuss the justfication for this later in the series. Also,
> both previous RFCs for ppc64 - by 2 different people - have
> needed this trick! See:
>  - https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
>  - https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
> ---
>  mm/kasan/common.c  | 4 ++++
>  mm/kasan/generic.c | 3 +++
>  mm/kasan/kasan.h   | 4 ++++
>  mm/kasan/shadow.c  | 4 ++++
>  4 files changed, 15 insertions(+)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 10177cc26d06..0ad615f3801d 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -331,6 +331,10 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>         u8 tag;
>         void *tagged_object;
>
> +       /* Bail if the arch isn't ready */
> +       if (!kasan_arch_is_ready())
> +               return false;
> +
>         tag = get_tag(object);
>         tagged_object = object;
>         object = kasan_reset_tag(object);
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 53cbf28859b5..c3f5ba7a294a 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -163,6 +163,9 @@ static __always_inline bool check_region_inline(unsigned long addr,
>                                                 size_t size, bool write,
>                                                 unsigned long ret_ip)
>  {
> +       if (!kasan_arch_is_ready())
> +               return true;
> +
>         if (unlikely(size == 0))
>                 return true;
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8f450bc28045..19323a3d5975 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -449,6 +449,10 @@ static inline void kasan_poison_last_granule(const void *address, size_t size) {
>
>  #endif /* CONFIG_KASAN_GENERIC */
>
> +#ifndef kasan_arch_is_ready
> +static inline bool kasan_arch_is_ready(void)   { return true; }
> +#endif
> +
>  /*
>   * Exported functions for interfaces called from assembly or from generated
>   * code. Declarations here to avoid warning about missing declarations.
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 082ee5b6d9a1..74134b657d7d 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -73,6 +73,10 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
>  {
>         void *shadow_start, *shadow_end;
>
> +       /* Don't touch the shadow memory if arch isn't ready */
> +       if (!kasan_arch_is_ready())
> +               return;
> +

What about kasan_poison_last_granule()? kasan_unpoison() currently
seems to potentially trip on that.

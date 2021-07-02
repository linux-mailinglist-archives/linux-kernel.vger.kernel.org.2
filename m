Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC813B9E4A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhGBJgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhGBJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:36:37 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41793C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 02:34:05 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s17so10718507oij.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrAYdCh2ggaj+XWyXcYy308yp58pQSy2cm79Y1b9M3w=;
        b=hNF+Pzl08HoowaYaI83wQ56Z3dXc8hRtqXGtkOzRz33spQN1kGyXCVYZVzm0DYWiLw
         XtCqS+WaXZriTD8y0SP0WsV9iOn77PsWScKeRn4c7PG9cj8ydXssDog7mjNCw8tmmuLE
         kK/MdzCEK4SKBRDgdHLCHcKpPKZuUv9KbQlZsSJ99wkV6LZRqUA7MZdDTdir0KunOwLX
         lD+r1KE0ZhmxbwGSwrPHUm2/Tsy4UGZZOG9CAMykeOXzLAkYHI/yBhyJ2wmodFGjJxWT
         pblIW+2gTt0xKiPPMkXLrT5fWrh9OBCPA3PjQmoVivLa/x88/0TG/o5HEJS/5C8jiftf
         Nbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrAYdCh2ggaj+XWyXcYy308yp58pQSy2cm79Y1b9M3w=;
        b=nxDD2ma1upBpiPS0o3+sebiErzvQrcoKJrT3Nv4dBIE1mJs5o76EJq/jwYacjchtOC
         W/dARtHK1kSutwQSjw0Qse0DTIAJ2GE38v2zACYcAxuoSm+5yul65tnPXy/lcqjHjUax
         PgYCKv1dyXC8qMX9lAX115XPyhhYO86Y40dZRHEjpJ76QAtqLGmOJ9lrp15D6j38sAMT
         J4vVZyJftpEKNto4kmXcD8Mzp900QiuR9K65VU1TNglSGI8Qn2uWRxsXXy6ad2Yml+t6
         vrd3yHx/XobDi1DRufnNim2NUB+8JfKa12/qEK/phBVlFFK3rxJT2moddCHt8+zxilGj
         bT/Q==
X-Gm-Message-State: AOAM530R4ZCr0xGSlaH1NcYIx8PnhiQ0yM8echnmV/RB/K/lbnI/Qila
        X2G6s7dZVMhIE8Php0lkesmY3wokvmUOrM/wb2R9xg==
X-Google-Smtp-Source: ABdhPJzv4fiupIq0BP8aoyZl0EKj339UCB3ZRtMVV0Lv/baM7npJRmNBELCQcSGxXvHf8nlEIar0CsEzluqEKYruPtc=
X-Received: by 2002:a05:6808:210e:: with SMTP id r14mr2475518oiw.172.1625218444412;
 Fri, 02 Jul 2021 02:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210702085332.10035-1-yee.lee@mediatek.com>
In-Reply-To: <20210702085332.10035-1-yee.lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 2 Jul 2021 11:33:53 +0200
Message-ID: <CANpmjNPqHJqAaDBJDA1t-OOWKMSs5sqbwVRAkQr+E6w5EgJ1Nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: introduce helper to check slub_debug_enabled
To:     yee.lee@mediatek.com
Cc:     andreyknvl@gmail.com, wsd_upstream@mediatek.com,
        nicholas.tang@mediatek.com, Kuan-Ying.Lee@mediatek.com,
        chinwen.chang@mediatek.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2021 at 10:54, <yee.lee@mediatek.com> wrote:
>
> From: Marco Elver <elver@google.com>
>
> Introduce a helper to check slub_debug_enabled, so that we can confine
> the use of #ifdef to the definition of the slub_debug_enabled_unlikely()
> helper.
>
> ---

^^ this '---' is wrong. It needs to be removed, because anything after
the first '---' will be discarded if it is turned into a commit by the
maintainer.


> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Yee Lee <yee.lee@mediatek.com>
>
> ---
>  mm/slab.h | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 7b60ef2f32c3..a11126afe24c 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -216,10 +216,18 @@ DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
>  #endif
>  extern void print_tracking(struct kmem_cache *s, void *object);
>  long validate_slab_cache(struct kmem_cache *s);
> +static inline bool slub_debug_enabled_unlikely(void)
> +{
> +       return static_branch_unlikely(&slub_debug_enabled);
> +}
>  #else
>  static inline void print_tracking(struct kmem_cache *s, void *object)
>  {
>  }
> +static inline bool slub_debug_enabled_unlikely(void)
> +{
> +       return false;
> +}
>  #endif
>
>  /*
> @@ -229,11 +237,10 @@ static inline void print_tracking(struct kmem_cache *s, void *object)
>   */
>  static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
>  {
> -#ifdef CONFIG_SLUB_DEBUG
> -       VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
> -       if (static_branch_unlikely(&slub_debug_enabled))
> +       if (IS_ENABLED(CONFIG_SLUB_DEBUG))
> +               VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
> +       if (slub_debug_enabled_unlikely())
>                 return s->flags & flags;
> -#endif
>         return false;
>  }
>
> --
> 2.18.0

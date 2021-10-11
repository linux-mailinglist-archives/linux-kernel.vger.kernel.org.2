Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2E5429549
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhJKRKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhJKRKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:10:14 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006F1C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 10:08:13 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y207so22344924oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bdR8B2SCkgkhZRGwEibKgUZJ+mS8tIXLqdrjvZhlSeY=;
        b=MADCvz5NbcGRWgYUnnEopvajCNlM9xGn432/01uisL2VJssIEWlI/Fp0eBrIiaXZMx
         ztNx3+nsgemWrq2UTWsbaQUoHMKuoFTfh1+kU2nh9Bms9CQXZc0LuRNHhDyqTbEm9yE+
         BpREs6YY7zhuWj6GWj90eTWxm9BYoeNybaQYZfxJr2tuk/TqaIqcziu1wIv/aUFyLnSh
         /+Tg5gt0LgiW+gZj2fCh/JFTSgX1hwAr88eSRGp9xcejw2UrvzNcYYi8eCg8noMqMx3t
         lXgWAqtDqQS+UGJkU01sXU//fn6JESUFhrFLIs8TP7lS4Bn3TSMm7OG2YBNYkNjUrBWo
         FQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdR8B2SCkgkhZRGwEibKgUZJ+mS8tIXLqdrjvZhlSeY=;
        b=YScIXbS+vTmxEL0+9UXAWUzIwhyRC7xGQ9gfTm4297/zj569DM0ffWtHvMJEpIe+lz
         Lxnp0DiIEk/oKbg+Wyu89OMrIliMqSOMsRo+EoUzxH0D1QpUnnm6aS6XZ/9PmGC8PmhQ
         X5ExpSfqgvVS0Mr2Ukpj2Vu+ztmmkyVf5wvnevDVQBeWDxKbpVvbsX7oE4waikDcVBgm
         boKcDCWYSXyisMTdYgCPjiAJv6aDOK9b1Eohm7rh6570YqpYMRIWx8s+nDYbwlUWjM94
         /2+RPZGFwg6jfPmxCnBIck6lm3EOJDFWR7lXI165hBmPVQNj1+/DNIoyVkT9BTd4/Qfw
         xxVw==
X-Gm-Message-State: AOAM533S3DapsIX9vLGd+isGwNGuZ7W1lfkw1nNiRVHUI451UihLZDRf
        TThxirHwTnLNStv0fycrBbfRaXP0jS59Ygvd/XRiWg==
X-Google-Smtp-Source: ABdhPJyLho+5zSsoVSlKP+x611Lv7WBfE3Spy5S+sd4hJmMPlnG+XC8c/EJh3fRyckNGj+URcwD6go10L9AJ6c7zRJ0=
X-Received: by 2002:a54:4618:: with SMTP id p24mr109828oip.134.1633972093136;
 Mon, 11 Oct 2021 10:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211007095815.3563-1-vbabka@suse.cz> <YV7TnygBLdHJjmRW@elver.google.com>
 <2a62971d-467f-f354-caac-2b5ecf258e3c@suse.cz>
In-Reply-To: <2a62971d-467f-f354-caac-2b5ecf258e3c@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Oct 2021 19:08:01 +0200
Message-ID: <CANpmjNP4U9a5HFoRt=HLHpUCNiR5v82ia++wfRCezTY1TpR9RA@mail.gmail.com>
Subject: Re: [PATCH] lib/stackdepot: allow optional init and stack_table
 allocation by kvmalloc()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kasan-dev@googlegroups.com,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Oliver Glitta <glittao@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 at 19:02, Vlastimil Babka <vbabka@suse.cz> wrote:
[...]
> > On the other hand, the lazy initialization mode you're introducing
> > requires an explicit stack_depot_init() call somewhere and isn't as
> > straightforward as before.
> >
> > Not sure what is best. My intuition tells me STACKDEPOT_LAZY_INIT would
> > be safer as it's a deliberate opt-in to the lazy initialization
> > behaviour.
>
> I think it should be fine with ALWAYS_INIT. There are not many stackdepot
> users being added, and anyone developing a new one will very quickly find
> out if they forget to call stack_depot_init()?

I think that's fine.

> > Preferences?
> >
> > [...]
> >> --- a/drivers/gpu/drm/drm_mm.c
> >> +++ b/drivers/gpu/drm/drm_mm.c
> >> @@ -980,6 +980,10 @@ void drm_mm_init(struct drm_mm *mm, u64 start, u64 size)
> >>      add_hole(&mm->head_node);
> >>
> >>      mm->scan_active = 0;
> >> +
> >> +#ifdef CONFIG_DRM_DEBUG_MM
> >> +    stack_depot_init();
> >> +#endif
> >
> > DRM_DEBUG_MM implies STACKDEPOT. Not sure what is more readable to drm
> > maintainers, but perhaps it'd be nicer to avoid the #ifdef here, and
> > instead just keep the no-op version of stack_depot_init() in
> > <linux/stackdepot.h>. I don't have a strong preference.
>
> Hm, but in case STACKDEPOT is also selected by something else (e.g.
> CONFIG_PAGE_OWNER) which uses lazy init but isn't enabled on boot, then
> without #ifdef CONFIG_DRM_DEBUG_MM above, this code would call a
> stack_depot_init() (that's not a no-op) even in case it's not going to be
> using it, so not what we want to achieve.
> But it could be changed to use IS_ENABLED() if that's preferred by DRM folks.

You're right -- but I'll leave this to DRM folks.

> BTW it's possible that there won't be any DRM review because this failed to
> apply:
> https://patchwork.freedesktop.org/series/95549/
> DRM folks, any hint how to indicate that the base was next-20211001?
>
[...]
> > +#ifdef CONFIG_STACKDEPOT_ALWAYS_INIT
> > +static inline int stack_depot_early_init(void)       { return stack_depot_init(); }
> > +#else
> > +static inline int stack_depot_early_init(void)       { return 0; }
> > +#endif       /* CONFIG_STACKDEPOT_ALWAYS_INIT */
>
> We could, but it's a wrapper made for only a single caller...
>
> >>  #endif
> >> diff --git a/init/main.c b/init/main.c
> >> index ee4d3e1b3eb9..b6a5833d98f5 100644
> >> --- a/init/main.c
> >> +++ b/init/main.c
> >> @@ -844,7 +844,8 @@ static void __init mm_init(void)
> >>      init_mem_debugging_and_hardening();
> >>      kfence_alloc_pool();
> >>      report_meminit();
> >> -    stack_depot_init();
> >> +    if (IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT))
> >> +            stack_depot_init();
> >
> > I'd push the decision of when to call this into <linux/stackdepot.h> via
> > wrapper stack_depot_early_init().
>
> No strong preferrences, if you think it's worth it.

All the other *init() functions seem to follow the same idiom as there
are barely any IS_ENABLED() in init/main.c.  So I think it's just
about being consistent with the rest.

Thanks,
-- Marco

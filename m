Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D83830C829
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbhBBRnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhBBRk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:40:27 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904A4C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 09:39:47 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id h14so20650232otr.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BII6X9VkkCmC/J7Ey1mCa41oEbJr520MWQnzH5Xhv9Q=;
        b=PXjuYV0cOp+567jMKpyOOYrjzFrmMQhpSsf4yKEj5lgebN6BPUEB3mV0so6yLmEjZ/
         pYQR5Gdmou19gzOoWJ02cuLckRr52qZxtZuUgRJb4FaJNr+sge515wPZqkQl0ntQoqDy
         2I1jXVcIZ27bOU7BTbY6PRYYi1TfDbC0AuCrtCI9cQAk2pNS+CZhFBl5ydKPDMl1MctF
         DxR5LaBQwSAWdWblKfK9QJV/mQWpWk6jfKfqi+VILWUVP/kqmv33gByUpZDlWHRHmeyC
         CO9qGnyidze/4GQnX95hyvKsKOGzcWqlqmanJw08OXhM9+d+0EPazBulZoC2p6BQfprs
         rVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BII6X9VkkCmC/J7Ey1mCa41oEbJr520MWQnzH5Xhv9Q=;
        b=rLdv4qfFmUaduH7sJUWYAxgFfLNf3/TogKIZjztJOq5lEsMO9yfoR6zmQx9NJ3IObt
         14Ld8qnJXPvWwELZEkaDaH+R4Z+6txkzaUyeN0OstpMBHjipVFYIlD0K/+oiNA/MHquH
         DRjukVZwvCgQ5JCM6/b85158cnVllbamgV/FrQFA2DwUFxlTsyxXBGEoW3kBKHOz7PG8
         Afnm6SHjJ1kL9efjyO/VlOyBFN/4cvnhXZVlqQediwRy6Uo+rutgQdBdqbyWcRckPc85
         gdnChyqjSZlvjij1xUxxXvBop8CsYlY0/LS4UuH0j37vkRW1PKShsuXTgNJokl7uoP58
         2tTw==
X-Gm-Message-State: AOAM530CmFaSkXOY3N5njHkMq+doB3VDT4KAfR3VTJwTQTDkKE5sBjFD
        ZQ7nHNBgIK23E7zt6dlq+lzBXDdkW08oUarSgXV//Q==
X-Google-Smtp-Source: ABdhPJyR3YEZ4MxJTnMrgfDlYCaQYg+zdfO3gVmBuM9e5QmzuE0U8HFwQZS9QkNvG8speGBODgcWI+2jh8ltkuDl1Fo=
X-Received: by 2002:a9d:4687:: with SMTP id z7mr16664460ote.233.1612287586711;
 Tue, 02 Feb 2021 09:39:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com> <b3a02f4f7cda00c87af170c1bf555996a9c6788c.1612208222.git.andreyknvl@google.com>
 <YBl9C+q84BqiFd4F@elver.google.com> <CAAeHK+xzBpdzO7BmdVZe3_g5Di+-AGyYAO5zBVvOpEUtXD8koA@mail.gmail.com>
In-Reply-To: <CAAeHK+xzBpdzO7BmdVZe3_g5Di+-AGyYAO5zBVvOpEUtXD8koA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 2 Feb 2021 18:39:35 +0100
Message-ID: <CANpmjNNf7i4EoehOC_Zx_gHax3AU7HTxWBXfeTkJxZv8ezYgcw@mail.gmail.com>
Subject: Re: [PATCH 02/12] kasan, mm: optimize kmalloc poisoning
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 at 18:16, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Tue, Feb 2, 2021 at 5:25 PM Marco Elver <elver@google.com> wrote:
> >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > > +
> > > +/**
> > > + * kasan_poison_last_granule - mark the last granule of the memory range as
> > > + * unaccessible
> > > + * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
> > > + * @size - range size
> > > + *
> > > + * This function is only available for the generic mode, as it's the only mode
> > > + * that has partially poisoned memory granules.
> > > + */
> > > +void kasan_poison_last_granule(const void *address, size_t size);
> > > +
> > > +#else /* CONFIG_KASAN_GENERIC */
> > > +
> > > +static inline void kasan_poison_last_granule(const void *address, size_t size) { }
>
> ^
>
> > > +
> > > +#endif /* CONFIG_KASAN_GENERIC */
> > > +
> > >  /*
> > >   * Exported functions for interfaces called from assembly or from generated
> > >   * code. Declarations here to avoid warning about missing declarations.
>
> > > @@ -96,6 +92,16 @@ void kasan_poison(const void *address, size_t size, u8 value)
> > >  }
> > >  EXPORT_SYMBOL(kasan_poison);
> > >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > > +void kasan_poison_last_granule(const void *address, size_t size)
> > > +{
> > > +     if (size & KASAN_GRANULE_MASK) {
> > > +             u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
> > > +             *shadow = size & KASAN_GRANULE_MASK;
> > > +     }
> > > +}
> > > +#endif
> >
> > The function declaration still needs to exist in the dead branch if
> > !IS_ENABLED(CONFIG_KASAN_GENERIC). It appears in that case it's declared
> > (in kasan.h), but not defined.  We shouldn't get linker errors because
> > the optimizer should remove the dead branch. Nevertheless, is this code
> > generally acceptable?
>
> The function is defined as empty when !CONFIG_KASAN_GENERIC, see above.

I missed that, thanks.

Reviewed-by: Marco Elver <elver@google.com>

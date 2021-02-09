Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB86731501E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhBINZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhBINZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:25:30 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE0C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 05:24:50 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x9so9749693plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 05:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLaBmb+gbvYqE7SFoBORWrnKQFbpMrwQooOmjDgpSmc=;
        b=Aaono0oIpDgkEDIXP5mkUIMiyx2/b7W24BRlceYxZTzAfaUlNp8B9UX+B89nU2x2vD
         w5AQhJHbkQc7SrodWfdoHGKpNfANjseR7lXUrWtEQg6Fd+jAVsVwYK+3NWnVhHO31MOU
         wtopGP8DbAjxdsMzmLsx/8jzjnDTWiK3BjuRyfmNGyZyvB96ze6+B+TdJtg9JoM8hREG
         OGBYv+x1b0yJHlr97loq8Ve7tPr+tlHA8VBXsb5pNd4tyMBw78Wme+2LgI2ajXCCoZRQ
         nS88kYG0AC2v1gXJrKuVg3dUo8zsrHZvn6t2tY/yYTTbq1Ll3SdlGQ1P0gI8dp0x2Bch
         OIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLaBmb+gbvYqE7SFoBORWrnKQFbpMrwQooOmjDgpSmc=;
        b=DIc9Vme++jcqE0CsbA0EU/JSUJ+Aj5Cd3lSfzBA7k3559Kz7udjEDX7q8GUrXIOk/y
         E58sK1JunjnYfrnTdRy8dRmNGuBAA1G6ooU6+Y4eNW25no/IyYM8/cNsBjv3ei9iAB7z
         dyhi+x6ydPhAZ6wHbTKRUJvPAb4b3JBXvRcErIzBgTIpnIr6igPo1bvzNRPeBwlCHZR6
         Y8TM3JSe+68djhgWghscx/iwDOKHONlayeZKOB1Yc7WShbqcJlynY2i27dGCk47r8E1K
         Nne/l4TUOOFaow0/PZd0lbM+QrLzsAxkBpRoIQYOi2jE6ExgURRhkG+PC7K3mNhGVtyJ
         R4uQ==
X-Gm-Message-State: AOAM532u699I8oPb9FXyE1SCLQ3Ll8PYZqfkTzQ/OwnPuYF6oZTfYxkc
        jkutn8gP+VD+3SIH+IuLdPcwCgGi/OID4lwx/0Os0g==
X-Google-Smtp-Source: ABdhPJwxowFZTWwsONc5/aDAhaLkmNppY95ibAPHfxLZiYQwz6o50yJpaTZV/WidlF7oXRCB9No9ewGuc+EyJs0yjqc=
X-Received: by 2002:a17:903:31d1:b029:de:8361:739b with SMTP id
 v17-20020a17090331d1b02900de8361739bmr21064623ple.85.1612877089414; Tue, 09
 Feb 2021 05:24:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612546384.git.andreyknvl@google.com> <9bef90327c9cb109d736c40115684fd32f49e6b0.1612546384.git.andreyknvl@google.com>
 <YCEW4SNDDERCWd7f@elver.google.com>
In-Reply-To: <YCEW4SNDDERCWd7f@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 9 Feb 2021 14:24:38 +0100
Message-ID: <CAAeHK+xHnAVbVOF_wuk3+K5Dy2K2i0NTi+_fZfGX-KHXubRW4A@mail.gmail.com>
Subject: Re: [PATCH v3 mm 08/13] kasan, mm: optimize krealloc poisoning
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
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

On Mon, Feb 8, 2021 at 11:48 AM Marco Elver <elver@google.com> wrote:
>
> On Fri, Feb 05, 2021 at 06:34PM +0100, Andrey Konovalov wrote:
> > Currently, krealloc() always calls ksize(), which unpoisons the whole
> > object including the redzone. This is inefficient, as kasan_krealloc()
> > repoisons the redzone for objects that fit into the same buffer.
> >
> > This patch changes krealloc() instrumentation to use uninstrumented
> > __ksize() that doesn't unpoison the memory. Instead, kasan_kreallos()
> > is changed to unpoison the memory excluding the redzone.
> >
> > For objects that don't fit into the old allocation, this patch disables
> > KASAN accessibility checks when copying memory into a new object instead
> > of unpoisoning it.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> Clarification below.
>
> > ---
> >  mm/kasan/common.c | 12 ++++++++++--
> >  mm/slab_common.c  | 20 ++++++++++++++------
> >  2 files changed, 24 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 7ea643f7e69c..a8a67dca5e55 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -476,7 +476,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
> >
> >       /*
> >        * The object has already been unpoisoned by kasan_slab_alloc() for
> > -      * kmalloc() or by ksize() for krealloc().
> > +      * kmalloc() or by kasan_krealloc() for krealloc().
> >        */
> >
> >       /*
> > @@ -526,7 +526,7 @@ void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
> >
> >       /*
> >        * The object has already been unpoisoned by kasan_alloc_pages() for
> > -      * alloc_pages() or by ksize() for krealloc().
> > +      * alloc_pages() or by kasan_krealloc() for krealloc().
> >        */
> >
> >       /*
> > @@ -554,8 +554,16 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
> >       if (unlikely(object == ZERO_SIZE_PTR))
> >               return (void *)object;
> >
> > +     /*
> > +      * Unpoison the object's data.
> > +      * Part of it might already have been unpoisoned, but it's unknown
> > +      * how big that part is.
> > +      */
> > +     kasan_unpoison(object, size);
> > +
> >       page = virt_to_head_page(object);
> >
> > +     /* Piggy-back on kmalloc() instrumentation to poison the redzone. */
> >       if (unlikely(!PageSlab(page)))
> >               return __kasan_kmalloc_large(object, size, flags);
> >       else
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index dad70239b54c..60a2f49df6ce 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1140,19 +1140,27 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
> >       void *ret;
> >       size_t ks;
> >
> > -     if (likely(!ZERO_OR_NULL_PTR(p)) && !kasan_check_byte(p))
> > -             return NULL;
> > -
> > -     ks = ksize(p);
> > +     /* Don't use instrumented ksize to allow precise KASAN poisoning. */
> > +     if (likely(!ZERO_OR_NULL_PTR(p))) {
> > +             if (!kasan_check_byte(p))
> > +                     return NULL;
>
> Just checking: Check byte returns true if the object is not tracked by KASAN, right? I.e. if it's a KFENCE object, kasan_check_byte() always returns true.

kasan_check_byte() still performs the check, but since KFENCE objects
are never poisoned, the check always passes.

Thanks!
